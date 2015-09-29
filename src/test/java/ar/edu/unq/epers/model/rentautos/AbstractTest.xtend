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

class AbstractTest {
	
	public static boolean inMemory = true
	
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
	
	def private void fillMocks() {
		runner.run([
			
			val empresaHome = HomeLocator::instance.empresaHome
			val autoHome = HomeLocator::instance.autoHome
			val ubicacionHome = HomeLocator::instance.ubicacionHome
			val usuarioHome = HomeLocator::instance.usuarioHome
			
			val categoriaFamiliar = new Familiar
			val retiro = new Ubicacion("Retiro")
			val aeroparque = new Ubicacion("Aeroparque")
			val auto = new Auto => [
				marca = "Peugeot"
				modelo = "505"
				año = 1990
				patente = "XXX123"
				costoBase = 100D
				categoria = categoriaFamiliar
				ubicacionInicial = retiro
			]
			
			ubicacionHome => [
				save(retiro)
				save(aeroparque)
			]
			
			autoHome.save(auto)
	
			val usuarioPrueba = new Usuario => [
				nombre = "Pepe"
				apellido = "Pruebas"
				usuario = "usuarioPrueba"
				password = "pss"
				mail = "mail@mail.com"
				nacimiento = new DateTime(1990,05,05,0,0) 
				estaValidado = true
			]
			
			usuarioHome.save(usuarioPrueba)
			
			val usuarioEmpresa = new Usuario => [
				nombre = "Pepa"
				apellido = "Pruebo"
				usuario = "usuarioEmpresa"
				password = "pss2"
				mail = "mail2@mail.com"
				nacimiento = new DateTime(1991,05,05,0,0) 
				estaValidado = true
			]
			
			usuarioHome.save(usuarioEmpresa)
			
			val empresa = new Empresa => [
				cuit = "30-11223344-90"
				nombreEmpresa = "Empresa Fantasmita"
				cantidadMaximaDeReservasActivas = 2
				valorMaximoPorDia = 1000D
			]
			
			empresaHome.save(empresa)
			
			empresa.usuarios.add(usuarioEmpresa)
		])
	}
}
