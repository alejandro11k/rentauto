package ar.edu.unq.epers.servicios

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.AutoHomeHbn
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Ubicacion

class AutoService {
	
	def crearAuto(String marca, String modelo, Integer anio, String patente, 
		Categoria categoria, Double costoBase, Ubicacion ubicacionInicial) {
		SessionManager.runInSession([
			var auto = new Auto(marca,modelo,anio,patente,categoria,costoBase,
				ubicacionInicial);
			new AutoHomeHbn().save(auto)
			auto
		]);
	}
	
}