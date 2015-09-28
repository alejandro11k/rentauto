package ar.edu.unq.epers.home.hbm

import ar.edu.unq.epers.home.EmpresaHome
import ar.edu.unq.epers.model.Empresa
import ar.edu.unq.epers.arq.runner.HibernateRunner

class EmpresaHbmHome extends EmpresaHome {
	
	override getPorCuit(String unCUIT) {
		HibernateRunner::currentSession().get(typeof(Empresa) ,unCUIT) as Empresa
	}
	
	override save(Empresa anObject) {
		HibernateRunner::currentSession().save(anObject)
	}
	
}