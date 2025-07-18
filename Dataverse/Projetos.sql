SELECT

/*PROJECT*/

project.createdon PROJECT_DT_CRIACAO,
LEFT(project.msdyn_projectid, 5) AS PROJECT_ID,
project.msdyn_subject PROJECT_PROJETO,

CONCAT(CAST(project.msdyn_duration AS INT), ' dias') AS PROJECT_DURACAO,
CONCAT(CAST(project.msdyn_effort AS INT), ' horas') PROJECT_ESFORCO,
CONCAT(CAST(project.msdyn_effortcompleted AS INT), ' horas') PROJECT_ESFORCO_CONCLUIDO,
CONCAT(CAST(project.msdyn_effortremaining AS INT), ' horas') PROJECT_ESFORCO_RESTANTE,

project.msdyn_scheduledstart PROJECT_DT_INICIOPREVISTO,
project.msdyn_taskearlieststart PROJECT_DT_INICIO,
project.msdyn_finish PROJECT_DT_CONCLUSAO,
project.msdyn_progress [PROJECT_%_CONCLUÍDO],

CASE 
    WHEN project.msdyn_progress = 1 THEN 'Concluído'
    WHEN project.msdyn_progress = 0 THEN 'Não iniciado'
    WHEN project.msdyn_progress > 0 THEN 'Em andamento'
    ELSE NULL 
END AS PROJECT_PROGRESSO

FROM msdyn_project project

WHERE 1=1
AND project.msdyn_subject LIKE 'Projeto -%'
