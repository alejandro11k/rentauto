package ar.edu.unq.epers.home.hbm

import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.arq.runner.HibernateRunner

class AutoHbmHome extends AutoHome {
	
	override getPorPatente(String patente) {
		HibernateRunner::currentSession().get(typeof(Auto) ,patente) as Auto
	}
	
	override save(Auto unAuto) {
		HibernateRunner::currentSession().save(unAuto)
	}
	
}