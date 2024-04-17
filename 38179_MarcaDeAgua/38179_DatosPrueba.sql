use circulemos2
select proce.nombre_proceso,dpl.nombre_plantilla,dpl.codigo_plantilla, COUNT(distinct(dd.id_documento)) cantidad
from  [documentos].[dbo].[documento] dd 
join [documentos].[dbo].[plantilla]   dpl on dpl.id_plantilla = dd.id_plantilla
join documentos.dbo.proceso proce on proce.id_proceso = dpl.id_proceso
where year(dd.fecha_creacion) = 2023
group by proce.nombre_proceso,dpl.nombre_plantilla,dpl.codigo_plantilla
order by proce.nombre_proceso, COUNT(1) desc