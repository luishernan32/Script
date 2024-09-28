
--1 Listado de los lotes relacionados errores corregidos
use circulemos2
select   rp.LOTE, COUNT(rs.id_consecutivo_reconstruccion) cantidad from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio = rp.numero_juicio
and rs.numero_oficio = rp.no_oficio
where rs.procesado = 1
and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-08-01') 
group by rp.LOTE


--2 Sentencias para Gestion de Archivo

declare @s1 varchar(100), @s2 varchar(100), @s3 varchar(100), @s4 varchar(100), @lote varchar(100)
set @s1= 'sudo cp /opt/artefactos/reconstr/'
set @s2= '/PDF_1/'
set @s3= '/PDF_2/'
set @s4= '/PDF_3/'
set @lote ='Lote001' 



IF OBJECT_ID('tempdb..#CommandShell2') is not null  
 DROP TABLE #CommandShell2

select @s1 + book + @s2 +documento_1+' '+path_documento_1  +' 2>> errores.txt' sentencia, book
into #CommandShell2
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio = rp.numero_juicio
and rs.numero_oficio = rp.no_oficio
where rs.procesado = 1
and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-08-01') 
and rp.LOTE = @lote
union all
select @s1 + book + @s3 +documento_2+' '+path_documento_2  +' 2>> errores.txt' sentencia, book
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio = rp.numero_juicio
and rs.numero_oficio = rp.no_oficio
where rs.procesado = 1
and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-08-01') 
and rp.LOTE = @lote
union all
select @s1 + book + @s4 +documento_3+' '+path_documento_3  +' 2>> errores.txt' sentencia, book
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio = rp.numero_juicio
and rs.numero_oficio = rp.no_oficio
where rs.procesado = 1
and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-08-01') 
and rp.LOTE = @lote


select COUNT( rs.id_consecutivo_reconstruccion )*3 cantidad
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio = rp.numero_juicio
and rs.numero_oficio = rp.no_oficio
where rs.procesado = 1
and convert(date,rs.fecha_procesamiento) >= convert(date, '2024-08-01') 
and rp.LOTE = @lote

select sentencia from #CommandShell2


