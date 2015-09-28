package ar.edu.unq.epers.model.rentautos

import ar.edu.unq.epers.model.rentautos.test.CalculoDePrecioTest
import ar.edu.unq.epers.model.rentautos.test.EmpresaTest
import ar.edu.unq.epers.model.rentautos.test.UbicacionPorFechaTest
import ar.edu.unq.epers.model.rentautos.test.ValidarReservasTest
import org.junit.BeforeClass
import org.junit.runner.RunWith
import org.junit.runners.Suite

import static ar.edu.unq.epers.model.rentautos.AbstractTest.*

@RunWith(Suite) 
@Suite.SuiteClasses(#[
	CalculoDePrecioTest,
	EmpresaTest,
	UbicacionPorFechaTest,
	ValidarReservasTest
])

class AllTestsHibernate {
	
	@BeforeClass 
	def static void prepare() {
		AbstractTest.inMemory = false
	}

}