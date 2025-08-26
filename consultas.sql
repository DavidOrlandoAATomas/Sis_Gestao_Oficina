-- 1. RECUPERAÇÕES SIMPLES COM SELECT STATEMENT
SELECT * FROM custumer;
SELECT fname, surname, telefone FROM custumer;
SELECT license_plate, brand, model FROM vehicle;
SELECT order_id, order_status, total FROM service_order;

-- 2. FILTROS COM WHERE STATEMENT
SELECT * FROM custumer WHERE tipo_doc = 'BI';
SELECT * FROM vehicle WHERE brand = 'Toyota';
SELECT * FROM service_order WHERE total > 30000.00;
SELECT * FROM mechanic WHERE specialty = 1; -- Mecânicos especialistas em motor
SELECT * FROM piece WHERE quantity > 20; -- Peças com estoque alto

-- 3. EXPRESSÕES PARA GERAR ATRIBUTOS DERIVADOS
SELECT 
    order_id, 
    total, 
    total * 0.9 AS total_com_desconto,
    total * 0.1 AS valor_desconto
FROM service_order;

SELECT 
    CONCAT(fname, ' ', surname) AS nome_completo,
    TIMESTAMPDIFF(YEAR, data_contratacao, CURDATE()) AS anos_na_empresa,
    salario_base * 1.1 AS salario_com_aumento
FROM mechanic;

SELECT 
    pname,
    unit_value,
    quantity,
    unit_value * quantity AS valor_total_estoque,
    CASE 
        WHEN quantity < 20 THEN 'Reposição Necessária'
        WHEN quantity = 20 THEN 'Estoque Mínimo'
        ELSE 'Estoque Suficiente'
    END AS status_estoque
FROM piece;

-- 4. ORDENAÇÕES DOS DADOS COM ORDER BY
SELECT * FROM custumer ORDER BY surname, fname;
SELECT * FROM service_order ORDER BY total DESC;
SELECT * FROM vehicle ORDER BY v_year DESC, brand ASC;
SELECT * FROM piece ORDER BY unit_value DESC;
SELECT * FROM service ORDER BY subtotal DESC;

-- 5. CONDIÇÕES DE FILTROS AOS GRUPOS – HAVING STATEMENT

SELECT 
    specialty_name,
    COUNT(*) AS quantidade_mecanicos,
    AVG(salary) AS salario_medio
FROM mechanic m
JOIN specialty s ON m.specialty = s.specialty_id
GROUP BY specialty_name
HAVING AVG(salary) > 80000;

SELECT 
    order_status,
    COUNT(*) AS quantidade_ordens,
    AVG(total) AS valor_medio
FROM service_order
GROUP BY order_status
HAVING AVG(total) > 25000;

-- 6. JUNÇÕES ENTRE TABELAS
-- Ordens de serviço com detalhes do cliente e veículo
SELECT 
    so.order_id,
    so.order_date,
    so.total,
    so.order_status,
    CONCAT(c.fname, ' ', c.surname) AS cliente,
    v.license_plate,
    v.brand,
    v.model
FROM service_order so
JOIN vehicle v ON so.vehicle = v.vehicle_id
JOIN custumer c ON v.vehicle_owner = c.custumer_id;

-- Serviços realizados em cada ordem com peças utilizadas
SELECT 
    so.order_id,
    s.service_type,
    s.service_desc,
    ssv.quantity  AS qtd_servico,
    ssv.unit_value AS valor_servico,
    p.pname AS peca_utilizada,
    sp.quantity AS qtd_peca,
    sp.unit_value AS valor_peca
FROM service_order so
JOIN so_service ssv ON so.order_id = ssv.order_id
JOIN service s ON ssv.service_id = s.service_id
LEFT JOIN so_piece sp ON so.order_id = sp.order_id
LEFT JOIN piece p ON sp.piece_id = p.piece_id;

-- Mecânicos por equipe com suas especialidades
SELECT 
    t.team_name,
    CONCAT(m.fname, ' ', m.surname) AS mecanico,
    s.specialty_name
FROM team t
JOIN team_mechanic tm ON t.team_id = tm.team
JOIN mechanic m ON tm.mechanic = m.mechanic_id
JOIN specialty s ON m.specialty = s.specialty_id;

-- Relatório financeiro mensal
SELECT 
    MONTH(so.order_date) AS mes,
    YEAR(so.order_date) AS ano,
    COUNT(so.order_id) AS total_ordens,
    SUM(so.total) AS receita_total,
    AVG(so.total) AS ticket_medio,
    SUM(CASE WHEN so.order_status = 'Finalizada' THEN so.total ELSE 0 END) AS receita_realizada,
    SUM(CASE WHEN so.order_status IN ('Pendente', 'Em_Andamento') THEN so.total ELSE 0 END) AS receita_pendente
FROM service_order so
GROUP BY YEAR(so.order_date), MONTH(so.order_date)
ORDER BY ano DESC, mes DESC;

-- Peças mais utilizadas nas ordens de serviço
SELECT 
    p.pname,
    p.ptype,
    SUM(sp.quantity) AS total_utilizado,
    SUM(sp.quantity * sp.unit_value) AS valor_total_utilizado,
    p.quantity AS estoque_atual
FROM piece p
JOIN so_piece sp ON p.piece_id = sp.piece_id
GROUP BY p.piece_id
ORDER BY total_utilizado DESC;

-- Clientes que mais gastaram
SELECT 
    c.custumer_id,
    CONCAT(c.fname, ' ', c.surname) AS cliente,
    COUNT(so.order_id) AS total_ordens,
    SUM(so.total) AS total_gasto,
    AVG(so.total) AS media_por_ordem
FROM custumer c
JOIN vehicle v ON c.custumer_id = v.vehicle_owner
JOIN service_order so ON v.vehicle_id = so.vehicle
GROUP BY c.custumer_id, c.fname, c.surname
HAVING COUNT(so.order_id) > 0
ORDER BY total_gasto DESC;