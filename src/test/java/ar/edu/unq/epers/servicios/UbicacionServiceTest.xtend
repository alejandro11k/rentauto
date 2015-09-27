package ar.edu.unq.epers.servicios

import org.junit.Before
import org.junit.Test
import org.junit.Assert

class UbicacionServiceTest {
	@Before
	def void startUp(){
		new UbicacionService().crearUbicacion("Don Bosco")
	}

	@Test
	def consultar() {
		var ubicacion = new UbicacionService().consultarUbicacion("Don Bosco");
		Assert.assertEquals(1,1);
	}
}