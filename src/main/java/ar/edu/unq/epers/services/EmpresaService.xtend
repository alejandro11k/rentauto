package ar.edu.unq.epers.services

import ar.edu.unq.epers.arq.Service
import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.arq.runner.Runner
import ar.edu.unq.epers.exceptions.NoHayAutosDisponiblesParaLaReserva
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.IUsuario
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import java.util.Date
import java.util.List
import java.util.Set
import java.util.ArrayList

class EmpresaService extends Service {
	
	new(Runner runner) {
		super(runner)
	}
	
	def autosEnUnaUbicacion(Ubicacion unaUbicacion, Date unaFecha){
		val autos = HomeLocator::instance.autoHome.getAll
		autos.filter[ubicacionParaDia(unaFecha)==unaUbicacion]
	}
	/** Retorna los autos disponibles para una ubicacion en particular
	 * en una fecha determinada
	 */
	 def autosDisponibles(Ubicacion unaUbicacion, Date unaFecha){
        val autos = HomeLocator::instance.autoHome.getAll
        autos.filter[ubicacionParaDia(unaFecha) == unaUbicacion && estaLibre(unaFecha,unaFecha)].toList 	
    }
	
	def autosDisponibles(Ubicacion origen, Date inicio, Date fin, Categoria categoria){
		val autos = HomeLocator::instance.autoHome.getPorCategoria(categoria.nombre)
		filtrarAutos(autos, inicio, origen, fin)
	}
	
	//
	def autosDisponibles(Ubicacion origen, Date inicio, Date fin){
		val autos = HomeLocator::instance.autoHome.getAll()		
		filtrarAutos(autos, inicio, origen, fin)
	}
	
	private def filtrarAutos(List<Auto> autos, Date inicio, Ubicacion origen, Date fin) {
		autos.filter[ubicacionParaDia(inicio) == origen && estaLibre(inicio,fin)].toList
	}
	
	def realizarUnaReserva(IUsuario usuario, Ubicacion origen,Ubicacion destino,Date inicio,Date fin) throws NoHayAutosDisponiblesParaLaReserva{
		val autos = autosDisponibles(origen,inicio,fin)
		
		if (autos.length > 0){
			new Reserva => [
				it.origen = origen
				it.destino = destino
				it.inicio = inicio
				it.fin = fin
				it.auto = autos.get(0)
				it.usuario = usuario
				reservar()
			]
			
			//val List<Auto> autos2 = new ArrayList<Auto>()
			//autos.tail.forEach[ x | autos2.add(x)]
			 
			return autos
		}
		else
			throw new NoHayAutosDisponiblesParaLaReserva
	}
	/**
	 * realiza una reserva de un auto sin chequear disponivilidad!
	 */
	def realizarUnaReserva(Auto auto,IUsuario usuario, Ubicacion origen,Ubicacion destino,Date inicio,Date fin) {
		new Reserva => [
			it.origen = origen
			it.destino = destino
			it.inicio = inicio
			it.fin = fin
			it.auto = auto
			it.usuario = usuario
			reservar()
		]
	}
	
}