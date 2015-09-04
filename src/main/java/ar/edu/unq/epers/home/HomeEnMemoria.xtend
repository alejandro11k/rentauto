package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Usuario
import java.util.Collection
import java.util.ArrayList
import java.util.Map
import java.util.Set

class HomeEnMemoria implements Home{
	
	Set<Usuario> usuarios
	Map<String,String> validaciones
	
	new()
	{
		usuarios = newHashSet()
		validaciones = newHashMap()
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
	override agregarValidacionPendiente(String unNombreDeUsuario,String unCodigoDeValidacion){
		validaciones.put(unNombreDeUsuario, unCodigoDeValidacion)
	}
	override getCodigoDeValidacion(Usuario usuario){
		usuario.codigoDeValidacion
	}
	
	override noIncluye(Usuario usuario) {
		!validaciones.containsKey(usuario.usuario)
	}
	
	override dameAlUsuarioConCodigo(String unCodigoDeValidacion) {
//		var validacionesIt = validaciones.entrySet.iterator
//		
//		while (validacionesIt.hasNext){
//			if (validacionesIt.next.value == unCodigoDeValidacion)
//				return dameAlUsuarioConNombre(validacionesIt.next.key)
//		}
		
		for (Map.Entry<String,String> entry : validaciones.entrySet()) {
		    if (entry.value == unCodigoDeValidacion)
		    	return dameAlUsuarioConNombre(entry.key)
		}		
	}
	
	override borrarValidacionPara(Usuario unUsuario) {
		validaciones.remove(unUsuario)
	}
	
	override actualizar(Usuario usuario) {
		usuarios.remove(usuario)
		usuarios.add(usuario)
	}
	
	override dameAlUsuarioConNombre(String unNombreDeUsuario) {	
		for (Usuario usuario : usuarios) {
		    if (usuario.usuario == unNombreDeUsuario)
		    	return usuario
		}	
	}
	
}