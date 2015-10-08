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
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Usuario
import org.joda.time.DateTime

class EasyServiceTest extends AbstractTestEmpty{
		
	@Test
	def void test_autosDisponibles_por_ubicacion_y_fecha_con_autosSinReservasEnUnaUbicacionParticular(){
		runner.run([
			val es = new EmpresaService(runner)
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			val autosDisponibles = es.autosDisponibles(retiro, hoy())
			val autoEsperado = HomeLocator.instance.autoHome.getPorPatente("XXX123")
			
			assertTrue(autosDisponibles.contains(autoEsperado))
			assertEquals(2, autosDisponibles.size)
		])
	}

	@Test
	def void test_autosDisponibles_por_ubicacion_y_fecha_con_autosReservados(){
		runner.run([
			val es = new EmpresaService(runner)
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			val autoReservado1 = HomeLocator.instance.autoHome.getPorPatente("XXX124")
			val autoReservado2 = HomeLocator.instance.autoHome.getPorPatente("XXX123")
			val aeroparque = HomeLocator::instance.ubicacionHome.getPorNombre("Aeroparque")

			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = hoy()
				fin = nuevaFecha(2016, 01, 01)
				auto = autoReservado1
				usuario = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
				reservar()
			]
			
			val autosDisponibles = es.autosDisponibles(retiro, hoy())
			
			new Reserva => [
				origen = retiro
				destino = aeroparque
				inicio = hoy()
				fin = nuevaFecha(2016, 01, 01)
				auto = autoReservado2
				usuario = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
				reservar()
			]
			
			val sinAutosDisponibles = es.autosDisponibles(retiro, hoy())
			
			assertFalse(autosDisponibles.contains(autoReservado1))
			assertEquals(1, autosDisponibles.size)
			assertEquals(0,sinAutosDisponibles.size)
		])
	}

	@Test
	def void test_autosDisponibles_por_ubicacion_rango_de_fecha_y_categoria(){
		runner.run([
			val es = new EmpresaService(runner)
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			
			val Categoria familiar = new Familiar()
			
			val autosDisponibles = es.autosDisponibles(retiro, hoy(), nuevaFecha(2016,01,01), familiar)
			val todosLosAutos = HomeLocator.instance.autoHome.getAll
			
			assertEquals(todosLosAutos, autosDisponibles)
			
		])
	}
	
	@Test
	def void test_realizarReserva(){
		runner.run([
			val es = new EmpresaService(runner)
			var usuario = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
			//es.realizarUnaReserva(usuario, new Ubicacion("Retiro"), new Ubicacion("Retiro"), hoy(), nuevaFecha(2016,01,01))
			val retiro = HomeLocator::instance.ubicacionHome.getPorNombre("Retiro")
			es.realizarUnaReserva(usuario, retiro, retiro, hoy(), nuevaFecha(2016,01,01))
			var usuarioConReserva = HomeLocator::instance.usuarioHome.getPorUsername("usuarioPrueba")
			
			assertEquals(1,usuarioConReserva.reservas.size())
		])
	}
		
	override fillMocks() {
		{
		runner.run([
			val autoHome = HomeLocator::instance.autoHome
			val usuarioHome = HomeLocator::instance.usuarioHome
			val Categoria familiar = new Familiar()
			val retiro = new Ubicacion("Retiro")
			val aeroparque = new Ubicacion("Aeroparque")
			val auto1 = new Auto => [
				marca = "Peugeot"
				modelo = "505"
				año = 1990
				patente = "XXX123"
				costoBase = 100D
				categoria = familiar
				ubicacionInicial = retiro
			]
			
			val auto2 = new Auto => [
				marca = "Peugeot"
				modelo = "505"
				año = 1990
				patente = "XXX124"
				costoBase = 100D
				categoria = familiar
				ubicacionInicial = retiro
			]
			
		
			autoHome => [save(auto1)
				save(auto2)
			]
			
			val usuarioPrueba = new Usuario => [
				nombre = "Pepe"
				apellido = "Pruebas"
				usuario = "usuarioPrueba"
				password = "pss"
				mail = "mail@mail.com"
				nacimiento = new DateTime(1990,05,05,0,0) 
				estaValidado = true
			]
			
			usuarioHome.save(usuarioPrueba)
			
		])
	}
	}
	
}