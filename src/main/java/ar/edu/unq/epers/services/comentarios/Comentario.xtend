package ar.edu.unq.epers.services.comentarios

import ar.edu.unq.epers.home.Calificacion
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Comentario {
	String usuario
	String patenteAuto
	Integer nroSolicitudReserva
	Calificacion calificacion	
}