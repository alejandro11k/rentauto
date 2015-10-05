package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import org.junit.Test

import static org.junit.Assert.*
import ar.edu.unq.epers.model.rentautos.AbstractTestEmpty
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Turismo
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.TodoTerreno
import ar.edu.unq.epers.arq.NullObject

class EasyCategoriaTest extends AbstractTestEmpty{
		
	@Test
	def void categorias(){
		runner.run([
			val fam = HomeLocator::instance.categoriaHome.getNombre("Familiar")
			val fam2 = HomeLocator::instance.categoriaHome.getNombre("Familiar")
			assertEquals(fam2,fam)
			NullObject.NULL		
		])
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