package ar.edu.unq.epers.home.hbm

import ar.edu.unq.epers.home.UbicacionHome
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.arq.runner.HibernateRunner

class UbicacionHbmHome extends UbicacionHome {
	
	override getPorNombre(String string) {
		HibernateRunner::currentSession().get(typeof(Ubicacion) ,string) as Ubicacion
	}
	
	override save(Ubicacion anObject) {
		HibernateRunner::currentSession().save(anObject)
	}
	
}