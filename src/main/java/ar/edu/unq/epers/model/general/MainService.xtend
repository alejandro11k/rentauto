package ar.edu.unq.epers.model.general

import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.services.grafos.AmigosService
import ar.edu.unq.epers.home.UsuarioHome
import ar.edu.unq.epers.arq.homeLocator.HibernateHomeLocator
import ar.edu.unq.epers.arq.runner.HibernateRunner

class MainService {
	
	HibernateRunner hbmRunner
	UsuarioHome usuarioHome
	AmigosService amigosService
	
	new(){
		hbmRunner = new HibernateRunner
		HomeLocator::setInstance(new HibernateHomeLocator())
		usuarioHome = HomeLocator::instance.usuarioHome
		amigosService = new AmigosService
	}
	
	/**
	 * Registra un Usuario en el sistema
	 */
	def registrarUsuario(Usuario usuario) {
		hbmRunner.run([usuarioHome.save(usuario)])
		amigosService.agregar(usuario)
	}
	
	/**
	 * Genera una relación de amistad entre dos usuarios
	 */
	def amigar(Usuario usuario, Usuario usuario2) {
		amigosService.amigar(usuario, usuario2)
	}
	
	/**
	 * Retorna una colección con los amigos del usuario indicado
	 */
	def amigosDe(Usuario usuario) {
		amigosService.amigosDe(usuario)
	}
	
	/**
	 * Borra toda la información del sistema
	 */
	 def clean(){
	 	hbmRunner.resetSessionFactory
	 	amigosService.eliminarTodosLosNodosYRelaciones
	 }
}