package ar.edu.unq.epers.arq.homeLocator

import ar.edu.unq.epers.home.memory.AutoMemoryHome
import ar.edu.unq.epers.home.memory.EmpresaMemoryHome
import ar.edu.unq.epers.home.memory.UbicacionMemoryHome
import ar.edu.unq.epers.home.memory.UsuarioMemoryHome
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class MemoryHomeLocator extends HomeLocator {
	
	EmpresaMemoryHome empresaHome = new EmpresaMemoryHome
	AutoMemoryHome autoHome = new AutoMemoryHome
	UbicacionMemoryHome ubicacionHome = new UbicacionMemoryHome
	UsuarioMemoryHome usuarioHome = new UsuarioMemoryHome
}