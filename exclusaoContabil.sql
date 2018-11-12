/*
	Script não testado
*/

DO $$


DECLARE 
empresa_nome UUID[];


begin

empresa_nome = array[/*'INSIRA O GUIDE AQUI'*/]::uuid[];

delete from ns.bens where estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from contabil.lancamentos where estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from contabil.loteslancamentos where estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from contabil.centrosdecustoanuais where centrodecusto IN (Select centrodecusto from contabil.centrosdecusto where empresa=any(empresa_nome));

delete from contabil.centrosdecusto where empresa=any(empresa_nome);

delete from contabil.signatarios where estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from contabil.classificacaocontas where empresa=any(empresa_nome);

delete from contabil.extratosbancarios where estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from contabil.contasanuais where conta in (
	select conta from contabil.contas where empresa=any(empresa_nome)
);

delete from contabil.lancamentospadrao where empresa=any(empresa_nome);

delete from contabil.contas where empresa=any(empresa_nome);

delete from contabil.contasreferenciais where mae IN (Select contamae from contabil.contas where empresa=any(empresa_nome));

END; $$
