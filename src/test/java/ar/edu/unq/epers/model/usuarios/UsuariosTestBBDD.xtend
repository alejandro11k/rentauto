package ar.edu.unq.epers.model.usuarios

import ar.edu.unq.epers.exceptions.NuevaPasswordInvalida
import ar.edu.unq.epers.exceptions.UsuarioNoExisteException
import ar.edu.unq.epers.exceptions.UsuarioYaExisteException
import ar.edu.unq.epers.exceptions.ValidacionException
import ar.edu.unq.epers.home.Home
import ar.edu.unq.epers.home.HomeBBDD
import ar.edu.unq.epers.model.EnviadorDeMails
import ar.edu.unq.epers.model.Sistema
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Validador
import org.joda.time.DateTime
import org.junit.After
import org.junit.Before
import org.junit.Test

import static org.junit.Assert.*
import static org.mockito.Mockito.*

class UsuariosTestBBDD {
	
	Sistema sistema
	Usuario usuario
	DateTime fecha
	Home persistor
	EnviadorDeMails enviadorDeMails
	
	@Before
	def void setUp(){
		fecha = new DateTime(1980,04,11,0,0)
		usuario = new Usuario('Alejandro','Kro','ak','123','a@a.com',fecha)
		persistor = new HomeBBDD()
		enviadorDeMails = mock(EnviadorDeMails)
		sistema = new Sistema(persistor, enviadorDeMails)
		sistema.registrarUsuario(usuario)
		
	}
	
	@After
	def void tearDown(){
		persistor.eliminarRegistros()
	}
	
	@Test
	def void igualdadEntreUsuarios(){
		assertEquals(usuario,usuario)
	}
	
	@Test
	def void dameAlUsuario(){
		assertEquals(persistor.dameAlUsuario(usuario),usuario)
	}
	
	@Test(expected = UsuarioYaExisteException)
	def void registrarUsuarioExistente(){
		
		var usuarioBis = new Usuario('Alejandru','Kro','ak','123','a@a.com',fecha)
		sistema.registrarUsuario(usuarioBis)
		
	}
	
	@Test
	def obterCodigoDeValidacion(){
		var validador = new Validador
		assertEquals(validador.generarCodigoDeValidacion.length,6)
		
	}
	
	@Test
	def validacionDeUsuario(){
		
		var codigoDeValidacion = usuario.codigoDeValidacion
		sistema.validarCuenta(codigoDeValidacion)
		
		var usuarioEnSistema = persistor.dameAlUsuario(usuario)
		
		assertTrue(usuarioEnSistema.estaValidado)
		
	}
	
	@Test (expected=ValidacionException)
	def void validacionDeCuentaConCodigoIncorrecto(){
		
		sistema.validarCuenta(usuario.getCodigoDeValidacion())
		sistema.validarCuenta(usuario.getCodigoDeValidacion())
	}
	
	@Test
	def ingresoDeUsuarioValidado(){
		
		sistema.validarCuenta(usuario.codigoDeValidacion)
		
		val usuarioIngresado = sistema.ingresarUsuario(usuario.usuario, '123')
		
		assertEquals(usuario, usuarioIngresado)
	}
	
	@Test (expected=UsuarioNoExisteException)
	def void ingresoDeUsuarioNoValidado(){
		sistema.ingresarUsuario(usuario.usuario, '123')
	}
	
	@Test (expected=UsuarioNoExisteException)
	def void ingresoDeUsuarioValidadoPasswordIncorrecta(){
		
		sistema.validarCuenta(usuario.codigoDeValidacion)
		sistema.ingresarUsuario(usuario.usuario, '555')
	}
	
	@Test (expected=UsuarioNoExisteException)
	def void ingresoDeUsuarioNoExistente(){
		
		sistema.validarCuenta(usuario.codigoDeValidacion)
		sistema.ingresarUsuario('abc', '555')
	}
	
	
	@Test
	def cambioDePasswordCorrecto(){
		
		sistema.validarCuenta(usuario.codigoDeValidacion)
		sistema.cambiarPassword('ak','123','321')
		
		val usuarioIngresado = sistema.ingresarUsuario(usuario.usuario, '321')
		
		assertEquals(usuario, usuarioIngresado)
	}
	
	@Test (expected=NuevaPasswordInvalida)
	def cambioDePasswordInvalido(){
		
		sistema.validarCuenta(usuario.codigoDeValidacion)
		sistema.cambiarPassword('ak','123','123')
	}
}