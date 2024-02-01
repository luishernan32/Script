select * from trazabilidad_error_financiacion_incumplida where numero_de_convenio='505166' --and estado='1'
order by 1 desc
 --114032
update trazabilidad_error_financiacion_incumplida set estado=0 where id_trazabilidad_error_financiacion_incumplida=114099


select *from job
where nombre='JobConveniosIncumplidos'


select *from trigger_job
where id_job='41'

select *from trazabilidad_condonacion
where numero_financiacion='505166'

--7443765
--7443765 valor numeroObligacion en la depuracion
--11132512 numeroDeObligacion=numeroCoactivo

--1673992
--[7443765, 1003400]

--[11132512, 1673992]

--11132512

--[10977519, 7329249, 7421780, 7598224, 7610066, 7851118, 8335901, 8539404, 8558341, 8566616, 8677616, 9063865] Los que arroja la depuracion
--[11132512,7443765,7540780,7733571,7746893,9567108,9650077,9689139,9690996,9691890,9713617,9623496]
--11132512


--[11132512,7443765,7540780,7733571,7746893,9567108,9650077,9689139,9690996,9691890,9713617,9623496]

--[7443765,7540780,7733571,9690996,9691890,7443765,7540780,7733571,9690996,9691890,7443765,7540780,7733571,9690996,9691890,7443765,7540780,7733571,9690996,9691890]trazabilidadCondonacionDTO



SELECT oc.numeroObligacion, c.numeroCoactivo , c.id  
 FROM obligacion_coactivo oc


 SELECT numero_obligacion, numeroCoactivo , id  
 FROM obligacion_coactivo oc

select *from obligacion_coactivo
select *from coactivo
select *from proceso

SELECT oc.numero_obligacion, c.numero_coactivo 
FROM obligacion_coactivo oc
JOIN coactivo c on c.id_coactivo=oc.id_coactivo
JOIN proceso p on p.id_proceso=c.id_proceso
WHERE oc.numero_obligacion in('10977519', '7329249', '7421780', '7598224', '7610066', '7851118', '8335901', '8539404', '8558341', '8566616', '8677616', '9063865')
--WHERE oc.numero_obligacion='7421780'

AND oc.codigo_tipo_obligacion='1'
and p.id_estado_proceso='31'

--[11132512, 1673992] No corresponde
--[7443765, 1003400] Si corresponde
--tipoObligacion=1
--estadoProceso 31