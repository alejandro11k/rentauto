package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.IUsuario
import ar.edu.unq.epers.model.Usuario

abstract class UsuarioHome extends AbstractHome<Usuario> {
	
	def IUsuario getPorUsername(String string)
	
}