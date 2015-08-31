package ar.edu.unq.epers.model.usuarios

import org.junit.Test

import static org.junit.Assert.*
import org.joda.time.DateTime
import org.junit.Before

class UsuariosTest {
	
	@Before
	def setUp(){
		var fecha = new DateTime(1980,04,11,0,0)
		var usuario = new Usuario('Alejandro','Kro','ak','123','a@a.com',fecha)
		var sistema = new Sistema()
		sistema.registrarUsuario(usuario)
		
	}
	
	@Test (expected=UsuarioYaExisteException.class)
	def registrarUsuarioExistente(){
		
		sistema.registrarUsuario(usuario)		
	}
	
	@Test
	def validacionDeUsuario(){
		
		sistema.validarCuenta(usuario.getCodigoDeValidacion())
		assertTrue(sistema.estaValidado(usuario))
		
	}
	
	@Test (expected=ValidacionException.class)
	def validacionDeCuentaConCodigoIncorrecto(){
		
		sistema.validarCuenta(usuario.getCodigoDeValidacion())
		sistema.validarCuenta(usuario.getCodigoDeValidacion())		
	}
	
	@Test
	def ingresoDeUsuarioValidado(){
		
		sistema.validarCuenta(usuario.getCodigoDeValidacion())
		val usuarioIngresado = sistema.ingresarUsuario(usuario.getNombreDeUsuario(), '123')
		
		assertEquals(usuario, usuarioLogeado)
	}
	
	@Test (expected=UsuarioNoRegistradoException.class)
	def ingresoDeUsuarioNoValidado(){
		
		sistema.ingresarUsuario(usuario.getNombreDeUsuario(), '123')
	}
	
	@Test (expected=UsuarioNoExiste.class)
	def ingresoDeUsuarioValidadoPasswordIncorrecta(){
		
		sistema.validarCuenta(usuario.getCodigoDeValidacion())
		sistema.ingresarUsuario(usuario.getNombreDeUsuario(), '555')
	}
	
	@Test (expected=UsuarioNoExiste.class)
	def ingresoDeUsuarioNoExistente(){
		
		sistema.validarCuenta(usuario.getCodigoDeValidacion())
		sistema.ingresarUsuario('abc', '555')
	}
	
	
	@Test
	def cambioDePasswordCorrecto(){
		
		sistema.validarCodigoDeUsuario(usuario,usuario.getCodigoDeValidacion())
		sistema.cambiarPassword('ak','123','321')
		
		val usuarioIngresado = sistema.ingresarUsuario(usuario.getNombreDeUsuario(), '321')
		
		assertEquals(usuario, usuarioIngresado)
	}
	
	@Test (expected=NuevaPasswordInvalida.class)
	def cambioDePasswordInvalido(){
		
		sistema.validarCodigoDeUsuario(usuario,usuario.getCodigoDeValidacion())
		sistema.cambiarPassword('ak','123','123')
	}
}