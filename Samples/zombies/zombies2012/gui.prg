process controlar_gui();
private
	id_municion;
	id_puntos;
	id_vidas;
	id_icono;
	id_granadas;
	id_zombies;
	id_zombies2;
	id_findexit;
	
	zombies_restantes;
end
begin
	file = fpg_gui;
	graph = 1;
	x = 0;
	y = 0;
	
	id_icono = gui_icono_arma();
	id_puntos = write_var(0, 86, 37, 5, partida.puntos);
	id_granadas = write_var(0, 50, 23, 4, partida.granadas);
	id_vidas = write_var(0, 83, 23, 4, partida.vidas);
	id_zombies = write(0, 300, 10, 5, "Zombies Left: ");
	
	id_zombies2 = write_var(0, 320, 10, 5, zombies_restantes);
	
	loop
		zombies_restantes = zombies_necesarios - zombies_muertos;
		
		IF  ( zombies_restantes <= 0 )
			id_zombies = write(0, 320, 20, 5, "Now find the exit!");
		END
		
		if ( arma_actual <> pistola )
			id_municion = write_var (0, 16, 37, 4,partida.municion[arma_actual]);
		else
			id_municion = write (0, 16, 37, 4,"INF");
		end
		
		graph = (partida.salud / 10) + 30;
		
		frame;
		
		delete_text ( id_municion );
		delete_text ( id_zombies );
	end
end

process gui_icono_arma()

begin
	file = fpg_gui;
	x = 15;
	y = 15;
	z = father.z -1;
	loop
		graph = arma_actual + 10;
		frame;
	end
end
