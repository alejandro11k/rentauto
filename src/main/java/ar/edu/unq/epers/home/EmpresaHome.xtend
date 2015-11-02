package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Empresa

abstract class EmpresaHome extends AbstractHome<Empresa> {
	
	def Empresa getPorCuit(String unCUIT)
	
}