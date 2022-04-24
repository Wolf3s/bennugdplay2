
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>


#include <bgddl.h>
#include "dlvaracc.h"


#ifdef PLAYSTATION2

#include <sifrpc.h>//Masteries, fix SDL mixer

#include <kernel.h>//Masteries, EE threads
#include <libmc.h>



#endif


//save ps2 data in memory card
static int fx_ps2_mc_save(INSTANCE * my, int * params)
{
    const char * filename ;
    int result = 0 ;

#ifdef PLAYSTATION2
    filename = string_get( params[0] ) ;
    if ( !filename ) return 0 ;

    printf("salvando datos en memory %d  \n  ", params[2]);
    result= CreateSaveMC(filename, ( void * )params[1], params[2] );

    string_discard( params[0] ) ;
#endif

    return result ;
}



//load ps2 data in memory card
static int fx_ps2_mc_load(INSTANCE * my, int * params)
{
    const char * filename ;
    int result = 0 ;

#ifdef PLAYSTATION2
    filename = string_get( params[0] ) ;
    if ( !filename ) return 0 ;

    printf("cargando datos de memory %d  \n  ", params[2]);
    result= LoadSaveMC(filename, ( void * )params[1], params[2] );

    string_discard( params[0] ) ;
#endif

    return result ;
}


static char actAlign[6];

#define SMALLENGINE_DS  1
#define BIGENGINE_DS  2

// ps2 DUALSHOCK  using MASTERIES code
// port, typeengine, instensity
static int fx_ps2_dualshock(INSTANCE * my, int * params)
{
#ifdef PLAYSTATION2
   int intensidad;

   if (params[1] == SMALLENGINE_DS)
   {
      actAlign[0] = (params[2] != 0); //Start small engine
      padSetActDirect(params[0], 0, actAlign);
   }
   else//big engine
   {
      intensidad = params[2];
      if (intensidad > 255) intensidad=255;

      actAlign[1] = intensidad; //Start big engine
      padSetActDirect(params[0], 0, actAlign);
   }

#endif

    return 0 ;
}



/* ----------------------------------------------------------------- */
/* Declaracion de funciones                                          */

#define FENIX_export(a,b,c,d)  {a,b,c,(void*)d}


DLLEXPORT DLSYSFUNCS  __bgdexport(mod_play2,functions_exports)[] = {
    //initialize

	FENIX_export ("PLAY2_MC_SAVE", "SPI", TYPE_DWORD, fx_ps2_mc_save ) ,
    FENIX_export ("PLAY2_MC_LOAD", "SPI", TYPE_DWORD, fx_ps2_mc_load ) ,

    FENIX_export ("PLAY2_DUALSHOCK", "III", TYPE_DWORD, fx_ps2_dualshock ) ,


    { 0            , 0     , 0         , 0              }
};



/* ----------------------------------------------------------------- */






DLLEXPORT void __bgdexport( mod_play2, module_initialize )()
{
// MEMORY CARD
#ifdef PLAYSTATION2
	int ret = SifLoadModule("rom0:XSIO2MAN", 0, NULL);
	if (ret < 0) {
		printf("Failed to load module: SIO2MAN");
		SleepThread();
	}

	ret = SifLoadModule("rom0:XMCMAN", 0, NULL);
	if (ret < 0) {
		printf("Failed to load module: MCMAN");
		SleepThread();
	}

	ret = SifLoadModule("rom0:XMCSERV", 0, NULL);
	if (ret < 0) {
		printf("Failed to load module: MCSERV");
		SleepThread();
	}

	if(mcInit(MC_TYPE_XMC) < 0) {
		printf("Failed to initialise memcard server!\n");
		SleepThread();
	}

    int mc_Type, mc_Free, mc_Format;

// Since this is the first call, -1 should be returned.
	mcGetInfo(0, 0, &mc_Type, &mc_Free, &mc_Format);
	mcSync(0, NULL, &ret);
	printf("mcGetInfo returned %d\n",ret);
	printf("Type: %d Free: %d Format: %d\n\n", mc_Type, mc_Free, mc_Format);

	// Assuming that the same memory card is connected, this should return 0
	mcGetInfo(0,0,&mc_Type,&mc_Free,&mc_Format);
	mcSync(0, NULL, &ret);
	printf("mcGetInfo returned %d\n",ret);
	printf("Type: %d Free: %d Format: %d\n\n", mc_Type, mc_Free, mc_Format);

#endif
}



DLLEXPORT char * __bgdexport(mod_play2,modules_dependency)[] = {
	"mod_string",
	NULL
};



