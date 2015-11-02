package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.model.Deportivo
import ar.edu.unq.epers.model.TodoTerreno
import ar.edu.unq.epers.model.Turismo
import ar.edu.unq.epers.model.rentautos.AbstractTest
import org.junit.Test

import static org.junit.Assert.*

class CalculoDePrecioTest extends AbstractTest {

	@Test
	def void precioFamiliar() {
		runner.run([
			val auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
			assertEquals(auto.costoTotal, auto.costoBase + 200, 0)
		])
	}

	@Test
	def void precioTodoTerreno() {
		runner.run([
			val auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
			auto.categoria = new TodoTerreno
			assertEquals(auto.costoTotal, auto.costoBase * 1.10, 0)
		])
	}

	@Test
	def void precioDeportivo() {
		runner.run([
			val auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
			auto.categoria = new Deportivo
			assertEquals(auto.costoTotal, auto.costoBase * 1.20, 0)
		])
	}

	@Test
	def void precioTurismo() {
		runner.run([
			val auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
			auto.categoria = new Turismo
			assertEquals(auto.costoTotal, auto.costoBase - 200, 0)
		])
	}

}