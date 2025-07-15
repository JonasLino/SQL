SELECT

/*PROJECT*/
LEFT(project.msdyn_projectid, 5) AS PROJECT_ID,

/*TASK*/
LEFT(task.msdyn_projecttaskid, 5) AS TASK_ID,
task.createdon TASK_DT_CRIACAO,
task.msdyn_duration TASK_DURACAO,
task.msdyn_effort TASK_ESFORCO,
task.msdyn_effortcompleted TASK_ESFORCO_CONCLUIDO,
task.msdyn_effortremaining TASK_ESFORCO_RESTANTE,

task.msdyn_progress TASK_PROGRESS,

task.msdyn_parenttaskname TASK_PAI,
task.msdyn_subject TASK,
task.msdyn_projectbucketname TASK_BUCKET,

task.msdyn_scheduledstart TASK_DT_INICIOPREVISTO,
task.msdyn_scheduledend TASK_DT_FIMPREVISTO,

task.msdyn_start TASK_DT_INICIO,
task.msdyn_finish TASK_DT_CONCLUSAO,

CASE 
    WHEN task.msdyn_priority = 1 THEN 'Urgente'
    WHEN task.msdyn_priority = 5 THEN 'Média'
    WHEN task.msdyn_priority = 9 THEN 'Baixa'
	WHEN task.msdyn_priority = 3 THEN 'Importante'
    ELSE NULL 
END AS TASK_PRIORIDADE,

CASE 
    WHEN task.msdyn_progress = 1 THEN 'Concluído'
    WHEN task.msdyn_progress = 0 THEN 'Não iniciado'
    WHEN task.msdyn_progress > 0 THEN 'Em andamento'
    ELSE NULL 
END AS TASK_PROGRESSO_TASK

/*ATRIBUIÇÃO*/

--atribuicao.msdyn_projectid ATRIBUICAO_PROJECT_ID,
--atribuicao.msdyn_taskid ATRIBUICAO_TASK_ID,
--atribuicao.msdyn_taskidname ATRIBUICAO_TASK,
--CASE WHEN atribuicao.msdyn_bookableresourceidname = 'Rodolfo Belo'								  THEN 'Rodolfo Belo'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Edeson Costa Azevedo'						  THEN 'Edeson Azevedo'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Maria Lohana Araujo Pitanga'				  THEN 'Lohana Pitanga'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Igor Meneses'								  THEN 'Igor Meneses'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Rafaela Ita Alves Batista'				  THEN 'Rafaela Ita'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Rafael de Queiroz Carvalho'				  THEN 'Rafael Queiroz'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Jose Eduardo Gonçalves Gois'				  THEN 'Eduardo Gonçalves'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'TONY SILVA'								  THEN 'Tony Silva'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Icaro Castelo Branco da Costa 1-2022123008' THEN 'Icaro Castelo'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Fernando Eryck da Costa e Silva'			  THEN 'Fernando Eryck'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Robson Mendes'							  THEN 'Robson Mendes'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Francisco Jonas Pereira Lino' THEN 'Jonas Lino'
--	 WHEN atribuicao.msdyn_bookableresourceidname = 'Brenda Rayana de Oliveira Facanha Freire' THEN 'Brenda Rayana' END AS ATRIBUICAO_TECNICO

FROM msdyn_project project

INNER JOIN msdyn_projecttask task
ON task.msdyn_project = project.msdyn_projectid

		--INNER JOIN msdyn_resourceassignment atribuicao
		--ON atribuicao.msdyn_taskid = task.msdyn_projecttaskid

WHERE 1=1
AND project.msdyn_subject LIKE 'Projeto -%'
AND task.msdyn_subject NOT IN (
        SELECT DISTINCT t2.msdyn_parenttaskname
        FROM msdyn_projecttask t2
        WHERE t2.msdyn_parenttaskname IS NOT NULL
    )