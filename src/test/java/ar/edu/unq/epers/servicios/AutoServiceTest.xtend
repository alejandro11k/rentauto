package ar.edu.unq.epers.servicios

import org.junit.Assert
import org.junit.Test
import org.junit.Before

import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Turismo

class AutoServiceTest {
	
	@Before
	def void startUp(){
		new AutoService().crearAuto("","",1900,"",new Turismo(),100.00, new Ubicacion(""));
	}

	@Test
	def nada() {
		Assert.assertTrue(true)
	}
	
}