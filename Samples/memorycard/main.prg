// --------------------------------------------------------------------------
// Bennu Tests                                         2000 José Luis Cebrián
// --------------------------------------------------------------------------


import "mod_text";
import "mod_say";

import "mod_grproc";
import "mod_video";
import "mod_screen";

import "mod_proc";
import "mod_key";
import "mod_draw";
import "mod_timers";
import "mod_joy"
import "mod_play2"



//PLAYSTATION2 
#define PLAYSTATION2_OS  777 
//PLAYSTATION2 CONTROL MAPPER
#define JOY_PS2_CROSS(A)     JOY_GETBUTTON(A,1)
#define JOY_PS2_CIRCLE(A)    JOY_GETBUTTON(A,2)
#define JOY_PS2_SQUARE(A)    JOY_GETBUTTON(A,0)
#define JOY_PS2_TRIANGLE(A)  JOY_GETBUTTON(A,3)
#define JOY_PS2_SELECT(A)    JOY_GETBUTTON(A,4)
#define JOY_PS2_START(A)     JOY_GETBUTTON(A,5)
#define JOY_PS2_L1(A)        JOY_GETBUTTON(A,6)
#define JOY_PS2_L2(A)        JOY_GETBUTTON(A,8)
#define JOY_PS2_L3(A)        JOY_GETBUTTON(A,10)
#define JOY_PS2_R1(A)        JOY_GETBUTTON(A,7)
#define JOY_PS2_R2(A)        JOY_GETBUTTON(A,9)
#define JOY_PS2_R3(A)        JOY_GETBUTTON(A,11)

#define JOY_PS2_RIGHT(A)     (JOY_GETAXIS(A,0) >= 10000)
#define JOY_PS2_LEFT(A)      (JOY_GETAXIS(A,0) <= -10000)
#define JOY_PS2_UP(A)        (JOY_GETAXIS(A,1) <= -10000)
#define JOY_PS2_DOWN(A)      (JOY_GETAXIS(A,1) >= 10000)
//--------------------------------




//ps2 dualshock types
#define SMALLENGINE_DS  1
#define BIGENGINE_DS  2



GLOBAL 

  option ;
  
  struct test1
     int x1,y1,z1;
  end;
  
  struct test2
     int x1,y1,z1;
  end= 701,702,703;

   
BEGIN
    set_mode(320,240,32, MODE_DOUBLEBUFFER | MODE_HARDWARE | DOUBLE_BUFFER | HW_SURFACE );
    
    write (0, 160,  4, 1, "Bennugd  - memory card TEST") ;
 
	
  //only 8 chars filename  ps2 is supported  --------------------------
    if (PLAY2_MC_LOAD("game1.dat", test1, sizeof(test1)))  //LOAD FROM MC
	  write (0, 60,  50, 0, "FILE LOADED CORRECTLY FROM MC") ;
	  write (0, 60,  60, 0, "X1 "+ test1.x1 + " Y1 "+ test1.y1 + " Z1 "+ test1.z1) ;
 	else
       if (PLAY2_MC_SAVE("game1.dat", test2, sizeof(test2))) //CREATE IN MC
         write (0, 60,  60, 0, "FILE SAVED CORRECTLY IN MC") ;
	   else
	     write (0, 60,  70, 0, "MEMORY CARD  ERROR ERROR ERRORERROR ERROR ERRORERROR ERROR ERROR ") ;
	   end
	end
		
    
    while ((not KEY(_ESC)) and (not JOY_PS2_R3(0)) )
	
	//GAMEPAD NRO 1 --- DUALSHOCK TEST
	    if (JOY_PS2_CROSS(0) )
            //dualshock based in MASTERIES code  		
		    //dualshock parameters (gamepad-port, typeengine, intensity 0..255)
			
		    PLAY2_DUALSHOCK(0,BIGENGINE_DS, 160); //start big engine with intensity 160, in gamepad port zero
            
			say("BIG ENGINE STARTED.. XD XD  "); 			
        end;
		
        if (JOY_PS2_CIRCLE(0)  )
            //dualshock parameters (gamepad-port, typeengine, intensity 0..255)
			
		    PLAY2_DUALSHOCK(0,BIGENGINE_DS, 0); //stop big engine

            say("BIG ENGINE STOP ..   XD XD  ");			
        end;		
	
	
	
	//GAMEPAD NRO 2 -- DUALSHOCK TEST
	    if (JOY_PS2_CROSS(1) )
    	    //dualshock parameters (gamepad-port, typeengine, intensity 0..255)
			
		    PLAY2_DUALSHOCK(1,BIGENGINE_DS, 160); //start big engine with intensity 160, in gamepad port one
            
			say("BIG ENGINE STARTED.. XD XD  "); 			
        end;		
		
        if (JOY_PS2_CIRCLE(1)  )
            //dualshock parameters (gamepad-port, typeengine, intensity 0..255)
			
		    PLAY2_DUALSHOCK(1,BIGENGINE_DS, 0); //stop big engine

            say("BIG ENGINE STOP ..   XD XD  ");			
        end;		
	
	
        FRAME ;
    end ;
    
END

