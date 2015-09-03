package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Usuario
import java.util.Collection
import java.util.ArrayList

class HomeEnMemoria implements Home{
	
	Collection<Usuario> usuarios
	Collection<Pair<String,String>> validaciones
	
	new()
	{
		usuarios = newArrayList()
		validaciones = newArrayList()
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
	override  agregarValidacionPendiente(Pair<String,String> usuarioCodigo){
		validaciones.add(usuarioCodigo)
	}
	override getCodigoDeValidacion(String usuario){
		'hi'
	}
	
	
}