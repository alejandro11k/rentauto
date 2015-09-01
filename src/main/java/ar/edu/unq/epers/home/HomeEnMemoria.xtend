package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Usuario
import java.util.Collection
import java.util.ArrayList

class HomeEnMemoria implements Home{
	
	Collection<Usuario> usuarios
	
	new()
	{
		usuarios = newArrayList()
	}
	
	override dameAlUsuario(Usuario usuario) {
		for (Usuario usuarioEnLista: usuarios)
		{
			if (usuarioEnLista == usuario)
				return usuarioEnLista
		}
		return null
	}
	
	override agregaUsuario(Usuario usuario) {
		usuarios.add(usuario)
	}
	
}