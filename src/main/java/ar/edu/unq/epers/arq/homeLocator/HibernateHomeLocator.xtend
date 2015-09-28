package ar.edu.unq.epers.arq.homeLocator

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.home.hbm.EmpresaHbmHome
import ar.edu.unq.epers.home.hbm.AutoHbmHome
import ar.edu.unq.epers.home.hbm.UbicacionHbmHome
import ar.edu.unq.epers.home.hbm.UsuarioHbmHome

@Accessors
class HibernateHomeLocator extends HomeLocator {
	
	EmpresaHbmHome empresaHome = new EmpresaHbmHome
	AutoHbmHome autoHome = new AutoHbmHome
	UbicacionHbmHome ubicacionHome = new UbicacionHbmHome
	UsuarioHbmHome usuarioHome = new UsuarioHbmHome
}