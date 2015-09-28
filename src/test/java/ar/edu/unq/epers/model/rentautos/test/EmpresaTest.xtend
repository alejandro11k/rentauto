package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.model.rentautos.AbstractTest
import ar.edu.unq.epers.model.ReservaEmpresarial
import ar.edu.unq.epers.model.ReservaException
import org.junit.Test

import static ar.edu.unq.epers.extensions.DateExtensions.*
import static org.junit.Assert.*
import ar.edu.unq.epers.services.EmpresaService
import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.arq.NullObject

class EmpresaTest extends AbstractTest{
		
	@Test
	def void reservaOk(){
		runner.run([
			val unaEmpresa = HomeLocator::instance.empresaHome.getPorCuit("30-11223344-90")
			
			new ReservaEmpresarial => [
				origen = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
				destino = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
				inicio = nuevaFecha(2015,03,01)
				fin = nuevaFecha(2015,03,05)
				auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
				usuario = HomeLocator::instance.usuarioHome.getPorUsername("usuarioEmpresa")
				empresa = unaEmpresa 
				reservar()
			]
			assertEquals(1, unaEmpresa.reservas.size)
			NullObject.NULL
		])
	}

	@Test(expected=ReservaException)
	def void reservaUsuarioInvalido(){
		runner.run([
			new ReservaEmpresarial => [
				origen = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
				destino = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
				inicio = nuevaFecha(2015,03,01)
				fin = nuevaFecha(2015,03,05)
				auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
				usuario = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
				empresa = HomeLocator::instance.empresaHome.getPorCuit("30-11223344-90") 
				reservar()
			]
			fail()
			NullObject.NULL
		])
	}

}