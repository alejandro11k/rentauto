package ar.edu.unq.epers.model

import org.joda.time.DateTime
import org.eclipse.xtend.lib.annotations.Accessors

class Usuario {
	
	String nombre
	String apellido
	String usuario
	String password
	String mail
	DateTime nacimiento
	
	@Accessors
	String codigoDeValidacion
	@Accessors
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
	
	def getUsuario(){
		this.usuario
	}
	
	override equals(Object other)
	// Dos usuarios son iguales, cuando su nombre de usuario es el mismo.
	{
	    if (other == null) 
	    	return false
	    if (other instanceof Usuario)
	    	return other.usuario == this.usuario
	}	
}