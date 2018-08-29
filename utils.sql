/*
	Série de comandos/funcões para algumas correções mais simples
*/

-- Porta 5432 - Normalmente apenas no banco de homologação
select ns.processoposrestore();

-- Reajuste de Cálculos no Persona
select conversor.ajustacalculosindical();