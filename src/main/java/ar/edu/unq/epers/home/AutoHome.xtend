package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import java.util.Set
import java.util.List

abstract class AutoHome extends AbstractHome<Auto> {
	
	def Auto getPorPatente(String string)
	def List<Auto> getAll()
	def List<Auto> getPorCategoria(String unaCategoria)
}