drop schema if exists EpersTP1;
create database EpersTP1;

use EpersTP1;

CREATE TABLE Usuario(
NOMBRE varchar(12),
APELLIDO varchar(12),
USUARIO varchar(12),
PASSWORD varchar(12),
MAIL varchar(12),
NACIMIENTO date,
CODIGODEVALIDACION varchar(6),
ESTAVALIDADO boolean,
PRIMARY KEY (USUARIO)
);

CREATE TABLE Validacion(USUARIO varchar(12),
CODIGODEVALIDACION varchar(6),
PRIMARY KEY (CODIGODEVALIDACION),
FOREIGN KEY (USUARIO) REFERENCES Usuario(USUARIO)
);

DROP SCHEMA IF EXISTS rentauto;
CREATE SCHEMA rentauto;

USE rentauto;

CREATE TABLE  `rentauto`.`ubicaciones` (
  `U_NOMBRE` varchar(20) NOT NULL,
  PRIMARY KEY (`U_NOMBRE`)
) 

INSERT INTO jugadores (J_NOMBRE,J_APELLIDO,J_NRO) VALUES ("Juan Carlos","Batman",23);
  `J_ID` int(11) NOT NULL AUTO_INCREMENT,
ENGINE = InnoDB AUTO_INCREMENT=1;