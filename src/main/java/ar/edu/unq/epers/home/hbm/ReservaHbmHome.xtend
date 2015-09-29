package ar.edu.unq.epers.home.hbm

import ar.edu.unq.epers.arq.runner.HibernateRunner
import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.model.Reserva

class ReservaHbmHome extends ReservaHome {
	
	override save(Reserva anObject) {
		HibernateRunner::currentSession().save(anObject)
	}
	
}