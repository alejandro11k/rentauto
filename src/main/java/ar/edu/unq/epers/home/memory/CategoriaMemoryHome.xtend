package ar.edu.unq.epers.home.memory

import ar.edu.unq.epers.home.CategoriaHome
import ar.edu.unq.epers.model.Categoria
import java.util.Set

class CategoriaMemoryHome extends CategoriaHome{
	
	private Set<Categoria> categorias = newHashSet
	
	override getNombre(String string) {
		categorias.findFirst[each | each.getNombre.equals(string)]
	}
	
	override save(Categoria unaCategoria) {
		categorias.add(unaCategoria)
	}
	
}