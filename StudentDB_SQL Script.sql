-- MySQL Script generated by MySQL Workbench
-- Tue Dec  6 12:12:54 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student` (
  `idStudent` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `studentType` VARCHAR(45) NULL,
  PRIMARY KEY (`idStudent`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Instructor` (
  `idInstructor` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `SSN` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idInstructor`),
  UNIQUE INDEX `SSN_UNIQUE` (`SSN` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Course` (
  `idCourse` INT NOT NULL,
  `Title` VARCHAR(45) NULL,
  `Instructor_idInstructor` INT NOT NULL,
  PRIMARY KEY (`idCourse`),
  INDEX `fk_Course_Instructor_idx` (`Instructor_idInstructor` ASC) VISIBLE,
  CONSTRAINT `fk_Course_Instructor`
    FOREIGN KEY (`Instructor_idInstructor`)
    REFERENCES `mydb`.`Instructor` (`idInstructor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Team` (
  `idTeam` INT NULL,
  `Course_idCourse` INT NOT NULL,
  PRIMARY KEY (`idTeam`, `Course_idCourse`),
  INDEX `fk_Team_Course1_idx` (`Course_idCourse` ASC) VISIBLE,
  CONSTRAINT `fk_Team_Course1`
    FOREIGN KEY (`Course_idCourse`)
    REFERENCES `mydb`.`Course` (`idCourse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Report` (
  `idReport` INT NOT NULL,
  `Title` VARCHAR(45) NULL,
  `Team_idTeam` INT NOT NULL,
  `Team_Course_idCourse` INT NOT NULL,
  PRIMARY KEY (`idReport`),
  INDEX `fk_Report_Team1_idx` (`Team_idTeam` ASC, `Team_Course_idCourse` ASC) VISIBLE,
  CONSTRAINT `fk_Report_Team1`
    FOREIGN KEY (`Team_idTeam` , `Team_Course_idCourse`)
    REFERENCES `mydb`.`Team` (`idTeam` , `Course_idCourse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Instructor_Phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Instructor_Phone` (
  `Phone` INT NOT NULL,
  `Instructor_idInstructor` INT NOT NULL,
  `PhoneInsID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PhoneInsID`),
  INDEX `fk_Instructor_Phone_Instructor1_idx` (`Instructor_idInstructor` ASC) VISIBLE,
  CONSTRAINT `fk_Instructor_Phone_Instructor1`
    FOREIGN KEY (`Instructor_idInstructor`)
    REFERENCES `mydb`.`Instructor` (`idInstructor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Enrollment` (
  `Course_idCourse` INT NOT NULL,
  `Student_idStudent` INT NOT NULL,
  `Grade` DECIMAL(3) NULL,
  PRIMARY KEY (`Course_idCourse`, `Student_idStudent`),
  INDEX `fk_Course_has_Student_Student1_idx` (`Student_idStudent` ASC) VISIBLE,
  INDEX `fk_Course_has_Student_Course1_idx` (`Course_idCourse` ASC) VISIBLE,
  CONSTRAINT `fk_Course_has_Student_Course1`
    FOREIGN KEY (`Course_idCourse`)
    REFERENCES `mydb`.`Course` (`idCourse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_has_Student_Student1`
    FOREIGN KEY (`Student_idStudent`)
    REFERENCES `mydb`.`Student` (`idStudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prerequisite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prerequisite` (
  `Course_idCourse` INT NOT NULL,
  `Prereq_ID` INT NOT NULL,
  PRIMARY KEY (`Course_idCourse`, `Prereq_ID`),
  INDEX `fk_Course_has_Course_Course2_idx` (`Prereq_ID` ASC) VISIBLE,
  INDEX `fk_Course_has_Course_Course1_idx` (`Course_idCourse` ASC) VISIBLE,
  CONSTRAINT `fk_Course_has_Course_Course1`
    FOREIGN KEY (`Course_idCourse`)
    REFERENCES `mydb`.`Course` (`idCourse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_has_Course_Course2`
    FOREIGN KEY (`Prereq_ID`)
    REFERENCES `mydb`.`Course` (`idCourse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`GradStudent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`GradStudent` (
  `Student_idStudent` INT NOT NULL,
  `Advisor` INT NULL,
  PRIMARY KEY (`Student_idStudent`),
  INDEX `fk_GradStudent_Instructor1_idx` (`Advisor` ASC) VISIBLE,
  CONSTRAINT `fk_GradStudent_Student1`
    FOREIGN KEY (`Student_idStudent`)
    REFERENCES `mydb`.`Student` (`idStudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GradStudent_Instructor1`
    FOREIGN KEY (`Advisor`)
    REFERENCES `mydb`.`Instructor` (`idInstructor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UGStudent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`UGStudent` (
  `Student_idStudent` INT NOT NULL,
  `Major` VARCHAR(45) NULL,
  `Tutor` INT NULL,
  `Mentor` INT NULL,
  PRIMARY KEY (`Student_idStudent`),
  INDEX `fk_UGStudent_GradStudent1_idx` (`Tutor` ASC) VISIBLE,
  INDEX `fk_UGStudent_UGStudent1_idx` (`Mentor` ASC) INVISIBLE,
  CONSTRAINT `fk_UGStudent_Student1`
    FOREIGN KEY (`Student_idStudent`)
    REFERENCES `mydb`.`Student` (`idStudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UGStudent_GradStudent1`
    FOREIGN KEY (`Tutor`)
    REFERENCES `mydb`.`GradStudent` (`Student_idStudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UGStudent_UGStudent1`
    FOREIGN KEY (`Mentor`)
    REFERENCES `mydb`.`UGStudent` (`Student_idStudent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
