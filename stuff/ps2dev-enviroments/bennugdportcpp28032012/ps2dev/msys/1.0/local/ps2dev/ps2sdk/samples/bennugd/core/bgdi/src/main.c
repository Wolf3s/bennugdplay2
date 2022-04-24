/*
 *  Copyright © 2006-2011 SplinterGU (Fenix/Bennugd)
 *  Copyright © 2002-2006 Fenix Team (Fenix)
 *  Copyright © 1999-2002 José Luis Cebrián Pagüe (Fenix)
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


# _____     ___ ____
#  ____|   |    ____|
# |     ___|   |____             Bennugd port by Colombian Developers
#-----------------------------------------------------------------------

 */


/*
 * INCLUDES
 */

#ifdef _WIN32
#define  _WIN32_WINNT 0x0500
#include <windows.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "bgdi.h"
#include "bgdrtm.h"
#include "xstrings.h"
#include "dirs.h"

#if defined(TARGET_IOS)
#include <SDL.h>
#elif defined(TARGET_WII)
#include <SDL.h>
#include <fat.h>
#elif defined(TARGET_PSP)
#include "psp.h"
#elif defined(TARGET_ANDROID)
#include <SDL.h>
#endif

/* ---------------------------------------------------------------------- */

static char * dcb_exts[] = { ".dcb", ".dat", ".bin", NULL };

static int standalone  = 0;  /* 1 only if this is an standalone interpreter   */
static int embedded    = 0;  /* 1 only if this is a stub with an embedded DCB */

/* ---------------------------------------------------------------------- */

/*
 *  FUNCTION : main
 *
 *  Main function
 *
 *  PARAMS:
 *      INT n: ERROR LEVEL to return to OS
 *
 *  RETURN VALUE:
 *      No value
 *
 */

 void  SDL_Log(const char *fmt, ...)
{

}

#include <SDL.h>

int SDL_main( int argc, char *argv[] )
{
    char * filename = NULL, dcbname[ __MAX_PATH ], *ptr ;
    int i, j, ret = -1;
    file * fp = NULL;
    INSTANCE * mainproc_running;
    dcb_signature dcb_signature;

    printf("Iniciando Bennugd - Port by Colombian Developers \n");

    filename = "cdrom0:\\MAIN.DCB";
	if (!file_exists(filename)) {
	    printf("%s doesn't exist, quitting\n", filename);
	    return -1;
	}
    printf("%s exists\n", filename);

    // Remember to compile DCB with debug (bgdc -g) info!
    debug = 0;


printf("Fase 1 \n");
 if (SDL_Init(SDL_INIT_VIDEO) < 0 ) return 1;




    /* Initialization (modules needed before dcb_load) */

    string_init() ;
    init_c_type() ;

printf("Fase 2 \n");
    /* Init application title for windowed modes */

    strcpy( dcbname, filename ) ;

    if ( appname && filename != appname )
    {
        free( appname );
        appname = strdup( filename ) ;
    }

    if ( !embedded )
    {
        /* First try to load directly (we expect myfile.dcb) */
        if ( !dcb_load( dcbname ) )
        {
            char ** dcbext = dcb_exts;
            int dcbloaded = 0;

            while ( dcbext && *dcbext )
            {
                strcpy( dcbname, filename ) ;
                strcat( dcbname, *dcbext ) ;
                if (( dcbloaded = dcb_load( dcbname ) ) ) break;
                dcbext++;
            }

            if ( !dcbloaded )
            {
                printf( "%s: doesn't exist or isn't version %d DCB compatible\n", filename, DCB_VERSION >> 8 ) ;
                return -1 ;
            }
        }
    }
    else
    {
        dcb_load_from( fp, dcbname, dcb_signature.dcb_offset );
    }
printf("Fase 3 \n");
    /* If the dcb is not in debug mode */

    if ( dcb.data.NSourceFiles == 0 ) debug = 0;

    /* Initialization (modules needed after dcb_load) */

    sysproc_init() ;
printf("Fase 4 \n");
#ifdef _WIN32
    HWND hWnd = /*GetForegroundWindow()*/ GetConsoleWindow();
    DWORD dwProcessId;
    GetWindowThreadProcessId( hWnd, &dwProcessId );
    if ( dwProcessId == GetCurrentProcessId() ) ShowWindow( hWnd, SW_HIDE );
#endif

    argv[0] = filename;
    bgdrtm_entry( argc, argv );
printf("Fase 5 \n");
    if ( mainproc )
    {
        mainproc_running = instance_new( mainproc, NULL ) ;
        ret = instance_go_all() ;
    }

#ifdef TARGET_PSP
    sceKernelExitGame();
#endif
printf("Fase 6 \n");
    bgdrtm_exit( ret );

    free( appexename        );
    free( appexepath        );
    free( appexefullpath    );
    free( appname           );
printf("Fase 7 \n");
    return ret;
}

