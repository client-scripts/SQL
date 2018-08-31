/*Exclui as Obras Fantasmas que não possuem vínculo no Persona*/

do
$$
declare 
estab record;
ar_obras uuid[];
begin
--select * from ns.obras
for estab in (select * from ns.estabelecimentos order by codigo)
loop
  ar_obras = null;
  select array_agg(id_obra) FROM scritta.lanaju WHERE id_obra IN (SELECT id FROM ns.obras WHERE id_estabelecimento = estab.estabelecimento) into ar_obras;
  if ar_obras[1] is not null then
    raise notice 'Encontradas obras %',ar_obras;
    raise notice 'Apagando ajustes';
    DELETE FROM scritta.lanaju WHERE id_obra = any(ar_obras);
  end if;  
  --
  ar_obras = null;
  select array_agg(id_obra) FROM ns.df_itens WHERE id_obra IN (SELECT id FROM ns.obras WHERE id_estabelecimento = estab.estabelecimento) into ar_obras;
  if ar_obras[1] is not null then
    raise notice 'Encontradas obras itens %',ar_obras;
    raise notice 'Removendo vínculo itens.';
    update ns.df_itens set id_obra = null WHERE id_obra = any(ar_obras);
  end if;   
  --
  ar_obras = null;
  select array_agg(id_obra) FROM ns.df_servicos  WHERE id_obra IN (SELECT id FROM ns.obras WHERE id_estabelecimento = estab.estabelecimento) into ar_obras;
  if ar_obras[1] is not null then
    raise notice 'Encontradas obras itens serviços %',ar_obras;
    raise notice 'Removendo vínculo itens serviços.';
    update ns.df_servicos  set id_obra = null WHERE id_obra = any(ar_obras);
  end if;     
end loop;

raise notice 'Apagando obras sem vinculo com Persona.';
delete from  ns.obras where 
id not in (select obra from persona.codigossefipgpsobras group by obra) and
id not in (select obra from persona.historicosgpsobrasestabelecimentos group by obra) and
id not in (select obra from persona.lotacoes group by obra) and
id not in (select id_obra from ns.df_docfis group by id_obra);
end;
$$;

/*
  Versão 2 - Apaga tudo por código da obra
*/

do
$$
declare

nome_obras varchar[]; 

begin
  
  nome_obras = array['OBRAS AQUI']::varchar;

  delete from scritta.lanaju where id_obra in (
    select id from ns.obras where obra=any(nome_obras)
  );

  delete from ns.obras where obra=any(nome_obras);

end;
$$

