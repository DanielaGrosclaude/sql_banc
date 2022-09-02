SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- crea banco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `banco` DEFAULT CHARACTER SET utf8 ;
USE `banco` ;

-- -----------------------------------------------------
-- Tabla banco 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `banco`.`sucursal` (
  `id_sucursal` INT NOT NULL,
  `nombre_sucursal` VARCHAR(40) NOT NULL,
  `localidad` VARCHAR(45) NULL,
  PRIMARY KEY (`id_sucursal`))
;


-- -----------------------------------------------------
-- Tabla cuenta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`cuenta` (
  `id_cuenta` INT NOT NULL,
  `fecha_alta` DATE NOT NULL,
  PRIMARY KEY (`id_cuenta`))
;


-- -----------------------------------------------------
-- Tabla cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `cuit` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(40) NOT NULL,
  `fecha_alta` DATETIME NOT NULL,
  `fecha_proceso` DATETIME NOT NULL,
  `cuenta_id_cuenta` INT NOT NULL,
  `sucursal_id_sucursal` INT NOT NULL,
  PRIMARY KEY (`id_cliente`, `cuenta_id_cuenta`),
  INDEX `fk_cliente_cuenta1_idx` (`cuenta_id_cuenta` ASC) VISIBLE,
  INDEX `fk_cliente_sucursal1_idx` (`sucursal_id_sucursal` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_cuenta1`
    FOREIGN KEY (`cuenta_id_cuenta`)
    REFERENCES `banco`.`cuenta` (`id_cuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_sucursal1`
    FOREIGN KEY (`sucursal_id_sucursal`)
    REFERENCES `banco`.`sucursal` (`id_sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Tabla tarjeta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banco`.`tarjeta` (
  `num_tarjeta` INT NOT NULL AUTO_INCREMENT,
  `id_transaccion` INT NOT NULL,
  `id_cuenta` INT NOT NULL,
  `fecha_alta` DATE NOT NULL,
  `fecha_caducidad` DATE NULL,
  `saldo` FLOAT NOT NULL,
  `cliente_id_cuenta` INT NOT NULL,
  PRIMARY KEY (`num_tarjeta`),
  INDEX `fk_tarjeta_cliente1_idx` (`cliente_id_cuenta` ASC) VISIBLE,
  CONSTRAINT `fk_tarjeta_cliente1`
    FOREIGN KEY (`cliente_id_cuenta`)
    REFERENCES `banco`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ;


-- -----------------------------------------------------
-- Tabla transaccion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `banco`.`transaccion` (
  `id_transaccion` INT NOT NULL AUTO_INCREMENT,
  `id_cuenta` INT NOT NULL,
  `monto` FLOAT NOT NULL,
  `cuenta_destino` VARCHAR(20) NOT NULL,
  `fecha_proceso` DATETIME NOT NULL,
  `tarjeta_num_tarjeta` INT NOT NULL,
  PRIMARY KEY (`id_transaccion`),
  INDEX `fk_transaccion_tarjeta_idx` (`tarjeta_num_tarjeta` ASC) VISIBLE,
  CONSTRAINT `fk_transaccion_tarjeta`
    FOREIGN KEY (`tarjeta_num_tarjeta`)
    REFERENCES `banco`.`tarjeta` (`num_tarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



