CREATE DATABASE IF NOT EXISTS db_empresa_af;
USE db_empresa_af;

DROP TABLE IF EXISTS tbl_funcionarios;
DROP TABLE IF EXISTS tbl_enderecos;
DROP TABLE IF EXISTS tbl_emails;
DROP TABLE IF EXISTS tbl_cargos;

CREATE TABLE IF NOT EXISTS tbl_enderecos (
	Endereco_Id INT PRIMARY KEY AUTO_INCREMENT,
    Endereco_Estado VARCHAR(50),
    Endereco_Cidade VARCHAR(50),
    Endereco_Bairro VARCHAR(50),
    Endereco_Rua VARCHAR(50),
    Endereco_Numero VARCHAR(50),
    Endereco_Complemento VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS tbl_emails (
	Funcionario_Id INT
    REFERENCES tbl_funcionarios (Funcionario_Id),
    Funcionario_Email VARCHAR(50),
    PRIMARY KEY (Funcionario_Id, Funcionario_Email)
);
CREATE TABLE IF NOT EXISTS tbl_cargos (
	Cargo_Id INT PRIMARY KEY AUTO_INCREMENT,
	Cargo_Nome VARCHAR(50),
    Cargo_Jornada INT,
    Cargo_Salario INT
);
CREATE TABLE IF NOT EXISTS tbl_funcionarios (
	Funcionario_Id INT PRIMARY KEY AUTO_INCREMENT,
    Funcionario_Nome VARCHAR(50),
    Funcionario_Sobrenome VARCHAR(50),
    Funcionario_Endereco_Id INT,
    Funcionario_Cargo_Id INT,
    FOREIGN KEY fk_endereco_id (Funcionario_Endereco_Id)
		REFERENCES tbl_enderecos (Endereco_Id),
	FOREIGN KEY fk_cargo_id (Funcionario_Cargo_Id)
		REFERENCES tbl_cargos (Cargo_Id)
);
CREATE OR REPLACE VIEW vw_funcionarios_detalhes AS
	SELECT
		CONCAT(tbl_funcionarios.Funcionario_Nome, " ", 
			tbl_funcionarios.Funcionario_Sobrenome) AS "Nome",
		tbl_emails.Funcionario_Email AS "Email",
		tbl_enderecos.Endereco_Estado AS "Estado",
		tbl_enderecos.Endereco_Cidade AS "Cidade",
		tbl_enderecos.Endereco_Bairro AS "Bairro",
		tbl_enderecos.Endereco_Rua AS "Rua",
		tbl_enderecos.Endereco_Numero AS "Número",
		tbl_enderecos.Endereco_Complemento AS "Complemento",
		tbl_cargos.Cargo_Nome AS "Cargo",
		tbl_cargos.Cargo_Jornada AS "Jornada", 
		tbl_cargos.Cargo_Salario AS "Salário"
	FROM tbl_funcionarios
    JOIN tbl_enderecos
		ON tbl_funcionarios.Funcionario_Endereco_Id = tbl_enderecos.Endereco_Id
	JOIN tbl_cargos
		ON tbl_funcionarios.Funcionario_Cargo_Id = tbl_cargos.Cargo_Id
	JOIN tbl_emails
		ON tbl_funcionarios.Funcionario_Id = tbl_emails.Funcionario_Id
;

INSERT INTO tbl_enderecos VALUES
(NULL, "Paraíba", "João Pessoa", NULL, "Rua Suassuna", 30, NULL),
(NULL, NULL, "London", NULL, "Rua Lovelace", 67, NULL),
(NULL, "Acre", "Mesóclise", "Predicado", "Rua Substantivo", 78, NULL),
(NULL, "Paraíba", "João Pessoa", NULL, "Rua Eurico", 50, "Apt 28, Bloco C");
SELECT * FROM tbl_enderecos;

INSERT INTO tbl_cargos VALUES
(NULL, "Contador", 40, 3000),
(NULL, "Developer", 20, 15000),
(NULL, "Linguista", 44, 8000);
SELECT * FROM tbl_cargos;

INSERT INTO tbl_funcionarios VALUES 
(NULL, "João", "Grilo", 1, 1),
(NULL, "Ada", "Byron", 2, 2),
(NULL, "Gerundino", "", 3, 3),
(NULL, "Chicó", "", 4, 1);
SELECT * FROM tbl_funcionarios;

INSERT INTO tbl_emails VALUES 
(1, "grilo@mail.com"),
(1, "joaog@mk.com"),
(2, "ada@mail.com"),
(2, "abyron@tech.com"),
(3, "gerundino@gmail.com");
SELECT * FROM tbl_emails;

SELECT * FROM vw_funcionarios_detalhes;