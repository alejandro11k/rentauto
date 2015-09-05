package ar.edu.unq.epers.home

import ar.edu.unq.epers.model.Usuario

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.joda.time.DateTime

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

			//while(rs.next()){
				u.nombre = rs.getString("NOMBRE");
				u.apellido = rs.getString("APELLIDO");
				u.usuario = rs.getString("USUARIO");
				u.password = rs.getString("PASSWORD");
				u.mail = rs.getString("MAIL");
				u.nacimiento = new DateTime(rs.getDate("NACIMIENTO"))
				u.codigoDeValidacion = rs.getString("CODIGODEVALIDACION");
				u.estaValidado = rs.getBoolean("ESTAVALIDADO");
			
			//}
			
			ps.close();
		}finally{
			close(conn,ps)
		}
		u
	}
	
	override agregaUsuario(Usuario usuario) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		var java.sql.Date nacimiento = new java.sql.Date( usuario.nacimiento.getMillis())
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
		}finally{
			close(conn,ps)
		}
	}
	
	override agregarValidacionPendiente(String unNombreDeUsuario, String unCodigoDeValidacion) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getCodigoDeValidacion(Usuario unUsuario) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override noIncluye(Usuario usuario) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override dameAlUsuarioConCodigo(String unCodigoDeValidacion) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override borrarValidacionPara(Usuario unUsuario) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override actualizar(Usuario usuario) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override puedeValidarCodigo(String unCodigoDeValidacion) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
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