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

#define ROM_PADMAN

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <sifrpc.h>//Masteries, fix SDL mixer

#include <kernel.h>//Masteries, EE threads



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

#include <SDL_thread.h>//Masteries
#include <SDL_timer.h>//Masteries

//Masteries, para la vibración del mando
#include <tamtypes.h>
#include <kernel.h>
#include <sifrpc.h>
#include "libpad.h"
//Fin includes vibración

//#include <SDL_systhread.h>//Masteries

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
  printf("sdl_log: %s \n",fmt);
}

extern int size_usbd_irx;
extern char usbd_irx[];
extern int size_usb_mass_irx;
extern char usb_mass_irx[];

#include <SDL.h>

/*  Masteries
 * waitPadReady()
 */
int waitPadReady(int port, int slot)
{
    int state;
    int lastState;
    char stateString[16];

    state = padGetState(port, slot);
    lastState = -1;
    while((state != PAD_STATE_STABLE) && (state != PAD_STATE_FINDCTP1)) {
        if (state != lastState) {
            padStateInt2String(state, stateString);
            printf("Please wait, pad(%d,%d) is in state %s\n",
                       port, slot, stateString);
        }
        lastState = state;
        state=padGetState(port, slot);
    }
    // Were the pad ever 'out of sync'?
    if (lastState != -1) {
        printf("Pad OK!\n");
    }
    return 0;
}


//-----------------------------------------------------
int SDL_main( int argc, char *argv[] )//SDL_main  Masteries
{
    char  filename[30], dcbname[ __MAX_PATH ], *ptr ;
    int i, j, ret = -1;
    file * fp = NULL;
    INSTANCE * mainproc_running;
    dcb_signature dcb_signature;

    static char actAlign[6];

// ----------------------------
  SifIopReset(NULL, 0);
  //SifResetIop();//Masteries, trying to fix the SDL mixer audio issue
  while(!SifIopSync()){};

  SifInitRpc(0);
  SifInitIopHeap();
  SifLoadFileInit();
  fioInit(); /* Only needed if you use fio*() functions. */

  sbv_patch_enable_lmb();
  sbv_patch_disable_prefix_check();

// ----------------------------
	printf("Cargando .. IRXs\n");
	// USB mass support
    SifExecModuleBuffer(&usbd_irx, size_usbd_irx, 0, NULL, &ret);
    printf("USBD.irx loadmodule %d\n", ret);
    SifExecModuleBuffer(&usb_mass_irx, size_usb_mass_irx, 0, NULL, &ret);
    printf("USBDHD.irx loadmodule %d\n", ret);

// ---------------------------- verifica donde esta el dcb si en USB o en CDROM
    char cadruta[10]="";

    strcpy(filename , "mass:\\MAIN.DCB");
    if (ret=fopen(filename,"r"))
    {
       strcpy(cadruta,"mass:\\");
       fclose(ret);
       printf("%s exists  ******** \n", filename);
    }
    else
    {
      strcpy(filename , "cdrom0:\\MAIN.DCB");
      if (ret=fopen(filename,"r"))
      {
        strcpy(cadruta,"cdrom0:\\");
        fclose(ret);
        printf("%s exists  ******** \n", filename);
      }
      else
      {
         printf("MAIN.DCB not exists  ******** \n");
         return -1;
      }
    }


// ----------------------------
    char cadmodulos[30];

    printf("sample: loading freesd \n");
    strcpy(cadmodulos,cadruta);
    strcat(cadmodulos,"FREESD.IRX");
    ret = SifLoadModule(cadmodulos, 0, NULL);
	printf("libFREEsd loadmodule %d\n", ret);

	printf("sample: loading audsrv \n");
	strcpy(cadmodulos,cadruta);
    strcat(cadmodulos,"AUDSRV.IRX");
	ret = SifLoadModule(cadmodulos, 0, NULL);
	printf("audsrv loadmodule %d\n", ret);

	ret = audsrv_init();

// ----------------------------

    printf("iniciando sdl todo \n");
	if ( SDL_Init (SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_JOYSTICK | SDL_INIT_TIMER ) < 0 )
	{
		printf ("ColDev - SDL Init Error: %s\n", SDL_GetError()) ;
		return 1 ;
	}

//Masteries, init Dualshock gamepad
padInit(0);

padSetMainMode(0, 0, 1, PAD_MMODE_LOCK);//1   3
actAlign[0] = 0;
actAlign[1] = 1;
actAlign[2] = 0xff;
actAlign[3] = 0xff;
actAlign[4] = 0xff;
actAlign[5] = 0xff;
actAlign[6] = 0xff;
waitPadReady(0, 0);
padSetActAlign(0, 0, actAlign);
waitPadReady(0, 0);

actAlign[0] = 1; // Start small engine
padSetActDirect(0, 0, actAlign);

// ----------------------------

    printf("Iniciando Bennugd - Port by Colombian Developers \n");
/*
    strcpy(filename , "mass:\\MAIN.DCB");
	if (!file_exists(filename))
    {
       strcpy(filename , "cdrom0:\\MAIN.DCB");
	   if (!file_exists(filename))
	   {
	     printf("%s doesn't exist, quitting\n", filename);
	     return -1;
	   }
	}

    printf("%s exists\n", filename);
    // Remember to compile DCB with debug (bgdc -g) info! */
    debug = 0;

// ----------------------------

printf("Fase 1 \n");


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


/*
int pico_main( int argc, char *argv[] )
{
    //Masteries
    struct t_ee_thread mainThread, soundThread;
    int mainThreadId, soundThreadId;

    mainThread.status = 0;
    mainThread.func = (void*)the_main;
    mainThread.stack = (void*)((int*)malloc(0x2000) + 0x2000 - 4);//(void*)((int*)malloc(0x800) + 0x800 - 4)
    mainThread.initial_priority = 0x40;//Masteries, priority 64 decimal

    //Masteries, start the main thread
    mainThreadId = CreateThread( &mainThread );
    StartThread( mainThreadId, NULL );

   while( 1 )
      {
      iRotateThreadReadyQueue( 0x40 );
      }

   return 0;
}
*/


