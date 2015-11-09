package ar.edu.unq.epers.home

import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.DynamicLabel
import ar.edu.unq.epers.model.Usuario
import org.neo4j.graphdb.RelationshipType
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Direction
import ar.edu.unq.epers.model.Mensaje
import org.neo4j.graphdb.traversal.Evaluators

@Accessors
class AmigosHome {
	GraphDatabaseService graph

	new(GraphDatabaseService graph) {
		this.graph = graph
	}

	private def userLabel() {
		DynamicLabel.label("User")
	}
	
	private def messageLabel() {
		DynamicLabel.label("Message")
	}
	
	def crearNodo(Usuario user) {
		graph.createNode(userLabel) => [
			setProperty("nombre", user.nombre)
			setProperty("apellido",user.apellido)
			setProperty("usuario",user.usuario)
		]
	}
	
	def crearNodo(Mensaje unMensaje) {
		graph.createNode(messageLabel) => [
			setProperty("cuerpo", unMensaje.cuerpo)
		]
	}
	


	def eliminarUsuario(Usuario user) {
		getNodo(user) => [
			relationships.forEach[delete]
			delete
		]
	}
	
	def <T> Node getNodo(T object){
		 switch object {
	      Usuario: getNodo(object as Usuario)
	      Mensaje: getNodo(object as Mensaje)
	      default: throw new RuntimeException("La clase "+ object.class.simpleName+ " no esta mapeada en Neo4j")
	    }
	}
	
	def getNodo(Usuario usuario) {
		graph.findNodes(userLabel, "usuario", usuario.usuario).head	
	}
	
	def getNodo(Mensaje mensaje){
		graph.findNodes(messageLabel, "cuerpo", mensaje.cuerpo).head
	}
	
	def relacionar(Usuario unUsuario, Usuario otroUsuario) {
		val nodo1 = getNodo(unUsuario);
		val nodo2 = getNodo(otroUsuario);
		nodo1.createRelationshipTo(nodo2,TipoDeRelaciones.AMISTAD);
	}
	
	def <T> relacionar(T obj1, T obj2, RelationshipType rel){
		var nodo1 = getNodo(obj1 as T)
		var nodo2 = getNodo(obj2 as T)
		nodo1.createRelationshipTo(nodo2, rel)
	}
	

	
	private def toUsuario(Node nodo) {
		new Usuario => [
			nombre = nodo.getProperty("nombre") as String
			apellido = nodo.getProperty("apellido") as String
			usuario = nodo.getProperty("usuario") as String
		]
	}
	
	private def toMensaje(Node nodo) {
		new Mensaje => [
			cuerpo = nodo.getProperty("cuerpo") as String
		]
	}


	def getAmigos(Usuario user) {
		val nodoUsuario = getNodo(user)
		val nodoAmigos = nodosRelacionados(nodoUsuario, TipoDeRelaciones.AMISTAD, Direction.BOTH)
		nodoAmigos.map[toUsuario].toSet
	}
	
	def getRecibidos (Usuario usuario) {
		val nodoUsuario = getNodo(usuario)
		val nodoMensajes = nodosRelacionados(nodoUsuario, TipoDeRelaciones.RECEPCION, Direction.INCOMING)
		nodoMensajes.map[toMensaje].toSet
	}


	protected def nodosRelacionados(Node nodo, RelationshipType tipo, Direction direccion) {
		nodo.getRelationships(tipo, direccion).map[it.getOtherNode(nodo)]
	}
	
	def getEnviados(Usuario usuario) {
		val nodoUsuario = getNodo(usuario)
		val nodoMensajes = nodosRelacionados(nodoUsuario, TipoDeRelaciones.ENVIO, Direction.OUTGOING)
		nodoMensajes.map[toMensaje].toSet
	}
	
	def amigosDeAmigos(Usuario usuario){
		val node = getNodo(usuario)
		graph.traversalDescription()
        .depthFirst()
        .relationships( TipoDeRelaciones.AMISTAD )
        .evaluator(Evaluators.excludeStartPosition)
        .traverse(node)
        .nodes
        .map[toUsuario]
        .toSet
		
	}
	
	def eliminarTodosLosNodosYRelaciones(){
		graph.execute("MATCH (n) DETACH DELETE n")
	}
	
}
