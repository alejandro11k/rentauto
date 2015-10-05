package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import org.junit.Test

import static org.junit.Assert.*
import ar.edu.unq.epers.model.rentautos.AbstractTestEmpty
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Familiar

class EasyAutoTest extends AbstractTestEmpty{
		
	@Test
	def auto(){
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
			
			val auto = new Auto => [
				marca = "Peugeot"
				modelo = "505"
				año = 1990
				patente = "XXX123"
				costoBase = 100D
				categoria = new Familiar()
				ubicacionInicial = new Ubicacion("Retiro")
			]
			
			autoHome.save(auto)
			
			void
			
		])
	}
	}
	
}