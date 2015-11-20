package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
abstract class Categoria {
	String nombre
	
	abstract def Double calcularCosto(Auto auto)
	def String getNombre() { this.nombre }
}


class Turismo extends Categoria{
	
	new(){nombre="Turismo"}
	
	override calcularCosto(Auto auto) {
		if(auto.año > 2000){
			return auto.costoBase * 1.10			
		}else{
			return auto.costoBase - 200
		}
	}
}

class Familiar extends Categoria{
	
	new(){nombre="Familiar"}
	
	override calcularCosto(Auto auto) {
		return auto.costoBase + 200
	}
}

class Deportivo extends Categoria{
	
	new(){nombre="Deportivo"}
	
	override calcularCosto(Auto auto) {
		if(auto.año > 2000){
			return auto.costoBase * 1.30			
		}else{
			return auto.costoBase * 1.20
		}
	}
}

class TodoTerreno extends Categoria{
	
	new(){nombre="Todo terreno"}
	
	override calcularCosto(Auto auto) {
		auto.costoBase * 1.10
	}
}
