package ar.edu.unq.epers.model.cache

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Turismo
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.general.MainService
import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import static ar.edu.unq.epers.extensions.DateExtensions.*
import org.junit.Before
import org.junit.Test

import static org.junit.Assert.*
import ar.edu.unq.epers.services.CacheService
import java.util.Date
import com.datastax.driver.core.PreparedStatement
import com.datastax.driver.core.Row
import ar.edu.unq.epers.model.Usuario
import org.joda.time.DateTime

class CassandraTest {
	
	MainService service
	Auto unAuto
	Auto otroAuto
	Ubicacion retiro
	Ubicacion constitucion
	Cluster cluster
	Session session
	Date navidad
	Date anioNuevo
	CacheService cacheService
	Usuario usuarioPrueba

	@Before
	def void setUp(){		
		
		cluster = Cluster.builder.addContactPoint("127.0.0.1").build
		session = cluster.connect
		
		session.execute("DROP KEYSPACE IF EXISTS rentauto")
		
		session.execute("CREATE KEYSPACE rentauto 
						WITH replication = 
						{'class':'SimpleStrategy','replication_factor':3};")
		
																
		session.execute("CREATE TABLE rentauto.autosDisponibles(
   													fecha timestamp,
													ubicacion text,
   													autos set<text>,
													PRIMARY KEY (fecha,ubicacion));")
   		
		session.execute("USE rentauto")
		
		cacheService = new CacheService()
		
   		fillMocks()
   		
	}
	
	@Test
	def void testGuardoUnosAutosYMeLosTraigo(){
		
		cacheService.insertar(navidad,retiro)
		cacheService.agregarAuto(unAuto,navidad,retiro)
		cacheService.agregarAuto(otroAuto,navidad,retiro)
		
		assertEquals(cacheService.autosDisponibles(navidad,retiro).get(0),unAuto.patente)
		
	}
	
	@Test
	def void realizoUnaReservaYQuedaUnAutoEnLaCache(){
		cacheService.realizarUnaReserva(usuarioPrueba,retiro,retiro,navidad,anioNuevo)
		assertEquals(cacheService.autosDisponibles(navidad,retiro).get(0),otroAuto.patente)
	}
	

//	@Test
//	def void llenarLaCacheAlPedirAutos(){
//		val obtenido = cacheService.autosDisponibles(retiro,navidad,navidad)
//		val esperado = newHashSet.add(unAuto)
//		
//		assertEquals(esperado,obtenido)
//	}
	
	
	private def fillMocks() {
		
		service = new MainService
		service.registrarUbicacion(new Ubicacion('Retiro'))
		service.registrarUbicacion(new Ubicacion('Constitucion'))	
		retiro = service.ubicacion('Retiro') 
		constitucion = service.ubicacion('Constitucion') 
		unAuto = new Auto => [
			marca='Chevrolet'
			modelo='Classic'
			patente='BAD234'
			categoria = new Turismo
			ubicacionInicial = retiro
		]
		otroAuto = new Auto => [
			marca='Ford'
			modelo='Classic'
			patente='GOD234'
			categoria = new Turismo
			ubicacionInicial = retiro
		]
		service.registrarAuto(unAuto)
		navidad = nuevaFecha(2015,12,25)
		anioNuevo = nuevaFecha(2016,01,01)
		
		usuarioPrueba = new Usuario => [
				nombre = "Pepe"
				apellido = "Pruebas"
				usuario = "usuarioPrueba"
				password = "pss"
				mail = "mail@mail.com"
				nacimiento = new DateTime(1990,05,05,0,0) 
				estaValidado = true
			]
			
		service.registrarUsuario(usuarioPrueba)
		
	}	
	
}