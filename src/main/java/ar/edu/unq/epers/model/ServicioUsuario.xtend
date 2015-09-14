package ar.edu.unq.epers.model

import ar.edu.unq.epers.exceptions.NuevaPasswordInvalida
import ar.edu.unq.epers.exceptions.UsuarioNoExisteException
import ar.edu.unq.epers.exceptions.UsuarioYaExisteException
import ar.edu.unq.epers.exceptions.ValidacionException
import ar.edu.unq.epers.home.Home

class Sistema {

	Home persistorDeUsuarios
	Validador validador
	EnviadorDeMails enviador
	
	new(Home persistorDeUsuarios, EnviadorDeMails enviador){
		this.persistorDeUsuarios = persistorDeUsuarios
		this.validador = new Validador
		this.enviador = enviador
	}
	
	/**
	 * Registra un Usuario en el Sistema 
	 * 
	 * @param usuario El usuario que se quiere registrar
	 * @throws UsuarioYaExisteException si ya fue registrado
	 */
	def registrarUsuario(Usuario usuario) throws UsuarioYaExisteException
	{
		if (puedoRegistrar(usuario)){
			// Genero un codigo de validacion
			var nuevoCodigoDeValidacion = validador.generarCodigoDeValidacion
			
			// Le asigno el codigo al Usuario
			usuario.codigoDeValidacion = nuevoCodigoDeValidacion			
			persistorDeUsuarios.agregaUsuario(usuario)
			
			// Agrego una nueva validacion pendiente a mi lista de validaciones pendientes
			persistorDeUsuarios.agregarValidacionPendiente(usuario.usuario, nuevoCodigoDeValidacion)
			
			var mail = new Mail			
			this.enviador.enviarMail(mail)		
		}
		else
			throw new UsuarioYaExisteException()
	}
	
	/**
	 * Indica si el usuario ya existe en el sistema
	 * 
	 * @param unUsuario el usuario a verificar
	 */
	private def puedoRegistrar(Usuario unUsuario) {
		persistorDeUsuarios.dameAlUsuario(unUsuario) == null
	}	
	
	def getCodigoDeValidacion(Usuario usuario){
		persistorDeUsuarios.getCodigoDeValidacion(usuario)
	}
	
	/**
	 * Valida un usuario registrado para que este pueda operar
	 * 
	 * @param codigoDeValidacion el codigo de validacion unico del usuario
	 * @throws ValidacionException si el codigo de validacion es invalido o 
	 * el usuario fue validado
	 */
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
	
	/**
	 * Loguea un usuario en el sistema
	 * 
	 * @param unNombreDeUsuario el nombre del usuario a loguear
	 * @param unaClaveDeUsuario la clave del usuario
	 * 
	 * @throws UsuarioNoExisteException 
	 * si el usuario no existe,
	 * ingreso un nombre incorrecto,
	 * ingreso una contraseña incorrecta,
	 * no fue validado.
	 */
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