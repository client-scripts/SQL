/*
	Exclui as Obras Fantasmas que não possuem vínculo no Persona
	Testado na versão 12235.18
*/

do $$
declare
	id_obras uuid[];
begin
	id_obras = array['COLOCAR UUID DAS OBRAS AQUI - SELECT OBRA, ID FROM NS.OBRAS']::uuid[];

	delete from scritta.lanaju
	where id_obra = any(id_obras);

	delete from financas.titulos	
	where id_gps in (
		select id from scritta.grec_gps
		where id_obra = any(id_obras)
	);

	delete from scritta.grec_gps
	where id_obra = any(id_obras);

	delete from estoque.itens_mov
	where id_itemdocfis in (
		select id from ns.df_itens
		where id_docfis in (
			select id from ns.df_docfis
			where id_obra = any(id_obras)
		)
	);

	delete from ns.df_itens
	where id_docfis in (
		select id from ns.df_docfis
		where id_obra = any(id_obras)
	);


	delete from ns.df_servicos 
	where id_docfis in (
		select id from ns.df_docfis
		where id_obra = any(id_obras)
	);

	delete from ns.df_docfis
	where id_obra = any(id_obras);

	delete from ns.obras
	where id = any(id_obras);
end
$$
