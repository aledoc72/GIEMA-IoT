-- MySQL Workbench Synchronization
-- Generated: 2019-09-04 18:01
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Usuario

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `ingusbbo_giot` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `ingusbbo_giot`.`usuario` (
  `username` VARCHAR(45) NOT NULL,
  `clave` VARCHAR(256) NOT NULL,
  `nombres` VARCHAR(60) NOT NULL,
  `apellidos` VARCHAR(60) NOT NULL,
  `correo` VARCHAR(80) NOT NULL,
  `tipo_usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC),
  INDEX `fk_usuario_tipo_usuario_idx` (`tipo_usuario` ASC),
  CONSTRAINT `fk_usuario_tipo_usuario`
    FOREIGN KEY (`tipo_usuario`)
    REFERENCES `ingusbbo_giot`.`tipo_usuario` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ingusbbo_giot`.`nodo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `latitud` DOUBLE NOT NULL,
  `longitud` DOUBLE NOT NULL,
  `protocolo` VARCHAR(80) NOT NULL,
  `gateway` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nodo_gateway_idx` (`gateway` ASC),
  CONSTRAINT `fk_nodo_gateway`
    FOREIGN KEY (`gateway`)
    REFERENCES `ingusbbo_giot`.`gateway` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ingusbbo_giot`.`sensor` (
  `id` INT(11) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `frecuencia_min` INT(3) NOT NULL,
  `nodo` INT(11) NOT NULL,
  `tipo_sensor` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sensor_nodo_idx` (`nodo` ASC),
  INDEX `fk_sensor_tipo_sensor_idx` (`tipo_sensor` ASC),
  CONSTRAINT `fk_sensor_nodo`
    FOREIGN KEY (`nodo`)
    REFERENCES `ingusbbo_giot`.`nodo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sensor_tipo_sensor`
    FOREIGN KEY (`tipo_sensor`)
    REFERENCES `ingusbbo_giot`.`tipo_sensor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ingusbbo_giot`.`tipo_sensor` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` INT(11) NOT NULL,
  `magnitud` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ingusbbo_giot`.`gateway` (
  `id` INT(11) NOT NULL,
  `clave` VARCHAR(256) NOT NULL,
  `protocolo` VARCHAR(45) NOT NULL,
  `sis_opt` VARCHAR(46) NOT NULL,
  `contacto` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ingusbbo_giot`.`tipo_usuario` (
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ingusbbo_giot`.`mensaje` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `valor` VARCHAR(45) NOT NULL,
  `sensor` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mensaje_sensor_idx` (`sensor` ASC),
  CONSTRAINT `fk_mensaje_sensor`
    FOREIGN KEY (`sensor`)
    REFERENCES `ingusbbo_giot`.`sensor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
