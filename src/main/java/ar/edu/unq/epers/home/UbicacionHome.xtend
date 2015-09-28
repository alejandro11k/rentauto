package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Ubicacion

abstract class UbicacionHome extends AbstractHome<Ubicacion> {
	
	def Ubicacion getPorNombre(String string)
	
}