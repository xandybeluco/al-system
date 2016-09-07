-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema al_system
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `al_system` ;

-- -----------------------------------------------------
-- Schema al_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `al_system` DEFAULT CHARACTER SET utf8 ;
USE `al_system` ;

-- -----------------------------------------------------
-- Table `al_system`.`uf`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`uf` ;

CREATE TABLE IF NOT EXISTS `al_system`.`uf` (
  `ibge` INT(2) UNSIGNED NOT NULL,
  `nome` VARCHAR(19) CHARACTER SET 'utf8' NOT NULL,
  `sigla` ENUM('AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'EX', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO') CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`ibge`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC),
  UNIQUE INDEX `sigla_UNIQUE` (`sigla` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`pessoa` ;

CREATE TABLE IF NOT EXISTS `al_system`.`pessoa` (
  `cnpj_cpf` VARCHAR(14) CHARACTER SET 'utf8' NOT NULL,
  `ie_rg` VARCHAR(16) CHARACTER SET 'utf8' NOT NULL,
  `nome_razao` VARCHAR(128) CHARACTER SET 'utf8' NOT NULL,
  `fantasia_sobrenome` VARCHAR(64) CHARACTER SET 'utf8' NULL,
  `abertura_nascimento` TIMESTAMP NULL,
  `tipo` ENUM('FISICA', 'JURIDICA') CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`cnpj_cpf`),
  UNIQUE INDEX `ie_rg_UNIQUE` (`ie_rg` ASC),
  INDEX `nome_razao_INDEX` (`nome_razao` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`endereco` ;

CREATE TABLE IF NOT EXISTS `al_system`.`endereco` (
  `bairro` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  `cep` INT(8) NOT NULL,
  `cidade` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  `complemento` VARCHAR(64) CHARACTER SET 'utf8' NULL,
  `complemento_2` VARCHAR(64) CHARACTER SET 'utf8' NULL,
  `contato` VARCHAR(16) CHARACTER SET 'utf8' NULL,
  `ibge` INT(8) UNSIGNED NOT NULL,
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  `numero` VARCHAR(8) CHARACTER SET 'utf8' NOT NULL DEFAULT 's.n.º',
  `pessoa` VARCHAR(14) CHARACTER SET 'utf8' NOT NULL,
  `tipo` ENUM('EMPRESARIAL', 'PADRAO', 'PESSOAL') CHARACTER SET 'utf8' NOT NULL DEFAULT 'PADRAO',
  `uf` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `endereco_cidade_INDEX` (`cidade` ASC),
  INDEX `fk_endereco_pessoa_INDEX` (`pessoa` ASC),
  INDEX `fk_endereco_uf_INDEX` (`uf` ASC),
  CONSTRAINT `fk_endereco_pessoa`
    FOREIGN KEY (`pessoa`)
    REFERENCES `al_system`.`pessoa` (`cnpj_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_uf`
    FOREIGN KEY (`uf`)
    REFERENCES `al_system`.`uf` (`ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`telefone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`telefone` ;

CREATE TABLE IF NOT EXISTS `al_system`.`telefone` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `contato` VARCHAR(16) CHARACTER SET 'utf8' NULL,
  `numero` VARCHAR(16) CHARACTER SET 'utf8' NOT NULL,
  `pessoa` VARCHAR(14) CHARACTER SET 'utf8' NOT NULL,
  `tipo` ENUM('EMPRESARIAL', 'PADRAO', 'PESSOAL') CHARACTER SET 'utf8' NOT NULL DEFAULT 'PADRAO',
  PRIMARY KEY (`id`),
  INDEX `fk_telefone_pessoa_INDEX` (`pessoa` ASC),
  CONSTRAINT `fk_telefone_pessoa`
    FOREIGN KEY (`pessoa`)
    REFERENCES `al_system`.`pessoa` (`cnpj_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`email` ;

CREATE TABLE IF NOT EXISTS `al_system`.`email` (
  `contato` VARCHAR(16) CHARACTER SET 'utf8' NULL,
  `endereco_eletronico` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pessoa` VARCHAR(14) CHARACTER SET 'utf8' NOT NULL,
  `tipo` ENUM('EMPRESARIAL', 'NF_E', 'PADRAO', 'PESSOAL') CHARACTER SET 'utf8' NOT NULL DEFAULT 'PADRAO',
  PRIMARY KEY (`id`),
  INDEX `fk_email_pessoa_INDEX` (`pessoa` ASC),
  CONSTRAINT `fk_email_pessoa`
    FOREIGN KEY (`pessoa`)
    REFERENCES `al_system`.`pessoa` (`cnpj_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`credencial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`credencial` ;

CREATE TABLE IF NOT EXISTS `al_system`.`credencial` (
  `pessoa` VARCHAR(14) CHARACTER SET 'utf8' NULL,
  `senha` VARCHAR(128) CHARACTER SET 'utf8' NOT NULL DEFAULT '93f4a4e86cf842f2a03cd2eedbcd3c72325d6833fa991b895be40204be651427652c78b9cdbdef7c01f80a0acb58f791c36d49fbaa5738970e83772cea18eba1',
  `situacao` ENUM('ATIVO', 'INATIVO') CHARACTER SET 'utf8' NOT NULL,
  `usuario` VARCHAR(16) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`usuario`),
  INDEX `fk_credencial_pessoa_INDEX` (`pessoa` ASC),
  CONSTRAINT `fk_credencial_pessoa`
    FOREIGN KEY (`pessoa`)
    REFERENCES `al_system`.`pessoa` (`cnpj_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`grupo_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`grupo_servico` ;

CREATE TABLE IF NOT EXISTS `al_system`.`grupo_servico` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`forma_pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`forma_pagamento` ;

CREATE TABLE IF NOT EXISTS `al_system`.`forma_pagamento` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `descricao` ENUM('CARTAO_CREDITO', 'CARTAO_DEBITO', 'CHEQUE', 'DINHEIRO', 'PERMUTA', 'PROMISSORIA') CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`condicao_pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`condicao_pagamento` ;

CREATE TABLE IF NOT EXISTS `al_system`.`condicao_pagamento` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL,
  `forma_pagamento` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `forma_pagamento_descricao_UNIQUE` (`forma_pagamento` ASC, `descricao` ASC),
  INDEX `fk_condicao_pagamento_forma_pagamento_INDEX` (`forma_pagamento` ASC),
  CONSTRAINT `fk_condicao_pagamento_forma_pagamento`
    FOREIGN KEY (`forma_pagamento`)
    REFERENCES `al_system`.`forma_pagamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`ordem_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`ordem_servico` ;

CREATE TABLE IF NOT EXISTS `al_system`.`ordem_servico` (
  `condicao_pagamento` INT UNSIGNED NOT NULL,
  `data_abertura` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `observacao` VARCHAR(256) CHARACTER SET 'utf8' NULL,
  `pessoa` VARCHAR(14) CHARACTER SET 'utf8' NOT NULL,
  `tipo` ENUM('ORCAMENTO', 'SERVICO') CHARACTER SET 'utf8' NOT NULL,
  `usuario_abertura` VARCHAR(16) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ordem_servico_pessoa_INDEX` (`pessoa` ASC),
  INDEX `fk_ordem_servico_condicao_pagamento_INDEX` (`condicao_pagamento` ASC),
  INDEX `fk_ordem_servico_usuario_INDEX` (`usuario_abertura` ASC),
  CONSTRAINT `fk_ordem_servico_pessoa`
    FOREIGN KEY (`pessoa`)
    REFERENCES `al_system`.`pessoa` (`cnpj_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordem_servico_condicao_pagamento`
    FOREIGN KEY (`condicao_pagamento`)
    REFERENCES `al_system`.`condicao_pagamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordem_servico_usuario`
    FOREIGN KEY (`usuario_abertura`)
    REFERENCES `al_system`.`credencial` (`usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`grupo_ordem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`grupo_ordem` ;

CREATE TABLE IF NOT EXISTS `al_system`.`grupo_ordem` (
  `data_alteracao` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `data_finalizacao_prevista` TIMESTAMP NULL,
  `grupo_servico` INT UNSIGNED NOT NULL,
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ordem_servico` BIGINT UNSIGNED NOT NULL,
  `situacao` ENUM('ABERTO', 'CANCELADO', 'FINALIZADO') CHARACTER SET 'utf8' NOT NULL,
  `usuario_alteracao` VARCHAR(16) CHARACTER SET 'utf8' NOT NULL,
  `valor_servico` DECIMAL(8,2) UNSIGNED NOT NULL DEFAULT 0,
  `valor_orcamento` DECIMAL(8,2) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `grupo_servico_ordem_servico_INDEX` (`grupo_servico` ASC, `ordem_servico` ASC),
  INDEX `fk_grupo_ordem_grupo_servico_INDEX` (`grupo_servico` ASC),
  INDEX `fk_grupo_ordem_ordem_servico_INDEX` (`ordem_servico` ASC),
  INDEX `fk_grupo_ordem_usuario_INDEX` (`usuario_alteracao` ASC),
  CONSTRAINT `fk_grupo_ordem_grupo_servico`
    FOREIGN KEY (`grupo_servico`)
    REFERENCES `al_system`.`grupo_servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupo_ordem_ordem_servico`
    FOREIGN KEY (`ordem_servico`)
    REFERENCES `al_system`.`ordem_servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupo_ordem_usuario`
    FOREIGN KEY (`usuario_alteracao`)
    REFERENCES `al_system`.`credencial` (`usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`conta_receber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`conta_receber` ;

CREATE TABLE IF NOT EXISTS `al_system`.`conta_receber` (
  `data_alteracao` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `data_vencimento` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `montante_pago` DECIMAL(8,2) UNSIGNED NOT NULL DEFAULT 0,
  `numero_parcela` INT UNSIGNED NOT NULL DEFAULT 0,
  `observacao` VARCHAR(128) CHARACTER SET 'utf8' NULL,
  `ordem_servico` BIGINT UNSIGNED NOT NULL,
  `pessoa` VARCHAR(14) CHARACTER SET 'utf8' NOT NULL,
  `saldo_devedor` DECIMAL(8,2) UNSIGNED NOT NULL,
  `situacao` ENUM('ABERTO', 'AMORTIZADO', 'BAIXADO') CHARACTER SET 'utf8' NOT NULL,
  `usuario_alteracao` VARCHAR(16) CHARACTER SET 'utf8' NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conta_receber_ordem_servico_INDEX` (`ordem_servico` ASC),
  INDEX `fk_conta_receber_pessoa_INDEX` (`pessoa` ASC),
  INDEX `fk_conta_receber_usuario_INDEX` (`usuario_alteracao` ASC),
  UNIQUE INDEX `ordem_servico_numero_parcela_UNIQUE` (`ordem_servico` ASC, `numero_parcela` ASC),
  CONSTRAINT `fk_conta_receber_ordem_servico`
    FOREIGN KEY (`ordem_servico`)
    REFERENCES `al_system`.`ordem_servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conta_receber_pessoa`
    FOREIGN KEY (`pessoa`)
    REFERENCES `al_system`.`pessoa` (`cnpj_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conta_receber_usuario`
    FOREIGN KEY (`usuario_alteracao`)
    REFERENCES `al_system`.`credencial` (`usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`conta_pagar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`conta_pagar` ;

CREATE TABLE IF NOT EXISTS `al_system`.`conta_pagar` (
  `data_abertura` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_alteracao` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `data_emissao` TIMESTAMP NULL,
  `data_vencimento` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fatura` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL,
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `mes_referente` VARCHAR(7) CHARACTER SET 'utf8' NOT NULL,
  `montante_pago` DECIMAL(8,2) UNSIGNED NOT NULL DEFAULT 0,
  `numero_parcela` INT UNSIGNED NOT NULL DEFAULT 0,
  `observacao` VARCHAR(128) CHARACTER SET 'utf8' NULL,
  `periodo_referente_inicio` TIMESTAMP NULL,
  `periodo_referente_fim` TIMESTAMP NULL,
  `pessoa` VARCHAR(14) CHARACTER SET 'utf8' NOT NULL,
  `saldo_devedor` DECIMAL(8,2) UNSIGNED NOT NULL,
  `situacao` ENUM('ABERTO', 'AMORTIZADO', 'BAIXADO') CHARACTER SET 'utf8' NOT NULL,
  `usuario_abertura` VARCHAR(16) CHARACTER SET 'utf8' NOT NULL,
  `usuario_alteracao` VARCHAR(16) CHARACTER SET 'utf8' NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conta_pagar_pessoa_INDEX` (`pessoa` ASC),
  INDEX `fk_conta_pagar_usuario_abertura_INDEX` (`usuario_abertura` ASC),
  INDEX `fk_conta_pagar_usuario_alteracao_INDEX` (`usuario_alteracao` ASC),
  UNIQUE INDEX `fatura_numero_parcela_pessoa_UNIQUE` (`fatura` ASC, `numero_parcela` ASC, `pessoa` ASC),
  CONSTRAINT `fk_conta_pagar_pessoa`
    FOREIGN KEY (`pessoa`)
    REFERENCES `al_system`.`pessoa` (`cnpj_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conta_pagar_usuario_abertura`
    FOREIGN KEY (`usuario_abertura`)
    REFERENCES `al_system`.`credencial` (`usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conta_pagar_usuario_alteracao`
    FOREIGN KEY (`usuario_alteracao`)
    REFERENCES `al_system`.`credencial` (`usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO al_system;
 DROP USER al_system;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'al_system' IDENTIFIED BY 'al_system';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `al_system`.* TO 'al_system';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `al_system`.`uf`
-- -----------------------------------------------------
START TRANSACTION;
USE `al_system`;
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (00, 'Exterior', 'EX');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (11, 'Rondônia', 'RO');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (12, 'Acre', 'AC');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (13, 'Amazonas', 'AM');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (14, 'Roraima', 'RR');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (15, 'Pará', 'PA');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (16, 'Amapá', 'AP');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (17, 'Tocantins', 'TO');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (21, 'Maranhão', 'MA');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (22, 'Piauí', 'PI');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (23, 'Ceará', 'CE');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (24, 'Rio Grande do Norte', 'RN');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (25, 'Paraíba', 'PB');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (26, 'Pernambuco', 'PE');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (27, 'Alagoas', 'AL');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (28, 'Sergipe', 'SE');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (29, 'Bahia', 'BA');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (31, 'Minas Gerais', 'MG');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (32, 'Espírito Santo', 'ES');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (33, 'Rio de Janeiro', 'RJ');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (35, 'São Paulo', 'SP');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (41, 'Paraná', 'PR');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (42, 'Santa Catarina', 'SC');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (43, 'Rio Grande do Sul', 'RS');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (50, 'Mato Grosso do Sul', 'MS');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (51, 'Mato Grosso', 'MT');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (52, 'Goiás', 'GO');
INSERT INTO `al_system`.`uf` (`ibge`, `nome`, `sigla`) VALUES (53, 'Distrito Federal', 'DF');

COMMIT;


-- -----------------------------------------------------
-- Data for table `al_system`.`forma_pagamento`
-- -----------------------------------------------------
START TRANSACTION;
USE `al_system`;
INSERT INTO `al_system`.`forma_pagamento` (`id`, `descricao`) VALUES (DEFAULT, 'CARTAO_CREDITO');
INSERT INTO `al_system`.`forma_pagamento` (`id`, `descricao`) VALUES (DEFAULT, 'CARTAO_DEBITO');
INSERT INTO `al_system`.`forma_pagamento` (`id`, `descricao`) VALUES (DEFAULT, 'CHEQUE');
INSERT INTO `al_system`.`forma_pagamento` (`id`, `descricao`) VALUES (DEFAULT, 'DINHEIRO');
INSERT INTO `al_system`.`forma_pagamento` (`id`, `descricao`) VALUES (DEFAULT, 'PERMUTA');
INSERT INTO `al_system`.`forma_pagamento` (`id`, `descricao`) VALUES (DEFAULT, 'PROMISSORIA');

COMMIT;

