do $$
declare
	id_empresa uuid[];
begin
	id_empresa = array['COLOCAR UUID DAS EMPRESAS AQUI - SELECT OBRA, ID FROM NS.EMPRESAS']::uuid[];

	delete from persona.intervalosjornadas
	where jornada in (
		select jornada from persona.jornadas
		where empresa = any(id_empresa)
	);

	delete from persona.historicostrabalhadores
	where trabalhador in (
		select trabalhador from persona.trabalhadores
		where empresa = any(id_empresa)
	);

	delete from persona.afastamentostrabalhadores
	where trabalhador in (
		select trabalhador from persona.trabalhadores
		where empresa = any(id_empresa)
	);

	delete from persona.mudancastrabalhadores
	where trabalhador in (
		select trabalhador from persona.trabalhadores
		where empresa = any(id_empresa)
	);

	delete from persona.calculostrabalhadores
	where trabalhador in (
		select trabalhador from persona.trabalhadores
		where empresa = any(id_empresa)
	);

	delete from persona.trabalhadores
	where empresa = any(id_empresa);

	delete from persona.horarios
	where empresa = any(id_empresa);
	
	delete from persona.jornadas
	where empresa = any(id_empresa);

end
$$