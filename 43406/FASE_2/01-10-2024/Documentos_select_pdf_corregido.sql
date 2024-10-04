--select top 1 *from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos  --tabla #2
--select top 1 *from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes


--1 Listado de los lotes relacionados errores corregidos
use circulemos2
select   rp.LOTE, COUNT(rs.id_reconstruccion) cantidad from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos rs
inner join integracion_terceros.dbo.reconstr_solicitud_bienes_doc_pre rp on rs.numero_juicio = rp.numero_juicio
and rs.numero_oficio = rp.[No# Oficio]
where rs.procesado = 1
and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-09-01') 
--and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-09-25') 
group by rp.LOTE


--select top 1 * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos 

--480191
--2 Sentencias para Gestion de Archivo

declare @s1 varchar(100), @s2 varchar(100), @s3 varchar(100), @s4 varchar(100), @lote varchar(100)
set @s1= 'sudo cp /opt/artefactos/reconstr/'
set @s2= '/PDF_1/'
set @s3= '/PDF_2/'
set @s4= '/PDF_3/'
set @lote ='Lote18' 



IF OBJECT_ID('tempdb..#CommandShell2') is not null  
 DROP TABLE #CommandShell2

select @s1 + book + @s2 +documento_solicitud+' '+path_documento_solicitud  +' 2>> errores.txt' sentencia, book
into #CommandShell2
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos rs
inner join integracion_terceros.dbo.reconstr_solicitud_bienes_doc_pre rp on rs.numero_juicio = rp.numero_juicio
and rs.numero_oficio = rp.[No# Oficio]
where rs.procesado = 1
and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-09-01') 
and rp.LOTE = @lote
union all
select @s1 + book + @s3 +documento_oficio+' '+path_documento_oficio  +' 2>> errores.txt' sentencia, book
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos rs
inner join integracion_terceros.dbo.reconstr_solicitud_bienes_doc_pre rp on rs.numero_juicio = rp.numero_juicio
and rs.numero_oficio = rp.[No# Oficio]
where rs.procesado = 1
and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-09-01') 
and rp.LOTE = @lote
union all
select @s1 + book + @s4 +documento_sentar_razon+' '+path_documento_sentar_razon  +' 2>> errores.txt' sentencia, book
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos rs
inner join integracion_terceros.dbo.reconstr_solicitud_bienes_doc_pre rp on rs.numero_juicio = rp.numero_juicio
and rs.numero_oficio = rp.[No# Oficio]
where rs.procesado = 1
and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-09-01') 
and rp.LOTE = @lote


select COUNT( rs.id_reconstruccion )*3 cantidad
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos rs
inner join integracion_terceros.dbo.reconstr_solicitud_bienes_doc_pre rp on rs.numero_juicio = rp.numero_juicio
and rs.numero_oficio = rp.[No# Oficio]
where rs.procesado = 1
and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-09-01') 
and rp.LOTE = @lote

select sentencia from #CommandShell2
