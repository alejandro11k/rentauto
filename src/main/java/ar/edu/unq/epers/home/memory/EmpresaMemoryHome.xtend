package ar.edu.unq.epers.home.memory

import ar.edu.unq.epers.home.EmpresaHome
import ar.edu.unq.epers.model.Empresa
import java.util.Set

class EmpresaMemoryHome extends EmpresaHome {
	
	private Set<Empresa> empresas = newHashSet
	
	override save(Empresa unaEmpresa) {
		empresas.add(unaEmpresa)
	}
	
	override getPorCuit(String unCUIT) {
		empresas.findFirst[each | each.cuit.equals(unCUIT)]
	}
	
}