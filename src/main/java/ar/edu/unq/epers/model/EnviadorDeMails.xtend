package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors

interface EnviadorDeMails {
	def void enviarMail(Mail mail)
}

@Accessors
class Mail {
	String body
	String subject
	String to
	String from
}