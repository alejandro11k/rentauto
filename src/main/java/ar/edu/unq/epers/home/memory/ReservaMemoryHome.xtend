package ar.edu.unq.epers.home.memory

import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.model.Reserva
import java.util.Set

class ReservaMemoryHome extends ReservaHome {
	
	private Set<Reserva> reservas = newHashSet
	
	override save(Reserva unaReserva) {
		reservas.add(unaReserva)
	}
	
}