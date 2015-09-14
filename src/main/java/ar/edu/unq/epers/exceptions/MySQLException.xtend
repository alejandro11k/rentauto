package ar.edu.unq.epers.exceptions

import java.sql.SQLException

class MySQLException extends Exception{
	
	new(String msj, SQLException exception) {
		super(msj)
	}
	
}