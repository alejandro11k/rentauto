package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.rentautos.AbstractTestEmpty
import org.junit.Test

import static org.junit.Assert.*

class EasyAutoTest extends AbstractTestEmpty{
		
	@Test
	def void auto(){
		runner.run([
		val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
		assertEquals(unAuto,unAuto)
		])
	}
	@Test
	def void autoCategoria(){
		runner.run([
		val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
		assertEquals(unAuto.categoria.nombre,new Familiar().nombre)
		])
	}
		
	override fillMocks() {
		{
		runner.run([
			val autoHome = HomeLocator::instance.autoHome
			val usuarioHome = HomeLocator::instance.usuarioHome
			
			val categoriaHome = HomeLocator::instance.categoriaHome
			val Categoria familiar = new Familiar()
			
			val ubicacionHome = HomeLocator::instance.ubicacionHome
			val retiro = new Ubicacion("Retiro")
			val auto = new Auto => [
				marca = "Peugeot"
				modelo = "505"
				año = 1990
				patente = "XXX123"
				costoBase = 100D
				categoria = familiar
				ubicacionInicial = retiro
			]
			
			autoHome.save(auto)
			
		])
	}
	}
	
}