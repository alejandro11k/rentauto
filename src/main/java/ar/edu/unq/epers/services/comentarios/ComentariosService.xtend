package ar.edu.unq.epers.services.comentarios

import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.home.Calificacion
import ar.edu.unq.epers.home.ComentariosHome
import ar.edu.unq.epers.arq.runner.ComentariosRunner
import org.mongojack.DBQuery

class ComentariosService {
	
	ComentariosHome<Comentario> home
	
	new(){
		home = ComentariosRunner.instance.collection(Comentario)
	}
	
	def calificar(Usuario usuario, Reserva reserva, Calificacion calificacion) {
		home.insert(new Comentario => [
			usuario = usuario.usuario
			patenteAuto = reserva.auto.patente
			numeroSolicitud = reserva.numeroSolicitud
			it.calificacion = calificacion
		])
	}
	
	def obtenerComentario(Reserva reserva) {
		home.mongoCollection.find(DBQuery.is("numeroSolicitud", reserva.numeroSolicitud)).next
	}
	
	def cleanDB() {
		home.mongoCollection.drop
	}
	
}