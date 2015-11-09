package ar.edu.unq.epers.model.amigos

import org.junit.Test

import static org.junit.Assert.*
import ar.edu.unq.epers.services.grafos.AmigosService
import ar.edu.unq.epers.model.Usuario
import org.junit.Before
import org.junit.After
import java.util.LinkedHashSet

class AmigosTest {
	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	Usuario usuario4
	Usuario usuario5
	Usuario usuario6
	AmigosService service
	
	@Test
	def void esAmigo(){
		val amigos = service.amigosDe(usuario1)
		assertEquals(3, amigos.length)
		//val amigosDeUsuario1 = new LinkedHashSet()
		//amigosDeUsuario1.addAll(usuario2,usuario3,usuario5)
		assertTrue(amigos.contains(usuario2))
		assertTrue(amigos.contains(usuario3))
		assertTrue(amigos.contains(usuario5))
		
	}
	@Test
	def void tieneUnSoloAmigo(){
		service.amigar(usuario5,usuario1)
		val amigos = service.amigosDe(usuario5)
		assertEquals(1, amigos.length)
		assertEquals(amigos.head,usuario1)
	}
	
	@Test
	def void enviarMensajeAUnAmigo(){
		service.enviarMensaje(usuario1, usuario2, "Hola")
		assertEquals("Hola", service.mensajesRecibidos(usuario2).head.cuerpo)
		assertEquals(1, service.mensajesEnviados(usuario1).size)
	}
	
	@Test
	def void amigosDeUsuarioConAmigos(){
		val result = service.amigosDeAmigos(usuario1)
		assertEquals(4, result.size)
		assertFalse(result.contains(usuario6))
	}
	
	@Test
	def void amigosDeUsuarioConAmigosEnElMedio(){
		val result = service.amigosDeAmigos(usuario3)
		assertEquals(4, result.size)
		assertFalse(result.contains(usuario6))
		assertTrue(result.contains(usuario1))
		assertTrue(result.contains(usuario2))
		assertTrue(result.contains(usuario4))
		assertTrue(result.contains(usuario5))
		
	}
	
	@Test
	def void amigosDeUsuarioSinAmigos(){
		val result = service.amigosDeAmigos(usuario6)
		assertTrue(result.empty)
	}
	
	@After
	def void after(){
		service.eliminarTodosLosNodosYRelaciones
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
		usuario3 = new Usuario => [
			nombre = "Pepe"
			apellido = "Pepez"
			usuario = "pepe2"
		]
		usuario4 = new Usuario =>  [
			nombre = "Pepita"
			apellido = "Golondrina"
			usuario = "pepita"
		]
		usuario5 = new Usuario => [
			nombre = "ASD"
			apellido = "TEST"
			usuario = "test"
		]
		usuario6 = new Usuario => [
			nombre = "Forever"
			apellido = "Alone"
			usuario = "falone"
		]
		
		service = new AmigosService
		service => [
			agregar(usuario1)
			agregar(usuario2)
			agregar(usuario3)
			agregar(usuario4)
			agregar(usuario5)
			agregar(usuario6)
			amigar(usuario1,usuario2)
			amigar(usuario2,usuario3)
			amigar(usuario2,usuario4)
			amigar(usuario1,usuario5)
			amigar(usuario3,usuario1)
		]	
	}
	
}