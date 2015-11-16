package ar.edu.unq.epers.services.comentarios

import ar.edu.unq.epers.home.Calificacion
import com.fasterxml.jackson.annotation.JsonProperty
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongojack.ObjectId

@Accessors
class Comentario {
	String usuario
	String patenteAuto
	Integer numeroSolicitud
	Calificacion calificacion	
	@ObjectId
	@JsonProperty("_id")
	String id
}