package ar.edu.unq.epers.model

import ar.edu.unq.epers.home.Home
import ar.edu.unq.epers.home.HomeEnMemoria
import ar.edu.unq.epers.exceptions.UsuarioYaExisteException
import java.util.Map

class Sistema {

	Home persistorDeUsuarios
	
	new(){
		this.persistorDeUsuarios = new HomeEnMemoria()
	}	
	
	def registrarUsuario(Usuario usuario) throws UsuarioYaExisteException
	// Registra un Usuario en el sistema.
	// Si ya existe, lanza una excepcion.
	{
		var usuarioObtenido = persistorDeUsuarios.dameAlUsuario(usuario)
		if (usuarioObtenido == null)
			persistorDeUsuarios.agregaUsuario(usuario)
		else
			throw new UsuarioYaExisteException()
	}	
}