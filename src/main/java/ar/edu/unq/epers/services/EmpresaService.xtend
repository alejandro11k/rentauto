package ar.edu.unq.epers.services


import ar.edu.unq.epers.arq.Service
import ar.edu.unq.epers.arq.runner.Runner
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import java.util.Set
import ar.edu.unq.epers.model.Auto

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
	
}