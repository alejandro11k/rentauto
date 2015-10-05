package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.rentautos.AbstractTestEmpty
import org.junit.Test
import static ar.edu.unq.epers.extensions.DateExtensions.*
import static org.junit.Assert.*
import ar.edu.unq.epers.services.EmpresaService

class EasyServiceTest extends AbstractTestEmpty{
		
	@Test
	def void autosSinReservas(){
		runner.run([
			val es = new EmpresaService(runner)
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			val autosDisponibles = es.autosDisponibles(retiro, hoy())
			val autoEsperado = HomeLocator.instance.autoHome.getPorPatente("XXX123")
			
			assertTrue(autosDisponibles.contains(autoEsperado))
			assertEquals(1, autosDisponibles.size)
		])
	}

	@Test
	def void autosReservados(){
		runner.run([
			val es = new EmpresaService(runner)
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			val autosDisponibles = es.autosDisponibles(retiro, hoy())
			val autoEsperado = HomeLocator.instance.autoHome.getPorPatente("XXX123")
			
			assertTrue(autosDisponibles.contains(autoEsperado))
			assertEquals(1, autosDisponibles.size)
		])
	}

		
	override fillMocks() {
		{
		runner.run([
			val autoHome = HomeLocator::instance.autoHome
			val Categoria familiar = new Familiar()
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