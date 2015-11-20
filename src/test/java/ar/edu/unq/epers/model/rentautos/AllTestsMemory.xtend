package ar.edu.unq.epers.model.rentautos

import ar.edu.unq.epers.model.rentautos.test.CalculoDePrecioTest
import ar.edu.unq.epers.model.rentautos.test.EmpresaTest
import ar.edu.unq.epers.model.rentautos.test.UbicacionPorFechaTest
import ar.edu.unq.epers.model.rentautos.test.ValidarReservasTest
import org.junit.BeforeClass
import org.junit.runner.RunWith
import org.junit.runners.Suite

import static ar.edu.unq.epers.model.rentautos.AbstractTest.*
import ar.edu.unq.epers.model.rentautos.test.EasyServiceTest
import ar.edu.unq.epers.model.rentautos.test.ReservasClaudioTest

@RunWith(Suite) 
@Suite.SuiteClasses(#[
	CalculoDePrecioTest,
	EmpresaTest,
	UbicacionPorFechaTest,
	//EasyServiceTest
	//ReservasClaudioTest,
	ValidarReservasTest
])

class AllTestsMemory {
	@BeforeClass 
	def static void prepare() {
		AbstractTest.inMemory = true
	}
}