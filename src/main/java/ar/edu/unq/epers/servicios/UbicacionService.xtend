package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.home.UbicacionHomeHbn

class UbicacionService {
	def crearUbicacion(String nombre) {
		SessionManager.runInSession([
			var ubicacion = new Ubicacion(nombre);
			new UbicacionHomeHbn().save(ubicacion)
			ubicacion
		]);
	}
	def consultarUbicacion(String id) {
		SessionManager.runInSession([
			new UbicacionHomeHbn().get(id)
		])
	}
}