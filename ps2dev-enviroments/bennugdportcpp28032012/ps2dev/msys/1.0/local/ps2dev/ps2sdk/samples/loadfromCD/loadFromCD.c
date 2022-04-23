//----------------------------------------------------------------------------//
// Includes
//----------------------------------------------------------------------------//
//PS2
#include <tamtypes.h>
#include <kernel.h>
#include <sifrpc.h>
#include <loadfile.h>
#include <debug.h>
#include <libpad.h>
#include <sys/stat.h>
#include <audsrv.h>
#include <iopcontrol.h>
#include <iopheap.h>

//Standard C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <string.h>

#include <stdio.h>

// Using cdvd.irx and cdvd.h from PGEN sources
#include "cdvd_rpc.h"
#include <sbv_patches.h>


//----------------------------------------------------------------------------//
// Integrated Modules //
//----------------------------------------------------------------------------//
extern unsigned char cdvd[];
extern unsigned int size_cdvd;

//----------------------------------------------------------------------------//
// Function Prototypes //
//----------------------------------------------------------------------------//
// Local Funtions
void loadModules();


//----------------------------------------------------------------------------//
// Main //
//----------------------------------------------------------------------------//
int main()
{

    unsigned char* filebuffer = NULL;
    int n;

    /*
    SifInitRpc(0);
    SifExitIopHeap();
	 SifLoadFileExit();
	 SifExitRpc();
	 SifResetIop();
	 SifIopReset(s_pUDNL, 0);
	 SifInitRpc(0);
     */
      printf("fase 1 \n");

    sbv_patch_enable_lmb();
printf("fase 2 \n");
    loadModules();
printf("fase 3 \n");
   // CDVD_Init();        // not needed?
printf("fase 4 \n");

    // Open an example filename
    //FILE* File = fopen("cdfs:/datafile.dat", "r");
    //FILE* File = fopen("cdfs:/SLES_502.15", "r");
    FILE* File = fopen("cdrom0:\\SLES_502.15", "r");

    if (File == NULL)
    {
        printf("Failed to load title file\n");
        return -1;
    }

    printf("file loaded OK \n");

    //Get filesize //
    fseek(File, 0, SEEK_END);
    int FileSize = (int)ftell(File);
    fseek(File, 0, SEEK_SET);

    if (!(filebuffer = malloc(FileSize)))
    {
        fclose(File);
        printf("Error: Couldnt allocate buffer\n");
        return -1;
    }

    printf("FileSize = %d\n", FileSize);
    if (!(fread(filebuffer, FileSize, 1, File)))
    {
        fclose(File);
        printf("Error: Cannot read file\n");
        free(filebuffer);
        return -1;
    }


    // ending
    fclose(File);
    free(filebuffer);

    //n = CDVD_TrayReq(CdTrayOpen);
    CDVD_Stop();

    SleepThread();

    return 0;

}

//----------------------------------------------------------------------------//
//Put modules to load here
//----------------------------------------------------------------------------//
void loadModules()
{
    int ret;
/*
    ret = SifLoadModule("rom0:SIO2MAN", 0, NULL);       // TBD : is this needed?
    if (ret < 0)
    {
        printf("sifLoadModule sio failed: %d\n", ret);
        SleepThread();
    }

    ret = SifLoadModule("rom0:LIBSD", 0, NULL);         // TBD : is this needed?
    if (ret < 0)
    {
        printf("sifLoadModule libsd failed: %d\n", ret);
        SleepThread();
    }
*/
    //Load embedded modules
    SifExecModuleBuffer(cdvd, size_cdvd, 0, NULL, &ret);
}
