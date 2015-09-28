package ar.edu.unq.epers.arq.runner

import ar.edu.unq.epers.arq.ServiceCommand

/**
 * Executa un ServiceCommand
 */
interface Runner {
	
	def <T> T run(ServiceCommand<T> s)

}
