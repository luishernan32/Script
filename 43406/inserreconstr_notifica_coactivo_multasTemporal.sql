USE [integracion_terceros]
GO
begin tran
INSERT INTO [dbo].[reconstr_notifica_coactivo_multas]
           ([NUMERO_JUICIO]
           ,[NUMERO_COACTIVO]
           ,[ID_TRAMITE]
           ,[FECHA_REGISTRO]
           ,[FACTURA_AXIS]
           ,[VALOR_FACTURA]
           ,[TIPO_IDENTIFICACION]
           ,[NUMERO_IDENTIFICACION]
           ,[ID_TIPO_COACTIVO]
           ,[TIPO_NOTIFICACION]
           ,[FECHA_NOTIFICACION]
           ,[ESTADO_LECTURA]
           ,[ERROR])
     VALUES
	 ('322749-2023','13616591',	'10582383','4/01/2024 16:28','10582383','20.74','CED','0912386513',1,'NOTIFICADO POR EMAIL','26/12/2023',1	,null),
     ('3007-2024','13665863','13244637','16/01/2024 13:12','13244637','25.61','CED','0918150970',1, 'NOTIFICADO POR GACETA','8/01/2024	',1	,null),
     ('15582-2024','13690629','13407034','23/01/2024 10:22','13407034','113.4','CED','0905399705',1,'NOTIFICADO POR EMAIL','15/01/2024',1	,null),
     ('16547-2024','13703172','11925173','23/01/2024 10:36','11925173','99.99','CED','0905563839',1,'NOTIFICADO POR EMAIL','16/01/2024',1	,null)
GO

commit tran

rollback tran


select *from  integracion_terceros.dbo.reconstr_notifica_coactivo_multas 
where numero_juicio in('322749-2023','3007-2024','15582-2024','16547-2024')

/*('326305-2023','326309-2023','322737-2023','322739-2023',
 '322740-2023','3010-2024','3011-2024','3013-2024',
'3014-2024','3015-2024','317073-2023','15583-2024',
'15587-2024','38283-2024')*/--14 JUICIOS


select  * from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
where procesado = 0
and error is not null
and error = 'El proceso coactivo no existe'



select top 10 *from integracion_terceros.dbo.reconstr_notifica_coactivo_multas
where NUMERO_JUICIO='314769-2023'



select co.numero_coactivo,id_tramite,oc.numero_obligacion, concat(po.numero_proceso,'-',year(po.fecha_inicio)) as juicio
from coactivo co
inner join obligacion_coactivo oc on co.id_coactivo=oc.id_coactivo
inner join proceso po on po.id_proceso=co.id_proceso
--inner join persona pe on pe.id_persona=co.id_deudor
--where po.numero_proceso ='314769'
--where co.id_tramite='873422'
where po.numero_proceso in('324830','319875','319879','319884')--='15595'--'314769' --
--in('314769','21280','319878','319883','326307','20046','319877','319882','15595','324828','319876','319880','15591','3003','324830','319875','319879','319884')
--='314769'
--in('','','','','','','','','','','','','','','','','','')
and year(po.fecha_inicio)='2023'


--21280-2023	12216728	12098114	14024225





select top 30 *from coactivo co
inner join obligacion_coactivo oc on co.id_coactivo=oc.id_coactivo
inner join proceso po on po.id_proceso=co.id_proceso
--inner join persona pe on pe.id_persona=co.id_deudor
--where po.numero_proceso ='314769'
--where co.id_tramite='873422'
where po.numero_proceso='314769'
and year(po.fecha_inicio)='2023'
--and anio='2023'
--in('314769','21280','319878','319883','326307','20046','319877','319882','15595','324828','319876','319880','15591','3003','324830','319875','319879','319884')




BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
and numero_juicio in('326305-2023','326309-2023','322737-2023','322739-2023',
                     '322740-2023','3010-2024','3011-2024','3013-2024',
                     '3014-2024','3015-2024','317073-2023','15583-2024',
                     '15587-2024','38283-2024')
COMMIT TRAN
exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo







------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE [integracion_terceros]
GO

INSERT INTO [dbo].[reconstr_notifica_coactivo_multas]
           ([NUMERO_JUICIO]
           ,[NUMERO_COACTIVO]
           ,[ID_TRAMITE]
           ,[FECHA_REGISTRO]
           ,[FACTURA_AXIS]
           ,[VALOR_FACTURA]
           ,[TIPO_IDENTIFICACION]
           ,[NUMERO_IDENTIFICACION]
           ,[ID_TIPO_COACTIVO]
           ,[TIPO_NOTIFICACION]
           ,[FECHA_NOTIFICACION]
           ,[ESTADO_LECTURA]
           ,[ERROR])
     VALUES
           (<NUMERO_JUICIO, varchar(50),>
           ,<NUMERO_COACTIVO, varchar(50),>
           ,<ID_TRAMITE, bigint,>
           ,<FECHA_REGISTRO, date,>
           ,<FACTURA_AXIS, bigint,>
           ,<VALOR_FACTURA, numeric(38,2),>
           ,<TIPO_IDENTIFICACION, varchar(50),>
           ,<NUMERO_IDENTIFICACION, varchar(50),>
           ,<ID_TIPO_COACTIVO, varchar(50),>
           ,<TIPO_NOTIFICACION, varchar(50),>
           ,<FECHA_NOTIFICACION, date,>
           ,<ESTADO_LECTURA, tinyint,>
           ,<ERROR, varchar(4000),>)
GO



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select top 10 oc.numero_obligacion
from
coactivo c inner join obligacion_coactivo oc on
c.id_coactivo=oc.id_coactivo
inner join persona pe on c.id_deudor=pe.id_persona
inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion

--where c.numero_coactivo='14031691'





USE [integracion_terceros]
GO

INSERT INTO [dbo].[reconstr_notifica_coactivo_multas]
           ([NUMERO_JUICIO]
           ,[NUMERO_COACTIVO]
           ,[ID_TRAMITE]
           ,[FECHA_REGISTRO]
           ,[FACTURA_AXIS]
           ,[VALOR_FACTURA] 
           ,[TIPO_IDENTIFICACION]
           ,[NUMERO_IDENTIFICACION]
           ,[ID_TIPO_COACTIVO]
           ,[TIPO_NOTIFICACION]
           ,[FECHA_NOTIFICACION]
           ,[ESTADO_LECTURA]
           ,[ERROR])
     VALUES
		 
		  ('314769-2023','13575107','15482003','04-01-2024 14:38','13286126','27.47','CED','0914298351',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
		  ('21280-2024','13749928','15601460','02-02-2024 14:59','13566443','33.08','CED','201926342',1,'NOTIFICADO POR EMAIL','29-01-2024',1,null),
          ('319878-2023','13602062','15500752','04-01-2024 15:50','11769460','51.81','CED','0951123660',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('319883-2023','13602065','15500755','04-01-2024 15:50','11769491','51.81','CED','0951123660',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('326307-2023','13637369','15527391','04-01-2024 17:09','12804671','18.9','CED','0913168456',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('20046-2024','13735654','15588222','02-02-2024 14:47','13462356','189','CED','0916712326',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('319877-2023','13602057','15500747','04-01-2024 15:50','11769269','51.81','CED','0951123660',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('319882-2023','13602064','15500754','04-01-2024 15:50','11769478','51.81','CED','0951123660',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('15595-2024','13690656','15545839','23-01-2024 10:22','13387561','15.75','CED','0919205963',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('324828-2023','13630906','15521767','16-01-2024 15:00','13240831','88.73','CED','1301300404',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('319876-2023','13602061','15500751','04-01-2024 15:50','11769451','51.81','CED','0951123660',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('319880-2023','13602058','15500748','04-01-2024 15:50','11769289','51.81','CED','0951123660',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('15591-2024','13690653','15545836','23-01-2024 10:22','12315741','8.28','CED','0909254617',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('3003-2024','13665857','15534021','16-01-2024 13:12','13252304','88.73','CED','0915165807',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('324830-2023','13630907','15521768','04-01-2024 16:55','13248538','177.26','CED','1301300404',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('319875-2023','13602060','15500750','04-01-2024 15:50','11769442','51.81','CED'	,'0951123660',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('319879-2023','13602059','15500749','04-01-2024 15:50',	'11769304','51.81','CED','0951123660',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null),
          ('319884-2023','13602066','15500756','04-01-2024 15:50',	'11769497','25.9','CED','0951123660',1,'NOTIFICADO POR EMAIL','23-08-2024',1,null)
GO



