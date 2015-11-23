package ar.edu.unq.epers.home.hbm

import ar.edu.unq.epers.arq.runner.HibernateRunner
import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.model.Reserva
import java.util.List

class ReservaHbmHome extends ReservaHome {
	
	override save(Reserva anObject) {
		HibernateRunner::currentSession().save(anObject)
	}
	
	def List<Reserva> getPorUsername(String usuario) {
		val q = HibernateRunner::currentSession().createQuery("from Reservas as r where r.usuario = :unvalor")
		q.setString("unvalor", usuario)
		q.list()
	}
	
}