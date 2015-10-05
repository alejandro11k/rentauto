package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import org.junit.Test

import static org.junit.Assert.*
import ar.edu.unq.epers.model.rentautos.AbstractTestEmpty
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Turismo
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.TodoTerreno

class EasyCategoriaTest extends AbstractTestEmpty{
		
	@Test
	def categorias(){
		var fam = HomeLocator::instance.ubicacionHome.getPorNombre("Familiar")
		var fam2 = HomeLocator::instance.ubicacionHome.getPorNombre("Familiar")
		assertEquals(fam2,fam)
		
		assertTrue(true)
	}
	
	override fillMocks() {
		{
		runner.run([
			val categoriaHome = HomeLocator::instance.categoriaHome
			
			val Categoria familiar = new Familiar()
			val Categoria turismo = new Turismo()
			val Categoria deportivo = new Deportivo()
			val Categoria todoTerreno = new TodoTerreno()
			
			categoriaHome => [
				save(familiar)
				save(turismo)
				save(deportivo)
				save(todoTerreno)
			]
		])
	}
	}
	
}