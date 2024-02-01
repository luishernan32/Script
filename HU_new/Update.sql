select pr.* , tp.fecha_inicio from circulemos2.dbo.proceso pr
inner join circulemos2.dbo.trazabilidad_proceso tp on pr.id_proceso =tp.id_proceso and tp.id_estado_proceso = 13
where pr.id_tipo_proceso = 1
and YEAR(pr.fecha_inicio)>=2023
and pr.id_estado_proceso= 13
order by tp.id_trazabilidad_proceso desc

select *from proceso
where --id_estado_proceso='13' and 
numero_proceso='56'



begin tran
update proceso set id_estado_proceso='13'
where id_proceso='2828472'
commit tran

select *from proceso
where id_proceso='2828472'

begin tran
update documentos..plantilla set fecha_fin='2023-06-21' where id_plantilla=2532
update documentos..plantilla set fecha_inicio='2023-06-22' where id_plantilla=2550
commit tran


--13 estado solitud de pruebas
--where id proceso


select *from estado_proceso

select *from acta_resorteo