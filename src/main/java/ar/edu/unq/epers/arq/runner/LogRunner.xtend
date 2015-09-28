package ar.edu.unq.epers.arq.runner

import ar.edu.unq.epers.arq.ServiceCommand

/**
 * Decora la ejecuci�n de cualquier comando con lineas de log
 */
class LogRunner extends RunnerDecorator {
	
	new(Runner inner) {
		super(inner)
	}

	override <T> T run(ServiceCommand<T> command) {
		log.info('''Inicio: �command.getClass()�''')
		
		var startTime = System.currentTimeMillis()
		try {
			super.run(command)
		} finally {
			val timeTook = System.currentTimeMillis() - startTime
			log.info('''Fin: �command.getClass()� Tiempo: �timeTook� ms''')
		}

	}

}
