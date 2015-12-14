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
import ar.edu.unq.epers.home.UbicacionHome
import ar.edu.unq.epers.services.EmpresaService
import ar.edu.unq.epers.home.Calificacion
import ar.edu.unq.epers.home.ReservaHome
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.home.Visibilidad
import java.util.List

class MainService {
	
	HibernateRunner hbmRunner
	UsuarioHome usuarioHome
	AutoHome autoHome
	UbicacionHome ubicacionHome
	AmigosService amigosService
	ComentariosService comentariosService
	ReservaHome reservaHome
	EmpresaService empresaService
	
	new(){
		hbmRunner = new HibernateRunner
		HomeLocator::setInstance(new HibernateHomeLocator())
		usuarioHome = HomeLocator::instance.usuarioHome
		autoHome = HomeLocator::instance.autoHome
		ubicacionHome = HomeLocator::instance.ubicacionHome
		amigosService = new AmigosService
		comentariosService = new ComentariosService
		reservaHome = HomeLocator::instance.reservaHome
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
	 * Registra una Ubicacion en el sistema
	 */
	def registrarUbicacion(Ubicacion ubicacion) {
		hbmRunner.run([ubicacionHome.save(ubicacion)])
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
		hbmRunner.run([empresaService.realizarUnaReserva(usuario,origen,destino,inicio,fin)])
	}
	/**
	 * Realiza una reserva si chequear disponibilidad
	 */
	def realizarUnaReserva(Auto auto, Usuario usuario, Ubicacion origen, Ubicacion destino, Date inicio, Date fin) {
		hbmRunner.run([empresaService.realizarUnaReserva(auto,usuario,origen,destino,inicio,fin)])
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
	 * Indica si dos usuarios son amigos
	 */
	def sonAmigos(Usuario usuario1,Usuario usuario2){
		amigosDe(usuario2).contains(usuario1)
	}
	/**
	 * Retorna un usuario
	 */
	 def usuario(String usuario){
	 	hbmRunner.run([usuarioHome.getPorUsername(usuario)])
	 }
	 /**
	 * Retorna una Ubicacion
	 */
	 def ubicacion(String ubicacion){
	 	hbmRunner.run([ubicacionHome.getPorNombre(ubicacion)])
	 }
	 /**
	  * Retorna los autos disponibles en una fecha y ubicacion
	  */
	  def autosEnUnaUbicacion(Ubicacion unaUbicacion, Date inicio, Date fin){
	  	//empresaService.autosDisponibles(unaUbicacion,unaFecha)
	  	//hbmRunner.run([reservaService.autosDisponibles(unaUbicacion,unaFecha,autoHome.all)])
	  	hbmRunner.run([empresaService.autosDisponibles(unaUbicacion,inicio,fin)])
	  }
	/**
	 * Borra toda la información del sistema
	 */
	 def clean(){
	 	hbmRunner.resetSessionFactory
	 	amigosService.eliminarTodosLosNodosYRelaciones
	 	comentariosService.cleanDB
	 }
	
	/**
	 * Retorna toda la lista de reservas que hizo un usuario
	 */
	def consultarReservas(Usuario usuario) {
		hbmRunner.run([reservaHome.getPorUsername(usuario.usuario)])
	}
	
	def calificar(Usuario usuario, Reserva reserva, Calificacion calificacion, String unTexto, Visibilidad unaVisibilidad) {
		comentariosService.calificar(usuario,reserva,calificacion,unTexto,unaVisibilidad)
	}
	
	def obtenerComentario(Reserva unaReserva) {
		comentariosService.obtenerComentario(unaReserva)
	}
	
	def obtenerPerfilDeUsuario(Usuario usuarioConsultor, Usuario usuarioConsultado) {
		val listaDeVisibilidades = visibilidadesEntre(usuarioConsultado, usuarioConsultor)
		comentariosService.obtenerPerfilDeUsuario(usuarioConsultado, listaDeVisibilidades)
	}
	
	/**
	 * Genera una lista de visibilidades (PRIVADO, PUBLICO, AMIGOS)
	 * entre dos usuarios según su relación
	 */
	def private visibilidadesEntre(Usuario usuario, Usuario usuario2) {
		val lista = newArrayList
		visibilidadesPosibles.forEach[each | each.corresponde(usuario, usuario2, lista,this)]
		lista
	}
	
	def private visibilidadesPosibles() {
		#[Visibilidad.AMIGOS, Visibilidad.PRIVADO, Visibilidad.PUBLICO]
	}
	
}