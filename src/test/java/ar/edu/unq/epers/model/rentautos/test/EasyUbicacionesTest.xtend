package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import org.junit.Test

import static org.junit.Assert.*
import ar.edu.unq.epers.model.rentautos.AbstractTestEmpty
import ar.edu.unq.epers.model.Ubicacion

class EasyUbicacionesTest extends AbstractTestEmpty{
		
	@Test
	def ubicaciones(){
		var origen = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
		var destino = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
		assertEquals(origen,destino)
		
		assertTrue(true)
	}
	
	override fillMocks() {
		{
		runner.run([
			val empresaHome = HomeLocator::instance.empresaHome
			val autoHome = HomeLocator::instance.autoHome
			val ubicacionHome = HomeLocator::instance.ubicacionHome
			val usuarioHome = HomeLocator::instance.usuarioHome
			
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