package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Empresa;
import ar.edu.unq.epers.model.Reserva;

/* @Accessors
 */public class ReservaEmpresarial extends Reserva {
  private Empresa empresa;
  
  private /* String */Object nombreContacto;
  
  private /* String */Object cargoContacto;
  
  public void reservar() {
    super.reservar();
    this.empresa.agregarReserva(this);
  }
}
