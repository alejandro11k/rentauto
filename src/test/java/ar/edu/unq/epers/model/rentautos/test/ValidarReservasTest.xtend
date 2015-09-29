package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.NullObject
import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.ReservaException
import ar.edu.unq.epers.model.rentautos.AbstractTest
import org.junit.Test

import static ar.edu.unq.epers.extensions.DateExtensions.*
import static org.junit.Assert.*

class ValidarReservasTest extends AbstractTest {
	@Test
	def void reservaUnica() {
		runner.run([
			val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
			
			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015, 03, 01)
				fin = nuevaFecha(2015, 03, 05)
				auto = unAuto
				usuario = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
				reservar()
			]
			
			assertEquals(1, unAuto.reservas.size)
			
			NullObject.NULL
		])
	}

	@Test
	def void reservaQueNoSePisan() {
		runner.run([
			val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
			val usuarioPrueba = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
		
			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015, 03, 01)
				fin = nuevaFecha(2015, 03, 05)
				it.auto = unAuto
				it.usuario = usuarioPrueba
				reservar()
			]
	
			new Reserva => [
				origen = aeroparque
				destino = retiro
				inicio = nuevaFecha(2015, 03, 06)
				fin = nuevaFecha(2015, 03, 07)
				it.auto = unAuto
				it.usuario = usuarioPrueba
				reservar()
			]
	
			assertEquals(2, unAuto.reservas.size)
		
			NullObject.NULL
		])
	}

	@Test(expected=ReservaException)
	def void reservaQueSePisan() {
		runner.run([
			val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")

			unAuto.agregarReserva(
				new Reserva => [
					origen = retiro
					destino = aeroparque
					inicio = nuevaFecha(2015, 03, 01)
					fin = nuevaFecha(2015, 03, 05)
					auto = unAuto
				])
	
			unAuto.agregarReserva(
				new Reserva => [
					origen = aeroparque
					destino = retiro
					inicio = nuevaFecha(2015, 03, 04)
					fin = nuevaFecha(2015, 03, 07)
					auto = unAuto
				])
	
			fail()
			
			NullObject.NULL
		])
	}

	@Test(expected=ReservaException)
	def void reservasSinSentido() {
		runner.run([
			val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
			unAuto.agregarReserva(
				new Reserva => [
					origen = retiro
					destino = aeroparque
					inicio = nuevaFecha(2015, 03, 01)
					fin = nuevaFecha(2015, 03, 05)
					auto = unAuto
				])
	
			unAuto.agregarReserva(
				new Reserva => [
					origen = retiro
					destino = aeroparque
					inicio = nuevaFecha(2015, 03, 05)
					fin = nuevaFecha(2015, 03, 07)
					auto = unAuto
				])
	
			fail()
			NullObject.NULL
		])
	}

}
