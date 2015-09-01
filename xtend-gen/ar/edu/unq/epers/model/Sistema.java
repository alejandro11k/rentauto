package ar.edu.unq.epers.model;

import ar.edu.unq.epers.home.Home;
import ar.edu.unq.epers.home.HomeEnMemoria;
import ar.edu.unq.epers.model.Usuario;

public class Sistema {
  private Home persistor;
  
  public Sistema() {
    HomeEnMemoria _homeEnMemoria = new HomeEnMemoria();
    this.persistor = _homeEnMemoria;
  }
  
  public java.lang.Object registrarUsuario(final Usuario usuario) {
    return null;
  }
}
