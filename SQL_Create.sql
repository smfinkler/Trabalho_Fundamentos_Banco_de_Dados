-- Banco de Dados
CREATE DATABASE IF NOT EXISTS `trabalhofbd`;
USE `trabalhofbd`;

-- Tabela de Regiões do Brasil
CREATE TABLE IF NOT EXISTS `regiao` (
  `id_regiao` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `regiao_nome` varchar(20) NOT NULL,
  `regiao_area_km2` bigint(10) unsigned NOT NULL,
  `regiao_porcentagem_area` decimal(3,1) unsigned NOT NULL,
  `regiao_populacao` int(8) unsigned NOT NULL,
  `regiao_porcentagem_pop` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id_regiao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabela de Estado do Brasil
CREATE TABLE IF NOT EXISTS `estado` (
  `id_estado` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `estado_nome` varchar(45) NOT NULL,
  `estado_sigla` char(2) NOT NULL,
  `estado_area_km2` bigint(10) NOT NULL,
  `estado_populacao` int(8) NOT NULL,
  `id_regiao` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id_estado`),
  KEY `fk_Estado_Regiao_idx` (`id_regiao`),
  CONSTRAINT `fk_Estado_Regiao` FOREIGN KEY (`id_regiao`) REFERENCES `regiao` (`id_regiao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabela de Casos por Estado do Brasil
CREATE TABLE IF NOT EXISTS `casos_estado` (
  `id_casos_estado` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `id_estado` tinyint(2) unsigned NOT NULL,
  `est_casos` int(7) unsigned NOT NULL,
  `est_casos_ms` int(7) unsigned NOT NULL,
  `est_nao_conf` smallint(4) unsigned NOT NULL,
  `est_mortes` smallint(5) unsigned NOT NULL,
  `est_mortes_ms` smallint(5) unsigned NOT NULL,
  `est_url` varchar(60) NOT NULL,
  `est_mortes_por_100k` float(7,5) unsigned zerofill NOT NULL,
  `est_casos_por_100k` float(9,5) unsigned zerofill NOT NULL,
  `est_mortes_por_casos` float(6,5) unsigned zerofill NOT NULL,
  `est_recuperados` mediumint(6) unsigned NOT NULL,
  `est_suspeitos` mediumint(6) unsigned NOT NULL,
  `est_testes` mediumint(7) unsigned NOT NULL,
  `est_testes_por_100k` float(10,5) unsigned zerofill NOT NULL,
  `est_data` date NOT NULL,
  `est_novos_casos` smallint(5) unsigned NOT NULL,
  `est_novas_mortes` smallint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_casos_estado`),
  KEY `fk_Casos_Estado_Estado1_idx` (`id_estado`),
  CONSTRAINT `fk_Casos_Estado_Estado1` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabela de Histórico de Casos por Estado do Brasil
CREATE TABLE IF NOT EXISTS `his_casos_estados` (
  `id_his_casos_estado` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `his_semana_ep` tinyint(2) unsigned NOT NULL,
  `his_data` date NOT NULL,
  `id_estado` tinyint(2) unsigned NOT NULL,
  `his_novas_mortes` smallint(5) unsigned NOT NULL,
  `his_mortes` mediumint(6) unsigned NOT NULL,
  `his_novos_casos` mediumint(6) unsigned NOT NULL,
  `his_casos` mediumint(7) unsigned NOT NULL,
  `his_mortes_ms` mediumint(6) unsigned NOT NULL,
  `his_casos_ms` mediumint(7) unsigned NOT NULL,
  `his_mortes_por_100k` float(7,5) unsigned zerofill NOT NULL,
  `his_casos_por_100k` float(9,5) unsigned zerofill NOT NULL,
  `his_mortes_por_casos` float(6,5) unsigned zerofill NOT NULL,
  `his_recuperados` mediumint(6) unsigned NOT NULL,
  `his_suspeitos` mediumint(6) unsigned NOT NULL,
  `his_testes` mediumint(7) unsigned NOT NULL,
  `his_testes_por_100k` float(10,5) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id_his_casos_estado`),
  KEY `fk_His_Casos_Estados_Estado1_idx` (`id_estado`),
  CONSTRAINT `fk_His_Casos_Estados_Estado1` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabela de Casos por Cidade do Brasil
CREATE TABLE IF NOT EXISTS `casos_cidade` (
  `id_casos_cidade` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `id_estado` tinyint(2) unsigned NOT NULL,
  `cid_cidade` varchar(100) NOT NULL,
  `cid_ibge_id` mediumint(7) unsigned NOT NULL,
  `cid_cod_regiao_saude` mediumint(5) unsigned NOT NULL,
  `cid_nome_regiao_saude` varchar(80) NOT NULL,
  `cid_mortes` smallint(5) unsigned NOT NULL,
  `cid_casos` mediumint(7) unsigned NOT NULL,
  `cid_mortes_por_100k` float(8,5) unsigned zerofill NOT NULL,
  `cid_casos_por_100k` float(10,5) unsigned zerofill NOT NULL,
  `cid_mortes_por_casos` float(6,5) unsigned zerofill NOT NULL,
  `cid_fonte` varchar(45) NOT NULL,
  `cid_data` date NOT NULL,
  `cid_novos_casos` smallint(4) unsigned NOT NULL,
  `cid_novas_mortes` smallint(4) unsigned NOT NULL,
  `cid_ultima_data` date NOT NULL,
  PRIMARY KEY (`id_casos_cidade`),
  KEY `fk_Casos_Cidade_Estado1_idx` (`id_estado`),
  CONSTRAINT `fk_Casos_Cidade_Estado1` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;