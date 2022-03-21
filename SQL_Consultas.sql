
-- Evolução diária do vírus
SELECT SUM(his_casos_ms) AS "Casos Totais(Brasil)", his.his_data AS "Data do dado"
FROM his_casos_estados	his
GROUP BY his.his_data
HAVING SUM(his_casos_ms);

-- Evolução mensal do vírus a partir do dia 25 de fevereiro de 2020 (Primeiro caso)
SELECT SUM(his_casos_ms)  AS "Casos Totais(Brasil)", his.his_data AS "Data do dado"
FROM his_casos_estados	his
WHERE EXTRACT(DAY FROM his.his_data) = 26
GROUP BY his.his_data
HAVING SUM(his_casos_ms);

-- Evolução semanal do vírus(último dia de cada semana) no Brasil
SELECT his.his_semana_ep, SUM(his.his_casos_ms)  AS "Casos Totais(Brasil)", his.his_data AS "Data do dado"
FROM his_casos_estados his, ((SELECT his.his_semana_ep AS semEpi, MAX(his.his_data) AS maxData
										FROM his_casos_estados his
										GROUP BY his.his_semana_ep)AS tab)
WHERE his.his_semana_ep = tab.semEpi AND his.his_data = tab.maxData
GROUP BY his.his_semana_ep
HAVING SUM(his.his_casos_ms);

-- Casos totais e mortes no Brasil, obtido a partir dos estados
SELECT SUM(e.est_casos_ms) AS "Casos Totais(Brasil)", SUM(e.est_MORTES_ms) AS "Mortes Totais(Brasil)"
FROM casos_estado e;

-- Casos totais e mortes por região do Brasil
SELECT r.regiao_nome AS "Região", SUM(est.est_casos_ms) AS "Casos Totais", SUM(est.est_mortes_ms) AS "Mortes Totais"
FROM casos_estado est NATURAL JOIN estado e NATURAL JOIN regiao r
GROUP BY r.id_regiao
ORDER BY SUM(est.est_casos_ms) DESC;

-- Casos totais e mortes por estado do Brasil
SELECT e.estado_nome AS "Estado", est.est_casos_ms AS "Casos Totais", est.est_mortes_ms AS "Mortes Totais"
FROM casos_estado est NATURAL JOIN estado e
ORDER BY est.est_casos_ms DESC;

-- Casos totais e mortes por cidade do Brasil
SELECT r.regiao_nome AS "Região", e.estado_nome AS "Estado", c.cid_cidade AS "Cidade" ,c.cid_casos AS "Casos Totais", c.cid_mortes AS "Mortes Totais"
FROM casos_cidade c NATURAL JOIN estado e NATURAL JOIN regiao r
ORDER BY c.cid_casos DESC;


-- Tabela de Casos Confirmados e Densidade demográfica de cada estado
SELECT e.estado_nome, ce.est_casos AS "Casos confirmados", (e.estado_populacao / e.estado_area_km2)*1000 AS "Densidade Demográfica(hab/km²)"
FROM estado e NATURAL INNER JOIN casos_estado ce
ORDER BY ce.est_casos DESC

-- Tabela de Estados e suas Densidades Demográficas
SELECT e.estado_nome, (e.estado_populacao / e.estado_area_km2)*1000 AS "Densidade Demográfica(hab/km²)"
FROM estado e
ORDER BY (e.estado_populacao / e.estado_area_km2)*1000 DESC

-- Tabela de Estados e seu número total de casos
SELECT e.estado_nome, ce.est_casos AS "Casos confirmados"
FROM estado e NATURAL INNER JOIN casos_estado ce
ORDER BY ce.est_casos DESC

-- Tabela de Casos Confirmados e Densidade demográfica de cada região
SELECT r.regiao_nome, SUM(ce.est_casos_ms) AS "Casos Totais", (e.estado_populacao / e.estado_area_km2)*1000 AS "Densidade Demográfica(hab/km²)"
FROM estado e NATURAL JOIN casos_estado ce NATURAL JOIN regiao r
GROUP BY e.id_regiao
ORDER BY SUM(ce.est_casos_ms) DESC

-- Número de testes por estado do Brasil
SELECT e.estado_nome AS "Estado", est.est_testes AS "Testes Totais", est.est_testes_por_100k AS "Testes a cada 100k de hab"
FROM casos_estado est NATURAL JOIN estado e
ORDER BY est.est_testes DESC;

-- Número de mortes por casos por estado do Brasil
SELECT e.estado_nome AS "Estado", est.est_mortes_por_casos AS "Mortes por casos"
FROM casos_estado est NATURAL JOIN estado e
ORDER BY est.est_mortes_por_casos DESC;

