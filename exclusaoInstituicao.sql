/*
	Script para exclusão das instituições por uuid das mesmas
*/

DO $$
DECLARE 
varinstituicoes UUID[];
vareventos UUID[];
varplanossaude UUID[];

begin

varinstituicoes = array['fc36a29d-a1f7-4cdb-bbcb-c1b84cb64ae5']::uuid[];
vareventos := array(select evento::uuid from persona.eventos where instituicao = any(varinstituicoes));
varplanossaude := array(select planosaude::uuid from persona.planossaude where instituicao = any(varinstituicoes));

delete from persona.calculostrabalhadores
where instituicao = any(varinstituicoes);

delete from persona.planossauderubricas
where rubrica = any(vareventos);

delete from persona.calculostrabalhadores
where evento = any(vareventos);

delete from persona.movimentos
where evento = any(vareventos);

delete from persona.eventos
where instituicao = any(varinstituicoes);

delete from persona.movimentos
where instituicao = any(varinstituicoes);

delete from persona.planossaudedependentestrabalhadores
where planosaudetrabalhador in (
	select planosaudetrabalhador from persona.planossaudetrabalhadores
	where planosaude = any(varplanossaude)
);

delete from persona.planossaudetrabalhadores
where planosaude = any(varplanossaude);

delete from persona.planossaude
where instituicao = any(varinstituicoes);

update persona.trabalhadores
set instituicaoensino = null
where instituicaoensino = any(varinstituicoes);

delete from persona.instituicoes
where instituicao = any(varinstituicoes);

end; 
$$
