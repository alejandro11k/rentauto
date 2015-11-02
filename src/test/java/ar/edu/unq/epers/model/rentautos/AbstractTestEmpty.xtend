package ar.edu.unq.epers.model.rentautos

import ar.edu.unq.epers.arq.homeLocator.HibernateHomeLocator
import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.arq.runner.DummyRunner
import ar.edu.unq.epers.arq.runner.HibernateRunner
import ar.edu.unq.epers.arq.runner.LogRunner
import ar.edu.unq.epers.arq.runner.Runner
import org.junit.After
import org.junit.Before

abstract class AbstractTestEmpty {
	
	public static boolean inMemory = false
	
	Runner _runner
	
	public def Runner getRunner() {
		if (_runner === null) {
			if (inMemory) {
				_runner = new DummyRunner()
			} else {
				_runner = new HibernateRunner()
			}
			_runner = new LogRunner(_runner)
		}
		_runner
	} 

	@After
	def limpiar() {
	    runner.resetSessionFactory()
	}

	@Before
	def prepare() {
		if (inMemory) {
			//HomeLocator::setInstance(new MemoryHomeLocator())
		} else {
			HomeLocator::setInstance(new HibernateHomeLocator())
		}
		fillMocks()
	}
	
	def public void fillMocks()
	
}