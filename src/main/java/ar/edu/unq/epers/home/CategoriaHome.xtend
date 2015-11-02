package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Categoria

abstract class CategoriaHome extends AbstractHome<Categoria> {
	
	def Categoria getNombre(String string)
	
}