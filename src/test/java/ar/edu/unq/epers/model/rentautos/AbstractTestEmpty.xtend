package ar.edu.unq.epers.model.rentautos

import ar.edu.unq.epers.arq.homeLocator.HibernateHomeLocator
import ar.edu.unq.epers.arq.homeLocator.HomeLocator
import ar.edu.unq.epers.arq.homeLocator.MemoryHomeLocator
import ar.edu.unq.epers.arq.runner.DummyRunner
import ar.edu.unq.epers.arq.runner.HibernateRunner
import ar.edu.unq.epers.arq.runner.LogRunner
import ar.edu.unq.epers.arq.runner.Runner
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Empresa
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.model.Usuario
import org.joda.time.DateTime
import org.junit.Before

class AbstractTestEmpty {
	
	public static boolean inMemory = false
	
	Runner _runner
	
	protected def Runner getRunner() {
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

	@Before
	def prepare() {
		if (inMemory) {
			HomeLocator::setInstance(new MemoryHomeLocator())
		} else {
			HomeLocator::setInstance(new HibernateHomeLocator())
		}
		fillMocks()
	}
	
	def private void fillMocks(){
		runner.run([
			val empresaHome = HomeLocator::instance.empresaHome
			val autoHome = HomeLocator::instance.autoHome
			val ubicacionHome = HomeLocator::instance.ubicacionHome
			val usuarioHome = HomeLocator::instance.usuarioHome
			
			null
		])
	}
}