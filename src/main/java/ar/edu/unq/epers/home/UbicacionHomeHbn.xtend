package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Ubicacion

class UbicacionHomeHbn {
	def save(Ubicacion j) {
		SessionManager.getSession().saveOrUpdate(j)
	}
	def get(String id){
		return SessionManager.getSession().get(typeof(Ubicacion) ,id) as Ubicacion
	}
}