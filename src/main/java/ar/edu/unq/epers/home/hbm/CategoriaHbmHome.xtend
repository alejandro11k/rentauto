package ar.edu.unq.epers.home.hbm

import ar.edu.unq.epers.arq.runner.HibernateRunner
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.home.CategoriaHome

class CategoriaHbmHome extends CategoriaHome {
	
	override getNombre(String string) {
		HibernateRunner::currentSession().get(typeof(Categoria) ,string) as Categoria
	}
	
	override save(Categoria anObject) {
		HibernateRunner::currentSession().save(anObject)
	}

	
}