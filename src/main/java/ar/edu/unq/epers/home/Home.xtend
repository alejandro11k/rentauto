package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Usuario

interface Home {
	
	def Usuario dameAlUsuario(Usuario usuario)
	def Usuario dameAlUsuarioConNombre(String unNombreDeUsuario)
	
	def void agregaUsuario(Usuario usuario)
	def void agregarValidacionPendiente(String unNombreDeUsuario, String unCodigoDeValidacion)
	// for test only
	def String getCodigoDeValidacion(Usuario unUsuario)
	
	// Un Usuario no existe en la lista de validaciones pendientes
	def boolean noIncluye(Usuario usuario)
	
	def Usuario dameAlUsuarioConCodigo(String unCodigoDeValidacion)
	
	def void borrarValidacionPara(Usuario unUsuario)
	
	def void actualizar(Usuario usuario)
	
	def boolean puedeValidarCodigo(String unCodigoDeValidacion)
	
}