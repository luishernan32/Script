--PDF_1
declare @lote varchar(100)
set @lote='Lote21_Retencion_Actualizacion_Medida'
select rp.*,rs.book, rs.id_consecutivo_reconstruccion
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio=rp.numero_juicio
and rs.numero_oficio=rp.no_Oficio
where rs.procesado=1
and convert(date,rs.fecha_procesamiento)>=convert(date,'2024-08-01')
and rp.LOTE='Lote21_Retencion_Actualizacion_Medida'
and rs.documento_1 in('865147-30184-2022-1.pdf')



--PDF 1
declare @lote varchar(100)
set @lote='Lote22_Retencion_Actualizacion_Medida'
select rp.*,rs.book, rs.id_consecutivo_reconstruccion
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio=rp.numero_juicio
and rs.numero_oficio=rp.no_Oficio
where rs.procesado=1
and convert(date,rs.fecha_procesamiento)>=convert(date,'2024-08-01')
and rp.LOTE='Lote22_Retencion_Actualizacion_Medida'
and rs.documento_1 in('865147-30184-2022-1.pdf')


--PDF 2
declare @lote varchar(100)
set @lote='Lote22_Retencion_Actualizacion_Medida'
select rp.*,rs.book, rs.id_consecutivo_reconstruccion
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio=rp.numero_juicio
and rs.numero_oficio=rp.no_Oficio
where rs.procesado=1
and convert(date,rs.fecha_procesamiento)>=convert(date,'2024-08-01')
and rp.LOTE='Lote22_Retencion_Actualizacion_Medida'
and rs.documento_2 in('865147-30184-2022-2.pdf')




select *from integracion_terceros.dbo.reconstr_sol_bienes_pre rs
where rs.Documento_solicitud in('865147-30184-2022-1.pdf')