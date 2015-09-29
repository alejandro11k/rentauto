package ar.edu.unq.epers.home.memory

import ar.edu.unq.epers.home.UsuarioHome
import ar.edu.unq.epers.model.Usuario
import java.util.Set

class UsuarioMemoryHome extends UsuarioHome {
	
	private Set<Usuario> usuarios = newHashSet
	
	override getPorUsername(String string) {
		usuarios.findFirst[each | each.usuario.equals(string)]
	}
	
	override save(Usuario unUsuario) {
		usuarios.add(unUsuario)
	}
	
}