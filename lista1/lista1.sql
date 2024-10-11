-- 1. Exibir lista de alunos e seus cursos:

CREATE VIEW vw_alunos_cursos AS
SELECT a.nome AS nome_aluno, d.nome AS nome_disciplina, c.nome AS nome_curso
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
JOIN disciplina d ON m.id_disciplina = d.id_disciplina
JOIN curso c ON d.id_curso = c.id_curso;

-- 2. Exibir total de alunos por disciplina:

CREATE VIEW vw_total_alunos_disciplina AS
SELECT d.nome AS nome_disciplina, COUNT(m.id_aluno) AS total_alunos
FROM disciplina d
LEFT JOIN matricula m ON d.id_disciplina = m.id_disciplina
GROUP BY d.nome;

-- 3. Exibir alunos e status das suas matrículas:

CREATE VIEW vw_alunos_status_matricula AS
SELECT a.nome AS nome_aluno, d.nome AS nome_disciplina, m.status_matricula
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
JOIN disciplina d ON m.id_disciplina = d.id_disciplina;

-- 4. Exibir professores e suas turmas:

CREATE VIEW vw_professores_turmas AS
SELECT p.nome AS nome_professor, d.nome AS nome_disciplina, t.horario
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
JOIN disciplina d ON t.id_disciplina = d.id_disciplina;

-- 5. Exibir alunos maiores de 20 anos:

CREATE VIEW vw_alunos_maiores_20 AS
SELECT nome, data_nascimento
FROM aluno
WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 20;

-- 6. Exibir disciplinas e carga horária total por curso:

CREATE VIEW vw_carga_horaria_curso AS
SELECT c.nome AS nome_curso, COUNT(d.id_disciplina) AS total_disciplinas, SUM(d.carga_horaria) AS carga_horaria_total
FROM curso c
JOIN disciplina d ON c.id_curso = d.id_curso
GROUP BY c.nome;

-- 7. Exibir professores e suas especialidades:

CREATE VIEW vw_professores_especialidades AS
SELECT nome, especialidade
FROM professor;

-- 8. Exibir alunos matriculados em mais de uma disciplina:

CREATE VIEW vw_alunos_multidisciplinas AS
SELECT a.nome, COUNT(m.id_disciplina) AS total_disciplinas
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
GROUP BY a.nome
HAVING COUNT(m.id_disciplina) > 1;

-- 9. Exibir alunos e o número de disciplinas que concluíram:

CREATE VIEW vw_alunos_disciplinas_concluidas AS
SELECT a.nome, COUNT(m.id_disciplina) AS disciplinas_concluidas
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
WHERE m.status_matricula = 'Concluído'
GROUP BY a.nome;

-- 10. Exibir todas as turmas de um semestre específico:

CREATE VIEW vw_turmas_semestre AS
SELECT *
FROM turma
WHERE semestre = '2024.1';

--  11. Exibir alunos com matrículas trancadas:

CREATE VIEW vw_alunos_matriculas_trancadas AS
SELECT a.nome
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
WHERE m.status_matricula = 'Trancado';

-- 12. Exibir disciplinas que não têm alunos matriculados:

CREATE VIEW vw_disciplinas_sem_alunos AS
SELECT d.nome AS nome_disciplina
FROM disciplina d
LEFT JOIN matricula m ON d.id_disciplina = m.id_disciplina
WHERE m.id_aluno IS NULL;

-- 13. Exibir a quantidade de alunos por status de matrícula:

CREATE VIEW vw_alunos_por_status_matricula AS
SELECT m.status_matricula, COUNT(m.id_aluno) AS total_alunos
FROM matricula m
GROUP BY m.status_matricula;


-- 14. Exibir o total de professores por especialidade:

CREATE VIEW vw_total_professores_especialidade AS
SELECT especialidade, COUNT(id_professor) AS total_professores
FROM professor
GROUP BY especialidade;

-- 15. Exibir lista de alunos e suas idades:

CREATE VIEW vw_alunos_idades AS
SELECT nome, TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade
FROM aluno;

-- 16. Exibir alunos e suas últimas matrículas:

CREATE VIEW vw_alunos_ultimas_matriculas AS
SELECT a.nome, MAX(m.data_matricula) AS ultima_matricula
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
GROUP BY a.nome;

-- 17. Exibir todas as disciplinas de um curso específico:

CREATE VIEW vw_disciplinas_curso AS
SELECT d.nome AS nome_disciplina
FROM disciplina d
JOIN curso c ON d.id_curso = c.id_curso
WHERE c.nome = 'Engenharia de Software';

-- 18. Exibir os professores que não têm turmas:

CREATE VIEW vw_professores_sem_turmas AS
SELECT p.nome
FROM professor p
LEFT JOIN turma t ON p.id_professor = t.id_professor
WHERE t.id_professor IS NULL;

-- 19. Exibir lista de alunos com CPF e email:

CREATE VIEW vw_alunos_cpf_email AS
SELECT nome, cpf, email
FROM aluno;

-- 20. Exibir o total de disciplinas por professor:

CREATE VIEW vw_total_disciplinas_por_professor AS
SELECT p.nome AS nome_professor, COUNT(t.id_disciplina) AS total_disciplinas
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
GROUP BY p.nome;