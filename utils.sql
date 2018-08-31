/*
	Série de comandos/funcões para algumas correções mais simples
*/

-- Porta 5432 - Normalmente apenas no banco de homologação
select ns.processoposrestore();

-- Reajuste de Cálculos no Persona
select conversor.ajustacalculosindical();

-- Seleciona funcionários por empresa e código
select a.nome as nome, b.razaosocial as empresa, b.codigo as codigo
from persona.trabalhadores a
left join ns.empresas b on a.empresa = b.empresa
order by codigo

-- Seleciona funcionários por estabelecimento e código
select a.nome as nome, b.descricao as estabelecimento, b.codigo as codigo
from persona.trabalhadores a
left join ns.estabelecimentos b on a.estabelecimento = b.estabelecimento
order by codigo