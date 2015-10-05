package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import org.junit.Test

import static org.junit.Assert.*
import ar.edu.unq.epers.model.rentautos.AbstractTestEmpty
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.arq.NullObject
import ar.edu.unq.epers.model.Turismo
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.TodoTerreno

class EasyAutoTest extends AbstractTestEmpty{
		
	@Test
	def void auto(){
		runner.run([
		val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
		assertEquals(unAuto,unAuto)
		NullObject.NULL	
		])
	}
	@Test
	def void autoCategoria(){
		runner.run([
		val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
		assertEquals(unAuto.categoria.nombre,new Familiar().nombre)
		NullObject.NULL	
		])
	}
	
//	@Test
//	def precioFamiliar(){
//		val auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
//		assertEquals(auto.costoTotal, auto.costoBase+200, 0)
//	}
//	
//	@Test
//	def precioTodoTerreno(){
//		val auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
//		auto.categoria = new TodoTerreno
//		assertEquals(auto.costoTotal, auto.costoBase*1.10, 0)
//	}
//	
//	@Test
//	def precioDeportivo(){
//		val auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
//		auto.categoria = new Deportivo
//		assertEquals(auto.costoTotal, auto.costoBase*1.20, 0)
//	}
//	
//	@Test
//	def precioTurismo(){
//		val auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
//		auto.categoria = new Turismo
//		assertEquals(auto.costoTotal, auto.costoBase - 200, 0)
//	}
	
	override fillMocks() {
		{
		runner.run([
			val autoHome = HomeLocator::instance.autoHome
			val usuarioHome = HomeLocator::instance.usuarioHome
			
			val categoriaHome = HomeLocator::instance.categoriaHome
			val Categoria familiar = new Familiar()
			//categoriaHome.save(familiar)
			
			val ubicacionHome = HomeLocator::instance.ubicacionHome
			val retiro = new Ubicacion("Retiro")
			//ubicacionHome.save(retiro)
			
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
			
			void
			
		])
	}
	}
	
}