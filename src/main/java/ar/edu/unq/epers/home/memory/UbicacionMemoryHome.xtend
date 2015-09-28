package ar.edu.unq.epers.home.memory

import ar.edu.unq.epers.home.UbicacionHome
import ar.edu.unq.epers.model.Ubicacion
import java.util.Set

class UbicacionMemoryHome extends UbicacionHome {
	
	private Set<Ubicacion> ubicaciones = newHashSet
	
	override save(Ubicacion unaUbicacion) {
		ubicaciones.add(unaUbicacion)
	}
	
	override getPorNombre(String string) {
		ubicaciones.findFirst[each | each.nombre.equals(string)]
	}
	
}