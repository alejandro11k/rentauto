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
		service.calificar(unUsuario, unaReserva, Calificacion.MALO)
		
		val comentario = service.obtenerComentario(unaReserva)
		
		assertEquals(comentario.usuario, unUsuario.usuario)
		assertEquals(comentario.numeroSolicitud, unaReserva.numeroSolicitud)
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