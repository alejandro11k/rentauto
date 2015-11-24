package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Usuario
import java.util.List

abstract class ReservaHome extends AbstractHome<Reserva> {
	
	def List<Reserva> getPorUsername(String usuario)
	
}