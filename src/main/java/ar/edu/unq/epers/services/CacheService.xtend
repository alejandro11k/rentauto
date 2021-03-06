package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.core.Statement
import com.datastax.driver.core.querybuilder.QueryBuilder
import com.datastax.driver.core.PreparedStatement
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.general.MainService
import ar.edu.unq.epers.model.Usuario
import java.util.Calendar
import java.util.List
import java.util.ArrayList

class CacheService {
	
	Cluster cluster
	MainService mainService
	
	new(){
		cluster = Cluster.builder.addContactPoint("127.0.0.1").build
		mainService = new MainService
	}
	
	
	/**
	 * Permite realizar una reserva
	 */
	def realizarUnaReserva(Usuario usuario, Ubicacion origen, Ubicacion destino, Date inicio, Date fin) {
		
		
		var Auto auto = null
		
		// BUSCO EN LA CACHE
		
		auto = autosDisponibles(inicio,fin,origen)
		
		// SI TENGO EL AUTO
		
		if (auto!=null){
			
			mainService.realizarUnaReserva(auto,usuario,origen,destino,inicio,fin)
		
			//quito el auto de la cache :( later...
		
		}
		else{
			// SI no lo tengo
		
			var autos = mainService.realizarUnaReserva(usuario,origen,destino,inicio,fin)
		
			// me falta popular la cache con la nueva busqueda :(  --> deberia venir en autos
		
			agregarAutos(autos,origen,inicio,fin)
			eliminar(autos.get(0),origen,inicio,fin)
			
		}	
		
	}
	
	
	
	/**
	 * estos metodos son solo para uso de cacheService, se mantienen publicos por razones
	 * de test
	 */
	
	
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
	
	
	def eliminar(Auto auto, Ubicacion ubicacion, Date date, Date date2) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def agregarAutos(List<Auto> autos,Ubicacion unaUbicacion, Date fechaInicio, Date fechaFin){
		
		//Si los dias estan repetidos no va a andar :(
		
		var dias = fechasDeBusqueda(fechaInicio,fechaFin)
		
		dias.forEach[ dia | 
			
			if(!cantidadDeAutosDisponibles(dia,unaUbicacion)) insertar(dia,unaUbicacion)
			
			autos.forEach[ auto | 
				agregarAuto(auto,dia,unaUbicacion)
			]
		]
	}
	
	def private cantidadDeAutosDisponibles(Date unaFecha, Ubicacion unaUbicacion){
		var query = "SELECT * FROM rentauto.autosDisponibles 
						WHERE fecha = '"+unaFecha.time+"' AND ubicacion='"+unaUbicacion.nombre+"';";	
		
		var result = getSession.execute(query)
		
		result.availableWithoutFetching >= 1
	}
	
	
	def autosDisponibles(Date unaFecha, Ubicacion unaUbicacion){
		var query = "SELECT * FROM rentauto.autosDisponibles 
						WHERE fecha = '"+unaFecha.time+"' AND ubicacion='"+unaUbicacion.nombre+"';";	
		
		var result = getSession.execute(query)
		
		if (result.availableWithoutFetching >= 1)
			result.head.getSet("autos",String)
		else
			null
	}
	
	def Auto autosDisponibles(Date fechaInicio, Date fechaFin, Ubicacion unaUbicacion){
		
		var dias = fechasDeBusqueda(fechaInicio,fechaFin)
		val autos = autosDisponibles(dias.get(0),unaUbicacion)
		
		if (tengoTodosLosDias(dias) && autos!=null){
			autos.toSet
			dias.forEach[
				x | autos.retainAll(autosDisponibles(x,unaUbicacion))
			]
			mainService.getAuto(autos.head)
		}
		null	
	}
	
	def private tengoTodosLosDias(ArrayList<Date> dates) {
		val q = "SELECT fecha FROM rentauto.autosDisponibles"
		var result = getSession.execute(q).all
		
		val resultFecha = newArrayList
		result.forEach[ x | resultFecha.add(x.getTimestamp(0)as Date)]
		
		resultFecha.containsAll(dates)
		
	}
	
	def fechasDeBusqueda(Date fechaInicio, Date fechaFin){
		var fecha = fechaInicio
		var dias = new ArrayList<Date>()
		
		while (fecha.before(fechaFin)){
			dias.add(fecha)
			fecha = fecha.addDays(1)
		}
		dias.add(fecha)
		
		dias
	}
	
	def Date addDays(Date date, int days)
    {
        var Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, days); //minus number would decrement the days
        return cal.getTime();
    }
	
	
//	/**
//	 * Retorno los autos disponibles para una ubicación y
//	 * 	un rango de fechas dadas.
//	 */
//	def autosDisponibles(Ubicacion ubicacion, Date inicio, Date fin) {
//	val qb = new QueryBuilder(cluster)
//	val Statement statement = qb
//			.select
//			.all
//			.from("rentauto","autosDisponibles")
//			.where(QueryBuilder.eq("fecha",inicio.time))
//			.and(QueryBuilder.eq("ubicacion",ubicacion.nombre))
//		cluster.connect.execute(statement)
//	}
	
	
}