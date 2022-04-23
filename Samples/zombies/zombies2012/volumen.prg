global
	volumen = 64;
end

process control_volumen()

private
	permitido;
	
	inactivo = 200;	//tiempo desde que se uso
	
	y_final = 230;
	
	velocidad = 2;
end

begin

	file = fpg_volumen;
	graph = volumen / 16;
	
	x = 160;
	y = 260;

	set_channel_volume(-1,volumen);
	set_song_volume(volumen);

	loop
		if ( jkeys_state[_jkey_volup] and volumen < 128 and permitido)
			permitido = false;
			volumen+= 16;
			set_channel_volume(-1,volumen);
			set_song_volume(volumen);
			inactivo = 0;
		end
		
		if ( jkeys_state[_jkey_voldown] and volumen > 0 and permitido)
			permitido = false;
			volumen-= 16;
			set_channel_volume(-1,volumen);
			set_song_volume(volumen);
			inactivo = 0;
		end
		
		if (not jkeys_state[_jkey_volup] and not jkeys_state[_jkey_voldown] and permitido == false)
			permitido = true;
		end
		
		inactivo++;
		
		// aparicion y desaparicion
		if ( inactivo < 80 )
			y_final = 230;
			if ( y > y_final )
				y-= velocidad *2;
			end
		else
			y_final = 260;
			if ( y < y_final )
				y+= velocidad;
			end
		end
			
		
		graph = volumen / 16;
		if ( graph == 0 ) graph = 9; end
		
		frame;
	end

end
