package ar.edu.unq.epers.services


import ar.edu.unq.epers.arq.Service
import ar.edu.unq.epers.arq.runner.Runner
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import java.util.Set
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import java.util.List
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.exceptions.NoHayAutosDisponiblesParaLaReserva
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.IUsuario

class EmpresaService extends Service {
	
	new(Runner runner) {
		super(runner)
	}
	
	/** Retorna los autos disponibles para una ubicacion en particular
	 * en una fecha determinada
	 */
	def autosDisponibles(Ubicacion unaUbicacion, Date unaFecha){
		val autos = HomeLocator::instance.autoHome.getAll
		var Set<Auto> result = newHashSet
		
		for (Auto a : autos){
			if (a.ubicacionParaDia(unaFecha) == unaUbicacion && a.estaLibre(unaFecha,unaFecha))
				result.add(a)
		}
		
		result
	}
	
	def autosDisponibles(Ubicacion origen, Date inicio, Date fin, Categoria categoria){
		val autos = HomeLocator::instance.autoHome.getPorCategoria(categoria.nombre)
		//autos.filter[each | !(each.categoria == categoria && each.ubicacionParaDia(inicio) == origen && each.estaLibre(inicio,fin))]
			
		var List<Auto> result = newArrayList
		
			for (Auto each : autos){
			if (each.ubicacionParaDia(inicio) == origen && each.estaLibre(inicio,fin))
				result.add(each)
		}
		
		result
	
	}
	
	def autosDisponibles(Ubicacion origen, Date inicio, Date fin){
		val autos = HomeLocator::instance.autoHome.getAll()		
		var List<Auto> result = newArrayList
		
		for (Auto each : autos){
			if (each.ubicacionParaDia(inicio) == origen && each.estaLibre(inicio,fin))
				result.add(each)
		}
		
		result
	
	}
	
	def realizarUnaReserva(IUsuario usuario, Ubicacion origen,Ubicacion destino,Date inicio,Date fin) throws NoHayAutosDisponiblesParaLaReserva{
		val auto = autosDisponibles(origen,inicio,fin).last
		if (auto != null){
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
		else
			throw new NoHayAutosDisponiblesParaLaReserva
	}
	
}