/*
 *  Copyright � 2006-2011 SplinterGU (Fenix/Bennugd)
 *  Copyright � 2002-2006 Fenix Team (Fenix)
 *  Copyright � 1999-2002 Jos� Luis Cebri�n Pag�e (Fenix)
 *
 *  This file is part of Bennu - Game Development
 *
 *  This software is provided 'as-is', without any express or implied
 *  warranty. In no event will the authors be held liable for any damages
 *  arising from the use of this software.
 *
 *  Permission is granted to anyone to use this software for any purpose,
 *  including commercial applications, and to alter it and redistribute it
 *  freely, subject to the following restrictions:
 *
 *     1. The origin of this software must not be misrepresented; you must not
 *     claim that you wrote the original software. If you use this software
 *     in a product, an acknowledgment in the product documentation would be
 *     appreciated but is not required.
 *
 *     2. Altered source versions must be plainly marked as such, and must not be
 *     misrepresented as being the original software.
 *
 *     3. This notice may not be removed or altered from any source
 *     distribution.
 *
 */

/* --------------------------------------------------------------------------- */

#include <SDL.h>

#if defined(TARGET_IOS)
#if SDL_VERSION_ATLEAST(2,0,0)
#define __LIB_RENDER
#include <g_video.h>
#include <librender.h>
#endif
#endif

#include "bgdrtm.h"

#include "bgddl.h"
#include "dlvaracc.h"

/* --------------------------------------------------------------------------- */

#define EXIT_STATUS         0
#define WINDOW_STATUS       1
#define FOCUS_STATUS        2
#define MOUSE_STATUS        3

/* --------------------------------------------------------------------------- */
/* Definicion de variables globales (usada en tiempo de compilacion) */

char * __bgdexport( libwm, globals_def ) =
    "exit_status = 0;\n"                /* SDL_QUIT status */
    "window_status = 1;\n"              /* MINIMIZED:0 VISIBLE:1 */
    "focus_status = 1;\n"               /* FOCUS status */
    "mouse_status = 1;\n";              /* MOUSE status (INSIDE WINDOW:1) */

/* --------------------------------------------------------------------------- */
/* Son las variables que se desea acceder.                           */
/* El interprete completa esta estructura, si la variable existe.    */
/* (usada en tiempo de ejecucion)                                    */

DLVARFIXUP  __bgdexport( libwm, globals_fixup )[] =
{
    /* Nombre de variable global, puntero al dato, tama�o del elemento, cantidad de elementos */
    { "exit_status"     , NULL, -1, -1 },
    { "window_status"   , NULL, -1, -1 },
    { "focus_status"    , NULL, -1, -1 },
    { "mouse_status"    , NULL, -1, -1 },
    { NULL              , NULL, -1, -1 }
};

/* --------------------------------------------------------------------------- */
/* Gesti�n de eventos de ventana                                               */
/* --------------------------------------------------------------------------- */

/*
 *  FUNCTION : wm_events
 *
 *  Process all pending wm SDL events, updating all global variables
 *
 *  PARAMS :
 *      None
 *
 *  RETURN VALUE :
 *      None
 */

static void wm_events()
{
    SDL_Event e ;
    int oldrestore, olddump;
    
    /* Procesa los eventos de ventana pendientes */

    GLODWORD( libwm, EXIT_STATUS ) = 0 ;

#if SDL_VERSION_ATLEAST(2,0,0)
    while ( SDL_PeepEvents( &e, 1, SDL_GETEVENT, SDL_QUIT, SDL_WINDOWEVENT ) > 0 )
    {
        switch ( e.type )
        {
            case SDL_QUIT:
                /* UPDATE  exit status... initilized each frame */
                GLODWORD( libwm, EXIT_STATUS ) = 1 ;
                break ;
                
            case SDL_WINDOWEVENT:
                switch (e.window.event) {
#if defined(TARGET_IOS)
                    case SDL_WINDOWEVENT_RESTORED:
                        // Get the new display surface & clear the old one
                        if(enable_scale) {
                            SDL_FreeSurface(scale_screen);
                            scale_screen = SDL_GetWindowSurface(window);
                        }
                        else {
                            SDL_FreeSurface(screen);
                            screen = SDL_GetWindowSurface(window);
                        }
                        
                        // Force full screen redraw
                        olddump    = GLODWORD( librender, DUMPTYPE );
                        oldrestore = GLODWORD( librender, RESTORETYPE );
                        GLODWORD( librender, DUMPTYPE )    = 1;
                        GLODWORD( librender, RESTORETYPE ) = 1;
                        gr_draw_frame();
                        GLODWORD( librender, DUMPTYPE )    = olddump;
                        GLODWORD( librender, RESTORETYPE ) = oldrestore;

                        GLODWORD(libwm, FOCUS_STATUS ) = 1;
                        break;
#endif
                    case SDL_WINDOWEVENT_ENTER:
                        GLODWORD(libwm, MOUSE_STATUS) = 1;
                        break;
                    case SDL_WINDOWEVENT_LEAVE:
                        GLODWORD(libwm, MOUSE_STATUS) = 0;
                        break;
                    case SDL_WINDOWEVENT_HIDDEN:
                        GLODWORD(libwm, WINDOW_STATUS) = 0;
                        break;
                    case SDL_WINDOWEVENT_SHOWN:
                        GLODWORD(libwm, WINDOW_STATUS) = 1;
                        break;
                }
            
            case SDL_SYSWMEVENT:
                break ;
        }
    }
#else
    while ( SDL_PeepEvents( &e, 1, SDL_GETEVENT, SDL_QUITMASK | SDL_ACTIVEEVENTMASK ) )
    {
        switch ( e.type )
        {
                /* WINDOW MANAGER EVENTS */
            case SDL_QUIT:
                /* UPDATE  exit status... initilized each frame */
                GLODWORD( libwm, EXIT_STATUS ) = 1 ;
//                bgdrtm_exit( -1 );
                break ;

            case SDL_ACTIVEEVENT:
                if ( e.active.state & SDL_APPACTIVE ) GLODWORD( libwm, WINDOW_STATUS ) = ( e.active.gain ) ? 1 : 0 ;
                if ( e.active.state & SDL_APPINPUTFOCUS ) GLODWORD( libwm, FOCUS_STATUS ) = ( e.active.gain ) ? 1 : 0 ;
                if ( e.active.state & SDL_APPMOUSEFOCUS ) GLODWORD( libwm, MOUSE_STATUS ) = ( e.active.gain ) ? 1 : 0 ;
                break ;
        }
    }
#endif
}

/* --------------------------------------------------------------------------- */

/* Bigest priority first execute
   Lowest priority last execute */

HOOK __bgdexport( libwm, handler_hooks )[] =
{
    { 4700, wm_events   },
    {    0, NULL        }
} ;

/* --------------------------------------------------------------------------- */

char * __bgdexport( libwm, modules_dependency )[] =
{
#if defined(TARGET_IOS)
    "libvideo",
    "librender",
#endif
    "libsdlhandler",
    NULL
};

/* --------------------------------------------------------------------------- */
