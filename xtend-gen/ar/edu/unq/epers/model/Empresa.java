package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Categoria;
import ar.edu.unq.epers.model.IUsuario;
import ar.edu.unq.epers.model.Reserva;

/* @Accessors
 */public class Empresa {
  private /* String */Object cuit;
  
  private /* String */Object nombreEmpresa;
  
  private /* List<IUsuario> */Object usuarios /* Skipped initializer because of errors */;
  
  private /* List<Reserva> */Object reservas /* Skipped initializer because of errors */;
  
  private int cantidadMaximaDeReservasActivas;
  
  private /* Double */Object valorMaximoPorDia;
  
  private /* List<Categoria> */Object categoriasAdmitidas /* Skipped initializer because of errors */;
  
  public java.lang.Object agregarReserva(final Reserva unaReserva) {
    throw new Error("Unresolved compilation problems:"
      + "\nadd cannot be resolved");
  }
  
  public void validarReserva(final Reserva unaReserva) {
    throw new Error("Unresolved compilation problems:"
      + "\n> cannot be resolved."
      + "\nThe field usuario is not visible"
      + "\nThe field auto is not visible"
      + "\nThe field categoria is not visible"
      + "\nsize cannot be resolved"
      + "\n== cannot be resolved"
      + "\ncontains cannot be resolved"
      + "\n! cannot be resolved"
      + "\nempty cannot be resolved"
      + "\n! cannot be resolved"
      + "\n&& cannot be resolved"
      + "\ncontains cannot be resolved"
      + "\n! cannot be resolved");
  }
  
  public Object reservasActivas() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field activa is undefined for the type Empresa"
      + "\nfilter cannot be resolved");
  }
}
