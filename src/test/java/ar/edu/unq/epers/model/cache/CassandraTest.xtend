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

class CassandraTest {
	
	MainService service
	Auto unAuto
	Ubicacion retiro
	Ubicacion constitucion
	Cluster cluster
	Session session
	Date navidad
	CacheService cacheService

	@Before
	def void setUp(){		
		// Connect to the cluster and keyspace "demo"
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
		
   		fillMocks()
	}
	
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
		service.registrarAuto(unAuto)
		navidad = nuevaFecha(2015,12,25)
		//anioNuevo = nuevaFecha(2016,01,01)
		val navidad2 = navidad.time
		
		cacheService = new CacheService()
		
		
		//val query0 = "INSERT INTO autosDisponibles (fecha, ubicacion, autos) 
		//				VALUES ('"+navidad2+"','Retiro',{'123ASD'});"	
		
		val query0 = "INSERT INTO autosDisponibles (fecha, ubicacion) 
						VALUES ('"+navidad2+"','"+retiro.nombre+"');"
		
		val query2 = "UPDATE autosDisponibles SET autos = autos+{'"+unAuto.patente+"'}
						WHERE fecha = '"+navidad2+"' AND ubicacion='"+retiro.nombre+"';";	
							
		session.execute(query0);
		session.execute(query2);
		
	}	
	
	@Test
	def void llenarLaCacheAlPedirAutos(){
		val obtenido = cacheService.autosDisponibles(retiro,navidad,navidad)
		val esperado = newHashSet.add(unAuto)
		
		assertEquals(esperado,obtenido)
	}
}