package ar.edu.unq.epers.arq

import ar.edu.unq.epers.arq.runner.Runner

/**
 * Tipo base para todos los servicios
 */
abstract class Service {
	
	Runner runner
	
	new(Runner runner) {
		this.runner = runner
	}
	
	protected def <T> execute(ServiceCommand<T> command) {
		runner.run(command)
	}
	
}