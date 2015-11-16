package ar.edu.unq.epers.model.comentarios.test

import ar.edu.unq.epers.home.Calificacion
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Turismo
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.services.comentarios.ComentariosService
import org.junit.Before
import org.junit.Test

import static org.junit.Assert.*
import org.junit.After
import ar.edu.unq.epers.home.Visibilidad

class ComentariosTest {
	
	Usuario unUsuario
	Reserva unaReserva
	Auto unAuto
	ComentariosService service
	
	@Before
	def void setUp(){
		unUsuario = new Usuario => [
			nombre = "Juan"
			apellido = "Perez"
			usuario = "jupe"
		]
		
		unAuto = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='BAD234'
			categoria = new Turismo
		]
		
		unaReserva = new Reserva => [
			numeroSolicitud = 123
			origen = new Ubicacion('Avellaneda')
			destino = new Ubicacion('Bernal')
			usuario = unUsuario
			auto = unAuto
		]
		
		service = new ComentariosService
	}
	
	@After
	def void cleanDB(){
		service.cleanDB
	}
	
	@Test
	def void calificarUnaReserva(){
		service.calificar(unUsuario, unaReserva, Calificacion.MALO, "Malo")
		
		val comentario = service.obtenerComentario(unaReserva)
		
		assertEquals(unUsuario.usuario, comentario.usuario)
		assertEquals(unaReserva.numeroSolicitud, comentario.numeroSolicitud)
		assertEquals(Calificacion.MALO, comentario.calificacion)
		assertEquals("Malo", comentario.texto)
	}
	
	@Test
	def void calificarUnaReservaSinPrivacidad(){
		service.calificar(unUsuario, unaReserva, Calificacion.MALO, "Malo")
		
		val comentario = service.obtenerComentario(unaReserva)
		
		assertEquals(Visibilidad.PUBLICO, comentario.visibilidad)
	}
	
	@Test
	def void calificarUnaReservaSoloAmigos(){
		service.calificar(unUsuario, unaReserva, Calificacion.MALO, "Malo", Visibilidad.AMIGOS)
		
		val comentario = service.obtenerComentario(unaReserva)
		
		assertEquals(Visibilidad.AMIGOS, comentario.visibilidad)
	}
	
	@Test
	def void calificarUnaReservaPrivado(){
		service.calificar(unUsuario, unaReserva, Calificacion.MALO, "Malo", Visibilidad.PRIVADO)
		
		val comentario = service.obtenerComentario(unaReserva)
		
		assertEquals(Visibilidad.PRIVADO, comentario.visibilidad)
	}
}