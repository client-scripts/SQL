
/*
Script para exclusão das empresas do módulo Persona por uuid
coloque as chaves da empresa no array empresa_nome
*/

DO $$

DECLARE 
empresa_nome UUID[];
umaempresa UUID;

begin

select array_agg(empresa)::uuid[] into strict empresa_nome
from ns.empresas
where codigo in ('0011','0012','0013','0014','0016','0021','0022','0024','0025','0026','0027','0031','0036');

delete from persona.movimentos
where empresa= any(empresa_nome);

delete from persona.mudancastrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome));

--deletando todos detalhamentos de calculos trabalhadores 
delete  from persona.detalhamentoscalculostrabalhadores
where calculotrabalhador in (select calculotrabalhador from persona.calculostrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome)));

--deletando calculos trabalhadores
delete from persona.calculostrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome));

--deletando faltas trabalhadores
delete from persona.faltastrabalhadores
where trabalhador in (select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome));

--deletando afastamentos
delete from persona.afastamentostrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome));

--deletando avisos ferias
delete from persona.avisosferiastrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome));

--deletando outros recebimentos
delete from persona.outrosrecebimentostrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome));

--deletando historicos trabalhadores
delete from persona.historicostrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome));


--delete tarifas concessionarias
delete from persona.tarifasconcessionariasvtstrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome));

delete from persona.planosaudedependentesvaloresmensais where planosaudedependentetrabalhador in(select planosaudedependentetrabalhador from persona.planossaudedependentestrabalhadores
where dependentetrabalhador in( select dependentetrabalhador from persona.dependentestrabalhadores
where trabalhador  in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome))));    

delete from persona.planossaudedependentestrabalhadores 
where dependentetrabalhador in (select dependentetrabalhador from persona.dependentestrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome)));    

--deletar para dependentes 
delete from  persona.documentosdependentescolaboradores
where dependentetrabalhador in( select dependentetrabalhador from persona.dependentestrabalhadores
where trabalhador  in(select trabalhador from persona.trabalhadores where empresa = any(empresa_nome)));
raise notice '3';
--Delestando os dependentes
delete from persona.dependentestrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa= any(empresa_nome));

--deletando Intervalo Jornada
delete from persona.intervalosjornadas
where jornada in (select jornada from persona.jornadas
where empresa= any(empresa_nome));

--deletando movimentos de ponto
delete from persona.movimentosponto
where empresa= any(empresa_nome);

-- deletando reajuste trabalhadores
delete from persona.reajustestrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa = any(empresa_nome));

--DELETENADO AVISOS PREVIOS
delete FROM PERSONA.AVISOSPREVIOSTRABALHADORES
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa = any(empresa_nome));

--deletando reajuste sindicato
delete from persona.reajustessindicatos
where reajustesindicato not in(select reajustesindicato from persona.reajustestrabalhadores);

delete from persona.planossaudetrabalhadores 
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa = any(empresa_nome));

--deletando riscosambientestrabalhadores
delete from persona.riscosambientestrabalhadores where ambientetrabalhador in 
(select ambientetrabalhador from persona.ambientestrabalhadores 
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome)));

--deletando medicosambientestrabalhadores
delete from persona.medicosambientestrabalhadores where ambientetrabalhador in 
(select ambientetrabalhador from persona.ambientestrabalhadores 
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome)));

-- delete ambientestrabalhadores
delete from persona.ambientestrabalhadores 
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--deletar para excluir o aso
delete from persona.analisesbiologicastrabalhadores
where asotrabalhador in(select asotrabalhador 
from persona.asostrabalhadores 
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa = any(empresa_nome)));

delete from persona.examesasostrabalhadores
where asotrabalhador in(select asotrabalhador 
from persona.asostrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome)));

delete from persona.riscosocupacionaisasostrabalhadores
where asotrabalhador in(select asotrabalhador 
from persona.asostrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome)));

--delete asostrabalhadores
delete from persona.asostrabalhadores 
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

-- delete atividadestrabalhadores
delete from persona.atividadestrabalhadores 
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete calculosbeneficiostrabalhadores
--select * from persona.calculosbeneficiostrabalhadores 
delete from persona.calculosbeneficiostrabalhadores 
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa = any(empresa_nome));

--delete camposespeciaistrabalhadores
--select * from persona.camposespeciaistrabalhadores 
delete from persona.camposespeciaistrabalhadores 
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa = any(empresa_nome));

--delete para cattrabalhador 
delete from persona.testemunhascatstrabalhadores 
where cattrabalhador in(select cattrabalhador 
from persona.catstrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome)));

delete from persona.partesatingidascatstrabalhadores 
where cattrabalhador in(select cattrabalhador 
from persona.catstrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome)));

--delete catstrabalhadores
--select * from persona.catstrabalhadores 
delete from persona.catstrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete codigosexternostrabalhadores
--select * from persona.codigosexternostrabalhadores 
delete from persona.codigosexternostrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete consolidacao
--select * from persona.consolidacao 
delete from persona.consolidacao 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete darftrabalhadores
--select * from persona.darftrabalhadores 
delete from persona.darftrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete documentoscolaboradores
--select * from persona.documentoscolaboradores 
delete from persona.documentoscolaboradores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--deletando para emprestimostrabalhadores
delete from persona.parcelasemprestimostrabalhadores
where emprestimotrabalhador in(select emprestimotrabalhador from persona.emprestimostrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome)));

--delete emprestimostrabalhadores
--select * from persona.emprestimostrabalhadores 
delete from persona.emprestimostrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete escalasfolgastrabalhadores
--select * from persona.escalasfolgastrabalhadores 
delete from persona.escalasfolgastrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete examestoxicologicostrabalhadores
--select * from persona.examestoxicologicostrabalhadores 
delete from persona.examestoxicologicostrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete grcstrabalhadores
--select * from persona.grcstrabalhadores 
delete from persona.grcstrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete grrftrabalhadores
--select * from persona.grrftrabalhadores 
delete from persona.grrftrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete guiasprevidenciasocialempresastrabalhadores
--select * from persona.guiasprevidenciasocialempresastrabalhadores 
delete from persona.guiasprevidenciasocialempresastrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores where empresa = any(empresa_nome));

--delete guiasprevidenciasocialtrabalhadores
--select * from persona.guiasprevidenciasocialtrabalhadores 
delete from persona.guiasprevidenciasocialtrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores where empresa = any(empresa_nome));

--delete guiassefiptrabalhadores
--select * from persona.guiassefiptrabalhadores 
delete from persona.guiassefiptrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores where empresa = any(empresa_nome));


--delete pedidosbeneficiosalelosodexotrabalhador
--select * from persona.pedidosbeneficiosalelosodexotrabalhador 
delete from persona.pedidosbeneficiosalelosodexotrabalhador 
where trabalhador  in(select trabalhador from persona.trabalhadores where empresa = any(empresa_nome));

--delete pontotrabalhadores
--select * from persona.pontotrabalhadores 
delete from persona.pontotrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores where empresa = any(empresa_nome));
raise notice '8';
--delete provisoes13trabalhadores
--select * from persona.provisoes13trabalhadores 
delete from persona.provisoes13trabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores where empresa = any(empresa_nome));

--delete provisoesferiastrabalhadores
--select * from persona.provisoesferiastrabalhadores 
delete from persona.provisoesferiastrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores where empresa = any(empresa_nome));

--delete salariosliquidostrabalhadores
--select * from persona.salariosliquidostrabalhadores 
delete from persona.salariosliquidostrabalhadores 
where trabalhador  in(select trabalhador from persona.trabalhadores where empresa = any(empresa_nome));

delete from persona.valestransportespersonalizadostrabalhadores 
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--delete ponto.historicos
delete from ponto.historicos
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--deletando inconsistenciaspontotrabalhadores
delete from ponto.inconsistenciaspontotrabalhadores
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome));

--pagamentos lançamentos 
delete from ponto.pagamentoslancamentos
where lancamento in (select lancamento from ponto.lancamentos
where trabalhador in(select trabalhador from persona.trabalhadores 
where empresa = any(empresa_nome)));


delete from ponto.ajustes 
where marcacao in(select marcacao from ponto.marcacoes
where trabalhador in(select trabalhador from persona.trabalhadores
where empresa = any(empresa_nome)));

delete from ponto.marcacoes
where trabalhador in(select trabalhador 
from persona.trabalhadores 
where empresa = any(empresa_nome));

delete from ponto.lancamentos
where trabalhador in(select trabalhador 
from persona.trabalhadores 
where empresa = any(empresa_nome));

--deletando trabalhadores
delete from persona.trabalhadores
where empresa= any(empresa_nome);
raise notice '11';

-- deletando guiasprevidenciasocialdepartamentos
delete from persona.guiasprevidenciasocialdepartamentos
where departamento in (select departamento from persona.departamentos
where estabelecimento in (select estabelecimento from ns.estabelecimentos
where empresa= any(empresa_nome)));

--deletando departamentos
delete from persona.departamentos
where estabelecimento in (select estabelecimento from ns.estabelecimentos
where empresa= any(empresa_nome));

--deletando horarios
delete from persona.horarios
where empresa= any(empresa_nome);

--deletando jornadas
delete from persona.jornadas 
where empresa= any(empresa_nome);

--deletando nivel de cargo
delete from persona.niveiscargos
where cargo in(select cargo from persona.cargos
where empresa = any(empresa_nome));

--deletando relatorios
delete FROM PERSONA.RELATORIOSGRAVADOSEMPRESAS WHERE EMPRESA= any(empresa_nome);

--deletando cargos
delete from persona.cargos
where empresa= any(empresa_nome);

--deletando feriados
delete from ns.feriados
where estabelecimento in (select estabelecimento from ns.estabelecimentos
where empresa = any(empresa_nome));

delete from ns.feriados
where lotacao in (select lotacao from persona.lotacoes
where empresa = any(empresa_nome));

--deletando lotações
delete from persona.lotacoes
where empresa= any(empresa_nome);

--deletando gpsestabelecimentos
delete from persona.historicosgpsestabelecimentos
where estabelecimento in (select estabelecimento from ns.estabelecimentos
where empresa= any(empresa_nome));

-- deletando historicosgps

delete from persona.historicosgps
where empresa in (select empresa from ns.empresas
where empresa= any(empresa_nome));


--deletando apuração de ponto
delete FROM PONTO.APURACOESPONTO WHERE EMPRESA= any(empresa_nome);

delete from persona.rubricasponto 
where evento in(select evento  from persona.eventos
where empresa in(select empresa from ns.empresas where empresa = any(empresa_nome)));

delete from persona.planossauderubricas 
where rubrica in(select evento  from persona.eventos 
where empresa in(select empresa from ns.empresas 
where empresa = any(empresa_nome)));

delete from ns.valoresdefaultcontabilizacoes
where empresa = any(empresa_nome);

delete from persona.eventos
where empresa in(select empresa from ns.empresas 
where empresa = any(empresa_nome));

foreach umaempresa in array empresa_nome loop 
perform persona.rubricaspadroes(umaempresa);
end loop;

delete FROM persona.planossaude 
where empresa = any(empresa_nome);

delete from persona.tiposfuncionarios
where empresa = any(empresa_nome);

END; $$
