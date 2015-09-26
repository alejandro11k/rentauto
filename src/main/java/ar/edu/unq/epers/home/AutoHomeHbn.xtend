package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Auto

class AutoHomeHbn {
	
	def save(Auto j) {
		SessionManager.getSession().saveOrUpdate(j)
	}
	
}