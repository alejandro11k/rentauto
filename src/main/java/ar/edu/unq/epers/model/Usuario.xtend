package ar.edu.unq.epers.model

import org.joda.time.DateTime
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.exceptions.UsuarioNoExisteException
import ar.edu.unq.epers.exceptions.NuevaPasswordInvalida

@Accessors class Usuario {
	
	String nombre
	String apellido
	String usuario
	String password
	String mail
	DateTime nacimiento
	String codigoDeValidacion
	boolean estaValidado
	
	new(String nombre, String apellido, String usuario, String password, String mail, DateTime nacimiento)
	{
		this.nombre = nombre
		this.apellido = apellido
		this.usuario = usuario
		this.password = password
		this.mail = mail
		this.nacimiento = nacimiento
		this.estaValidado = false
	}
	
	def passwordValida(String unaPassword) throws UsuarioNoExisteException{
		// Si un password es valida, me retorno a mi mismo.
		if (password == unaPassword)
			return this 
		else
			throw new UsuarioNoExisteException
	}
	
	override equals(Object other)
	// Dos usuarios son iguales, cuando su nombre de usuario es el mismo.
	{
	    if (other == null) 
	    	return false
	    if (other instanceof Usuario)
	    	return other.usuario == this.usuario
	}
	
	def cambiarPassword(String passwordActual, String passwordNueva)throws NuevaPasswordInvalida {
		if (passwordActual == password && passwordNueva != password)
			password = passwordNueva
		else
			throw new NuevaPasswordInvalida
	}
}