/*
   example: 
   - CrashBandicoot .. PS1/  Mario 3DS  - EXAMPLE
   
   
   YETI3D ENGINE 
   http://code.google.com/p/yeti3dplusplus/
*/

#include "yeti3d.h"


    import "mod_text";
    import "mod_grproc";
    import "mod_video";
    import "mod_map";
    import "mod_screen";
    import "mod_rand";
    import "mod_say";
    import "mod_mouse";


import "mod_proc";
import "mod_key";
import "mod_draw";
import "mod_sound";
import "mod_joy"



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


global    
 filemodel;
 yeti_gravity= -16;
 TYPE_ENTITY_3D  mycam;
 TYPE_ENTITY_3D pos;  
 estacorriendo=false;
 end;

 
 
private
  res,i;
  
begin               
  set_mode(320,240,32, MODE_DOUBLEBUFFER | MODE_HARDWARE | DOUBLE_BUFFER | HW_SURFACE );
  
  SET_FPS(40,0); 
  WRITE(0,10,10,0,"loading.... ");
  //say("resoluaicon w:"+YETI_SCREEN_WIDTH+ " h:"+YETI_SCREEN_height);
 frame;
 
  graph= new_map(YETI_SCREEN_WIDTH,YETI_SCREEN_HEIGHT,16);
  SET_CENTER(file,graph,0,0);//center bitmap
  x=0; y=0; z=45;
  
  //(texture,palette)      

   
   IF (OS_ID == PLAYSTATION2_OS)
    filemodel= yeti_loadfile("cdrom0:\\MARIO.BIN"); //3d model  
	if (not filemodel)
	   //load from USB
       filemodel= yeti_loadfile("mass:\\MARIO.BIN"); //3d model  	
    end 	
	
   else 
     filemodel= yeti_loadfile("MARIO.BIN"); //3d model  
   END

  YETI_SETRENDERGRAPH(file,graph); //fpgfile,graph

  
   IF (OS_ID == PLAYSTATION2_OS)
    if (not YETI_LOADTEXTURE("cdrom0:\\TEXTURES.RAW", "cdrom0:\\TEXTURES.PAL"))
	  //load from USB
	  YETI_LOADTEXTURE("mass:\\TEXTURES.RAW", "mass:\\TEXTURES.PAL");
	end
	
   else
    YETI_LOADTEXTURE("TEXTURES.RAW", "TEXTURES.PAL");
   end


   IF (OS_ID == PLAYSTATION2_OS)
    if (not yeti_init( &mycam, "cdrom0:\\MAPA2.Y3D" ))//ENTITYCAMERA,FILEMAP 
	   //load from USB
       yeti_init( &mycam, "mass:\\MAPA2.Y3D");
	end 	
	
   else
	yeti_init( &mycam, "MAPA2.Y3D" );//ENTITYCAMERA,FILEMAP   	 
   end	
  
    
	mycam.x= i2f(3);
	mycam.y=i2f(57);
	mycam.radius=0;
	frame;
	
	crear_modelo(1,  63); 
	DetectarColisionesParedes();
	
	
	IF (OS_ID == PLAYSTATION2_OS)
	 //FIX COLORS IN PS2
	 YETI_SETRENDERFX_RGB(31 << 0, 31 << 6, 31 << 11,  PIXEL_FILTER_NORMAL);
    end 

   delete_text(0);	 
   WRITE(0,10,20,0,"FENIX FPS: ");
   WRITE_INT(0,100,20,0,&FPS);

		
  while ( !key(_esc)  )
   	
	mycam.nocollision=true;  //camara no colisiona
	mycam.nocollisionwall=true;
	
	
 	 yeti_entity_look_at2(mycam, pos.x,pos.y,   mycam.z);//apuntar hacia modelo
	 
	 mycam.x=  pos.x;
  
   YETI_ENTITY_DEFAULT(&mycam,0,0,60);

	
   
     frame;                       
  end;               

  let_me_alone() ;
  
  //free resources
  yeti_FREE();
end





process crear_modelo(x,y)
private
  I=1,tick=0;
  estado=false;
  
begin  
     if (not yeti_addmodel(filemodel , &pos))//FILEID,ENTITYVAR
	   return ;
	 end;
	 
 	     
    pos.x=  i2f(x);
	 pos.y= i2f(y);
     pos.z=0;
     pos.radius=0;
    pos.Fixz= -590;  //arreglar el modelo que esta desubicado (Z) al crearlo en editor 
    
	frame;
		 yeti_entity_look_at2(pos, i2f(61),  i2f(61), pos.z ); 
	
  
  loop 
  
     //yeti_entity_freeze(pos);  //quita velocidad al personaje
      
  
     if (estacorriendo and NOT estado)    //a correr  - RUN
	  //2-8 correr
	  YETI_MODELANIM(&pos, 2,8,    80, LOOP_FOREVER);//entity,FRAMEINIT,#FRAMES,SPEED,LOOP
	  estado=true;
	else
	 IF (NOT estacorriendo)       //quietooo   - FREEZE
	    //0-1 quieto	 
	   YETI_MODELANIM(&pos, 0,1,    80, LOOP_FOREVER);//entity,FRAMEINIT,#FRAMES,SPEED,LOOP	
	   estado=false;
	 end
	end
	
	estacorriendo=false;
	 if (key(_RIGHT) OR JOY_PS2_RIGHT(0) )	  
        estacorriendo=true;	 
		yeti_entity_look_at2(pos, i2f(61),  i2f(63), pos.z ); //apunta  a derecha 
       pos.xx += YETI_fixsin(pos.t) >> 1;	  //lo mueve al frente
       pos.yy += YETI_fixcos(pos.t) >> 1;		 
	 end;	 
	 if (key(_LEFT) OR JOY_PS2_LEFT(0) )	   
         estacorriendo=true;	 
		 yeti_entity_look_at2(pos, i2f(0),  i2f(63), pos.z );		//apunta izquierda
		 pos.xx += YETI_fixsin(pos.t) >> 1;	  //mueve al frente
       pos.yy += YETI_fixcos(pos.t) >> 1;
	 end;  
	 
	 
	 if ((key(_space) or JOY_PS2_CROSS(0)) and  YETI_ENTITY_IN_GROUND(pos)   ) //verificar q esta tocando piso
	     pos.zz+=  70;  
	 end
	 
    YETI_ENTITY_DEFAULT(&pos,0,0,	160);//posiciona el modelo de acuerdo al terreno


	frame;
  end
  
end; 







process   DetectarColisionesParedes()
private
   string  cadena;
    TYPE_CELL_3D celda;
	
begin
    WRITE_string(0,100,50,0,&cadena);
  
   loop      
     YETI_GETCELL(f2i(pos.X), f2i( pos.Y)  , &celda);
	 
     if (TEXTURE_IS_LAVA( celda.wtt  )  and YETI_ENTITY_IN_GROUND(pos)    )	    
       cadena="MARIO ON LAVA";
	 else
	     cadena="" ;
	 end
	 
      frame;
   end 
end
