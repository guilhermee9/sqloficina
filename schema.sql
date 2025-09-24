-- CREATE DATABASE IF NOT EXISTS oficina_db CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- USE oficina_db;

CREATE TABLE clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome       VARCHAR(80) NOT NULL,
  cpf        CHAR(11)    NOT NULL,
  telefone   VARCHAR(15),
  email      VARCHAR(120),
  CONSTRAINT uk_clientes_cpf UNIQUE (cpf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE veiculos (
  id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  placa      CHAR(7) NOT NULL,
  marca      VARCHAR(30) NOT NULL,
  modelo     VARCHAR(60) NOT NULL,
  ano        SMALLINT NOT NULL,
  cor        VARCHAR(20),
  CONSTRAINT uk_veiculos_placa UNIQUE (placa),
  CONSTRAINT fk_veiculos_cliente
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE servicos (
  id_servico        INT AUTO_INCREMENT PRIMARY KEY,
  nome              VARCHAR(80) NOT NULL,
  categoria         ENUM('Mecânica','Elétrica','Funilaria','Diagnóstico','Revisão') NOT NULL,
  preco_base        DECIMAL(10,2) NOT NULL,
  minutos_estimados INT NOT NULL DEFAULT 60
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE ordens_servico (
  id_os            INT AUTO_INCREMENT PRIMARY KEY,
  id_veiculo       INT NOT NULL,
  data_abertura    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  data_fechamento  DATETIME NULL,
  status           ENUM('Aberta','Em andamento','Concluída','Cancelada') DEFAULT 'Aberta',
  forma_pagamento  ENUM('Dinheiro','Cartão','Pix','Boleto') NULL,
  desconto_os      DECIMAL(5,2) NOT NULL DEFAULT 0.00, -- percentual (0-100)
  observacoes      VARCHAR(255),
  CONSTRAINT fk_os_veiculo
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE itens_ordem (
  id_os           INT NOT NULL,
  id_servico      INT NOT NULL,
  quantidade      INT NOT NULL DEFAULT 1,
  preco_unitario  DECIMAL(10,2) NOT NULL,        -- snapshot do preço no momento
  desconto_item   DECIMAL(5,2) NOT NULL DEFAULT 0.00, -- % (0-100)
  PRIMARY KEY (id_os, id_servico),
  CONSTRAINT fk_item_os
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_item_servico
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
