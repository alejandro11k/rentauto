package ar.edu.unq.epers.home.hbm

import ar.edu.unq.epers.home.UsuarioHome
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.arq.runner.HibernateRunner

class UsuarioHbmHome extends UsuarioHome {
	
	override getPorUsername(String string) {
		HibernateRunner::currentSession().get(typeof(Usuario) ,string) as Usuario
	}
	
	override save(Usuario anObject) {
		HibernateRunner::currentSession().save(anObject)
	}
	
}