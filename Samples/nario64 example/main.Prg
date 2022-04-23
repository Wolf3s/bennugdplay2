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
#define BIGENGINE_DS    2
//--------------------------------





#define OCULTAR_SPRITE(A)    A.radius=	0;	  \
		YETI_ENTITY_FREEZE( A );	YETI_ENTITY_DATA( A, 0, TYPE_sprite3D); //oculta sprite


const
     TYPE_COIN = 1;
	 TYPE_PLAYER = 2;	 
	 ITEM_COIN= 100;
end
    
	
	
global    
 
 yeti_gravity= -16;
 TYPE_ENTITY_3D  mycam;
 TYPE_ENTITY_3D player;  
 estacorriendo=false;
 
 filemodel;
 filecoin;
 filesky;
 soundcoin;
end;

 
 
private
  res,i;
  
  
begin               
 // full_screen=TRUE;

  SET_FPS(30,0); //MAX ENGINE FPS

  //playstation2 run best in 32 depth  
  set_mode(320,240,32, MODE_DOUBLEBUFFER | MODE_HARDWARE | DOUBLE_BUFFER | HW_SURFACE );
  
  graph= new_map(YETI_SCREEN_WIDTH,YETI_SCREEN_HEIGHT,16);
  SET_CENTER(file,graph,0,0);//center bitmap
  x=0; y=0; z=45;
  
  //(texture,palette)      
   WRITE(0,10,20,0,"FENIX FPS: ");
   WRITE_INT(0,100,20,0,&FPS);
   
   filemodel= yeti_loadfile("MARIO.BIN"); //3d model  
   filecoin= YETI_LOADSPRITE("COIN.O3D");  
   soundcoin=    load_wav("MONEDA.WAV");
   filesky= YETI_LOADSPRITE("SKY.O3D");

   
   YETI_SETRENDERGRAPH(file,graph); //fpgfile,graph
   
   YETI_LOADTEXTURE("TEXTURES.RAW", "TEXTURES.PAL");     
   yeti_init( &mycam, "MAPA1.Y3D" );//ENTITYCAMERA,FILEMAP  
 
   yeti_setsky(filesky);
 	 
	crear_modelo(33,  10); 
	DetectarColisionesParedes();
	CargarItemsMapa();
	
	
	mycam.radius=0;
	frame;
	
	IF (OS_ID == PLAYSTATION2_OS)
	 //FIX COLORS IN PS2
	 YETI_SETRENDERFX_RGB(31 << 0, 31 << 6, 31 << 11,  PIXEL_FILTER_NORMAL);
    end
	
  while ( !key(_esc)   )
 	
	mycam.nocollision=true;  //camara no colisiona
	mycam.nocollisionwall=true;
	
	
 	 yeti_entity_look_at2(mycam, player.x,player.y,   mycam.z);//apuntar hacia modelo
	 
  if(yeti_getdistance(mycam,player) > 4)	
	  mycam.xx += yeti_fixsin(mycam.t) >> 2;  //move forward
      mycam.yy += yeti_fixcos(mycam.t) >> 2;	  
  end
  
   YETI_ENTITY_DEFAULT(&mycam,0,0,60);

	
   
     frame;                       
  end;               

  let_me_alone() ;
  
  //free resources
  yeti_FREE();
end






process  moneda(x,y)
private
  TYPE_ENTITY_3D pos;  

begin
     if (not YETI_ADDSPRITE(filecoin , &pos))//SPRITEID,ENTITYVAR
	   return ;
	 end;	 

	  pos.x= i2f(x) ; 
     pos.y= i2f(y) ;
	 pos.z=  i2f(4);	 
	 pos.radius= 220;
	 frame;

	 YETI_ENTITY_COLLISION(pos, true, TYPE_COIN,   TYPE_PLAYER);//moneda colisiona con player
	 
    loop
        if (pos.DetectedCollisionWithEntity  AND pos.DetectedCollisionWithEntityId == TYPE_PLAYER) 
      //    say("MONEDA COLISIONADA") ;       
		  		  		  
	      PLAY_WAV(soundcoin,0);
		  PLAY2_DUALSHOCK(0,SMALLENGINE_DS, 1);// start ps2 dualshock engine in port zero
		  
		  pos.DetectedCollisionWithEntity=false;
		  
		  return;
		end  
	   
	   
      YETI_ENTITY_DEFAULT(&pos,0,0,60);

	   frame;
	end    
	
onexit:
   OCULTAR_SPRITE(pos);	
end






process crear_modelo(x,y)
private
  I=1,tick=0;
  estado=false;
  
begin  
     if (not yeti_addmodel(filemodel , &player))//FILEID,ENTITYVAR
	   return ;
	 end;
	 
 	     
    player.x=  i2f(x);
	 player.y= i2f(y);
     player.z=0;
     player.radius=128;
    player.Fixz= -590;  //arreglar el modelo que esta desubicado (Z) al crearlo en editor 
    
	frame;
		
	YETI_ENTITY_COLLISION(player, true,    TYPE_PLAYER,  TYPE_COIN);//jugador colisiona con monedas
  
  loop 
  
//     yeti_entity_freeze(player);  //quita velocidad al personaje
      
  
    if (estacorriendo and NOT estado)    //a correr  - RUN
	  //2-8 correr
	  YETI_MODELANIM(&player, 2,8,    80, LOOP_FOREVER);//entity,FRAMEINIT,#FRAMES,SPEED,LOOP
	  estado=true;
	else
	 IF (NOT estacorriendo)       //quietooo   - FREEZE
	    //0-1 quieto	 
	   YETI_MODELANIM(&player, 0,1,    80, LOOP_FOREVER);//entity,FRAMEINIT,#FRAMES,SPEED,LOOP	
	   estado=false;
	 end
	end
	
	 if (key(_RIGHT) or JOY_PS2_RIGHT(0))	    
		player.tt += i2f(2);	 
	 end;	 
	 if (key(_LEFT) or JOY_PS2_LEFT(0))	    
		player.tt -= i2f(2);	
	 end;  
	 
	 estacorriendo=false;
	 if (key(_UP) or JOY_PS2_UP(0))	 
       	 estacorriendo=true;	 
	   player.xx += YETI_fixsin(player.t) >> 1;	  
       player.yy += YETI_fixcos(player.t) >> 1; 	   
	 end;	 
	 if (key(_DOWN) or JOY_PS2_DOWN(0))
	   estacorriendo=true;
	   player.xx -= YETI_fixsin(player.t) >> 1;
       player.yy -= YETI_fixcos(player.t) >> 1;
	 end;
	 if ((key(_space) OR JOY_PS2_CROSS(0)) and  YETI_ENTITY_IN_GROUND(player)   ) //verificar q esta tocando piso
	     player.zz+=  160;  
	 end
	 
     YETI_ENTITY_DEFAULT(&player,0,0,160);//posiciona el modelo de acuerdo al terreno


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
     YETI_GETCELL(f2i(player.X), f2i( player.Y)  , &celda);
	 
     if (TEXTURE_IS_LAVA( celda.wtt  )  and YETI_ENTITY_IN_GROUND(player)    )	    
       cadena="MARIO ON LAVA";
	 else
	     cadena="" ;
	 end
	 
      frame;
   end 
end





//search coins in map / set in map editor with a number
function CargarItemsMapa()
private 
    TYPE_CELL_3D celda;
    i, j;
    
begin
    for (i=0; i< 64;  i++)  //recorremos el mapa en busca de items como monedas
	for (j=0;  j<64;  j++)
	
	    YETI_GETCELL(     i,  j  , &celda);
		
	    if (celda.ent   ==  ITEM_COIN)// buscamos las monedas que creamos con la tecla "E" en el editor (codigo 100)
	        moneda(i,   j);
	      //  say("cargando moneda");	     
		end
		
	end
	end //for i
	

end
