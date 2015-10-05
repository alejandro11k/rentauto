package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import org.junit.Test

import static org.junit.Assert.*
import ar.edu.unq.epers.model.rentautos.AbstractTestEmpty
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.arq.NullObject

class EasyUbicacionesTest extends AbstractTestEmpty{
		
	@Test
	def void ubicaciones(){
		runner.run([
		var origen = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
		var destino = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
		assertEquals(origen,destino)
		
		assertTrue(true)
		NullObject.NULL	
		])
	}
	
	override fillMocks() {
		{
		runner.run([
			val ubicacionHome = HomeLocator::instance.ubicacionHome
			val retiro = new Ubicacion("Retiro")
			val aeroparque = new Ubicacion("Aeroparque")
			
			ubicacionHome => [
				save(retiro)
				save(aeroparque)
			]
		])
	}
	}
	
}