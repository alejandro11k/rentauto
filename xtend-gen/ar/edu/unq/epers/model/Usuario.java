package ar.edu.unq.epers.model;

public class Usuario {
  private /* String */Object nombre;
  
  private /* String */Object apellido;
  
  private /* String */Object usuario;
  
  private /* String */Object password;
  
  private /* String */Object mail;
  
  private /* DateTime */Object nacimiento;
  
  public Usuario(final /* String */Object nombre, final /* String */Object apellido, final /* String */Object usuario, final /* String */Object password, final /* String */Object mail, final /* DateTime */Object nacimiento) {
    this.nombre = nombre;
    this.apellido = apellido;
    this.usuario = usuario;
    this.password = password;
    this.mail = mail;
    this.nacimiento = nacimiento;
  }
}
