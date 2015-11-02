package ar.edu.unq.epers.services.grafos

import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.arq.runner.GraphServiceRunner
import org.neo4j.graphdb.GraphDatabaseService
import ar.edu.unq.epers.home.AmigosHome
import ar.edu.unq.epers.model.Mensaje
import ar.edu.unq.epers.home.TipoDeRelaciones

class AmigosService {
	
	def amigar(Usuario unUsuario, Usuario otroUsuario) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.relacionar(unUsuario, otroUsuario, TipoDeRelaciones.AMISTAD)
		]
	}
	
	def amigosDe(Usuario unUsuario){
		GraphServiceRunner::run[
			val home = createHome(it);
			home.getAmigos(unUsuario)
		]
	}
	
	def createHome(GraphDatabaseService service) {
		new AmigosHome(service)
	}
	
	def agregar(Usuario unUsuario){
		GraphServiceRunner::run[
			createHome(it).crearNodo(unUsuario)
		]
	}
	
	def eliminar(Usuario unUsuario){
		GraphServiceRunner::run[
			createHome(it).eliminarUsuario(unUsuario)
		]
	}
	
	def enviarMensaje(Usuario emisor, Usuario receptor, String cuerpoMensaje) {
		GraphServiceRunner::run[
			val mje = new Mensaje => [cuerpo = cuerpoMensaje]
			val home = createHome(it) 
			home.crearNodo(mje)
			home.relacionar(emisor,mje,TipoDeRelaciones.ENVIO)
			home.relacionar(mje,receptor,TipoDeRelaciones.RECEPCION)
		]
		
	}

	def mensajesRecibidos(Usuario unUsuario) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.getRecibidos(unUsuario)
		]
	}
	
	def mensajesEnviados(Usuario unUsuario) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.getEnviados(unUsuario)
		]
	}
	
}