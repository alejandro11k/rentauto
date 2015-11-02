package ar.edu.unq.epers.arq

import java.util.concurrent.Callable

interface ServiceCommand<T> extends Callable<T> {

	override def T call()

}
