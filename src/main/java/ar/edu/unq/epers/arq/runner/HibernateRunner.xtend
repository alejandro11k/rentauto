package ar.edu.unq.epers.arq.runner

import ar.edu.unq.epers.arq.ServiceCommand
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration

/**
 * Executa un ServiceCommand en el contexto de una sessi�n / transacci�n
 * de hibernate. 
 * 
 * Se encarga de liberar los recursos y comitear / rollbackear la transacci�n
 * luego de que el commando haya sido ejecutado
 */
class HibernateRunner implements Runner {
	static SessionFactory SESSION_FACTORY = HibernateRunner::initFactory()
	static ThreadLocal<Session> CURRENT_SESSION = new ThreadLocal<Session>()

	override <T> run(ServiceCommand<T> command) {
		var Session session = null
		var T result
		try {
			session = SESSION_FACTORY.openSession()
			session.beginTransaction()
			CURRENT_SESSION.set(session)
			
			result = command.call()
			
			session.flush()
			session.getTransaction().commit()
			return result

		} catch (RuntimeException e) {
			if(session !== null && session.getTransaction().isActive()) { 
				session.getTransaction().rollback()
			}
			throw e
		} finally {
			CURRENT_SESSION.set(null)
			if(session !== null) {
				session.close()
			}
		}
	}

	def private static initFactory() {
		val cfg = new Configuration()
		cfg.configure()
		cfg.buildSessionFactory()
	}

	def static currentSession() {
		val session = CURRENT_SESSION.get()
		if (session === null) {
			throw new RuntimeException("La session de hibernate no est� inicializada. 
								Esto solamente puede llamarse en el contexto de un runner")
		}
		session
	}

}
