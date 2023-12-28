[09:23] Nicolas Montañez Rozo
select top 10000 pe.numero_identificacion, numero_coactivo, numero_obligacion, co.fecha_notificacion,c.id_tramite, op.nombre, co.codigo_medio_imposicion, * from proceso p

--inner join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso and tp.id_estado_proceso=38

inner join coactivo c on p.id_proceso=c.id_proceso

inner join obligacion_coactivo oc on c.id_coactivo=oc.id_coactivo

inner join persona pe on c.id_deudor=pe.id_persona

inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion

inner join configuracion_infraccion ci on co.id_infraccion=ci.id_infraccion

inner join ordenamiento_pais op on ci.id_ordenamiento_pais=op.id_ordenamiento_pais

--inner join cartera ca on ca.nombre=co.id_factura_axis

where p.id_estado_proceso in(29) and anio=2021

--and ci.id_ordenamiento_pais=2

and c.id_tipo_coactivo=1

and c.cantidad_obligaciones=1

--and c.fecha_notificacion is null

--and oc.valor_interes_moratorios>0

--and oc.valor_costas_procesales>0

and ci.fecha_fin_vigencia is null

--and exists (select * from obligacion_coactivo_historico och where och.id_obligacion_coactivo=oc.id_obligacion_coactivo)

and not exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = p.id_proceso and tp.id_estado_proceso = 36)

order by p.fecha_inicio desc
[09:24] Nicolas Montañez Rozo
--PRONTO PAGO ORDENANZA

select top 1000 * from trazabilidad_transaccion_ws order by fecha_respuesta desc

select t.* from traza_visualizacion_video t order by id_traza_visualizacion_video desc

select top 1000 * from notificaciones..multa_circuitos mc where estado=1 and idcircuito= '7d164492-ebd1-42ee-a8e1-f3125e7be761' 

update notificaciones..multa_circuitos set multa ='8135803' where idcircuito = '7d164492-ebd1-42ee-a8e1-f3125e7be761'
 
--EMBARGOS - PAGOS

select * from estado_proceso where id_tipo_proceso=4

select * from tipo_proceso
 
select top 10000 pe.numero_identificacion, numero_coactivo, numero_obligacion, co.fecha_notificacion,c.id_tramite, op.nombre, co.codigo_medio_imposicion, * from proceso p

--inner join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso and tp.id_estado_proceso=38

inner join coactivo c on p.id_proceso=c.id_proceso

inner join obligacion_coactivo oc on c.id_coactivo=oc.id_coactivo

inner join persona pe on c.id_deudor=pe.id_persona

inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion

inner join configuracion_infraccion ci on co.id_infraccion=ci.id_infraccion

inner join ordenamiento_pais op on ci.id_ordenamiento_pais=op.id_ordenamiento_pais

--inner join cartera ca on ca.nombre=co.id_factura_axis

where p.id_estado_proceso in(29) and anio=2021

--and ci.id_ordenamiento_pais=2

and c.id_tipo_coactivo=1

and c.cantidad_obligaciones=1

--and c.fecha_notificacion is null

--and oc.valor_interes_moratorios>0

--and oc.valor_costas_procesales>0

and ci.fecha_fin_vigencia is null

--and exists (select * from obligacion_coactivo_historico och where och.id_obligacion_coactivo=oc.id_obligacion_coactivo)

and not exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = p.id_proceso and tp.id_estado_proceso = 36)

order by p.fecha_inicio desc
 
---------------------------------------------------------------------------------------------------------------------------------------------



select * from coactivo_oficio_bien order by 1 desc
 
select p.*, tp.* 

from proceso p

join trazabilidad_proceso tp on p.id_proceso=tp.id_proceso

join documento_proceso dp on dp.id_trazabilidad_proceso=tp.id_trazabilidad_proceso

join documentos.dbo.documento dd on dd.consecutivo_documento=dp.numero_documento

where tp.id_estado_proceso=29 and dp.id_tipo_documento_proceso=47

order by p.fecha_inicio desc
 
select top 10000 pe.numero_identificacion, numero_coactivo, numero_obligacion, co.fecha_notificacion,c.id_tramite, op.nombre, * from proceso p

--inner join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso and tp.id_estado_proceso=38

inner join coactivo c on p.id_proceso=c.id_proceso

inner join obligacion_coactivo oc on c.id_coactivo=oc.id_coactivo

inner join persona pe on c.id_deudor=pe.id_persona

inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion

inner join configuracion_infraccion ci on co.id_infraccion=ci.id_infraccion

inner join ordenamiento_pais op on ci.id_ordenamiento_pais=op.id_ordenamiento_pais

where 1=1

and p.id_estado_proceso not in(31) 

and anio>2016

--and ci.id_ordenamiento_pais=1

and c.id_tipo_coactivo=2

and c.cantidad_obligaciones=2

--and c.fecha_notificacion is null

--and oc.valor_interes_moratorios>0

--and oc.valor_costas_procesales=0

and ci.fecha_fin_vigencia is null

and exists (select * from obligacion_coactivo_historico och where och.id_obligacion_coactivo=oc.id_obligacion_coactivo)

--and not exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = p.id_proceso and tp.id_estado_proceso = 36)

order by p.fecha_inicio desc
 
 
--PRUEBAS CHATARRIZACIÓN

select * from reporte_chatarrizacion rc

join proceso p on rc.id_proceso=p.id_proceso

where rc.estado_excepcion =0 and rc.id_proceso_chatarrizacion is not null 

and p.id_estado_proceso = 112
 
---PRUEBAS SEGURIDAD VIAL

select i.codigo_infraccion, ci.porcentaje_descuento, ci.* from infraccion i

inner join configuracion_infraccion ci on ci.id_infraccion=i.id_infraccion

where aplica_descuento=1 

select * from curso order by 1 desc

select * from trazabilidad_curso where id_curso=2619

select c.id_estado_comparendo, ec.nombre, c.id_factura_axis from comparendo c join estado_comparendo ec on ec.id_estado_comparendo=c.id_estado_comparendo where id_factura_axis=7881993

select * from estado_comparendo
 
--EMBARGOS - IMPRESIÓN DE DOCUMENTOS

select top 1000 p.numero_proceso, c.anio, per.numero_identificacion, * from coactivo c

join proceso p on p.id_proceso=c.id_proceso

join trazabilidad_proceso tp on tp.id_trazabilidad_proceso=(select top 1 tr.id_trazabilidad_proceso from trazabilidad_proceso tr where tr.id_proceso=p.id_proceso and tr.id_estado_proceso=37 order by fecha_inicio desc) 

join persona per on per.id_persona =c.id_deudor

join documento_proceso dp on dp.id_trazabilidad_proceso=tp.id_trazabilidad_proceso and dp.id_tipo_documento_proceso in(17)

join documentos..documento d on d.consecutivo_documento=dp.numero_documento

where p.id_estado_proceso in(37)

--and c.id_proceso not in (select sml.id_proceso from seguimiento_motivo_levantamiento sml where estado=1)

--and p.numero_proceso='57967'

order by c.anio asc
 
--LEVANTAMIENTO DE MEDIDAS CAUTELARES ***Aqui

select top 10000 p.numero_proceso, anio, p.fecha_inicio, per.numero_identificacion, * from coactivo c

join proceso p on p.id_proceso=c.id_proceso

join trazabilidad_proceso tp on tp.id_trazabilidad_proceso=(select top 1 tr.id_trazabilidad_proceso from trazabilidad_proceso tr where tr.id_proceso=p.id_proceso and tr.id_estado_proceso=29 order by fecha_inicio asc) 

join persona per on per.id_persona =c.id_deudor

where p.id_estado_proceso in(27)

and c.id_proceso in (select sml.id_proceso from seguimiento_motivo_levantamiento sml where estado=1)

--and p.numero_proceso='57967'

order by p.fecha_inicio desc
 
--GENERACIÓN SOLICITUD OFICIO BIEN

select top 1000 p.numero_proceso,p.fecha_inicio, per.numero_identificacion, * from coactivo c

join proceso p on p.id_proceso=c.id_proceso

join trazabilidad_proceso tp on tp.id_trazabilidad_proceso=(select top 1 tr.id_trazabilidad_proceso from trazabilidad_proceso tr where tr.id_proceso=p.id_proceso and tr.id_estado_proceso=23 order by fecha_inicio asc) 

join persona per on per.id_persona =c.id_deudor

where p.id_estado_proceso in(23,29)

--and c.id_proceso not in (select sml.id_proceso from seguimiento_motivo_levantamiento sml where estado=1)

--and p.numero_proceso='57967'

order by p.fecha_inicio desc
 
--UBICACIÓN DE CARGUES PARA LEVANTAMIENTO DE MEDIDAS CAUTELARES

--Generación

select * from seguimiento_motivo_levantamiento order by 3 desc

--select * from proceso where id_proceso=1902396

--Impresión

select top 1000 * from seg_doc_impresion_embargo order by 1 desc

select top 1000 * from seg_doc_impre_reg_embargo where id_tipo_documento_proceso=32 order by 1 desc

--Envío

select top 1000 * from envio_doc_impresion_embargo order by 2 desc
 
 
--DATA PARA FINANCIAMIENTOS

select ci.id_ordenamiento_pais, c.id_factura_axis,cp.numero_identificacion, c.fecha_notificacion, * from comparendo c

join configuracion_infraccion ci on ci.id_infraccion=c.id_infraccion

join comparendo_persona cp on cp.cicomparendo=c.cicomparendo

join obligacion_coactivo oc on oc.numero_obligacion=c.id_factura_Axis

join coactivo co on co.id_coactivo=oc.id_coactivo

where c.id_Estado_Comparendo=13 --and ci.id_ordenamiento_pais=1

and co.id_tipo_coactivo=1

and co.cantidad_obligaciones=1 and anio=2018

and ci.id_infraccion in(276,107)

order by c.fecha_notificacion desc
 
--QUERYS INCUMPLIMIENTO DE CONVENIOS

	select * from detalle_financiacion

	where id_financiacion=344852
 
	begin tran

	update circulemos2.dbo.detalle_financiacion

	set fecha_pago_oportuno = '2023-11-15'

	where id_detalle_financiacion = 1515138;

	commit
 
	SELECT top 400 * FROM trazabilidad_financiacion_incumplida tfi1

	WHERE 1=1

	--and tipo_de_financiacion=1

	--and tfi1.numero_de_convenio=408947

	order by 1 desc;

	select * from estado_de_incumplimiento
 
	begin tran

	update trazabilidad_financiacion_incumplida

	set fecha_registro_marcacion = '2023-11-05 11:20:04.3260000'--2021-11-24 11:20:04.3260000

	where numero_de_convenio=531337

	commit
 
	EXEC ('begin

	update cp_detalles_convenios

	set fecha_inicio = to_date(''05/11/2023'', ''DD/MM/RRRR'')

	where id_convenio = 531337

	and nro_cuota = 1;

	end;') at SRVPRATM
 
	select * from trazabilidad_error_financiacion_incumplida

	--where numero_de_convenio = 505166 

	order by 1 desc

	select * from trazabilidad_error_financiacion_incumplida where error like '%Para Excluir%'

	update trazabilidad_error_financiacion_incumplida set estado=1 where error like '%Para Excluir%'
 
	begin tran

	update trazabilidad_error_financiacion_incumplida

	set estado=0

	where numero_de_convenio = 505166

	commit

--NOTIFICACIÓN EN LOTE DE COACTIVOS

select top 500 * from notificacion_coactivo_lote order by id_notificacion_coactivo_lote desc

INSERT INTO notificacion_coactivo_lote(numero_proceso,anio_proceso,fecha_registro,crear_documento) VALUES(19306,2019, getdate(), 1)

select * from coactivo c

join proceso p on c.id_proceso=p.id_proceso

where id_tipo_coactivo=3

and fecha_notificacion is null 

and id_estado_proceso in(29)

select * from estado_proceso
 
select top 100 * from trazabilidad_incumplimiento_email order by fecha_envio desc

select top 100 * from [dbo].[trazabilidad_error_financiacion_incumplida] order by fecha_de_proceso desc

select * from [dbo].[trazabilidad_financiacion_incumplida] where id_coactivo=1208644

select * from financiacion where numero_financiacion=463845

select * from estado_de_incumplimiento
 
SELECT * FROM documento_proceso dp

JOIN tipo_documento_proceso td ON dp.id_tipo_documento_proceso = td.id_tipo_documento_proceso

WHERE dp.numero_documento IN(8195241,8195242) --8195241 8195242
 
SELECT * FROM documento_proceso dp

JOIN tipo_documento_proceso td ON dp.id_tipo_documento_proceso = td.id_tipo_documento_proceso

WHERE dp.id_trazabilidad_proceso=10728626
 
select * from proceso p

join coactivo c on c.id_proceso=p.id_proceso

join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso

where p.id_Estado_proceso not in (31,27,28) --and p.id_tipo_proceso= 4

and tp.id_estado_proceso not in (23)

and fecha_notificacion is null

and c.id_tipo_coactivo= 3

and anio=2020
 
use circulemos2

SELECT year(PR.fecha_inicio) año,co.numero_coactivo, PR.numero_proceso numero_juicio

, co.id_tramite

, PR.fecha_inicio fecha_coactivo

, co.fecha_notificacion

, tnc.nombre tipo_notificacion

, t.codigo AS 'TIPO_IDENTIFICACION'

,pe.numero_identificacion

,CASE pe.id_tipo_identificacion WHEN 2 THEN pj.nombre_comercial

ELSE CONCAT(pe.nombre1,' ',pe.nombre2,' ',pe.apellido1,' ',pe.apellido2) end 'Nombre infractor',

co.valor_total_obligaciones,

co.valor_total_costas_procesales,

ep.nombre estado_coactivo,

co.cantidad_obligaciones,

pr.fecha_inicio

  from  proceso pr

  JOIN  coactivo co (nolock) on co.id_proceso = pr.id_proceso

  join estado_proceso ep (nolock) on pr.id_estado_proceso = eP.id_estado_proceso

  join persona pe (nolock) on pe.id_persona =co.id_deudor

  join tipo_identificacion_persona t on t.id_tipo_identificacion = pe.id_tipo_identificacion

  LEFT JOIN persona_juridica pj (NOLOCK) ON pj.id_persona_juridica = pe.id_persona

  left join tipo_notificacion_coactivo tnc (NOLOCK) ON tnc.id_tipo_notificacion_coactivo = co.id_tipo_notificacion_coactivo

  left join trazabilidad_proceso tp on tp.id_proceso=pr.id_proceso and tp.fecha_fin is null

where  PR.id_tipo_proceso = 4

--and (co.id_tipo_notificacion_coactivo  is null )

--and (co.id_tipo_notificacion_coactivo = 2 )

--and year( pr.fecha_inicio) = 2020

--AND co.numero_coactivo in ()

--and co.cantidad_obligaciones = 1

--and co.id_tipo_coactivo = 1

and pr.id_estado_proceso in(37)

--and exists (select * from obligacion_coactivo where id_coactivo=co.id_coactivo and valor_interes_moratorios=0 and valor_costas_procesales=0)

--and exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = pr.id_proceso and tp.id_estado_proceso = 36)

--AND CO.numero_coactivo = '3144073'

order by tp.fecha_inicio desc;

select * from estado_proceso where id_tipo_proceso=4
 
 
--Consultar numero de documentos generados

select --top 15

--per.id_persona,

--ic.id_persona,

sml.fecha_registro,--Fecha en que se genero

sml.idDocumento, --Documento que se genera

per.numero_identificacion,

--co.id_proceso, clave para obtener el número de juicio

co.anio,

pr.numero_proceso as numeroJuicio

from impulso_coactivo as ic

inner join persona as per on per.id_persona=ic.id_persona

inner join coactivo as co on co.id_coactivo = ic.id_coactivo

inner join proceso as pr on pr.id_proceso = co.id_proceso --incorporadas

inner join seguimiento_motivo_levantamiento as sml on pr.id_proceso=sml.id_proceso

--where per.id_persona=5176261

order by fecha_generacion desc
 
 
--Pruebas multa aviso

select * from integracion_terceros..it_multa where estado_lectura=8 and codigo_infraccion='906' order by 1 desc

select * from integracion_terceros..it_multa where id_multa=2813666

update integracion_terceros..it_multa set estado_lectura=8 where id_multa in (2836912)

select * from integracion_terceros..it_ubicabilidad_axis where numero_documento='0928669928' order by 1 desc

update integracion_terceros..it_ubicabilidad_axis set correo_electronico='sincorreo@datatools.com.co' where id_ubicabilidad_axis=1298173
 
select top 1000 * from integracion_terceros..it_multa 

where estado_lectura=9 and codigo_infraccion='906' 

and id_factura_axis in (select id_factura from integracion_terceros.dbo.v_datos_infracciones WHERE NUMERO_SERIE not in ('SPC1139','SPC1701','SPC1726','SPC1852','SPC1443','SPC1160','SPC1506','SPC1111'))

order by 1 desc
 
 
-- Reporte de Plantillas que utiliza cada estado de un proceso impugnatorio

use circulemos2

select pr.numero_proceso, year(pr.fecha_inicio) año, pr.fecha_inicio, tp.fecha_inicio fecha_estado  ,tp.id_estado_proceso, ep.nombre estado_proceso , tdp.nombre tipo_documento ,

dpl.id_proceso, dpl.nombre_plantilla, upe.login, dpl.codigo_plantilla

from proceso pr

join trazabilidad_proceso tp on pr.id_proceso = tp.id_proceso

join documento_proceso dp on tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso

join tipo_documento_proceso tdp on  dp.id_tipo_documento_proceso = tdp.id_tipo_documento_proceso

join [documentos].[dbo].[documento] dd on dd.consecutivo_documento = dp.numero_documento

join [documentos].[dbo].[plantilla]   dpl on dpl.id_plantilla = dd.id_plantilla

join usuario_persona upe on upe.id_usuario = tp.id_usuario

join estado_proceso ep on tp.id_estado_proceso = ep.id_estado_proceso

where pr.id_tipo_proceso = 4

--and tp.id_estado_proceso in (6,10)

--and pr.numero_proceso = '15266'

--and year(pr.fecha_inicio) ='2023'

and pr.id_proceso=1911300

order by tp.id_trazabilidad_proceso;

select * from [documentos].[dbo].[plantilla] where id_plantilla=2324

select top 100 * from [documentos].[dbo].[documento] order by 1 desc
 
 
select * from integracion_terceros..it_multa where estado_lectura=1 order by id_factura_axis asc

update integracion_terceros..it_multa set estado_lectura=1, apellido1_infractor='PILATUNA' where id_multa in (3757427)	

select top 1000 * from comparendo order by 1 desc