package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Usuario

interface Home {
	
	def Usuario dameAlUsuario(Usuario usuario)
	def void agregaUsuario(Usuario usuario)
	
}