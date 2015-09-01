package ar.edu.unq.epers.model

import org.joda.time.DateTime

class Usuario {
	
	String nombre
	String apellido
	String usuario
	String password
	String mail
	DateTime nacimiento
	
	new(String nombre, String apellido, String usuario, String password, String mail, DateTime nacimiento) {
		this.nombre = nombre
		this.apellido = apellido
		this.usuario = usuario
		this.password = password
		this.mail = mail
		this.nacimiento = nacimiento
	}
	
	override equals(Object other) {
	    if (other == null) return false;
	    if (other == this) return true;
	    if (other instanceof Usuario) return true;
	}
	
}