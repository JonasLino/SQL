SELECT

/*PROJECT*/
LEFT(project.msdyn_projectid, 5) AS PROJECT_ID,
project.msdyn_subject,
/*TASK*/
LEFT(task.msdyn_projecttaskid, 5) AS TASK_ID,
task.createdon TASK_DT_CRIACAO,

CONCAT(CAST(task.msdyn_duration AS INT), ' dias') AS  TASK_DURACAO,
CONCAT(CAST(task.msdyn_effort AS INT), ' horas')  TASK_ESFORCO,
CONCAT(CAST(task.msdyn_effortcompleted AS INT), ' horas')  TASK_ESFORCO_CONCLUIDO,
CONCAT(CAST(task.msdyn_effortremaining AS INT), ' horas')  TASK_ESFORCO_RESTANTE,

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

FROM msdyn_project project

INNER JOIN msdyn_projecttask task
ON task.msdyn_project = project.msdyn_projectid

WHERE 1=1
AND project.msdyn_subject LIKE 'Projeto -%'
AND task.msdyn_subject NOT IN (
        SELECT DISTINCT t2.msdyn_parenttaskname
        FROM msdyn_projecttask t2
        WHERE t2.msdyn_parenttaskname IS NOT NULL
    )
