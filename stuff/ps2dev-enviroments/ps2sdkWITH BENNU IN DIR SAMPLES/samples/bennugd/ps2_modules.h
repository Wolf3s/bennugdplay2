#ifndef __PS2SDK_1_1__
#include <stdio.h>
#endif
#include <tamtypes.h>
#include <sifrpc.h>
#include <kernel.h>
#include <loadfile.h>
#include <fileio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <debug.h>
#include <iopcontrol.h>

void loadMinimal()
 {
   int ret;

   ret = SifLoadModule("rom0:SIO2MAN", 0, NULL);
    ret = SifLoadModule("rom0:MCMAN", 0, NULL);
   if (ret < 0) {
      scr_printf("Error '%d' loading module rom0:MCMAN\n", ret);
   } else {
      scr_printf("Module rom0:MCMAN loaded\n");
   }
    ret = SifLoadModule("rom0:MCSERV", 0, NULL);
    ret = SifLoadModule("rom0:PADMAN", 0, NULL);
    ret = SifLoadModule("rom0:IOMAN", 0, NULL);

   //mcInit(MC_TYPE_MC);

   ret = SifLoadModule("mc0:usbd.irx", 0, NULL);
   if (ret < 0) {
      scr_printf("Error '%d' loading module mc0:usbd.irx\n", ret);
   } else {
      scr_printf("Module mc0:usbd.irx loaded\n");
   }
}
