global
	carla_est;
	carla_var;
	carla_dir;
	carla_posx;
	carla_posy;
	
	carla_disparox;
	carla_disparoy;
	carla_auxx;
	carla_auxy;
	
	carla_muriendo = false;	// si carla se murio, pero todavia no tiene que respawnear
	carla_muerta = true;	// si carla tiene que respawnear

	gravedad = 1;
	
	zombies_muertos;
	zombies_necesarios;

	suelo1;
	suelo2;
	techo;
	
	
	// todos los datos necesarios para guardar una partida
	struct partida;
		// globales
		int salud;
		int vidas;
		int puntos;
		int nivel;
		// armas actuales
		int armas[6];
		int municion[6];
		int granadas;
		int granada_tipo;
	end

end

/* -------------------------------------------------------------------------- */

// crea una partida nueva, y va al nivel correspondiente
function opcion_iniciar_juego();

begin

	// crea los datos de la partida nueva
	partida.salud = 100;
	partida.vidas = 4;
	partida.puntos = 0;
	partida.nivel = pantalla1;
	
	partida.armas[pistola] 		= true;
	partida.armas[uzi] 			= false;
	partida.armas[minigun] 		= false;
	partida.armas[escopeta] 	= false;
	partida.armas[misil] 		= false;
	partida.armas[cohete] 		= false;
	partida.armas[lanzallamas] 	= false;
	
	partida.municion[pistola]		= 999;
	partida.municion[uzi]			= 0;
	partida.municion[minigun]		= 0;
	partida.municion[escopeta]		= 0;
	partida.municion[misil]			= 0;
	partida.municion[cohete]		= 0;
	partida.municion[lanzallamas]	= 0;
	
	partida.granadas = 5;

	// y guarda la partida
	save("savegame.dat", partida);
	
	// inicia el primer nivel
	nivel_cambio = true;
	nivel = pantalla1;

end

/* -------------------------------------------------------------------------- */

// carga datos de una partida vieja y va al nivel correspondiente
function opcion_cargar_juego();

begin

	// obtiene la partida guardada
	load("savegame.dat", partida);
	
	partida.vidas = 4;
	partida.granadas = 5;
	
	//va al nivel correspondiente
	nivel_cambio = true;
	nivel = partida.nivel;

end

/* -------------------------------------------------------------------------- */

// inicia cada nivel del juego
// mantiene la ejecucion del juego
// reinicia a carla
// maneja la pausa
function iniciar_juego(carlax,carlay,finalx,finaly, objetivo);

private 
	int juego_pausado = false;
	int pausa_posible = false;
	int id_menu_pausa;
end

begin

	// carga recursos del juego
	fpg_carla = load_fpg(MasRuta+ "CARLA.FPG");
	fpg_zombie = load_fpg(MasRuta+ "ZOMBIE.FPG");
	fpg_armas = load_fpg(MasRuta+ "ARMAS.FPG");
	fpg_gui = load_fpg(MasRuta+ "GUI.FPG");
	fpg_items = load_fpg(MasRuta+ "ITEMS.FPG");
	
	sfx_armas[pistola] = load_wav(MasRuta+ "PISTOLA.WAV");
	sfx_armas[uzi] = load_wav(MasRuta+ "UZI.WAV");
	sfx_armas[minigun] = load_wav(MasRuta+ "MINIGUN.WAV");
	sfx_armas[escopeta] = load_wav(MasRuta+ "SHOTGUN.WAV");
	sfx_armas[misil] = load_wav(MasRuta+ "MISIL.WAV");
	sfx_armas[cohete] = load_wav(MasRuta+ "COHETE.WAV");
	sfx_armas[lanzallamas] = load_wav(MasRuta+ "LLAMAS.WAV");
	
	sfx_granada = load_wav(MasRuta+ "GRANADA.WAV");
	sfx_item = load_wav(MasRuta+ "PICKUP.WAV");
	

	// reproduce la musica
	play_song (bgm_pantalla1, -1);

	// inicio del nivel
	switch ( nivel )
		case pantalla1:
			// obtiene las durezas
			suelo1 = map_get_pixel(fpg_nivel,1,2,184);
			suelo2 = map_get_pixel(fpg_nivel,1,40,5);
			techo = map_get_pixel(fpg_nivel,1,9,5);
			// inciia el scroll
			start_scroll(0, fpg_nivel, 3, 2, 0, 0);
		end
		
		case pantalla2:
			suelo1 = map_get_pixel(fpg_nivel,1,182,197);
			techo = map_get_pixel(fpg_nivel,1,108,40);
			start_scroll(0, fpg_nivel, 2, 0, 0 ,0);
			
			item_arma(975,170);
			item_arma(975,170);
			item_arma(975,170);
		end
		
		case pantalla3:
			suelo1 = map_get_pixel(fpg_nivel,1,95,215);
			techo = map_get_pixel(fpg_nivel,1,10,65);
			start_scroll(0, fpg_nivel, 2, 0, 0 ,0);
		end
		
		case pantalla4:
			suelo1 = map_get_pixel(fpg_nivel,1,215,170);
			techo = map_get_pixel(fpg_nivel,1,20,220);
			start_scroll(0, fpg_nivel, 2, 0, 0 ,0);
			
			item_arma(180,155);
			item_arma(190,155);
			item_arma(200,155);
			item_arma(210,155);
			item_arma(220,155);
		end
		
		case pantalla5:
			suelo1 = map_get_pixel(fpg_nivel,1,0,70);
			techo = map_get_pixel(fpg_nivel,1,0,0);
			start_scroll(0, fpg_nivel, 2, 0, 0 ,0);
		end
		
		case pantalla6:
			suelo1 = map_get_pixel(fpg_nivel,1,2,90);
			techo = map_get_pixel(fpg_nivel,1,2,30);
			start_scroll(0, fpg_nivel, 2, 0, 0 ,0);
		end
	end

	carla_muerta = true;
	
	controlar_granadas();
	controlar_zombies();
	controlar_gui();
	controlar_objetivos(finalx, finaly, objetivo);
	controlar_armas();
	
	loop
		
		// si se apreta menu sale
		if ( jkeys_state[_JKEY_MENU] )
			nivel_cambio = true;
			nivel = menu;
			signal(id, S_KILL_TREE);
		end
		
		// si se apreta pause pone pause
		if ( jkeys_state[_JKEY_SELECT] and pausa_posible)
			pausa_posible = false;
			if ( juego_pausado )
				signal(id, S_WAKEUP_TREE);
				signal(id_menu_pausa, S_KILL);
				juego_pausado = false;
			else
				signal(id, S_FREEZE_TREE);
				signal(id, S_WAKEUP);
				juego_pausado = true;
				id_menu_pausa = menu_pausa();
			end
		end
		if (pausa_posible == false and not jkeys_state[_JKEY_SELECT])
			pausa_posible = true;
		end
		
		// reinicia a carla si quedan vidas, sino, terminar partida
		if ( carla_muerta == true )
			carla_muerta = false;
			carla_muriendo = false;
			partida.vidas--;
			partida.granadas = 5;
			
			if ( partida.vidas >= 0 )
				partida.salud = 100;
				carla(carlax, carlay);
			else
				nivel_cambio = true;
				nivel = gameover;
				signal(id,s_kill_tree);
			end
			
		end
		
		frame;
	end

onexit

	// descarga de recursos del juego
	unload_fpg (fpg_carla);
	unload_fpg (fpg_zombie);
	unload_fpg (fpg_armas);
	unload_fpg (fpg_gui);
	unload_fpg (fpg_items);
	
	unload_wav(sfx_armas[pistola]);
	unload_wav(sfx_armas[uzi]);
	unload_wav(sfx_armas[minigun]);
	unload_wav(sfx_armas[escopeta]);
	unload_wav(sfx_armas[misil]);
	unload_wav(sfx_armas[cohete]);
	unload_wav(sfx_armas[lanzallamas]);
	
	unload_wav(sfx_granada);
	
end

process menu_pausa();

begin
	file = fpg_sistema;
	graph = 02;
	x = 160;
	y = 120;
	loop
		frame;
	end

end


process controlar_objetivos(x,y,objetivo)
begin

	file = fpg_sistema;
	graph = 10;
	ctype = c_scroll;
	alpha = 0;
	
	zombies_muertos = 0;
	zombies_necesarios = objetivo;
	
	loop

		if ( zombies_muertos >= zombies_necesarios )
			alpha = 128;
		end
	
		if ( collision ( type carla ) and ( zombies_muertos >= zombies_necesarios ) )
			partida.nivel++;
			partida.vidas++;
			save( "savegame.dat", partida );
			nivel_cambio = true;
			nivel = partida.nivel;
			signal ( father, S_KILL_TREE );
		end
		frame;
	end

end

