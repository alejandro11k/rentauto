package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.ReservaHomeHbn
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.IUsuario
import ar.edu.unq.epers.model.Auto
import java.util.Date

class ReservaService {
	def crearReserva(Ubicacion origen,Ubicacion destino,
		Date fInicio,Date fFin,Auto auto,IUsuario iUsuario
	) {
		SessionManager.runInSession([
			var reserva = new Reserva()
			new ReservaHomeHbn().save(reserva)
			reserva
		]);
	}
}