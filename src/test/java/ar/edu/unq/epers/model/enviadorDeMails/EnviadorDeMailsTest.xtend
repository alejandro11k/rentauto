package ar.edu.unq.epers.model.enviadorDeMails

import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Sistema
import ar.edu.unq.epers.home.Home
import ar.edu.unq.epers.model.EnviadorDeMails
import org.junit.Before
import static org.mockito.Mockito.*
import org.junit.Test
import ar.edu.unq.epers.model.Mail

class EnviadorDeMailsTest {
	
	Sistema sistema
	Home persistor
	EnviadorDeMails enviadorDeMails
	Usuario usuario 
	
	@Before
	def void setUp(){
		persistor = mock(Home)
		enviadorDeMails = mock(EnviadorDeMails)
		
		usuario = mock(Usuario)
		
		when(usuario.codigoDeValidacion).thenReturn("")
		doNothing().when(enviadorDeMails).enviarMail(mock(Mail))
		//doNothing().when(persistor).agregaUsuario(usuario)
		//doNothing().when(persistor).agregarValidacionPendiente("","")
		
		sistema = new Sistema(persistor, enviadorDeMails)
	}
	
	//@Test
	//def void enviarMail(){
		//sistema.registrarUsuario(usuario)
		//verify(enviadorDeMails).enviarMail(mock(Mail))
	//}
}