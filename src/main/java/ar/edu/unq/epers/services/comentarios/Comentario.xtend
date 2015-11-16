package ar.edu.unq.epers.services.comentarios

import ar.edu.unq.epers.home.Calificacion
import com.fasterxml.jackson.annotation.JsonProperty
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.ObjectId
import ar.edu.unq.epers.home.Visibilidad

@Accessors
class Comentario {
	String usuario
	String patenteAuto
	Integer numeroSolicitud
	Calificacion calificacion
	String texto
	Visibilidad visibilidad
	@ObjectId
	@JsonProperty("_id")
	String id
	
	new(){
		visibilidad = Visibilidad.PUBLICO
	}
}