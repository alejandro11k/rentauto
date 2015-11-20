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

class MainServiceTest{

	MainService service
	Usuario usuarioPrueba
	Usuario usuarioPrueba2
	Auto unAuto
	Ubicacion retiro
	Ubicacion constitucion
	
	@Test
	def void amigarUsuarios(){
		service.amigar(usuarioPrueba, usuarioPrueba2)
		assertEquals(1, service.amigosDe(usuarioPrueba).size)
		assertTrue(service.amigosDe(usuarioPrueba).contains(usuarioPrueba2))
	}
	@Test
	def void realizarUnaReserva(){
		service.realizarUnaReserva(usuarioPrueba,retiro,constitucion,hoy(), nuevaFecha(2016,01,01))
		var usuarioConReserva = service.usuario("usuarioPrueba")
		assertEquals(1,usuarioConReserva.reservas.size())
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
		
		retiro = new Ubicacion('Retiro')
		constitucion = new Ubicacion('Constitucion')
		
		unAuto = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='BAD234'
			categoria = new Turismo
			ubicacionInicial = retiro
		]
		
		service.registrarAuto(unAuto)
		
		
		
		
		
	}
}