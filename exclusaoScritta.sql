/*
	Script para exclusão das empresas do módulo Scritta por uuid
	coloque as chaves da empresa no array empresa_nome
	Testado com sucesso na 12235.13
*/

DO $$


DECLARE 
empresa_nome UUID[];


begin

empresa_nome = array['COLOCAR UUID DAS EMPRESAS AQUI - SELECT EMPRESA FROM NS.EMPRESAS']::uuid[];


delete from estoque.itens_mov where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos
where empresa= any(empresa_nome));

delete from scritta.od_outdoc where id_gruout IN(Select id from scritta.od_gruout where id_empresa=any(empresa_nome));

delete from scritta.od_gruout where id_empresa=any(empresa_nome);

delete from scritta.sn_cfg where id_empresa=any(empresa_nome);

delete from scritta.sped_planocontas where id_empresa=any(empresa_nome);

delete from scritta.sped_custo where id_empresa=any(empresa_nome);

delete from scritta.sped_defcontas where id_empresa=any(empresa_nome);

delete from ns.bens where estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from financas.titulosreceberporvendedores where tituloreceber IN (Select id from financas.titulos where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome)));

delete from financas.baixas where id_titulo IN (Select id from financas.titulos where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome)));

delete from financas.itenschequespagamentos where id_titulo IN (Select id from financas.titulos where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome)));

delete from financas.titulos where id_estabelecimento IN (select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from estoque.itens_mov where id_docfis IN (Select id from ns.df_docfis where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome)));

delete from estoque.itens_mov where id_itemdocfis in (select id from ns.df_itens where id_docfis IN (Select id from ns.df_docfis where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome))));

delete from ns.df_itens where id_docfis IN (Select id from ns.df_docfis where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome)));

delete from ns.df_servicos where id_docfis IN (Select id from ns.df_docfis where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome)));

delete from scritta.grec_gnre where id_docfis IN (Select id from ns.df_docfis where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome)));

delete from ns.df_docfis where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from scritta.df_sertra where id_docfis IN (Select id from ns.df_docfis where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome)));

delete from scritta.lanaju where id_docfis IN (Select id from ns.df_docfis where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome)));

delete from contabilizacao.lancamentoscontabeis where estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from scritta.grec_gnre where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos
where empresa= any(empresa_nome));

delete from estoque.itens_mov where localdeestoque IN (Select localdeestoque from estoque.locaisdeestoques where estabelecimento IN ( Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome)));

delete from scritta.saldocredor where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from scritta.grec_resumo where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from scritta.grec_darf where imposto != 32 and documento not like 'DARF %' and id_empresa=any(empresa_nome);

delete from scritta.pendencias where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from contabilizacao.pendencias where estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from contabilizacao.lotes where estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from scritta.lanaju where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from scritta.grec_icms_iss where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from scritta.grec_cfg where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));

delete from scritta.uniprofissionais where id_estabelecimento IN (Select estabelecimento from ns.estabelecimentos where empresa=any(empresa_nome));	

delete from scritta.lf_lanfis where id_estabelecimento in (select estabelecimento from ns.estabelecimentos where empresa in (select empresa from ns.empresas where empresa=any(empresa_nome)));

END; $$
