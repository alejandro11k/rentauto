package ar.edu.unq.epers.model.comentarios.test

import org.junit.Test

import static org.junit.Assert.*
import org.junit.Before
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Turismo
import ar.edu.unq.epers.model.comentarios.ParametrosDeCalificacion
import ar.edu.unq.epers.home.Calificacion
import ar.edu.unq.epers.services.comentarios.ComentariosService

class ComentariosTest {
	
	Usuario unUsuario
	Reserva unaReserva
	Auto unAuto
	
	ComentariosService service
	
	@Before
	def setUp(){
		val unUsuario = new Usuario => [
			nombre = "Juan"
			apellido = "Perez"
			usuario = "jupe"
		]
		
		val unAuto = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='BAD234'
			categoria = new Turismo
		]
		
		val unaReserva = new Reserva => [
			numeroSolicitud = 123
			origen = new Ubicacion('Avellaneda')
			destino = new Ubicacion('Bernal')
			usuario = unUsuario
			auto = unAuto
		]
	}
	
	@Test
	def void calificarUnaReserva(){
//		val calificacion = new ParametrosDeCalificacion => [
//			calificacion = Calificacion.MALO			
//		]
		service.calificar(unUsuario, unaReserva, Calificacion.MALO)
		
		val comentario = service.obtenerComentario(unUsuario, unaReserva)
		
		assertEquals(comentario.usuario, unUsuario)
		assertEquals(comentario.unaReserva, unaReserva)
		assertEquals(comentario.calificacion, Calificacion.MALO)
	}
	
//	@Test
//	def void calificarUnaReserva(){
//		calificacion = new ParametrosDeCalificacion => [
//			calificacion = Calificacion.MALO
//			comentario = "FUUU"
//			nivelDeVisibilidad = Visibilidad.PUBLICO
//			
//		]
//		usuario.calificar(unaReserva, calificacion)
//	}
}