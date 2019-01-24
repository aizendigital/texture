-- MySQL Script generated by MySQL Workbench
-- ‫پنجشنبه ۲۴ ژانویه ۱۹، ۱۳:۲۶:۲۰‬
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Aizen_Db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Aizen_Db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Aizen_Db` DEFAULT CHARACTER SET utf8 ;
USE `Aizen_Db` ;

-- -----------------------------------------------------
-- Table `Aizen_Db`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`location` (
  `id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `country` VARCHAR(100) NULL,
  `city` VARCHAR(100) NULL,
  `additionalInfo` VARCHAR(100) NULL,
  `isRemote` TINYINT(1) NULL,
  `address` VARCHAR(100) NULL,
  `state` VARCHAR(100) NULL,
  `zipcode` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`company` (
  `id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `slug` VARCHAR(45) NOT NULL,
  `overview` MEDIUMTEXT NULL,
  `website` VARCHAR(250) NULL,
  `size` INT NULL,
  `foundDate` DATETIME NULL,
  `industry` VARCHAR(100) NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `location_id` INT NOT NULL,
  PRIMARY KEY (`id`, `location_id`),
  INDEX `fk_Company_location1_idx` (`location_id` ASC),
  CONSTRAINT `fk_Company_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `Aizen_Db`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`user` (
  `id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `company_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `company_id`),
  INDEX `fk_User_Company1_idx` (`company_id` ASC),
  CONSTRAINT `fk_User_Company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `Aizen_Db`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`job`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`job` (
  `id` INT NOT NULL,
  `company_id` INT NOT NULL,
  `location_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `slug` VARCHAR(100) NOT NULL,
  `departmant` VARCHAR(100) NULL,
  `internal_code` VARCHAR(100) NULL,
  `is_in_house_employer` TINYINT(1) NULL,
  `is_agency` VARCHAR(100) NULL,
  `job_function` VARCHAR(100) NULL,
  `description` VARCHAR(100) NULL,
  `requirements` VARCHAR(100) NULL,
  PRIMARY KEY (`id`, `company_id`, `location_id`),
  INDEX `fk_job_Company_idx` (`company_id` ASC),
  INDEX `fk_job_location1_idx` (`location_id` ASC),
  CONSTRAINT `fk_job_Company`
    FOREIGN KEY (`company_id`)
    REFERENCES `Aizen_Db`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_job_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `Aizen_Db`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`applicant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`applicant` (
  `id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `location_id` INT NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NULL,
  `website` VARCHAR(45) NULL,
  `about` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `location_id`),
  INDEX `fk_applicant_location1_idx` (`location_id` ASC),
  CONSTRAINT `fk_applicant_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `Aizen_Db`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`resume`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`resume` (
  `id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `applicant_id` INT NOT NULL,
  `file` VARCHAR(100) NOT NULL,
  `format` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`, `applicant_id`),
  INDEX `fk_resume_applicant1_idx` (`applicant_id` ASC),
  CONSTRAINT `fk_resume_applicant1`
    FOREIGN KEY (`applicant_id`)
    REFERENCES `Aizen_Db`.`applicant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`application` (
  `id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `resume_id` INT NOT NULL,
  `applicant_id` INT NOT NULL,
  `company_id` INT NOT NULL,
  PRIMARY KEY (`id`, `resume_id`, `applicant_id`, `company_id`),
  INDEX `fk_application_resume1_idx` (`resume_id` ASC),
  INDEX `fk_application_applicant1_idx` (`applicant_id` ASC),
  INDEX `fk_application_Company1_idx` (`company_id` ASC),
  CONSTRAINT `fk_application_resume1`
    FOREIGN KEY (`resume_id`)
    REFERENCES `Aizen_Db`.`resume` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_application_applicant1`
    FOREIGN KEY (`applicant_id`)
    REFERENCES `Aizen_Db`.`applicant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_application_Company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `Aizen_Db`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`attachment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`attachment` (
  `id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `application_id` INT NOT NULL,
  `file` VARCHAR(100) NOT NULL,
  `format` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `application_id`),
  INDEX `fk_attachment_application1_idx` (`application_id` ASC),
  CONSTRAINT `fk_attachment_application1`
    FOREIGN KEY (`application_id`)
    REFERENCES `Aizen_Db`.`application` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`employeeDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`employeeDetail` (
  `id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `type` VARCHAR(100) NULL,
  `keyword` VARCHAR(100) NULL,
  `job_id` INT NOT NULL,
  PRIMARY KEY (`id`, `job_id`),
  INDEX `fk_employeeDetail_job1_idx` (`job_id` ASC),
  CONSTRAINT `fk_employeeDetail_job1`
    FOREIGN KEY (`job_id`)
    REFERENCES `Aizen_Db`.`job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`experience`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`experience` (
  `id`  NULL,
  `title` VARCHAR(100) NULL,
  `description` VARCHAR(500) NULL,
  `startDate` DATETIME NULL,
  `endDate` DATETIME NULL,
  `companyTitle` VARCHAR(100) NULL,
  `employeeDetail_id` INT NOT NULL,
  PRIMARY KEY (`employeeDetail_id`),
  INDEX `fk_experience_employeeDetail1_idx` (`employeeDetail_id` ASC),
  CONSTRAINT `fk_experience_employeeDetail1`
    FOREIGN KEY (`employeeDetail_id`)
    REFERENCES `Aizen_Db`.`employeeDetail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`education`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`education` (
  `id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `startDate` DATETIME NULL,
  `endDate` DATETIME NULL,
  `description` VARCHAR(100) NULL,
  `fieldOfStudy` VARCHAR(100) NULL,
  `degree` VARCHAR(100) NULL,
  `school` VARCHAR(100) NULL,
  `employeeDetail_id` INT NOT NULL,
  PRIMARY KEY (`id`, `employeeDetail_id`),
  INDEX `fk_education_employeeDetail1_idx` (`employeeDetail_id` ASC),
  CONSTRAINT `fk_education_employeeDetail1`
    FOREIGN KEY (`employeeDetail_id`)
    REFERENCES `Aizen_Db`.`employeeDetail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`skill` (
  `id`  NOT NULL,
  `skill` VARCHAR(100) NULL,
  `applicant_id` INT NOT NULL,
  PRIMARY KEY (`applicant_id`, `id`),
  CONSTRAINT `fk_skill_applicant1`
    FOREIGN KEY (`applicant_id`)
    REFERENCES `Aizen_Db`.`applicant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`compensation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`compensation` (
  `id`  NOT NULL,
  `from` VARCHAR(100) NULL,
  `to` VARCHAR(100) NULL,
  `currency` VARCHAR(100) NULL,
  `job_id` INT NOT NULL,
  PRIMARY KEY (`id`, `job_id`),
  INDEX `fk_Aizen_job1_idx` (`job_id` ASC),
  CONSTRAINT `fk_Aizen_job1`
    FOREIGN KEY (`job_id`)
    REFERENCES `Aizen_Db`.`job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aizen_Db`.`benefit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aizen_Db`.`benefit` (
  `id`  NOT NULL,
  `benefit` VARCHAR(100) NULL,
  `compensation_id`  NOT NULL,
  `compensation_job_id` INT NOT NULL,
  PRIMARY KEY (`id`, `compensation_id`, `compensation_job_id`),
  INDEX `fk_benefit_compensation1_idx` (`compensation_id` ASC, `compensation_job_id` ASC),
  CONSTRAINT `fk_benefit_compensation1`
    FOREIGN KEY (`compensation_id` , `compensation_job_id`)
    REFERENCES `Aizen_Db`.`compensation` (`id` , `job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
