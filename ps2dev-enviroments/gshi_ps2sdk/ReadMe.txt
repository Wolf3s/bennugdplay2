GSHI_PS2SDK - Version 5.0

By Lazy Bastard, of GSHI.org (LBGSHI)


Version 5.0 changes:

Updated the PS2SDK; fixed gsLib issues.
___________________________
Version 4.6 changes:

Updated the PS2SDK with the latest patches.
___________________________


Before anything else is said, let it be known that I've really done very little here. I didn't create the PS2SDK, nor did I contribute in any way to its creation. I'm merely fixing various issues with the current Win32 build of the PS2SDK, and providing the results of this endeavor. I've also had help from several people, who I will name at the end of this ReadMe.

This package is current, as of October 2, 2009.

This is the fully compiled PS2SDK, using msys and MinGW, including gsKit (fixed; also improved for FONTM support; also improved drastically by Ragnorok's fixes), gslib, the SDL port, SDL Mixer, libjpg (functional version from myPS2 source), usbhdfsd, libcdvd, PS2Lib (for legacy/old source support), ps2eth, ps2ftpd, SMS, sioshell, sbv, ps2Perf, dreamGL, libtiff, romfs (partial functionality only; see below), libito (partial functionality only; see below), PS2-Packer (with all stubs), and PS2-Packer-Lite (in alignment with some sources floating around the 'net). Essentially, we have a fully-built, standard PS2SDK, and additional functionality through gsKit, gslib, SDL, SDL-Mixer, libjpg, usbhdfsd, libcdvd, PS2Lib, ps2eth, ps2ftpd, SMS, sioshell, sbv, the uLE patches, ps2Perf, dreamGL, libtiff, romfs, libito, PS2-Packer, and PS2-Packer-Lite. The required patches have, as mentioned above, been applied to include some added functionality, and allow uLaunchELF to compile. Mega Man's modifications to gsKit's FONTM support have been added as well, and the results are quite impressive. romfs and libito have been added, but, as the PC tools are Linux binaries, you won't be able to create romfs images using genromfs, or use the image conversion tool "itt" in libito (however, you will still be able to compile most sources that require romfs or libito, and you'll still be able to use either in your own projects, aside from those tools). I will likely add more functionality as I find the need for it, understand it, or figure out how to fix it. Please get in contact with me if you can help, even as a tester.

If you have a request for something to be included, feel free to let me know.


To install, simply extract the mingw and msys directories into C:\, and run msys.bat, under c:\msys\1.0\. If you like, copy the included shortcut to msys.bat (msys.lnk) to your desktop or Start menu, for quicker access. If you'll be checking things out via SVN (which you probably will, at some point), install Subversion by running svn-1.4.5-setup.exe.

NOTE: This environment is intended to be deployed on C:\. If it is deployed on another drive letter, it will not work correctly without some modification. I'll work out a solution to this later (alternately, you could scheme up, test, verify, and send me a solution to speed up the process...I'm a busy guy, and might not get around to even trying for some time).

To test your environment, change directory up to 1.0 (type "cd .." without quotes), then cd down to local/ps2dev/ps2sdk/samples (type "cd local/ps2dev/ps2sdk/samples"), choose a sample and cd into its directory (for example, type "cd cube"), then type "make". If you get the message "No targets specified and no makefile found", there's likely a subdirectory that contains the source you're looking to compile (as there is in several of the samples). Simply type "ls" to list the directory's contents, choose a subdirectory, type "cd subdirectory" (replacing subdirectory with whatever it's really called, of course), then try typing "make" again. If you compile something, then later want to compile it again (perhaps you modified it, or modified your environment), simply type "make clean", then type "make".

I've also provided a collection of compilable source, by many authors, which you can simply extract into your c:/msys/1.0/home directory, cd into after starting msys, and compile. It can currently be found here: http://gshi.org/vb/showthread.php?t=3098

...and an introduction to PS2 homebrew development, which can currently be found here: http://gshi.org/vb/showthread.php?t=3103

I've included a set of instructions for Vista users (written by chp), and the new msys-1.0.dll, renamed and ready for use, in the folder entitled "Vista" (in the archive this came in).


Thanks go out to:

Many, many people, for PS2SDK, and for the libraries and tools that I've installed for this PS2SDK.

Lukasz Bruun, for doing 99% of the work (this environment is based on his MinGW PS2SDK tutorial, with several modifications and fixes), and also for giving me a few nudges in the right direction involving gsKit, SDL, and romfs (the latter of which is still a work-in-progress). Also, a big thanks to him for providing me with precompiled copies of libito and romfs, which would not compile with MinGW/msys and the current PS2SDK.

ps2devman, for providing some Cygwin files for gsKit - as MinGW couldn't properly build gsKit without them, and PS2SDK will no longer build in Cygwin, thus I had no direct way of getting the files myself - and for providing help with fixing gsKit, and helping to update some source code of his to compile with the current PS2SDK (the more compilable source, the better :) ).

cosmito (previously ptek), for providing several Cygwin files and some good info for the attempted romfs fix, which is still being worked on, and for pointing me to the gsKit FONTM improvements Mega Man created.

Mega Man, for providing the FONTM improvements he created for gsKit.

The makers of myPS2, for their functional source of libjpg.

ragnarok2040, for mentioning in a thread at PS2Dev.org the idea of using myPS2's libjpg source, for his wonderful gsKit fixes, and for his ZLIB port.

Rev1Dev, for posing the questions that led to Ragnarok2040 mentioning the libjpg idea above (heh).

extraweb1, for requesting I add libjpg, which sent me on the quest that ended up with me adding not only libjpg, but usbhdfsd, and for asking a few questions concerning uLE, which prompted me to add the uLE patches :)

Oobles, for PS2Dev.org (and for giving me the ability to update the site and SVN repo).

And everyone else in the PS2 development scene :)


- LB