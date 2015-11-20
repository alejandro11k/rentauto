package ar.edu.unq.epers.model.rentautos.test

import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.ReservaException
import ar.edu.unq.epers.model.rentautos.AbstractTest
import org.junit.Test

import static ar.edu.unq.epers.extensions.DateExtensions.*
import static org.junit.Assert.*
import ar.edu.unq.epers.home.hbm.ReservaHbmHome

class ReservasClaudioTest extends AbstractTest{
	@Test
	def void dosReservasAgregadasEnOrden() {
	    //Agrego la primer reserva
	    runner.run([
	        val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
	        val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
	        val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
	        val usuarioPrueba = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
	
	        val reserva = new Reserva => [
	            origen = retiro
	            destino = aeroparque
	            inicio = nuevaFecha(2015,03,01)
	            fin = nuevaFecha(2015,03,05)
	            auto = unAuto
	            usuario = usuarioPrueba
	            reservar()
	        ]
	  
	        new ReservaHbmHome().save(reserva);
	    ])
	
	    //Agrego la segunda reserva
	    runner.run([
	        val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
	        val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
	        val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
	        val usuarioPrueba = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
	
	        val reserva = new Reserva => [
	            origen = aeroparque
	            destino = retiro
	            inicio = nuevaFecha(2015,03,06)
	            fin = nuevaFecha(2015,03,10)
	            auto = unAuto
	            usuario = usuarioPrueba
	            reservar()
	        ]
	        new ReservaHbmHome().save(reserva);
	    ])
	
	    //Pruebo las condiciones
	    runner.run([
	        val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
	        val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
	        val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
	
	        assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,02,28)))
	        assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,1)))
	        assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,2)))
	
	        assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,5)))
	        assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,6)))
	
	        assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,9)))
	        assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,11)))
	        assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,11)))
	    ])
	}
	
	@Test
	def void tresReservasAgregadasEnDesorden(){
	    this.dosReservasAgregadasEnOrden();
	
	    //Agrego la tercer reserva, previa a todas
	    runner.run([
	        val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
	        val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
	        val usuarioPrueba = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
	
	        val reserva = new Reserva => [
	            origen = retiro
	            destino = retiro
	            inicio = nuevaFecha(2015,01,01)
	            fin = nuevaFecha(2015,01,02)
	            auto = unAuto
	            usuario = usuarioPrueba
	            reservar()
	        ]
	        new ReservaHbmHome().save(reserva);
	    ])
	
	    //Pruebo las condiciones, no deberian haber cambiado por tener una reserva anterior. No?
	    runner.run([
	        val unAuto = HomeLocator::instance.autoHome.getPorPatente("XXX123")
	        val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
	        val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")
	
	        assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,02,28)))
	        assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,1)))
	        assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,2)))
	
	        assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,5)))
	        assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,6)))
	
	        assertEquals(aeroparque, unAuto.ubicacionParaDia(nuevaFecha(2015,03,9)))
	        assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,11)))
	        assertEquals(retiro, unAuto.ubicacionParaDia(nuevaFecha(2015,03,11)))
	    ])
	}
}