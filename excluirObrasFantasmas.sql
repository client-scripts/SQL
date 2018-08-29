/*Exclui as Obras Fantasmas que não possuem vínculo no Persona*/

do
$$
declare 
estab record;
ar_obras uuid[];

begin

  for estab in (select * from ns.estabelecimentos order by codigo)
  loop
    ar_obras = null;
    select array_agg(id_obra) FROM scritta.lanaju WHERE id_obra IN (SELECT id FROM ns.obras WHERE id_estabelecimento = estab.estabelecimento) into ar_obras;
    if ar_obras[1] is not null then
      raise notice 'Encontradas obras %',ar_obras;
      raise notice 'Apagando ajustes';
      DELETE FROM scritta.lanaju WHERE id_obra = any(ar_obras);
      raise notice 'Apagando obras';
      DELETE FROM ns.obras WHERE id = any(ar_obras); 
    end if;  
  end loop;
  raise notice 'Apagando obras sem vinculo com Persona.';
  delete from  ns.obras where 
  id not in (select obra from persona.codigossefipgpsobras group by obra) and
  id not in (select obra from persona.historicosgpsobrasestabelecimentos group by obra);

end;
$$;