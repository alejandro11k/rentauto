package ar.edu.unq.epers.model

import ar.edu.unq.epers.home.Home
import ar.edu.unq.epers.home.HomeEnMemoria
import ar.edu.unq.epers.exceptions.UsuarioYaExisteException
import java.util.Map

class Sistema {

	Home persistorDeUsuarios
	Validador validador
	
	new(){
		this.persistorDeUsuarios = new HomeEnMemoria()
		this.validador = new Validador
	}	
	
	def registrarUsuario(Usuario usuario) throws UsuarioYaExisteException
	// Registra un Usuario en el sistema.
	// Si ya existe, lanza una excepcion.
	{
		var usuarioObtenido = persistorDeUsuarios.dameAlUsuario(usuario)
		if (usuarioObtenido == null){
			persistorDeUsuarios.agregaUsuario(usuario)
			val usuarioCodigo = usuario.getUsuario -> validador.generarCodigoDeValidacion
			persistorDeUsuarios.agregarValidacionPendiente(usuarioCodigo)		
		}
		else
			throw new UsuarioYaExisteException()
	}	
	
	def getCodigoDeValidacion(String usuario){
		persistorDeUsuarios.getCodigoDeValidacion(usuario)
	}
	
	def validarCuenta(String codigoDeValidacion){
		
	}
	
	def estaValidado(Usuario usuario){
		false
	}
	
	
	
	
	
}