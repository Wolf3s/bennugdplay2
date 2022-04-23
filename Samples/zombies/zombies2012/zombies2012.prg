import "mod_draw";
import "mod_joy";
import "mod_key";
import "mod_map";
import "mod_math";
import "mod_proc";
import "mod_grproc";
import "mod_rand";
import "mod_screen";
import "mod_scroll";
import "mod_sound";
import "mod_text";
import "mod_video";
import "mod_file";

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
	
	// graficos
	int fpg_intro;
	int fpg_menu;
	int fpg_menu2;
	int fpg_sistema;
	int fpg_volumen;
	int fpg_nivel;
	int fpg_carla;
	int fpg_zombie;
	int fpg_armas;
	int fpg_gui;
	int fpg_items;
	
	// sonidos
	int menu_cursor;
	int sfx_armas[6];
	int sfx_granada;
	int sfx_item;
	
	// musica
	int bgm_intro;
	int bgm_pantalla1;
	
	string MasRuta="";
	
end

begin
    IF (OS_ID == PLAYSTATION2_OS)
	  if (file_exists("mass:\\intro.fpg") )//run in usb ??	     
		 MasRuta="mass:\\";
      else //run in cdrom 
         MasRuta="cdrom0:\\";
	  end  	  
	end
	
	// inicializacion de video
	if ( os_id == OS_GP2X_WIZ)
		set_mode(320, 240, 16, mode_fullscreen);
	else	 
		//scale_mode = SCALE_NOFILTER;
		//set_mode(320, 240, 16, mode_fullscreen);
		set_mode(320,240,32, MODE_DOUBLEBUFFER | MODE_HARDWARE | DOUBLE_BUFFER | HW_SURFACE );
	end
	    
	set_fps(30, 0);
	
	write_var(0, 0, 0, 0, fps);

	
	// inicializaciones
	iniciar_armas();

	//graficos "del sistema"
	fpg_sistema = load_fpg(MasRuta+ "SIST.FPG");
	fpg_volumen = load_fpg(MasRuta+ "VOLUMEN.FPG");
	
	// controles
	if ( os_id == OS_GP2X_WIZ)control_volumen();end
    asignar_teclas_pc();
    control_teclas();
	control_niveles();
	


end


include "jkeys.prg";		//controla la entrada por joystick
include "volumen.prg";		//controla el volumen del juego
include "niveles.prg";		//contrla el nivel que se ejecuta
include "intro.prg";		//intro del juego
include "menu.prg";			//controlador del menu principal
include "menu2.prg";		//las opciones del menu
include "juego.prg";		//las opciones del menu
include "carla.prg";		//personaje principal
include "armas.prg";
include "enemigos.prg";
include "funciones.prg";	//funciones de movimientos y colisiones
include "gui.prg";
include "items.prg";
