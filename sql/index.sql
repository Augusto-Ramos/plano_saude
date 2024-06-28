CREATE DATABASE plano_saude;
USE plano_saude;

CREATE TABLE medico (
    id_medico INT PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255),
    telefone VARCHAR(20),
    salario INT,
    horas_trabalhadas INT
);

CREATE TABLE medicamento (
    id_medicamento INT PRIMARY KEY,
    nome VARCHAR(255),
    dosagem VARCHAR(255),
    tipo_medicamento VARCHAR(255)
);

CREATE TABLE paciente (
    id_paciente INT PRIMARY KEY,
    nome VARCHAR(255),
    telefone VARCHAR(20),
    plano_saude VARCHAR(255),
    valor_plano INT,
    cpf VARCHAR(20),
    endereco VARCHAR(255),
    cep VARCHAR(20)
);



CREATE TABLE exame (
    id_exame INT PRIMARY KEY,
    nome VARCHAR(255),
    observacoes TEXT,
    resultados VARCHAR(255)
);

CREATE TABLE consulta (
    id_consulta INT PRIMARY KEY,
    id_medico INT,
    id_paciente INT,
    id_exame INT,
    data DATETIME,
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_exame) REFERENCES exame(id_exame),
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento)
);

CREATE TABLE plano_saude(
    id_plano_saude INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    plano_familiar INT,
    plano_individual INT,
    meses_pagamento INT,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);



INSERT INTO Exame (id_exame, nome, observacoes, resultados) VALUES
(1, 'Exame de Sangue', 'Paciente em jejum', 'Hemoglobina normal'),
(2, 'Raio-X', 'Pulmões claros', 'Sem alterações'),
(3, 'Eletrocardiograma', 'Eletrodos posicionados', 'Ritmo sinusal normal'),
(4, 'Ressonância Magnética', 'Imagens claras', 'Nenhuma anomalia detectada'),
(5, 'Exame de Urina', 'Coleta matinal', 'Tudo norma');

INSERT INTO medico (id_medico, nome, email, telefone, salario, horas_trabalhadas) VALUES 
(1, 'João Pedro', 'jpzin@gmail.com', '8912345678', 20000, "12"),
(2, 'Tiago André', 'tiaguinandre@gmail.com', '8612344678', 18000, "12"), 
(3, 'Filipe Tomé', 'tomefilipe@gmail.com', '8987654321', 25000, "15"), 
(4, 'Simão Jesus', 'simãojota@gmail.com', '8912445577', 16000, "10"), 
(5, 'Judas Moisés', 'moijudas@gmail.com', '8922345578', 5000, 08);


INSERT INTO Paciente (id_paciente, nome, telefone, plano_saude, valor_plano, cpf, endereco, cep) VALUES
(1, 'Alice Silva', '123456789', 'Plano A', 200.00, '12345678901', 'Rua A, 123', '12345678'),
(2, 'Bruno Souza', '987654321', 'Plano B', 180.00, '98765432101', 'Rua B, 456', '87654321'),
(3, 'Carlos Santos', '112233445', 'Plano C', 250.00, '11223344556', 'Rua C, 789', '12348765'),
(4, 'Diana Lima', '998877665', 'Plano D', 160.00, '99887766544', 'Rua D, 101', '87651234'),
(5, 'Eduardo Ferreira', '556677889', 'Plano E', 150.00, '55667788922', 'Rua E, 202', '12347654');


INSERT INTO Medicamento (id_medicamento, nome, dosagem, tipo_medicamento) VALUES
(1, 'Paracetamol', '500mg', 'Analgésico'),
(2, 'Ibuprofeno', '400mg', 'Anti-inflamatório'),
(3, 'Amoxicilina', '500mg', 'Antibiótico'),
(4, 'Omeprazol', '20mg', 'Inibidor de bomba de prótons'),
(5, 'Loratadina', '10mg', 'Antialérgico');

INSERT INTO Plano_Saude (id_paciente, plano_familiar, plano_individual, meses_pagamento) VALUES
(1, 1, 0, 12),
(2, 0, 1, 6),
(3, 1, 1, 24),
(4, 0, 1, 3),
(5, 1, 0, 12);

INSERT INTO Consulta (id_consulta, id_medico, id_paciente, id_exame, data) VALUES
(1, 1, 1, 1, '2024-06-01 10:00:00'),
(2, 2, 2, 2, '2024-06-02 11:00:00'),
(3, 3, 3, 3, '2024-06-03 09:30:00'),
(4, 4, 4, 4, '2024-06-04 14:00:00'),
(5, 5, 5, 5, '2024-06-05 16:00:00');


SELECT * FROM medico;
SELECT * FROM Medicamento;
SELECT * FROM Paciente;
SELECT * FROM Plano_Saude;
SELECT * FROM Exame;
SELECT * FROM Consulta;


SELECT 
    Consulta.id_consulta,
    Consulta.data,
    Medico.nome AS nome_medico,
    Medico.email AS email_medico
FROM 
    Consulta
JOIN 
    Medico ON Consulta.id_medico = Medico.id_medico;

SELECT 
    Consulta.id_consulta,
    Consulta.data,
    Paciente.nome AS nome_paciente,
    Paciente.telefone AS telefone_paciente
FROM 
    Consulta
JOIN 
    Paciente ON Consulta.id_paciente = Paciente.id_paciente;

SELECT 
    Consulta.id_consulta,
    Consulta.data,
    Exame.nome AS nome_exame,
    Exame.resultados AS resultado_exame
FROM 
    Consulta
JOIN 
    Exame ON Consulta.id_exame = Exame.id_exame;


SELECT * FROM Medico WHERE salario > 18000;
SELECT * FROM Paciente WHERE valor_plano > 200;
SELECT * FROM Consulta WHERE DATE(data) = '2024-06-01';
SELECT * FROM Medicamento WHERE tipo_medicamento = 'Antibiótico';

SELECT 
    Medico.nome AS nome_medico,
    COUNT(Consulta.id_consulta) AS total_consultas
FROM 
    Consulta
JOIN 
    Medico ON Consulta.id_medico = Medico.id_medico
GROUP BY 
    Medico.nome;

SELECT 
    AVG(salario) AS media_salarial 
FROM 
    Medico;

SELECT 
    SUM(valor_plano) AS valor_total_planos 
FROM 
    Paciente;

SELECT 
    COUNT(id_paciente) AS total_pacientes_plano_familiar
FROM 
    Plano_Saude
WHERE 
    plano_familiar = 1;


SELECT * FROM Paciente WHERE id_paciente = 3;
SELECT * FROM Exame WHERE id_exame = 2;
SELECT * FROM Medicamento WHERE id_medicamento = '4';



