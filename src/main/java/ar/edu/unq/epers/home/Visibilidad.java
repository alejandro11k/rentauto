package ar.edu.unq.epers.home;

import ar.edu.unq.epers.model.Usuario;
import ar.edu.unq.epers.model.general.MainService;

import java.util.List;

interface Strategy {
	void corresponde(Usuario usuario1, Usuario usuario2, List<Visibilidad> lista,MainService servicio);
}

public enum Visibilidad implements Strategy{
	PUBLICO{
		@Override
		public void corresponde(Usuario usuario1, Usuario usuario2, List<Visibilidad> lista,MainService servicio){
			lista.add(this);
		}
	}, 
	PRIVADO{
		@Override
		public void corresponde(Usuario usuario1, Usuario usuario2, List<Visibilidad> lista,MainService servicio){
			if (usuario1 == usuario2)
				lista.add(this);
		}
	},
	AMIGOS{
		@Override
		public void corresponde(Usuario usuario1, Usuario usuario2, List<Visibilidad> lista,MainService servicio){
			if(servicio.sonAmigos(usuario1, usuario2) || usuario1 == usuario2)
				lista.add(this);
		}
	};

	
}
