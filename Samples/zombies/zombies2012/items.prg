// 
// PROYECTO:	Zombies2012
// 
// ARCHIVO: 	objetos.prg
// 
// INFO: 		Objetos recogibles y/o destruibles en el escenario
// 


PROCESS ITEM_ARMA(X, Y);
private
	tipo;
	municion;
end
BEGIN
	FILE = FPG_ITEMS;
	ctype = c_scroll;
	tipo = rand(1,6);
	
	switch (tipo)
		case uzi:
			municion = 90;
		end
		case minigun:
			municion = 90;
		end
		case escopeta:
			municion = 16;
		end
		case misil:
			municion = 5;
		end
		case cohete:
			municion = 6;
		end
		case lanzallamas:
			municion = 100;
		end
	end

	GRAPH = tipo;

	LOOP
		
		// si el personaje la toca, aumenta la municion
		IF ( collision (type carla) )
			play_wav (sfx_item,0);
			partida.armas[tipo] = TRUE;
			partida.municion[TIPO] += municion;
			
			BREAK;
		END
	
		FRAME;
	END
END
