package ar.edu.unq.epers.model

import java.util.Random

class Validador {
	
	var letras = 'qwertyuiopasssdfghjklzxcvbnm'
	var numeros = '1234567890'
	
	def String generarCodigoDeValidacion(){
		
		var r = new Random()
		var nuevoCodigo = new StringBuilder()
		
		for(i : 0..<3){
			var l = letras.charAt(r.nextInt(26))
			nuevoCodigo = nuevoCodigo.append(l)
		}
		for(i : 0..<3){
			nuevoCodigo = nuevoCodigo.append(numeros.charAt(r.nextInt(10)))
		}
		
		nuevoCodigo.toString
		
	}
	
	
	
}