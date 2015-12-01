package ar.edu.unq.epers.model.cache

import org.junit.Test

import static org.junit.Assert.*
import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import org.junit.Before
import org.junit.Test

class CassandraTest {

	@Before
	def void setUp(){
		var Cluster cluster;
		var Session session;
		
		// Connect to the cluster and keyspace "demo"
		cluster = Cluster.builder().addContactPoint("127.0.0.1").build();
		session = cluster.connect();
		session.execute("DROP KEYSPACE IF EXISTS rentauto")
		session.execute("CREATE KEYSPACE rentauto 
						WITH replication = 
						{'class':'SimpleStrategy','replication_factor':3};")
		
	}	
	
	@Test
	def void testCrearTabla(){
		fail	
	}
}