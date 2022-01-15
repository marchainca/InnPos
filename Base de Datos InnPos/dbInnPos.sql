-- MySQL Script generated by MySQL Workbench
-- Fri Jan 14 17:29:36 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dbinnpos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbinnpos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbinnpos` DEFAULT CHARACTER SET utf8 ;
USE `dbinnpos` ;

-- -----------------------------------------------------
-- Table `dbinnpos`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(50) NOT NULL,
  `apellido` CHAR(50) NOT NULL,
  `identificacion` CHAR(15) NOT NULL,
  `telefono` CHAR(12) NOT NULL,
  `correo` CHAR(30) NOT NULL,
  `direccion` CHAR(40) NOT NULL,
  `cargo` ENUM('0', '1') NOT NULL,
  `user` CHAR(25) NOT NULL,
  `password` CHAR(180) NOT NULL,
  `password2` CHAR(180) NOT NULL,
  `fecha_ingreso` DATE NOT NULL,
  `estado` ENUM('0', '1') NOT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `categoria` CHAR(30) NOT NULL,
  `estado` ENUM('0', '1') NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_categoria`),
  INDEX `fk_categoria_usuario_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_categoria_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbinnpos`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `producto` CHAR(30) NOT NULL,
  `presentacion` CHAR(30) NOT NULL,
  `unidad` CHAR(30) NOT NULL,
  `moneda` CHAR(20) NOT NULL,
  `precio_compra` CHAR(45) NOT NULL,
  `precio_venta` CHAR(45) NOT NULL,
  `stock` CHAR(45) NOT NULL,
  `estado` ENUM('0', '1') NOT NULL,
  `imagen` CHAR(45) NOT NULL,
  `fecha_vencimiento` DATE NOT NULL,
  `id_categoria` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `id_categoria_idx` (`id_categoria` ASC),
  INDEX `fk_producto_usuario_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_producto_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `dbinnpos`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbinnpos`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `identificacion` CHAR(15) NOT NULL,
  `razon_social` CHAR(45) NOT NULL,
  `telefono` CHAR(12) NOT NULL,
  `correo` CHAR(30) NOT NULL,
  `direccion` CHAR(40) NOT NULL,
  `fecha` DATE NOT NULL,
  `estado` ENUM('0', '1') NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  INDEX `fk_proveedor_usuario_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_proveedor_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbinnpos`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`compra` (
  `id_compras` INT NOT NULL AUTO_INCREMENT,
  `fecha_compra` DATE NOT NULL,
  `numero_compra` CHAR(45) NOT NULL,
  `proveedor` CHAR(45) NOT NULL,
  `identificacion_proveedor` CHAR(15) NOT NULL,
  `comprador` CHAR(45) NOT NULL,
  `moneda` CHAR(20) NOT NULL,
  `subtotal` CHAR(20) NOT NULL,
  `total_iva` CHAR(20) NOT NULL,
  `total` CHAR(20) NOT NULL,
  `tipo_pago` CHAR(45) NOT NULL,
  `estado` ENUM('0', '1') NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_proveedor` INT NOT NULL,
  PRIMARY KEY (`id_compras`),
  INDEX `fk_compra_usuario_idx` (`id_usuario` ASC),
  INDEX `fk_compra_proveedor_idx` (`id_proveedor` ASC),
  CONSTRAINT `fk_compra_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbinnpos`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_proveedor`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `dbinnpos`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`detalle_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`detalle_compra` (
  `id_detalle_compra` INT NOT NULL AUTO_INCREMENT,
  `numero_compra` CHAR(45) NOT NULL,
  `indentificacion_proveedor` CHAR(45) NOT NULL,
  `producto` CHAR(30) NOT NULL,
  `moneda` CHAR(20) NOT NULL,
  `precio_compra` CHAR(45) NOT NULL,
  `cantidad_compra` CHAR(45) NOT NULL,
  `descuento` CHAR(45) NOT NULL,
  `importe` CHAR(45) NOT NULL,
  `fecha_compra` DATE NOT NULL,
  `estado` ENUM('0', '1') NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_proveedor` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_detalle_compra`),
  INDEX `fk_detalle_compra_producto_idx` (`id_producto` ASC),
  INDEX `fk_detalle_compra_usuario_idx` (`id_usuario` ASC),
  INDEX `fk_detalle_compra_proveedor_idx` (`id_proveedor` ASC),
  INDEX `fk_detalle_compra_categoria_idx` (`id_categoria` ASC),
  CONSTRAINT `fk_detalle_compra_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `dbinnpos`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_compra_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbinnpos`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_compra_proveedor`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `dbinnpos`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_compra_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `dbinnpos`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`cliente` (
  `id_cliente` INT NOT NULL,
  `ident_cliente` CHAR(15) NOT NULL,
  `nombre_cliente` CHAR(50) NOT NULL,
  `apellido_cliente` CHAR(50) NOT NULL,
  `telefono_cliente` CHAR(12) NOT NULL,
  `correo_cliente` CHAR(30) NOT NULL,
  `direccion_cliente` CHAR(40) NOT NULL,
  `fecha_ingreso` DATE NOT NULL,
  `estado` ENUM('0', '1') NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_cliente_usuario_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_cliente_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbinnpos`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`venta` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATE NOT NULL,
  `numero_venta` CHAR(20) NOT NULL,
  `cliente` CHAR(100) NOT NULL,
  `ident_cliente` CHAR(15) NOT NULL,
  `vendedor` CHAR(100) NOT NULL,
  `moneda` CHAR(20) NOT NULL,
  `subtotal` CHAR(20) NOT NULL,
  `total_iva` CHAR(20) NOT NULL,
  `total` CHAR(20) NOT NULL,
  `tipo_pago` CHAR(45) NOT NULL,
  `estado` ENUM('0', '1') NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `fk_venta_usuario_idx` (`id_usuario` ASC),
  INDEX `fk_venta_cliente_idx` (`id_cliente` ASC),
  CONSTRAINT `fk_venta_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbinnpos`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `dbinnpos`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`detalle_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`detalle_venta` (
  `id_detalle_venta` INT NOT NULL AUTO_INCREMENT,
  `numero_venta` CHAR(20) NOT NULL,
  `ident_cliente` CHAR(15) NOT NULL,
  `producto` CHAR(30) NULL,
  `moneda` CHAR(20) NOT NULL,
  `precio_venta` CHAR(20) NOT NULL,
  `cantidad_venta` CHAR(20) NOT NULL,
  `descuento` CHAR(45) NOT NULL,
  `importe` CHAR(45) NOT NULL,
  `fecha_venta` DATE NOT NULL,
  `estado` ENUM('0', '1') NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_producto` INT NOT NULL,
  PRIMARY KEY (`id_detalle_venta`),
  INDEX `fk_detalle_venta_usuario_idx` (`id_usuario` ASC),
  INDEX `fk_detalle_venta_cliente_idx` (`id_cliente` ASC),
  INDEX `fk_detalle_venta_producto_idx` (`id_producto` ASC),
  CONSTRAINT `fk_detalle_venta_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbinnpos`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `dbinnpos`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `dbinnpos`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`empresa` (
  `id_empresa` INT NOT NULL AUTO_INCREMENT,
  `ident_empresa` CHAR(20) NOT NULL,
  `nombre_empresa` CHAR(20) NOT NULL,
  `direccion_empresa` CHAR(45) NOT NULL,
  `correo_empresa` CHAR(45) NOT NULL,
  `telefono_empresa` CHAR(15) NOT NULL,
  `id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_empresa`),
  INDEX `fk_empresa_usuario_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_empresa_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbinnpos`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`permiso` (
  `id_permiso` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(45) NOT NULL,
  PRIMARY KEY (`id_permiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbinnpos`.`usuario_permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbinnpos`.`usuario_permiso` (
  `id_usuario_permiso` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `id_permiso` INT NOT NULL,
  PRIMARY KEY (`id_usuario_permiso`),
  INDEX `fk_usuario_permiso_usuario_idx` (`id_usuario` ASC),
  INDEX `fk_usuario_permiso_permiso_idx` (`id_permiso` ASC),
  CONSTRAINT `fk_usuario_permiso_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbinnpos`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_permiso_permiso`
    FOREIGN KEY (`id_permiso`)
    REFERENCES `dbinnpos`.`permiso` (`id_permiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;