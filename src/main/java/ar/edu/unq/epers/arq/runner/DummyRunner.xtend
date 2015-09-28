package ar.edu.unq.epers.arq.runner

import ar.edu.unq.epers.arq.ServiceCommand

/**
 * Simplemente ejecuta el comando
 */
class DummyRunner implements Runner {
	
	override <T> run(ServiceCommand<T> command) {
		command.call()
	}

}
