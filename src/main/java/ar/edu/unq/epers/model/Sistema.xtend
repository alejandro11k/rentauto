package ar.edu.unq.epers.model

import ar.edu.unq.epers.exceptions.UsuarioYaExisteException
import ar.edu.unq.epers.home.Home
import ar.edu.unq.epers.home.HomeEnMemoria
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
		if (puedoRegistrar(usuario)){
			// Genero un codigo de validacion
			var nuevoCodigoDeValidacion = validador.generarCodigoDeValidacion
			
			// Le asigno el codigo al Usuario
			usuario.codigoDeValidacion = nuevoCodigoDeValidacion			
			persistorDeUsuarios.agregaUsuario(usuario)
			
			// Agrego una nueva validacion pendiente a mi lista de validaciones pendientes
			persistorDeUsuarios.agregarValidacionPendiente(usuario.usuario, nuevoCodigoDeValidacion)		
		}
		else
			throw new UsuarioYaExisteException()
	}
	
	private def puedoRegistrar(Usuario unUsuario) {
		persistorDeUsuarios.dameAlUsuario(unUsuario) == null
	}	
	
	def getCodigoDeValidacion(Usuario usuario){
		persistorDeUsuarios.getCodigoDeValidacion(usuario)
	}
	
	def validarCuenta(String codigoDeValidacion){
		var usuario = persistorDeUsuarios.dameAlUsuarioConCodigo(codigoDeValidacion)
		usuario.estaValidado = true
		persistorDeUsuarios.borrarValidacionPara(usuario)
		persistorDeUsuarios.actualizar(usuario)
		
	}
	
	def boolean estaValidado(Usuario usuario){
		usuario.estaValidado && persistorDeUsuarios.noIncluye(usuario)
	}	
}