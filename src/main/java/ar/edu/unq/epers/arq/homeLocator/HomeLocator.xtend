package ar.edu.unq.epers.arq.homeLocator

import ar.edu.unq.epers.home.EmpresaHome
import ar.edu.unq.epers.home.AutoHome
import ar.edu.unq.epers.home.UbicacionHome
import ar.edu.unq.epers.home.UsuarioHome

abstract class HomeLocator {

	// Singleton
	static HomeLocator instance
	
	def static HomeLocator instance() {instance}
	
	def static void setInstance(HomeLocator ins) {instance = ins}
	
	def abstract EmpresaHome getEmpresaHome()
	
	def abstract AutoHome getAutoHome()
	
	def abstract UbicacionHome getUbicacionHome()
	
	def abstract UsuarioHome getUsuarioHome()
	
}