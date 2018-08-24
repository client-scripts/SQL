/*
	Verifica a migração dos Módulos Persona, Scritta e Contábil por empresa
*/

SELECT
 e.codigo,
 e.descricao,
 e.raizcnpj,
 g.codigo AS grupo,
 (
  EXISTS(SELECT 1 FROM persona.trabalhadores WHERE empresa    = e.empresa) or 
  EXISTS(SELECT 1 FROM persona.historicosgps WHERE empresa    = e.empresa)
 ) persona_convertido,
 EXISTS(SELECT 1 FROM contabil.contas       WHERE empresa    = e.empresa) contabil_convertido,
 EXISTS(SELECT 1 FROM scritta.lf_lanfis     WHERE id_estabelecimento IN (SELECT estabelecimento FROM ns.estabelecimentos WHERE empresa = e.empresa)) OR 
 EXISTS(SELECT 1 FROM scritta.od_outdoc     WHERE id_estabelecimento IN (SELECT estabelecimento FROM ns.estabelecimentos WHERE empresa = e.empresa)) scritta_convertido
FROM
 ns.empresas e
 INNER JOIN ns.gruposempresariais g ON
 e.grupoempresarial = g.grupoempresarial