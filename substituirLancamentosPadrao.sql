/*
	Substitui os lançamentos padrões modificados
		Ex: LANBLA_23 E LANBLA_24 para LANBLA
*/

do $$
declare
	newCode varchar;
begin
	for newCode in ('186CARTÃO', '190 13 FL', 'COFINS', 'CSLL', 'F1 AMER REC', 'F3 RECEITA', 'FGTS DEP', 'FGTS MTZ', 'FL MTZ', 'FOLHA 194', 'FOLHA F 4', 'FOLHA FL 1', 'FOLHA FL 2', 'FOLHA FL 3', 'ICMS FL 01', 'ICMS FL 02', 'ICMS FL 03', 'ICMS MATRIZ', 'IRPJ', 'PIS', 'QUEBRA', 'RECEITA F4', 'RECEITA F5', 'RECEITA F6', 
	'SOBRA')
	loop
		update contabil.lancamentospadrao
		set codigo = newCode
		where codigo like newCode||%;
	endloop;
end$$;