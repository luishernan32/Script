
--PDF 3
declare @lote varchar(100)
set @lote='Lote21_Retencion_Actualizacion_Medida'
select rp.*,rs.book, rs.id_consecutivo_reconstruccion
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio=rp.numero_juicio
and rs.numero_oficio=rp.no_Oficio
where rs.procesado=1
and convert(date,rs.fecha_procesamiento)>=convert(date,'2024-08-01')
and rp.LOTE='Lote21_Retencion_Actualizacion_Medida'
and rs.documento_3 in(
'864448-19817-2023-3.pdf'
)





