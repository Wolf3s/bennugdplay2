const

	// niveles del juego
	intro 		= 0;
	menu 		= 1;
	opciones 	= 2;
	ayuda 		= 3;
	creditos 	= 4;
	pantalla1	= 5;
	pantalla2	= 6;
	pantalla3	= 7;
	pantalla4	= 8;
	pantalla5	= 9;
	pantalla6	= 10;
	gameover	= 11;

	// estados del jugador
	reposo = 0;
	camina = 1;
	saltoh = 2;
	saltov = 3;
	// variantes
	ade	= 0;
	arr	= 1;
	aba	= 2;
	// direccion
	izq = 1;
	der = 0;

	// armas
	pistola = 0;
	uzi = 1;
	minigun = 2;
	escopeta = 3;
	misil = 4;
	cohete = 5;
	lanzallamas = 6;
	
	const_granadas = 8;
	
	// tipos de ataque
	tiro = 0;
	fuego = 1;
	poder = 2;

	// direccion de disparo
	arriba = 3;
	derecha = 2;
	abajo = 4;
	izquierda = 1;

END

/* -------------------------------------------------------------------------- */

global
	// niveles del juego
	int nivel = menu;
	int nivel_cambio = true;
	int nivel_cargado[15];

end


/* -------------------------------------------------------------------------- */

function control_niveles();

begin

	loop
	
		if ( nivel_cambio == true )
			nivel_cambio = false;
			delete_text(all_text);
			
			switch ( nivel )

/* -------------------------------------------------------------------------- */

				case intro:
					// descarga recursos anteriores
					descargar();
					
					// carga recursos actuales
					fpg_intro = load_fpg (MasRuta+ "INTRO.FPG");
					//bgm_intro = load_song (MasRuta+ "graveyrd.it");
					
					// avisa que se cargo
					nivel_cargado[intro] = true;
					
					// inicia procesos
					//play_song (bgm_intro, -1);
					iniciar_intro();
				
				end
				

/* -------------------------------------------------------------------------- */

				case menu:
					// descarga recursos anteriores
					descargar();
					
					// carga recursos actuales
					fpg_menu = load_fpg (MasRuta+ "MENU.FPG");
					
					// avisa que se cargo
					nivel_cargado[menu] = true;
					
					// inicia procesos
					efecto_fade();
					iniciar_menu();
				end
				

/* -------------------------------------------------------------------------- */

				case opciones:
					// descarga recursos anteriores
					descargar();
					

					// carga recursos actuales
					fpg_menu2 = load_fpg(MasRuta+ "MENU2.FPG");
					
					// avisa que se cargo
					nivel_cargado[opciones] = true;
					
					// inicia procesos
					// muestra pantalla de opciones
					efecto_fade();
					iniciar_menu_opciones();
				end
				

/* -------------------------------------------------------------------------- */

				case ayuda:
					// descarga recursos anteriores
					descargar();
					
					// carga recursos actuales
					fpg_menu2 = load_fpg(MasRuta+ "MENU2.FPG");
					
					// avisa que se cargo
					nivel_cargado[ayuda] = true;
					
					// inicia procesos
					efecto_fade();
					iniciar_menu_ayuda();
				end
				

/* -------------------------------------------------------------------------- */

				case creditos:
					// descarga recursos anteriores
					descargar();
					
					// carga recursos actuales
					fpg_menu2 = load_fpg(MasRuta+ "MENU2.FPG");
					
					// avisa que se cargo
					nivel_cargado[creditos] = true;
					
					// inicia procesos
					efecto_fade();
					iniciar_menu_creditos();
				end
				

/* -------------------------------------------------------------------------- */

				case pantalla1:
					// descarga recursos anteriores
					descargar();
					
					fpg_nivel = load_fpg(MasRuta+ "MAPA1.FPG");
					//bgm_pantalla1 = load_song(MasRuta+ "heavymet.xm");
					
					// avisa que se cargo
					nivel_cargado[pantalla1] = true;
					
					// inicia procesos
					efecto_fade();
					iniciar_juego(100,180,1260,200,30);
				end
				

/* -------------------------------------------------------------------------- */

				case pantalla2:
					// descarga recursos anteriores
					descargar();
					
					// carga recursos actuales
					fpg_nivel = load_fpg(MasRuta+ "MAPA2.FPG");
					//bgm_pantalla1 = load_song(MasRuta+ "industrial-rock.mod");
					
					// avisa que se cargo
					nivel_cargado[pantalla2] = true;
					
					// inicia procesos
					efecto_fade();
					iniciar_juego(175,36,10,515,40);
				end

/* -------------------------------------------------------------------------- */

				case pantalla3:
					// descarga recursos anteriores
					descargar();
					
					// carga recursos actuales
					fpg_nivel = load_fpg(MasRuta+ "MAPA3.FPG");
					//bgm_pantalla1 = load_song(MasRuta+ "graveyard.mod");
					
					// avisa que se cargo
					nivel_cargado[pantalla3] = true;
					
					// inicia procesos
					efecto_fade();
					iniciar_juego(980,100,20,160,50);
				end

/* -------------------------------------------------------------------------- */

				case pantalla4:
					// descarga recursos anteriores
					descargar();
					
					// carga recursos actuales
					fpg_nivel = load_fpg(MasRuta+ "MAPA4.FPG");
					//bgm_pantalla1 = load_song(MasRuta+ "zombi2.mod");
					
					// avisa que se cargo
					nivel_cargado[pantalla4] = true;
					
					// inicia procesos
					efecto_fade();
					iniciar_juego(995,155,10,330,60);
				end

/* -------------------------------------------------------------------------- */

				case pantalla5:
					// descarga recursos anteriores
					descargar();
					
					// carga recursos actuales
					fpg_nivel = load_fpg(MasRuta+ "MAPA5.FPG");
					//bgm_pantalla1 = load_song(MasRuta+ "panic.s3m");
					
					// avisa que se cargo
					nivel_cargado[pantalla5] = true;
					
					// inicia procesos
					efecto_fade();
					iniciar_juego(990,225,19,110,80);
				end

/* -------------------------------------------------------------------------- */

				case pantalla6:
					// descarga recursos anteriores
					descargar();
					
					// carga recursos actuales
					fpg_nivel = load_fpg(MasRuta+ "MAPA6.FPG");
					//bgm_pantalla1 = load_song(MasRuta+ "vaso-gdg.xm");
					
					// avisa que se cargo
					nivel_cargado[pantalla6] = true;
					
					// inicia procesos
					efecto_fade();
					iniciar_juego(1000,160,10,150,150);
				end

/* -------------------------------------------------------------------------- */

				case gameover:
					// descarga recursos anteriores
					descargar();
					
					// carga recursos actuales
					
					// avisa que se cargo
					nivel_cargado[gameover] = true;
					
					// inicia procesos
					iniciar_menu_gameover();
					efecto_fade();
				end
				
			end
			
		end
	
		frame;
		
	end
	
end


/* -------------------------------------------------------------------------- */

// descarga todos los recursos cargados
function descargar();

begin

/* -------------------------------------------------------------------------- */

	//intro
	if ( nivel_cargado[intro] )
		unload_fpg(fpg_intro);
		nivel_cargado[intro] = false;
	end
	

/* -------------------------------------------------------------------------- */

	//menu
	if ( nivel_cargado[menu] )
		unload_fpg(fpg_menu);
		nivel_cargado[menu] = false;
	end


/* -------------------------------------------------------------------------- */

	//opciones
	if ( nivel_cargado[opciones] )
		unload_fpg(fpg_menu2);
		nivel_cargado[opciones] = false;
	end
	

/* -------------------------------------------------------------------------- */

	//ayuda
	if ( nivel_cargado[ayuda] )
		unload_fpg(fpg_menu2);
		nivel_cargado[opciones] = false;
	end
	

/* -------------------------------------------------------------------------- */

	//creditos
	if ( nivel_cargado[creditos] )
		unload_fpg(fpg_menu2);
		nivel_cargado[opciones] = false;
	end
	

/* -------------------------------------------------------------------------- */

	//pantalla 1
	if ( nivel_cargado[pantalla1] )
		unload_song (bgm_pantalla1);
		unload_fpg (fpg_nivel);
		stop_scroll(0);
		nivel_cargado[pantalla1] = false;
	end
	

/* -------------------------------------------------------------------------- */

	//pantalla 2
	if ( nivel_cargado[pantalla2] )
		unload_song (bgm_pantalla1);
		stop_scroll(0);
		unload_fpg(fpg_nivel);
		nivel_cargado[pantalla2] = false;
	end

	

/* -------------------------------------------------------------------------- */

	//pantalla 3
	if ( nivel_cargado[pantalla3] )
		unload_song (bgm_pantalla1);
		stop_scroll(0);
		unload_fpg(fpg_nivel);
		nivel_cargado[pantalla3] = false;
	end

	

/* -------------------------------------------------------------------------- */

	//pantalla 4
	if ( nivel_cargado[pantalla4] )
		unload_song (bgm_pantalla1);
		stop_scroll(0);
		unload_fpg(fpg_nivel);
		nivel_cargado[pantalla4] = false;
	end

	

/* -------------------------------------------------------------------------- */

	//pantalla 5
	if ( nivel_cargado[pantalla5] )
		unload_song (bgm_pantalla1);
		stop_scroll(0);
		unload_fpg(fpg_nivel);
		nivel_cargado[pantalla5] = false;
	end

	

/* -------------------------------------------------------------------------- */

	//pantalla 6
	if ( nivel_cargado[pantalla6] )
		unload_song (bgm_pantalla1);
		stop_scroll(0);
		unload_fpg(fpg_nivel);
		nivel_cargado[pantalla6] = false;
	end

	clear_screen();
	delete_text(all_text);

end


/* -------------------------------------------------------------------------- */

process efecto_fade()

begin
	x = 320;
	y = 120;
	file = fpg_sistema;
	graph = 1;
	loop
		x+= 30;
		
		if ( x > 800 ) break; end
		
		frame;
	end
end
