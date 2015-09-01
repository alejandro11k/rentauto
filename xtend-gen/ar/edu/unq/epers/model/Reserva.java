package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Auto;
import ar.edu.unq.epers.model.IUsuario;
import ar.edu.unq.epers.model.Ubicacion;

/* @Accessors
 */public class Reserva {
  private /* Integer */Object numeroSolicitud;
  
  private Ubicacion origen;
  
  private Ubicacion destino;
  
  private /* Date */Object inicio;
  
  private /* Date */Object fin;
  
  private Auto auto;
  
  private IUsuario usuario;
  
  public Object costo() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field Days is undefined for the type Reserva"
      + "\nDateTime cannot be resolved."
      + "\nDateTime cannot be resolved."
      + "\ndaysBetween cannot be resolved"
      + "\ndays cannot be resolved"
      + "\n* cannot be resolved");
  }
  
  public void validar() {
    throw new Error("Unresolved compilation problems:"
      + "\n!= cannot be resolved"
      + "\n! cannot be resolved");
  }
  
  public Object isActiva() {
    throw new Error("Unresolved compilation problems:"
      + "\n<= cannot be resolved"
      + "\n&& cannot be resolved"
      + "\n<= cannot be resolved");
  }
  
  public boolean seSuperpone(final /* Date */Object desde, final /* Date */Object hasta) {
    throw new Error("Unresolved compilation problems:"
      + "\n<= cannot be resolved"
      + "\n&& cannot be resolved"
      + "\n<= cannot be resolved"
      + "\n<= cannot be resolved"
      + "\n&& cannot be resolved"
      + "\n<= cannot be resolved"
      + "\n<= cannot be resolved"
      + "\n&& cannot be resolved"
      + "\n<= cannot be resolved");
  }
  
  public int costoPorDia() {
    return 0;
  }
  
  public void reservar() {
    this.auto.agregarReserva(this);
    this.usuario.agregarReserva(this);
  }
}
