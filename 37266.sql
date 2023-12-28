StringBuilder jpql = new StringBuilder();
                jpql.append("SELECT c FROM Comparendo c");
                jpql.append(" INNER JOIN FETCH c.medioImposicion mi");
                jpql.append(" INNER JOIN FETCH c.direccion dir");
                jpql.append(" INNER JOIN FETCH c.estadoComparendo e");
                jpql.append(" INNER JOIN FETCH c.infraccion i");
                jpql.append(" INNER JOIN FETCH c.personaList cper");
                jpql.append(" INNER JOIN FETCH cper.persona per");
                jpql.append(" LEFT JOIN FETCH c.comparendoVehiculo as cv");

-------------------------------------------------------------
SELECT c FROM Comparendo c
INNER JOIN FETCH c.medioImposicion mi
INNER JOIN FETCH c.direccion dir
INNER JOIN FETCH c.estadoComparendo e

INNER JOIN FETCH c.infraccion 
INNER JOIN FETCH c.personaList cper
INNER JOIN FETCH cper.persona per
LEFT JOIN FETCH c.comparendoVehiculo as cv


USE circulemos2

SELECT c.id_factura_axis,
c.cicomparendo
FROM Comparendo c
INNER JOIN  medio_imposicion_comparendo mic  on c.codigo_medio_imposicion = mic.codigo_medio_imposicion
INNER JOIN direccion dir on c.id_direccion_comparendo=dir.id_direccion
INNER JOIN estado_comparendo ec on ec.id_estado_comparendo=c.id_estado_comparendo
INNER JOIN infraccion i on i.id_infraccion=c.id_infraccion
INNER JOIN comparendo_persona cp on cp.id_direccion=dir.id_direccion  -- personaList=comparendo_persona
INNER JOIN persona p on c.id_usuario=p.id_persona
INNER JOIN comparendo_vehiculo cv on ec.id_estado_comparendo=cv.id_comparendo_vehiculo
-----------------------------------------------------------------------------
INNER JOIN configuracion_infraccion ci on ci.id_infraccion=i.id_infraccion
INNER JOIN comparendo_cartera ccar on c.id_estado_comparendo=ccar.id_comparendo_cartera
-----------------------------------------------------------------------------

where c.cicomparendo is not null
--and p.numero_identificacion='0922905120'
--and c.fecha_notificacion is not null  --Multas sin notificar
--and ec.id_estado_comparendo in(1,1)
--and not exists(select *from proceso pro
--where pro.id_proceso in(select *from comparendo_proceso cpro where cpro.cicomparendo is not null) and pro.fecha_fin is null)
--and exists(select *from cartera car where car.saldo_capital>0 and car.id_cartera=ccar.id_cartera)
--and exists(select *from cartera car where car.codigo_estado_obligacion=2 and car.id_cartera is not null)
--and ci.fecha_inicio_vigencia is not null and (ci.fecha_fin_vigencia is null or ci.fecha_fin_vigencia is not null)
--and ci.aplica_descuento=1
--and not exists(select *from curso cur where cur.id_estado_curso is not null and cur.id_persona=p.id_persona
--and cur.fecha_registro is not null and cur.fecha_registro <=GETDATE())
and c.fecha_infraccion is not null 
--and not exists(select *from curso rcur where  rcur.id_infraccion is not null and rcur.id_persona=p.id_persona and rcur.id_estado_curso not in())--Estados excluidos de los cursos
















select *from comparendo_cartera


select *from configuracion_infraccion


select *from estado_comparendo

select *from direccion

select *from persona
select *from infraccion

select *from comparendo_vehiculo