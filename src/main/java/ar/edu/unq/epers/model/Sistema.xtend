package ar.edu.unq.epers.model

import ar.edu.unq.epers.home.Home
import ar.edu.unq.epers.home.HomeEnMemoria
import ar.edu.unq.epers.exceptions.UsuarioYaExisteException

class Sistema {

	Home persistor
	
	new(){
		this.persistor = new HomeEnMemoria()
	}	
	
	def registrarUsuario(Usuario usuario) throws UsuarioYaExisteException{
		var usuarioObtenido = persistor.dameAlUsuario(usuario)
		if (usuarioObtenido == null)
		{
			persistor.agregaUsuario(usuario)
		}
		else
		{
			throw new UsuarioYaExisteException()
		}
	}
	
}