package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Auto

abstract class AutoHome extends AbstractHome<Auto> {
	
	def Auto getPorPatente(String string)

}