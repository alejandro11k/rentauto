package ar.edu.unq.epers.model

import ar.edu.unq.epers.exceptions.NuevaPasswordInvalida
import ar.edu.unq.epers.exceptions.UsuarioNoExisteException
import ar.edu.unq.epers.exceptions.UsuarioYaExisteException
import ar.edu.unq.epers.exceptions.ValidacionException
import ar.edu.unq.epers.home.Home

class Sistema {

	Home persistorDeUsuarios
	Validador validador
	
	new(Home persistorDeUsuarios){
		this.persistorDeUsuarios = persistorDeUsuarios
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
		if (persistorDeUsuarios.puedeValidarCodigo(codigoDeValidacion)){
			var usuario = persistorDeUsuarios.dameAlUsuarioConCodigo(codigoDeValidacion)
			usuario.estaValidado = true
			persistorDeUsuarios.borrarValidacionPara(usuario)
			persistorDeUsuarios.actualizar(usuario)
		}
		else
			throw new ValidacionException
		
	}
	
	def boolean estaValidado(Usuario usuario){
		persistorDeUsuarios.dameAlUsuario(usuario).estaValidado
	}
	
	def ingresarUsuario(String unNombreDeUsuario, String unaClaveDeUsuario) throws UsuarioNoExisteException {
		var usuario = persistorDeUsuarios.dameAlUsuarioConNombre(unNombreDeUsuario)
		if (usuario != null && estaValidado(usuario)){
			usuario.passwordValida(unaClaveDeUsuario)			
		}
		else{
			throw new UsuarioNoExisteException
		}
	}
	
	def void cambiarPassword(String nombreDeUsuario, String passwordActual, String passwordNueva) throws NuevaPasswordInvalida {
		var usuario = persistorDeUsuarios.dameAlUsuarioConNombre(nombreDeUsuario)
		usuario.cambiarPassword(passwordActual, passwordNueva)
		persistorDeUsuarios.actualizar(usuario)
	}
	
}