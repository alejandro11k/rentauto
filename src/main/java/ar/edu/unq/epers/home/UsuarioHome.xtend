package ar.edu.unq.epers.home

import ar.edu.unq.epers.home.AbstractHome
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.IUsuario

abstract class UsuarioHome extends AbstractHome<Usuario> {
	
	def IUsuario getPorUsername(String string)
	
}