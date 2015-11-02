package ar.edu.unq.epers.home;

import org.neo4j.graphdb.RelationshipType;

public enum TipoDeRelaciones implements RelationshipType {
	AMISTAD, ENVIO, RECEPCION
}