package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Usuario

interface Home {
	
	def Usuario dameAlUsuario(Usuario usuario)
	def void agregaUsuario(Usuario usuario)
	def void agregarValidacionPendiente(Pair<String,String> usuarioCodigo)
	// for test only
	def String getCodigoDeValidacion(String Usuario)
}