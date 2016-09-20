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
-- Table `al_system`.`Uf`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`Uf` ;

CREATE TABLE IF NOT EXISTS `al_system`.`Uf` (
  `ibge` TINYINT(2) UNSIGNED NOT NULL,
  `nome` VARCHAR(19) CHARACTER SET 'utf8' NOT NULL,
  `sigla` ENUM('AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'EX', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO') CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`ibge`),
  UNIQUE INDEX `nomeUNIQUE` (`nome` ASC),
  UNIQUE INDEX `siglaUNIQUE` (`sigla` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`Pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`Pessoa` ;

CREATE TABLE IF NOT EXISTS `al_system`.`Pessoa` (
  `aberturaNascimento` TIMESTAMP NULL,
  `cnpjCpf` VARCHAR(14) CHARACTER SET 'utf8' NOT NULL,
  `fantasiaSobrenome` VARCHAR(64) CHARACTER SET 'utf8' NULL,
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ieRg` VARCHAR(16) CHARACTER SET 'utf8' NOT NULL,
  `nomeRazao` VARCHAR(128) CHARACTER SET 'utf8' NOT NULL,
  `perfilCliente` BIT(1) NOT NULL DEFAULT b'0',
  `perfilFornecedor` BIT(1) NOT NULL DEFAULT b'0',
  `perfilTransportador` BIT(1) NOT NULL DEFAULT b'0',
  `situacao` TINYINT UNSIGNED NOT NULL,
  `tipo` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cnpjCpfUNIQUE` (`cnpjCpf` ASC),
  UNIQUE INDEX `ieRgUNIQUE` (`ieRg` ASC),
  INDEX `cnpjCpfINDEX` (`cnpjCpf` ASC),
  INDEX `nomeRazaoINDEX` (`nomeRazao` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`Endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`Endereco` ;

CREATE TABLE IF NOT EXISTS `al_system`.`Endereco` (
  `bairro` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  `cep` CHAR(8) CHARACTER SET 'utf8' NOT NULL,
  `cidade` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  `complemento` VARCHAR(64) CHARACTER SET 'utf8' NULL,
  `complemento2` VARCHAR(64) CHARACTER SET 'utf8' NULL,
  `ibge` MEDIUMINT(8) UNSIGNED NULL,
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  `nomeContato` VARCHAR(16) CHARACTER SET 'utf8' NULL,
  `numero` VARCHAR(8) CHARACTER SET 'utf8' NOT NULL DEFAULT 's.n.º',
  `pessoa` SMALLINT UNSIGNED NOT NULL,
  `tipo` TINYINT UNSIGNED NOT NULL,
  `uf` TINYINT(2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `cidadeINDEX` (`cidade` ASC),
  INDEX `logradouroINDEX` (`logradouro` ASC),
  INDEX `enderecoPessoaFKINDEX` (`pessoa` ASC),
  INDEX `enderecoUfFKINDEX` (`uf` ASC),
  CONSTRAINT `enderecoPessoaFK`
    FOREIGN KEY (`pessoa`)
    REFERENCES `al_system`.`Pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `enderecoUfFK`
    FOREIGN KEY (`uf`)
    REFERENCES `al_system`.`Uf` (`ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`Telefone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`Telefone` ;

CREATE TABLE IF NOT EXISTS `al_system`.`Telefone` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nomeContato` VARCHAR(16) CHARACTER SET 'utf8' NULL,
  `numero` VARCHAR(16) CHARACTER SET 'utf8' NOT NULL,
  `pessoa` SMALLINT UNSIGNED NOT NULL,
  `tipo` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pessoaNumeroUNIQUE` (`pessoa` ASC, `numero` ASC),
  INDEX `telefonePessoaFKINDEX` (`pessoa` ASC),
  CONSTRAINT `telefonePessoaFK`
    FOREIGN KEY (`pessoa`)
    REFERENCES `al_system`.`Pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`Email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`Email` ;

CREATE TABLE IF NOT EXISTS `al_system`.`Email` (
  `enderecoEletronico` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  `id` INT UNSIGNED NOT NULL,
  `nomeContato` VARCHAR(16) CHARACTER SET 'utf8' NULL,
  `pessoa` SMALLINT UNSIGNED NOT NULL,
  `tipo` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pessoaEnderecoEletronicoUNIQUE` (`pessoa` ASC, `enderecoEletronico` ASC),
  INDEX `emailPessoaFKINDEX` (`pessoa` ASC),
  CONSTRAINT `emailPessoaFK`
    FOREIGN KEY (`pessoa`)
    REFERENCES `al_system`.`Pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`Credencial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`Credencial` ;

CREATE TABLE IF NOT EXISTS `al_system`.`Credencial` (
  `funcionario` SMALLINT UNSIGNED NOT NULL,
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `perfilAdministrador` BIT(1) NOT NULL DEFAULT b'0',
  `perfilPadrao` BIT(1) NOT NULL DEFAULT b'1',
  `senha` CHAR(128) CHARACTER SET 'utf8' NOT NULL DEFAULT '93f4a4e86cf842f2a03cd2eedbcd3c72325d6833fa991b895be40204be651427652c78b9cdbdef7c01f80a0acb58f791c36d49fbaa5738970e83772cea18eba1',
  `situacao` TINYINT UNSIGNED NOT NULL,
  `usuario` VARCHAR(16) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `funcionarioUNIQUE` (`funcionario` ASC),
  UNIQUE INDEX `usuarioUNIQUE` (`usuario` ASC),
  INDEX `usuarioINDEX` (`usuario` ASC),
  INDEX `credencialPessoaFKINDEX` (`funcionario` ASC),
  CONSTRAINT `credencialPessoaFK`
    FOREIGN KEY (`funcionario`)
    REFERENCES `al_system`.`Pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`Servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`Servico` ;

CREATE TABLE IF NOT EXISTS `al_system`.`Servico` (
  `descricao` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricaoUNIQUE` (`descricao` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`FormaPagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`FormaPagamento` ;

CREATE TABLE IF NOT EXISTS `al_system`.`FormaPagamento` (
  `descricao` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL,
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricaoUNIQUE` (`descricao` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`CondicaoPagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`CondicaoPagamento` ;

CREATE TABLE IF NOT EXISTS `al_system`.`CondicaoPagamento` (
  `descricao` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL,
  `formaPagamento` TINYINT UNSIGNED NOT NULL,
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `formaPagamentoDescricaoUNIQUE` (`formaPagamento` ASC, `descricao` ASC),
  INDEX `condicaoPagamentoFormaPagamentoFKINDEX` (`formaPagamento` ASC),
  CONSTRAINT `condicaoPagamentoFormaPagamentoFK`
    FOREIGN KEY (`formaPagamento`)
    REFERENCES `al_system`.`FormaPagamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`Ordem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`Ordem` ;

CREATE TABLE IF NOT EXISTS `al_system`.`Ordem` (
  `cliente` SMALLINT UNSIGNED NOT NULL,
  `condicaoPagamento` SMALLINT UNSIGNED NOT NULL,
  `dataAbertura` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `observacao` VARCHAR(256) CHARACTER SET 'utf8' NULL,
  `situacao` TINYINT UNSIGNED NOT NULL,
  `tipo` TINYINT UNSIGNED NOT NULL,
  `usuarioAbertura` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ordemClienteFKINDEX` (`cliente` ASC),
  INDEX `ordemCondicaoPagamentoFKINDEX` (`condicaoPagamento` ASC),
  INDEX `ordemUsuarioAberturaFKINDEX` (`usuarioAbertura` ASC),
  CONSTRAINT `ordemClienteFK`
    FOREIGN KEY (`cliente`)
    REFERENCES `al_system`.`Pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ordemCondicaoPagamentoFK`
    FOREIGN KEY (`condicaoPagamento`)
    REFERENCES `al_system`.`CondicaoPagamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ordemUsuarioAberturaFK`
    FOREIGN KEY (`usuarioAbertura`)
    REFERENCES `al_system`.`Credencial` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`ItemOrdemServico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`ItemOrdemServico` ;

CREATE TABLE IF NOT EXISTS `al_system`.`ItemOrdemServico` (
  `dataAlteracao` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `dataFinalizacaoPrevista` TIMESTAMP NULL,
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ordem` BIGINT UNSIGNED NOT NULL,
  `servico` INT UNSIGNED NOT NULL,
  `situacao` TINYINT UNSIGNED NOT NULL,
  `usuarioAlteracao` SMALLINT UNSIGNED NULL,
  `valorOrcamento` DECIMAL(9,2) UNSIGNED NOT NULL DEFAULT 0,
  `valorServico` DECIMAL(9,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `itemOrdemServicoOrdemINDEX` (`ordem` ASC),
  INDEX `ItemOrdemServicoOrdemFKINDEX` (`ordem` ASC),
  INDEX `ItemOrdemServicoServicoFKINDEX` (`servico` ASC),
  INDEX `ItemOrdemServicoUsuarioAlteracaoFKINDEX` (`usuarioAlteracao` ASC),
  CONSTRAINT `ItemOrdemServicoOrdemFK`
    FOREIGN KEY (`ordem`)
    REFERENCES `al_system`.`Ordem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ItemOrdemServicoServicoFK`
    FOREIGN KEY (`servico`)
    REFERENCES `al_system`.`Servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ItemOrdemServicoUsuarioAlteracaoFK`
    FOREIGN KEY (`usuarioAlteracao`)
    REFERENCES `al_system`.`Credencial` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`ContaReceber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`ContaReceber` ;

CREATE TABLE IF NOT EXISTS `al_system`.`ContaReceber` (
  `dataAbertura` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dataAlteracao` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `dataVencimento` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `montantePago` DECIMAL(9,2) UNSIGNED NOT NULL DEFAULT 0,
  `numeroParcela` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `observacao` VARCHAR(128) CHARACTER SET 'utf8' NULL,
  `ordem` BIGINT UNSIGNED NOT NULL,
  `saldoDevedor` DECIMAL(9,2) UNSIGNED NOT NULL,
  `situacao` TINYINT UNSIGNED NOT NULL,
  `usuarioAbertura` SMALLINT UNSIGNED NOT NULL,
  `usuarioAlteracao` SMALLINT UNSIGNED NULL,
  `valor` DECIMAL(9,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ordemNumeroParcelaUNIQUE` (`ordem` ASC, `numeroParcela` ASC),
  INDEX `contaReceberOrdemFKINDEX` (`ordem` ASC),
  INDEX `contaReceberUsuarioAberturaFKINDEX` (`usuarioAbertura` ASC),
  INDEX `contaReceberUsuarioAlteracaoFKINDEX` (`usuarioAlteracao` ASC),
  CONSTRAINT `contaReceberOrdemFK`
    FOREIGN KEY (`ordem`)
    REFERENCES `al_system`.`Ordem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contaReceberUsuarioAberturaFK`
    FOREIGN KEY (`usuarioAbertura`)
    REFERENCES `al_system`.`Credencial` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contaReceberUsuarioAlteracaoFK`
    FOREIGN KEY (`usuarioAlteracao`)
    REFERENCES `al_system`.`Credencial` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `al_system`.`ContaPagar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `al_system`.`ContaPagar` ;

CREATE TABLE IF NOT EXISTS `al_system`.`ContaPagar` (
  `dataAbertura` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dataAlteracao` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `dataEmissao` TIMESTAMP NULL,
  `dataVencimento` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fatura` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL,
  `fornecedor` SMALLINT UNSIGNED NOT NULL,
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `mesReferente` TINYINT UNSIGNED NOT NULL,
  `montantePago` DECIMAL(9,2) UNSIGNED NOT NULL DEFAULT 0,
  `numeroParcela` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `observacao` VARCHAR(128) CHARACTER SET 'utf8' NULL,
  `saldoDevedor` DECIMAL(9,2) UNSIGNED NOT NULL,
  `situacao` TINYINT UNSIGNED NOT NULL,
  `usuarioAbertura` SMALLINT UNSIGNED NOT NULL,
  `usuarioAlteracao` SMALLINT UNSIGNED NULL,
  `valor` DECIMAL(9,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `faturaFornecedorNumeroParcelaUNIQUE` (`fatura` ASC, `fornecedor` ASC, `numeroParcela` ASC),
  INDEX `contaPagarFornecedorFKINDEX` (`fornecedor` ASC),
  INDEX `contaPagarUsuarioAberturaFKINDEX` (`usuarioAbertura` ASC),
  INDEX `contaPagarUsuarioAlteracaoFKINDEX` (`usuarioAlteracao` ASC),
  CONSTRAINT `contaPagarFornecedorFK`
    FOREIGN KEY (`fornecedor`)
    REFERENCES `al_system`.`Pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contaPagarUsuarioAberturaFK`
    FOREIGN KEY (`usuarioAbertura`)
    REFERENCES `al_system`.`Credencial` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contaPagarUsuarioAlteracaoFK`
    FOREIGN KEY (`usuarioAlteracao`)
    REFERENCES `al_system`.`Credencial` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO alsystem;
 DROP USER alsystem;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'alsystem' IDENTIFIED BY 'alsystem';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `al_system`.* TO 'alsystem';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `al_system`.`Uf`
-- -----------------------------------------------------
START TRANSACTION;
USE `al_system`;
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (00, 'EXTERIOR', 'EX');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (11, 'RONDÔNIA', 'RO');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (12, 'ACRE', 'AC');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (13, 'AMAZONAS', 'AM');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (14, 'RORAIMA', 'RR');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (15, 'PARÁ', 'PA');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (16, 'AMAPÁ', 'AP');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (17, 'TOCANTINS', 'TO');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (21, 'MARANHÃO', 'MA');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (22, 'PIAUÍ', 'PI');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (23, 'CEARÁ', 'CE');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (24, 'RIO GRANDE DO NORTE', 'RN');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (25, 'PARAÍBA', 'PB');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (26, 'PERNAMBUCO', 'PE');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (27, 'ALAGOAS', 'AL');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (28, 'SERGIPE', 'SE');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (29, 'BAHIA', 'BA');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (31, 'MINAS GERAIS', 'MG');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (32, 'ESPÍRITO SANTO', 'ES');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (33, 'RIO DE JANEIRO', 'RJ');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (35, 'SÃO PAULO', 'SP');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (41, 'PARANÁ', 'PR');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (42, 'SANTA CATARINA', 'SC');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (43, 'RIO GRANDE DO SUL', 'RS');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (50, 'MATO GROSSO DO SUL', 'MS');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (51, 'MATO GROSSO', 'MT');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (52, 'GOIÁS', 'GO');
INSERT INTO `al_system`.`Uf` (`ibge`, `nome`, `sigla`) VALUES (53, 'DISTRITO FEDERAL', 'DF');

COMMIT;


-- -----------------------------------------------------
-- Data for table `al_system`.`FormaPagamento`
-- -----------------------------------------------------
START TRANSACTION;
USE `al_system`;
INSERT INTO `al_system`.`FormaPagamento` (`descricao`, `id`) VALUES ('CARTÃO DE CRÉDITO', DEFAULT);
INSERT INTO `al_system`.`FormaPagamento` (`descricao`, `id`) VALUES ('CARTÃO DE DÉBITO', DEFAULT);
INSERT INTO `al_system`.`FormaPagamento` (`descricao`, `id`) VALUES ('CHEQUE', DEFAULT);
INSERT INTO `al_system`.`FormaPagamento` (`descricao`, `id`) VALUES ('DINHEIRO', DEFAULT);
INSERT INTO `al_system`.`FormaPagamento` (`descricao`, `id`) VALUES ('PERMUTA', DEFAULT);
INSERT INTO `al_system`.`FormaPagamento` (`descricao`, `id`) VALUES ('PROMISSÓRIA', DEFAULT);

COMMIT;

