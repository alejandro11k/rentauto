package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.core.Statement
import com.datastax.driver.core.querybuilder.QueryBuilder
import com.datastax.driver.core.PreparedStatement
import ar.edu.unq.epers.model.Auto

class CacheService {
	
	Cluster cluster
	
	new(){
		cluster = Cluster.builder.addContactPoint("127.0.0.1").build
	}
	
	def getSession(){
		cluster.connect
	}
	
	def insertar(Date unaFecha, Ubicacion unaUbicacion){
		
		var query = "INSERT INTO rentauto.autosDisponibles (fecha, ubicacion) 
						VALUES ('"+unaFecha.time+"','"+unaUbicacion.nombre+"');"
		getSession.execute(query)		
	}
	
	def agregarAuto(Auto unAuto, Date unaFecha, Ubicacion unaUbicacion){
		var query = "UPDATE rentauto.autosDisponibles SET autos = autos+{'"+unAuto.patente+"'}
						WHERE fecha = '"+unaFecha.time+"' AND ubicacion='"+unaUbicacion.nombre+"';";
		getSession.execute(query)
	}
	
	def autosDisponibles(Date unaFecha, Ubicacion unaUbicacion){
		var query = "SELECT * FROM rentauto.autosDisponibles 
						WHERE fecha = '"+unaFecha.time+"' AND ubicacion='"+unaUbicacion.nombre+"';";	
		
		getSession.execute(query).head.getSet("autos",String)
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
			.where(QueryBuilder.eq("fecha",inicio.time))
			.and(QueryBuilder.eq("ubicacion",ubicacion.nombre))
		cluster.connect.execute(statement)
	}
	
	
}