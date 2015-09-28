package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Reserva

class ReservaHomeHbn {
	def save(Reserva j) {
		SessionManager.getSession().saveOrUpdate(j)
	}
}