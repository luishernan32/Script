select *from parametro

begin tran
update  parametro
set valor_parametro_defecto='1'
where codigo_parametro=233
commit tran

select *from job
where nombre='JobAbrirProcesoCoactivoObligaciones'

select *from trigger_job
where id_job='18'

select top 10 *from log_job
where nombre_job ='co.com.datatools.datatimer.c2.jobs.JobAbrirProcesoCoactivoObligaciones'
order by 1 desc

select 
