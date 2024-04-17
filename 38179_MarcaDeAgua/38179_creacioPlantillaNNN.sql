SELECT sdv.* FROM subsanacion_devolucion_valores  sdv
LEFT JOIN trazabilidad_proceso tp ON sdv.id_trazabilidad_proceso= tp.id_trazabilidad_proceso
LEFT JOIN proceso p ON tp.id_proceso=p.id_proceso
WHERE tp.id_estado_proceso = 74
AND tp.fecha_fin is null AND p.id_tipo_proceso =13
--AND GETDATE() > sdv.fecha_fin
order by 1 desc
 
begin tran
update circulemos2.dbo.subsanacion_devolucion_valores
set fecha_fin = convert(date,'2023-12-29')
where id_subsanacion_devolucion_valores =3
commit tran