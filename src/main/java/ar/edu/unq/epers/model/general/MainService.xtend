package ar.edu.unq.epers.model.general

import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.services.grafos.AmigosService
import ar.edu.unq.epers.home.UsuarioHome
import ar.edu.unq.epers.arq.homeLocator.HibernateHomeLocator
import ar.edu.unq.epers.arq.runner.HibernateRunner
import ar.edu.unq.epers.services.comentarios.ComentariosService
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.services.EmpresaService

class MainService {
	
	HibernateRunner hbmRunner
	UsuarioHome usuarioHome
	AutoHome autoHome
	AmigosService amigosService
	ComentariosService comentariosService
	EmpresaService empresaService
	
	new(){
		hbmRunner = new HibernateRunner
		HomeLocator::setInstance(new HibernateHomeLocator())
		usuarioHome = HomeLocator::instance.usuarioHome
		autoHome = HomeLocator::instance.autoHome
		amigosService = new AmigosService
		comentariosService = new ComentariosService
		empresaService = new EmpresaService(hbmRunner)
	}
	
	/**
	 * Registra un Usuario en el sistema
	 */
	def registrarUsuario(Usuario usuario) {
		hbmRunner.run([usuarioHome.save(usuario)])
		amigosService.agregar(usuario)
	}
	/**
	 * Registra un Auto en el sistema
	 */
	def registrarAuto(Auto auto) {
		hbmRunner.run([autoHome.save(auto)])
	}
	/**
	 * Permite realizar una reserva
	 */
	def realizarUnaReserva(Usuario usuario, Ubicacion origen, Ubicacion destino, Date inicio, Date fin) {
		empresaService.realizarUnaReserva(usuario,origen,destino,inicio,fin)
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
	 * Retorna un usuario
	 */
	 def usuario(String usuario){
	 	hbmRunner.run([usuarioHome.getPorUsername(usuario)])
	 }
	/**
	 * Borra toda la información del sistema
	 */
	 def clean(){
	 	hbmRunner.resetSessionFactory
	 	amigosService.eliminarTodosLosNodosYRelaciones
	 	comentariosService.cleanDB
	 }
}