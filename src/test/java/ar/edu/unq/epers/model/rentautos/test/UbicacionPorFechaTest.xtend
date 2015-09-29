package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.NullObject
import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.rentautos.AbstractTest
import org.junit.Test

import static ar.edu.unq.epers.extensions.DateExtensions.*
import static org.junit.Assert.*

class UbicacionPorFechaTest extends AbstractTest {
			
	@Test
	def void ubicacionReservasVacias(){
		val auto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
		assertEquals(auto.ubicacionInicial, auto.ubicacion)
	}
	
	@Test
	def void ubicacionUnaReserva(){
		runner.run([
			val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
			
			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015,03,01)
				fin = nuevaFecha(2015,03,05)
				auto = unAuto
				usuario = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
				reservar()
			]
			
			assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,02,28)))
			assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,01)))
			assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,02)))
			
			assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,05)))
			assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,06)))
			NullObject.NULL
		])
	}


	@Test
	def void ubicacionDosReservas(){
		runner.run([
			val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
			val usuarioPrueba = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
			
			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = nuevaFecha(2015,03,01)
				fin = nuevaFecha(2015,03,05)
				auto = unAuto
				usuario = usuarioPrueba
				reservar()
			]
	
			new Reserva => [
				origen = aeroparque
				destino = retiro
				inicio = nuevaFecha(2015,03,06)
				fin = nuevaFecha(2015,03,10)
				auto = unAuto
				usuario = usuarioPrueba
				reservar()
			]
			
			assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,02,28)))
			assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,1)))
			assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,2)))
			
			assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,5)))
			assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,6)))
	
			assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,9)))
			assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,11)))
			assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,11)))
			NullObject.NULL
		])
	}
	
}