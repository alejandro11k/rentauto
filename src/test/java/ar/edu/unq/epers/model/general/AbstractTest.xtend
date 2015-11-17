package ar.edu.unq.epers.model.general

import org.junit.Before
import ar.edu.unq.epers.model.Usuario
import org.joda.time.DateTime

class AbstractTest {
	
	MainService service
	Usuario usuarioPrueba
	Usuario usuarioPrueba2
	
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
	}
}