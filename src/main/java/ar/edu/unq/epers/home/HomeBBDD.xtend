package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Usuario
import java.sql.Connection
import java.sql.Date
import java.sql.DriverManager
import java.sql.PreparedStatement
import java.sql.ResultSet
import org.joda.time.DateTime
import java.sql.SQLException
import ar.edu.unq.epers.exceptions.UsuarioNoExisteException
import ar.edu.unq.epers.exceptions.MySQLException

class HomeBBDD implements Home{
	
	override dameAlUsuario(Usuario usuario) {
		dameAlUsuarioConNombre(usuario.usuario)
	}
	
	override dameAlUsuarioConNombre(String unNombreDeUsuario) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		var Usuario u = null
		try{
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Usuario WHERE USUARIO = ?");
			ps.setString(1, unNombreDeUsuario);
			var ResultSet rs = ps.executeQuery();

			while(rs.next()){
				u = new Usuario(
					rs.getString("NOMBRE"),
					rs.getString("APELLIDO"),
					rs.getString("USUARIO"),
					rs.getString("PASSWORD"),
					rs.getString("MAIL"),
					new DateTime(rs.getDate("NACIMIENTO"))
				)
				u.codigoDeValidacion = rs.getString("CODIGODEVALIDACION")
				u.estaValidado = rs.getBoolean("ESTAVALIDADO")
			
			}
			
			ps.close();
		}catch (SQLException e) {
   			throw new MySQLException("error en dameAlUsuarioConNombre", e);
		}
		finally{
			close(conn,ps)
		}
		u
	}
	
	def private dameNombreConCodigoDeValidacion(String unCodigoDeValidacion) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		var String u = null
		try{
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Validacion WHERE CODIGODEVALIDACION = ?");
			ps.setString(1, unCodigoDeValidacion);
			var ResultSet rs = ps.executeQuery();

			while(rs.next()){
				u = rs.getString("USUARIO")
			}
			
			ps.close();
		}catch (SQLException e) {
   			throw new MySQLException("error en dameNombreConCodigoDeValidacion", e);
		} 
		finally{
			close(conn,ps)
		}
		u
	}
	
	
	override agregaUsuario(Usuario usuario) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		var Date nacimiento = new Date( usuario.nacimiento.getMillis())
		try{
			conn = this.getConnection();
			ps = conn.prepareStatement("INSERT INTO Usuario (NOMBRE, APELLIDO, USUARIO, PASSWORD, 
			MAIL, NACIMIENTO, CODIGODEVALIDACION, ESTAVALIDADO) VALUES (?,?,?,?,?,?,?,?)");
			ps.setString(1, usuario.nombre);
			ps.setString(2, usuario.apellido);
			ps.setString(3, usuario.usuario);
			ps.setString(4, usuario.password);
			ps.setString(5, usuario.mail);
			ps.setDate(6, nacimiento);
			ps.setString(7, usuario.codigoDeValidacion);
			ps.setBoolean(8, usuario.estaValidado);
			ps.execute();
			ps.close();
		}catch (SQLException e) {
   			throw new MySQLException("error en agregarUsuario", e);
		}
		finally{
			close(conn,ps)
		}
	}
	
	override agregarValidacionPendiente(String unNombreDeUsuario, String unCodigoDeValidacion) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try{
			conn = this.getConnection();
			ps = conn.prepareStatement("INSERT INTO Validacion (USUARIO, CODIGODEVALIDACION) VALUES (?,?)");
			ps.setString(1, unNombreDeUsuario);
			ps.setString(2, unCodigoDeValidacion);
			ps.execute();
			ps.close();
		}catch (SQLException e) {
   			throw new MySQLException("error en agregarValidacionPendiente", e);
		}
		finally{
			close(conn,ps)
		}
	}
	
	override eliminarRegistros() {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try{
			conn = this.getConnection();
			ps = conn.prepareStatement("DELETE FROM Validacion");
			ps.execute();
			ps.close();
		}finally{
			close(conn,ps)
		}
		conn = null;
		ps = null;
		try{
			conn = this.getConnection();
			ps = conn.prepareStatement("DELETE FROM Usuario");
			ps.execute();
			ps.close();
		}catch (SQLException e) {
   			throw new MySQLException("error en eliminarRegistros", e);
		}
		finally{
			close(conn,ps)
		}
	}
	
	override getCodigoDeValidacion(Usuario unUsuario) {
		dameAlUsuarioConNombre(unUsuario.usuario).codigoDeValidacion
	}
	
	override noIncluye(Usuario usuario) {	
		!dameAlUsuario(usuario).estaValidado
		
	}
	
	override puedeValidarCodigo(String unCodigoDeValidacion) {
		dameNombreConCodigoDeValidacion(unCodigoDeValidacion)!=null
	}
	
	override dameAlUsuarioConCodigo(String unCodigoDeValidacion) {
		dameAlUsuarioConNombre(dameNombreConCodigoDeValidacion(unCodigoDeValidacion))
	}
	
	override borrarValidacionPara(Usuario unUsuario) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try{
			conn = this.getConnection();
			ps = conn.prepareStatement("DELETE FROM Validacion WHERE USUARIO = ?");
			ps.setString(1, unUsuario.usuario);
			ps.execute();
			ps.close();
		}catch (SQLException e) {
   			throw new MySQLException("error en borrarValidacionPara", e);
		}
		finally{
			close(conn,ps)
		}
	}
	
	override actualizar(Usuario usuario) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		var Date nacimiento = new Date( usuario.nacimiento.getMillis())
		try{
			conn = this.getConnection();
			ps = conn.prepareStatement("UPDATE Usuario SET 
			NOMBRE=?, APELLIDO=?, PASSWORD=?, 
			MAIL=?, NACIMIENTO=?, ESTAVALIDADO=?
			WHERE USUARIO = ?");
			ps.setString(1, usuario.nombre);
			ps.setString(2, usuario.apellido);
			ps.setString(3, usuario.password);
			ps.setString(4, usuario.mail);
			ps.setDate(5, nacimiento);
			ps.setBoolean(6, usuario.estaValidado);
			ps.setString(7, usuario.usuario);
			ps.execute();
			ps.close();
		}catch (SQLException e) {
   			throw new MySQLException("error en actualizar", e);
		}
		finally{
			close(conn,ps)
		}
	}
	
	@Deprecated
	def private borrarUsuario(Usuario usuario) {
		//el sistema no implementa borrar usuarios por el momento
		var Connection conn = null;
		var PreparedStatement ps = null;
		try{
			conn = getConnection();
			ps = conn.prepareStatement("DELETE FROM Usuario WHERE USUARIO = ?");
			ps.setString(1, usuario.usuario);
			ps.execute();
			ps.close();
		}finally{
			close(conn,ps)
		}
	}
	
	
	
	def private Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/EpersTP1?user=root&password=test");
	}
	
	def close(Connection conn, PreparedStatement ps) {
		if(ps != null)
			ps.close();
		if(conn != null)
			conn.close();
	}
	
}