package ar.edu.unq.epers.home.memory

import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.model.Auto
import java.util.Set

class AutoMemoryHome extends AutoHome {
	
	private Set<Auto> autos = newHashSet	
	
	override save(Auto unAuto) {
		autos.add(unAuto)
	}
	
	override getPorPatente(String string) {
		autos.findFirst[each|each.patente.equals(string)]
	}
	
}