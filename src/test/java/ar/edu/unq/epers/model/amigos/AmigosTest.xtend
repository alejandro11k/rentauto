package ar.edu.unq.epers.model.amigos

import org.junit.Test

import static org.junit.Assert.*
import ar.edu.unq.epers.services.grafos.AmigosService
import ar.edu.unq.epers.model.Usuario
import org.junit.Before
import org.junit.After

class AmigosTest {
	Usuario usuario1
	Usuario usuario2
	AmigosService service
	
	@Test
	def void esAmigo(){
		val amigos = service.amigosDe(usuario1)
		assertEquals(1, amigos.length)
		assertEquals(amigos.head, usuario2)
	}
	
	@Test
	def void enviarMensajeAUnAmigo(){
		service.enviarMensaje(usuario1, usuario2, "Hola")
		assertEquals("Hola", service.mensajesRecibidos(usuario2).head.cuerpo)
		assertEquals(1, service.mensajesEnviados(usuario1).size)
	}
	
	@After
	def void after(){
		service => [
			eliminar(usuario1)
			eliminar(usuario2)
		]
	}
	
	@Before
	def void setUp(){
		usuario1 = new Usuario => [
			nombre = "Juan"
			apellido = "Perez"
			usuario = "jupe"
		]
		usuario2 = new Usuario => [
			nombre = "Jhon"
			apellido = "Perez"
			usuario = "jope"
		]
		service = new AmigosService
		service => [
			agregar(usuario1)
			agregar(usuario2)
			amigar(usuario1,usuario2)
		]	
	}
	
}