/*
	Script para exclusão das instituições por uuid das mesmas
*/

DO $$
DECLARE 
varinstituicoes UUID[];
vareventos UUID[];
varplanossaude UUID[];

begin

varinstituicoes = array[
'2c94214e-b83c-4156-a643-66ca00e03be8',
'e1f4d26a-0687-43d4-80fa-a3488c2989a4',
'111a8a11-6db2-4be1-aed4-6e504901ffb4',
'2b55c3e1-80f5-41c5-b6c2-030edf60152c',
'bd293eb4-fdb8-4dcf-ae11-e5ba88e3b8ef',
'de3ad1e4-2b55-4e7d-aeeb-040397b95402',
'6258e53e-5343-467b-ae0d-2a899bc7bdc8',
'c56642a5-3444-4407-a0a1-b9055159d864',
'c5161038-ff36-4e5e-a070-46aba2ea8cca',
'ad6ee185-2b62-4a23-a5b2-7e273969bc29',
'3bdccc0d-41ba-40d1-92ef-f789a170018c',
'86e0c9af-f342-4f17-a6b2-794dcf20c24d',
'eb3ffc06-e0fc-4a29-92bc-238347ceb0a9',
'745b64c3-a44d-4995-bf65-61e48916208f',
'3a74e9f4-169a-4356-bcbf-aac8c6d383a9',
'561d648c-2c67-4088-bb28-bd64d52e5fb5',
'3fb7b626-96d9-467d-aa14-47e9096fe4bf',
'fe87ed82-5cde-47b0-aca0-cdb252171c5e',
'33d7c883-2d9b-4bd1-904b-6a31bd898d43',
'80e601c5-ed89-4ddb-a8f9-844a453531b4',
'f227b890-663b-483d-aa12-47f2b05e3bd0',
'2de6ff86-4abe-4171-a41a-bc2e05df30f2',
'83b1bc17-d5c1-43cc-8666-22c6dd208e9f',
'4cf977f1-1d1b-4333-b7fe-0e4836e26a82',
'fb795ac2-4104-4301-b11e-384263371ec6',
'bb281dab-baf5-4b10-9f80-59860b4c8ae8',
'd2348573-dab2-4549-a6e5-a34564bb2f5a',
'0546e731-c189-4fae-9165-28eaada365f7',
'c45bbdc7-185f-4fce-adde-b06e64716fa8',
'e7ffe106-29b4-468e-9068-b1baa1f94969',
'16c498e1-39ae-4a44-8625-c6ad2c7522ef',
'754818b5-8021-4ab3-9a14-7ee63f7a9b6d',
'4e00517d-39c4-41e7-991e-229b9556557f',
'de89fc1d-0b31-47c5-826d-4948b56b0265',
'55e8961e-7bc2-496a-a479-c240fc8288a1',
'd5fea4ca-b5e3-4a2e-9b17-4fb8ffe82647',
'86a5a7bd-501b-4e13-a8b8-e548598e19f0',
'f281dbfc-6f62-4be0-96eb-189b00dadc2d',
'102e4809-06e5-4f77-8a3b-471c8c9c8559',
'2f1e0f07-c23c-47c5-941b-f94137921369',
'041685b3-4a38-406b-a9c0-ff7f76ffa50c',
'392ee790-87ce-49d4-b14f-28c4b77b9b0c',
'cd1abac0-16fd-4b72-9e94-cee032fcb669',
'437fa1b4-fdd6-41a0-9b1e-d4d7ce137fc2',
'60c686d2-a957-4f17-ad81-cda20cf876cf',
'c844a1d6-bd3d-4f33-806a-6ed7b11db3ef',
'5f9693aa-cbd9-404e-b3bc-5ff483287ee1',
'3afdf368-ac81-4f7d-8b4b-248bdf318208',
'9f8c51b7-c099-493d-b88a-e29e11beefe3',
'4fb03f72-7646-48b6-8997-ea69c7be1868',
'75c3d77d-f9a7-40e9-a9de-811309d1f297',
'855a788f-06f8-4287-a08b-e0434a45fc59',
'd4f76b65-7e80-4df1-bd0b-c75dc32fbdeb',
'32f98a67-0997-4930-9051-ca5a0f85a723',
'304eb18a-fb6f-4a41-ab10-041ec0274d18',
'9652842f-690e-4e59-9553-84ff5347c488',
'7d643ed5-59f7-4b43-8343-ab6cebec11f0',
'c854a6c2-e96b-4b75-b7ec-5ab8eac7b27c',
'fbf1236f-74ec-49a1-afae-e4d18fb40062',
'5d1ac1b1-c76b-480b-afea-5943d9c91edf',
'9f2fb18a-3016-4799-a968-21ae879c77c6',
'82367704-3c36-4d0a-8218-7df655b8beee',
'ac778070-b6a3-4efc-b7f9-8e00b5b9a54f',
'15ddcdda-e911-40cf-84fc-e048747130fb',
'c1fd3ed3-fc17-4061-8719-d7d2a2396180',
'f70af9d9-d22e-48d0-a607-b97cebfbfc08'
]::uuid[];
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

update persona.trabalhadores
set instituicaointegradora = null
where instituicaointegradora = any(varinstituicoes);

delete from persona.instituicoes
where instituicao = any(varinstituicoes);

end; 
$$
