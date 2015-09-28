package ar.edu.unq.epers.arq.runner

import ar.edu.unq.epers.arq.ServiceCommand
import org.apache.log4j.Logger

abstract class RunnerDecorator implements Runner {
	protected Runner inner
	protected Logger log = Logger.getLogger(this.getClass())

	new(Runner inner) {
		this.inner = inner
	}

	override <T> T run(ServiceCommand<T> command) {
		return inner.run(command)
	}

}
