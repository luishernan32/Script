
select *from solicitud_pruebas_back 
select *from impulso_pruebas
select *from prueba
select *from trazabilidad_proceso
select *from proceso
-----------------------------------------------------------------------
select 
s.id_solicitud_pruebas_back,
p.numero_proceso,

pr.nombre_archivo,
pr.fecha_prueba,
pr.fecha_carga

from solicitud_pruebas_back s
inner join impulso_pruebas ipr
on ipr.id_solicitud_pruebas_back=s.id_solicitud_pruebas_back
inner join prueba pr
on pr.id_solicitud_pruebas_back=s.id_solicitud_pruebas_back
inner join trazabilidad_proceso tp
on tp.id_trazabilidad_proceso=s.id_trazabilidad_proceso
inner join proceso p
on p.id_proceso=tp.id_proceso
where 1=1
and s.id_solicitud_pruebas_back is not null
--10075
--3478
-----------------------------------------------------------------------
select 
s.id_solicitud_pruebas_back,
s.fecha_solicitud,
p.numero_proceso,

pr.nombre_archivo,
pr.fecha_prueba,
pr.fecha_carga

from solicitud_pruebas_back s
 LEFT join impulso_pruebas ipr
on ipr.id_solicitud_pruebas_back=s.id_solicitud_pruebas_back
LEFT  join prueba pr
on pr.id_solicitud_pruebas_back=s.id_solicitud_pruebas_back
 join trazabilidad_proceso tp
on tp.id_trazabilidad_proceso=s.id_trazabilidad_proceso
 join proceso p
on p.id_proceso=tp.id_proceso
where p.numero_proceso='10075'
--where 1=1
--and s.id_solicitud_pruebas_back is not null
--10075
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------

select *from usuario_persona


id_trazabilidad_proceso	id_proceso	id_estado_proceso	fecha_inicio	fecha_fin	id_usuario	id_sede_proceso	id_sede_usuario
13	9	15	2016-09-03 15:12:43.3490000	2016-09-06 07:16:30.1700000	3	NULL	NULL

  jpql.append("SELECT DISTINCT s FROM SolicitudPruebasBack s ");
            jpql.append("LEFT JOIN s.impulsoPruebas ip ");
            jpql.append("LEFT JOIN s.pruebas pru ");
            jpql.append("JOIN s.trazabilidadProceso tp ");
            jpql.append("JOIN tp.proceso p ");
            jpql.append("WHERE 1=1 ");

-----------------------------------------

SELECT  *FROM Prueba p
 LEFT JOIN FETCH solicitudPruebasBack spb
 on spb.
 LEFT JOIN FETCH apelacion a
 LEFT JOIN FETCH pruebasAportadas pa
LEFT JOIN FETCH impugnacion i
 LEFT JOIN FETCH p.usuario u
 WHERE i.id = :idImpugnacion


SELECT p FROM Prueba p
 LEFT JOIN FETCH p.solicitudPruebasBack spb
 LEFT JOIN FETCH p.apelacion a
 LEFT JOIN FETCH p.pruebasAportadas pa
LEFT JOIN FETCH p.impugnacion i
 LEFT JOIN FETCH p.usuario u
 WHERE i.id = :idImpugnacion



 jpql.append("SELECT p FROM Prueba p");
        jpql.append(" LEFT JOIN FETCH p.solicitudPruebasBack spb");
        jpql.append(" LEFT JOIN FETCH p.apelacion a");
        jpql.append(" LEFT JOIN FETCH p.pruebasAportadas pa");
        jpql.append(" LEFT JOIN FETCH p.impugnacion i");
        jpql.append(" LEFT JOIN FETCH p.usuario u");
        jpql.append(" WHERE i.id = :idImpugnacion");