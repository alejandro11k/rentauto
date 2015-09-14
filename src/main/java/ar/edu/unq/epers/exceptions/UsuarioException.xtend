package ar.edu.unq.epers.exceptions

import java.sql.SQLException

class UsuarioYaExisteException extends Exception {}

class ValidacionException extends Exception {}

class UsuarioNoExisteException extends Exception {}

class NuevaPasswordInvalida extends Exception {}