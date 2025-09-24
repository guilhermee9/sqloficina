-- USE oficina_db;

START TRANSACTION;

-- CLIENTES
INSERT INTO clientes (id_cliente, nome, cpf, telefone, email) VALUES
(1,'João Silva',  '12345678901','41999990001','joao.silva@email.com'),
(2,'Maria Souza', '23456789012','41999990002','maria.souza@email.com'),
(3,'Pedro Lima',  '34567890123','41999990003','pedro.lima@email.com'),
(4,'Ana Costa',   '45678901234','41999990004','ana.costa@email.com'),
(5,'Lucas Pereira','56789012345','41999990005','lucas.pereira@email.com');

-- VEÍCULOS
INSERT INTO veiculos (id_veiculo, id_cliente, placa, marca, modelo, ano, cor) VALUES
(1,1,'ABC1234','Toyota','Corolla',2018,'Preto'),
(2,2,'DEF4567','Ford','Fiesta',2014,'Prata'),
(3,3,'GHI7890','Volkswagen','Gol',2010,'Branco'),
(4,4,'JKL1234','Honda','Civic',2016,'Cinza'),
(5,5,'MNO5678','Fiat','Strada',2020,'Vermelho'),
(6,1,'PRS3456','Volkswagen','Polo',2019,'Azul');

-- SERVIÇOS
INSERT INTO servicos (id_servico, nome, categoria, preco_base, minutos_estimados) VALUES
(1,'Troca de Óleo','Revisão',120.00,30),
(2,'Alinhamento','Revisão',80.00,45),
(3,'Balanceamento','Revisão',60.00,30),
(4,'Revisão de Freios','Mecânica',250.00,120),
(5,'Substituição de Pastilhas','Mecânica',320.00,90),
(6,'Diagnóstico Eletrônico','Diagnóstico',150.00,40),
(7,'Troca de Bateria','Elétrica',220.00,60),
(8,'Higienização do Ar','Revisão',140.00,50),
(9,'Retoque Para-choque','Funilaria',500.00,240);

-- ORDENS DE SERVIÇO
INSERT INTO ordens_servico (id_os, id_veiculo, data_abertura, data_fechamento, status, forma_pagamento, desconto_os, observacoes) VALUES
(1,1,'2025-09-01 09:00:00','2025-09-01 15:30:00','Concluída','Pix',5.00,'Revisão 60k km'),
(2,2,'2025-09-10 10:00:00',NULL,'Em andamento',NULL,0.00,'Barulho nos freios'),
(3,3,'2025-08-15 11:00:00','2025-08-16 09:00:00','Concluída','Cartão',0.00,'Pane elétrica intermitente'),
(4,4,'2025-07-05 14:00:00','2025-07-05 16:00:00','Cancelada',NULL,0.00,'Cliente desistiu'),
(5,5,'2025-09-05 09:30:00','2025-09-06 10:45:00','Concluída','Dinheiro',3.00,'Vibração acima de 80 km/h'),
(6,1,'2025-09-20 08:15:00',NULL,'Em andamento',NULL,0.00,'Luz ABS acesa'),
(7,6,'2025-09-18 08:00:00','2025-09-18 12:00:00','Concluída','Cartão',0.00,'Mau cheiro no ar-condicionado'),
(8,2,'2025-08-01 10:20:00','2025-08-02 11:00:00','Concluída','Boleto',0.00,'Revisão básica');

-- ITENS DA OS
-- OS 1 (Corolla - João)
INSERT INTO itens_ordem (id_os, id_servico, quantidade, preco_unitario, desconto_item) VALUES
(1,1,1,120.00,0.00),   -- Troca de Óleo
(1,2,1,80.00,0.00),    -- Alinhamento
(1,3,2,60.00,10.00);   -- Balanceamento (2 rodas, 10% desc)

-- OS 2 (Fiesta - Maria) - Em andamento
INSERT INTO itens_ordem VALUES
(2,4,1,250.00,0.00),   -- Revisão de Freios
(2,5,1,320.00,5.00);   -- Substituição de Pastilhas

-- OS 3 (Gol - Pedro)
INSERT INTO itens_ordem VALUES
(3,6,1,150.00,0.00),   -- Diagnóstico
(3,7,1,220.00,5.00);   -- Troca de Bateria com 5% desc

-- OS 4 (Civic - Ana) - Cancelada
INSERT INTO itens_ordem VALUES
(4,1,1,120.00,0.00);   -- Troca de Óleo (acabou cancelada)

-- OS 5 (Strada - Lucas)
INSERT INTO itens_ordem VALUES
(5,2,1,80.00,0.00),    -- Alinhamento
(5,3,4,60.00,5.00);    -- Balanceamento (4 rodas, 5% desc)

-- OS 6 (Corolla - João) - Em andamento
INSERT INTO itens_ordem VALUES
(6,4,1,250.00,0.00),   -- Revisão de Freios
(6,6,1,150.00,0.00);   -- Diagnóstico Eletrônico

-- OS 7 (Polo - João)
INSERT INTO itens_ordem VALUES
(7,8,1,140.00,0.00),   -- Higienização do Ar
(7,1,1,120.00,0.00);   -- Troca de Óleo

-- OS 8 (Fiesta - Maria)
INSERT INTO itens_ordem VALUES
(8,1,1,120.00,0.00),   -- Troca de Óleo
(8,3,2,60.00,0.00);    -- Balanceamento (2 rodas)

COMMIT;
