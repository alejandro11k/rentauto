package ar.edu.unq.epers.model.general

import org.junit.Test
import ar.edu.unq.epers.model.Usuario
import org.joda.time.DateTime
import org.junit.Before
import static org.junit.Assert.*
import org.junit.After
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Turismo
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import static ar.edu.unq.epers.extensions.DateExtensions.*
import java.util.Date
import ar.edu.unq.epers.home.Calificacion
import ar.edu.unq.epers.home.Visibilidad

class MainServiceTest{

	MainService service
	Usuario usuarioPrueba
	Usuario usuarioPrueba2
	Auto unAuto
	Ubicacion retiro
	Ubicacion constitucion
	Date navidad
	Date anioNuevo
	
	@Test
	def void amigarUsuarios(){
		service.amigar(usuarioPrueba, usuarioPrueba2)
		assertEquals(1, service.amigosDe(usuarioPrueba).size)
		assertTrue(service.amigosDe(usuarioPrueba).contains(usuarioPrueba2))
	}
	@Test
	def void autosDisponiblesEnUnaUbicacionYUnaFecha(){
		var autosDisponibles = service.autosEnUnaUbicacion(retiro,navidad,navidad)
		assertEquals(unAuto,autosDisponibles.head)
	}
	@Test
	def void realizarUnaReserva(){
		
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		var usuarioConReserva = service.usuario("usuarioPrueba")
		assertEquals(1,usuarioConReserva.reservas.size())
	}
	@Test
	def void calificarUnaReserva(){
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		val unaReserva = service.consultarReservas(usuarioPrueba).head 
		service.calificar(usuarioPrueba, unaReserva, Calificacion.MALO, "Malo", Visibilidad.PUBLICO)
		
		val comentario = service.obtenerComentario(unaReserva)
		
		assertEquals(usuarioPrueba.usuario, comentario.usuario)
		assertEquals(unaReserva.numeroSolicitud, comentario.numeroSolicitud)
		assertEquals(Calificacion.MALO, comentario.calificacion)
		assertEquals("Malo", comentario.texto)
	}
	@Test
	def void verPerfilDeUnDesconocido(){
		val unAuto2 = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='asd432'
			categoria = new Turismo
			ubicacionInicial = retiro
		]
		val unAuto3 = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='ert432'
			categoria = new Turismo
			ubicacionInicial = retiro
		]
		service.registrarAuto(unAuto2)
		service.registrarAuto(unAuto3)
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		val unaReserva = service.consultarReservas(usuarioPrueba)
		service.calificar(usuarioPrueba, unaReserva.get(0), Calificacion.MALO, "Malo", Visibilidad.PRIVADO)
		service.calificar(usuarioPrueba, unaReserva.get(1), Calificacion.MALO, "Malo", Visibilidad.PUBLICO)
		service.calificar(usuarioPrueba, unaReserva.get(2), Calificacion.MALO, "Malo", Visibilidad.AMIGOS)
		
		val perfil = service.obtenerPerfilDeUsuario(usuarioPrueba2,usuarioPrueba)
		val current = perfil.size
		assertEquals(1, current)
	}
	
	@Test
	def void verPerfilDeUnAmigo(){
		val unAuto2 = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='asd432'
			categoria = new Turismo
			ubicacionInicial = retiro
		]
		val unAuto3 = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='ert432'
			categoria = new Turismo
			ubicacionInicial = retiro
		]
		service.registrarAuto(unAuto2)
		service.registrarAuto(unAuto3)
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		val unaReserva = service.consultarReservas(usuarioPrueba)
		service.calificar(usuarioPrueba, unaReserva.get(0), Calificacion.MALO, "Malo", Visibilidad.PRIVADO)
		service.calificar(usuarioPrueba, unaReserva.get(1), Calificacion.MALO, "Malo", Visibilidad.PUBLICO)
		service.calificar(usuarioPrueba, unaReserva.get(2), Calificacion.MALO, "Malo", Visibilidad.AMIGOS)
		
		service.amigar(usuarioPrueba,usuarioPrueba2)
		
		val perfil = service.obtenerPerfilDeUsuario(usuarioPrueba2,usuarioPrueba)
		val current = perfil.size
		assertEquals(2, current)
	}
	
		@Test
	def void verMiPerfil(){
		val unAuto2 = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='asd432'
			categoria = new Turismo
			ubicacionInicial = retiro
		]
		val unAuto3 = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='ert432'
			categoria = new Turismo
			ubicacionInicial = retiro
		]
		service.registrarAuto(unAuto2)
		service.registrarAuto(unAuto3)
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,navidad, anioNuevo)
		val unaReserva = service.consultarReservas(usuarioPrueba)
		service.calificar(usuarioPrueba, unaReserva.get(0), Calificacion.MALO, "Malo", Visibilidad.PRIVADO)
		service.calificar(usuarioPrueba, unaReserva.get(1), Calificacion.MALO, "Malo", Visibilidad.PUBLICO)
		service.calificar(usuarioPrueba, unaReserva.get(2), Calificacion.MALO, "Malo", Visibilidad.AMIGOS)
		
		val perfil = service.obtenerPerfilDeUsuario(usuarioPrueba,usuarioPrueba)
		val current = perfil.size
		assertEquals(3, current)
	}
	
	@After
	def void tearDown(){
		service.clean
	}
	
	@Before
	def void setUp(){
		service = new MainService
		
		usuarioPrueba = new Usuario => [
				nombre = "Pepe"
				apellido = "Pruebas"
				usuario = "usuarioPrueba"
				password = "pss"
				mail = "mail@mail.com"
				nacimiento = new DateTime(1990,05,05,0,0) 
				estaValidado = true
			]
			
		service.registrarUsuario(usuarioPrueba)
			
		usuarioPrueba2 = new Usuario => [
				nombre = "Pepe2"
				apellido = "Pruebas2"
				usuario = "usuarioPrueba2"
				password = "pss"
				mail = "mail@mail.com"
				nacimiento = new DateTime(1990,05,05,0,0) 
				estaValidado = true
			]
		
		service.registrarUsuario(usuarioPrueba2)
		
		service.registrarUbicacion(new Ubicacion('Retiro'))
		service.registrarUbicacion(new Ubicacion('Constitucion'))
		
		retiro = service.ubicacion('Retiro') 
		constitucion = service.ubicacion('Constitucion') 
		
		unAuto = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='BAD234'
			categoria = new Turismo
			ubicacionInicial = retiro
		]
		
		
		service.registrarAuto(unAuto)
		
		navidad = nuevaFecha(2015,12,25)
		anioNuevo = nuevaFecha(2016,01,01)

	}
}