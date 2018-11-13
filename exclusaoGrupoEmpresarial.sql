/*
	Script para exclusão dos grupos empresariais código
	coloque os códigos da empresa no array empresa_nome
	Testado com sucesso na 12235.13
*/

DO $$
DECLARE 
grupo_nome varchar[];

begin

grupo_nome = array['COLOCAR CODIGO DAS EMPRESAS AQUI - SELECT CODIGO FROM NS.GRUPOSEMPRESARIAIS']::varchar[];

delete from financas.classificacoesfinanceiras
where grupoempresarial in (
	select grupoempresarial from ns.gruposempresariais 
	where codigo=any(grupo_nome)
);

delete from financas.rateiospadrao
where grupoempresarial in (
	select grupoempresarial from ns.gruposempresariais
	where codigo=any(grupo_nome)
);

delete from ns.configuracoes
where grupoempresarial in (
	select grupoempresarial from ns.gruposempresariais
	where codigo=any(grupo_nome)
);

delete from ns.gruposempresariais
where codigo=any(grupo_nome);

END; $$
