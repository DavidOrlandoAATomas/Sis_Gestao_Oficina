-- Inserção de dados
INSERT INTO custumer (fname, surname, tipo_doc, num_doc, telefone, address) VALUES
('João', 'Santos', 'BI', '123456789LA123', '923456789', 'Rua das Flores, 123 - Luanda'),
('Maria', 'Fernandes', 'BI', '987654321LA456', '934567890', 'Av. 4 de Fevereiro, 456 - Luanda'),
('Carlos', 'Oliveira', 'Carta de Condução', 'CD123456', '945678901', 'Travessa da Paz, 789 - Benguela'),
('Ana', 'Costa', 'BI', '456789123LA789', '956789012', 'Rua do Comércio, 321 - Huambo'),
('Pedro', 'Machado', 'Passaporte', 'P1234567', '967890123', 'Av. Hoji Ya Henda, 654 - Lubango'),
('Sofia', 'Pereira', 'BI', '321654987LA321', '978901234', 'Rua Nossa Senhora, 987 - Cabinda');

INSERT INTO specialty (specialty_name, spacialty_desc) VALUES
('Motor', 'Especialista em reparação de motores'),
('Transmissão', 'Especialista em caixas de velocidades e transmissões'),
('Suspensão', 'Especialista em sistemas de suspensão e direção'),
('Elétrica', 'Especialista em sistemas elétricos e eletrónicos'),
('Ar Condicionado', 'Especialista em sistemas de climatização'),
('Pintura', 'Especialista em pintura automóvel');

INSERT INTO mechanic (fname, surname, specialty, address, salary) VALUES
('António', 'Silva', 1, 'Rua dos Mecânicos, 123-Luanda', 185000.00),
('Joaquim', 'Santos', 2, 'Av. das Oficinas, 456-Luanda', 178000.00),
('Fernando', 'Costa', 3, 'Travessa da moi, 789-Benguela', 175000.00),
('Ricardo', 'Oliveira', 4, 'Rua El4, 321-Huambo', 182000.00),
('Paulo', 'Machado', 5, 'Av. do Ar, 654-Lubango', 176000.00),
('Miguel', 'Pereira', 6, 'Rua 44, 987-Cabinda', 179000.00);

INSERT INTO team (team_name, responseble, vehicle) VALUES
('Equipe Motor', 1, 1),
('Equipe Elétrica', 4,4),
('Equipe C', 2,3),
('Equipe W', 3,2);

INSERT INTO team_mechanic (team, mechanic, data_inicio, funcao) VALUES
(1, 1, '2023-01-01', 'Líder'),
(1, 2, '2023-01-01', 'Mecânico'),
(2, 4, '2023-01-01', 'Líder'),
(2, 5, '2023-01-01', 'Mecânico'),
(3, 3, '2023-01-01', 'Líder'),
(3, 6, '2023-01-01', 'Mecânico');

INSERT INTO vehicle (license_plate, brand, model, v_year, vehicle_owner, color, mileage, last_revision) VALUES
('LD-01-23-AB', 'Toyota', 'Hilux', 2020, 1, 'Branco', 45000, '2023-06-15'),
('LD-02-23-CD', 'Hyundai', 'Tucson', 2021, 2, 'Preto', 32000, '2023-07-20'),
('LD-03-23-EF', 'Mercedes', 'C200', 2019, 3, 'Prata', 58000, '2023-05-10'),
('LD-04-23-GH', 'BMW', 'X5', 2022, 4, 'Azul', 15000, '2023-08-05'),
('LD-05-23-IJ', 'Volkswagen', 'Golf', 2018, 5, 'Vermelho', 72000, '2023-04-18'),
('LD-06-23-KL', 'Audi', 'A4', 2020, 6, 'Cinza', 39000, '2023-09-12');

INSERT INTO piece (pname, ptype, piece_desc, quantity, unit_value, supplier) VALUES
('Filtro de Óleo', 'Filtro', 'Filtro de óleo para motor a gasolina', 50, 2500.00, 'AutoParts Lda'),
('Pastilhas de Travão', 'Travões', 'Pastilhas de travão dianteiras', 30, 8500.00, 'BrakeTech'),
('Bateria 60Ah', 'Elétrica', 'Bateria 12V 60Ah', 15, 45000.00, 'PowerBattery'),
('Amortecedor Dianteiro', 'Suspensão', 'Amortecedor dianteiro esquerdo', 10, 32000.00, 'SuspensionParts'),
('Correia de Distribuição', 'Motor', 'Correia de distribuição kit completo', 12, 28000.00, 'MotorComponents'),
('Lâmpada LED', 'Elétrica', 'Lâmpada LED H7', 40, 7500.00, 'LightTech');

INSERT INTO service (service_type, service_desc, subtotal, custumer) VALUES
('Revisão', 'Revisão periódica completa', 25000.00, '6'),
('Troca de Travões', 'Substituição de pastilhas e discos', 18000.00, 2),
('Reparação Elétrica', 'Diagnóstico e reparação de problemas elétricos', 15000.00, 3),
('Substituição Bateria', 'Substituição de bateria', 8000.00, 1),
('Alinhamento Direção', 'Alinhamento de direção e balanceamento', 12000.00, 4),
('Pintura', 'Reparação e pintura de para-choques', 35000.00, 5);
select*from service_order;
INSERT INTO service_order (order_status, order_date, concl_date, total, team, vehicle, priority, problem_desc) VALUES
('Finalizada', '2023-10-01', '2023-10-02', 43000.00, 1, 1, 'Média', 'Barulho no motor e revisão periódica'),
('Em_Andamento', '2023-10-05', NULL, 26500.00, 2, 3, 'Alta', 'Problemas no sistema elétrico'),
('Pendente', '2023-10-10', NULL, 18000.00, 3, 2, 'Média', 'Troca de pastilhas de travão'),
('Esperando_Peça', '2023-10-08', NULL, 32000.00, 1, 4, 'Baixa', 'Substituição de amortecedores'),
('Finalizada', '2023-10-03', '2023-10-04', 75000.00, 2, 5, 'Urgente', 'Substituição completa da bateria e reparação elétrica'),
('Em_Andamento', '2023-10-12', NULL, 42000.00, 3, 6, 'Média', 'Pintura de para-choques dianteiro');

INSERT INTO so_service (order_id, service_id, quantity, unit_value) VALUES
(7, 1, 1, 25000.00),
(8, 3, 1, 15000.00),
(8, 1, 1, 15000.00),
(8, 4, 1, 8000.00),
(9, 2, 1, 18000.00),
(10, 5, 1, 12000.00),
(10, 2, 1, 18000.00),
(11, 4, 1, 8000.00),
(11, 3, 1, 15000.00),
(12, 5, 1, 35000.00);
select*from piece;
INSERT INTO so_piece (order_id, piece_id, quantity, unit_value) VALUES
(7, 7, 1, 2500.00),
(7, 11, 1, 28000.00),
(8, 9, 1, 45000.00),
(9, 8, 2, 8500.00),
(10, 10, 2, 32000.00),
(11, 9, 1, 45000.00),
(11, 12, 2, 7500.00),
(12, 12, 1, 7500.00);

INSERT INTO authorization (auth_type, auth_date, auth_value, custumer, order_id, auth_status) VALUES
('Assinatura', '2023-10-01', 43000.00, 1, 7, 'Aprovada'),
('Digital', '2023-10-05', 26500.00, 2, 8, 'Aprovada'),
('Digital', '2023-10-10', 18000.00, 3, 9, 'Pendente'),
('Verbal', '2023-10-08', 32000.00, 4, 10, 'Aprovada'),
('Assinatura', '2023-10-03', 75000.00, 5, 11, 'Aprovada'),
('Digital', '2023-10-12', 42000.00, 6, 12, 'Aprovada');