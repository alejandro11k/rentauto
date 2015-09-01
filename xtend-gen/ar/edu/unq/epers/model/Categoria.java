package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Auto;

/* @Accessors
 */public abstract class Categoria {
  private /* String */Object nombre;
  
  public abstract /* Double */Object calcularCosto(final Auto auto);
}
