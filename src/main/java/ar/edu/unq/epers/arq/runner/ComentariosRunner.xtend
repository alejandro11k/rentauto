package ar.edu.unq.epers.arq.runner;

import com.mongodb.DB
import com.mongodb.MongoClient
import java.net.UnknownHostException
import org.mongojack.JacksonDBCollection
import ar.edu.unq.epers.home.ComentariosHome

class ComentariosRunner {
	static ComentariosRunner INSTANCE;
	MongoClient mongoClient;
	DB db;

	synchronized def static ComentariosRunner instance() {
		if (INSTANCE == null) {
			INSTANCE = new ComentariosRunner();
		}
		return INSTANCE;
	}

	private new() {
		try {
			mongoClient = new MongoClient("localhost", 27017);
		} catch (UnknownHostException e) {
			throw new RuntimeException(e);
		}
		db = mongoClient.getDB("persistencia");
	}
	
	
	def <T> ComentariosHome<T> collection(Class<T> entityType){
		val dbCollection = db.getCollection(entityType.getSimpleName());
		new ComentariosHome<T>(JacksonDBCollection.wrap(dbCollection, entityType, String));
	}

}
