package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.core.Statement
import com.datastax.driver.core.querybuilder.QueryBuilder

class CacheService {
	
	Cluster cluster
	
	new(){
		cluster = Cluster.builder.addContactPoint("127.0.0.1").build
	}
	
	/**
	 * Retorno los autos disponibles para una ubicación y
	 * 	un rango de fechas dadas.
	 */
	def autosDisponibles(Ubicacion ubicacion, Date inicio, Date fin) {
	val qb = new QueryBuilder(cluster)
	val Statement statement = qb
			.select
			.all
			.from("rentauto","autosDisponibles")
			.where(QueryBuilder.eq("fecha",inicio))
			.and(QueryBuilder.eq("ubicacion",ubicacion))
		cluster.connect.execute(statement)
	}
	
}