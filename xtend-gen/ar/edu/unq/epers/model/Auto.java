package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Categoria;
import ar.edu.unq.epers.model.Reserva;
import ar.edu.unq.epers.model.Ubicacion;

/* @Accessors
 */public class Auto {
  private /* String */Object marca;
  
  private /* String */Object modelo;
  
  private /* Integer */Object año;
  
  private /* String */Object patente;
  
  private /* Double */Object costoBase;
  
  private Categoria categoria;
  
  private /* //Debe estar ordenado
  	List<Reserva> */Object reservas /* Skipped initializer because of errors */;
  
  private Ubicacion ubicacionInicial;
  
  public Auto(final /* String */Object marca, final /* String */Object modelo, final /* Integer */Object anio, final /* String */Object patente, final Categoria categoria, final /* Double */Object costoBase, final Ubicacion ubicacionInicial) {
    this.marca = marca;
    this.modelo = modelo;
    this.año = anio;
    this.patente = patente;
    this.costoBase = costoBase;
    this.categoria = categoria;
    this.ubicacionInicial = ubicacionInicial;
  }
  
  public Object getUbicacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nDate cannot be resolved.");
  }
  
  public Object ubicacionParaDia(final /* Date */Object unDia) {
    throw new Error("Unresolved compilation problems:"
      + "\nfindLast cannot be resolved"
      + "\nfin cannot be resolved"
      + "\n<= cannot be resolved"
      + "\n!= cannot be resolved"
      + "\ndestino cannot be resolved");
  }
  
  public /* Boolean */Object estaLibre(final /* Date */Object desde, final /* Date */Object hasta) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method seSuperpone is undefined for the type Auto"
      + "\nforall cannot be resolved"
      + "\n! cannot be resolved");
  }
  
  public Object agregarReserva(final Reserva reserva) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field inicio is undefined for the type Auto"
      + "\nadd cannot be resolved"
      + "\nsortInplaceBy cannot be resolved");
  }
  
  public Double costoTotal() {
    return this.categoria.calcularCosto(this);
  }
}
