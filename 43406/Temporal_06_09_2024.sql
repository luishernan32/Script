-- Ejemplo de Caso de Coactivo replicado
select top 1 * from circulemos2.dbo.coactivo_pendiente
where tipo_coactivo = 1
and coactivo_exitoso = 1
order by id_coactivo_pendiente desc
 
select pr.* from circulemos2.dbo.proceso pr
inner join circulemos2.dbo.coactivo co on pr.id_proceso = co.id_proceso
where co.numero_coactivo ='13531331'-- '14625684'
 
-- Caso real de los coactivos a replicar
 
 
select * from circulemos2.dbo.coactivo_pendiente   --obtengo 'numero_proceso' fecha_inicio='fecha_creacion'=fecha_fin
where numero_coactivo = '13531331'--'13664847';
 
 
--INSERT proceso 
id_proceso	id_tipo_proceso	numero_proceso	fecha_inicio	               fecha_fin	                          observacion	    id_estado_proceso
          	4	            2087	         2024-01-03 06:14:38.0000000	2024-01-03 06:14:38.0000000            'COACTIVO ANULADO'	31


----------------------------------------------------------------------------------------------------------------------------------------------------

select top 10 *from obligacion_coactivo
select top 10 *from comparendo_proceso
select top 10 *from trazabilidad_proceso
----------------------------------------------------------------------------------------------------------------------------------------------------
USE [circulemos2]


INSERT INTO [dbo].[proceso]
           ([id_tipo_proceso]
           ,[numero_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[observacion]
           ,[id_estado_proceso])
     VALUES
	        (4,'304104','2023-12-06 06:04:07.0000000','2023-12-06 06:04:07.0000000','COACTIVO ANULADO',31)
----------------------------------------------------------------------------------------------------------------------------------------------------
USE [circulemos2]
GO

INSERT INTO [dbo].[coactivo]
           ([codigo_organismo]
           ,[id_deudor]
           ,[id_configuracion_coactivo]
           ,[id_cargue_coactivo]
           ,[id_proceso]
           ,[id_funcionario]
           ,[id_direccion]
           ,[id_tramite]
           ,[anio]
           ,[cantidad_obligaciones]
           ,[fecha_notificacion]
           ,[numero_coactivo]
           ,[valor_total_obligaciones]
           ,[valor_total_costas_procesales]
           ,[id_tipo_notificacion_coactivo]
           ,[id_tipo_coactivo])
     VALUES
           (11001,126941,4,null,'id_proceso',42,null,15449879,2024,1,null,'13531331',127.5,0,null,1)

GO


----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
--insert select top 10 *from obligacion_coactivo

USE [circulemos2]
GO

INSERT INTO [dbo].[obligacion_coactivo]
           ([id_coactivo]
           ,[codigo_tipo_obligacion]
           ,[numero_obligacion]
           ,[fecha_obligacion]
           ,[valor_costas_procesales]
           ,[valor_obligacion]
           ,[valor_interes_moratorios]
           ,[id_cartera]
           ,[id_estado_obligacion_coactivo])
     VALUES
           (<id_coactivo, bigint,>
           ,<codigo_tipo_obligacion, int,>
           ,<numero_obligacion, varchar(50),>
           ,<fecha_obligacion, datetime2(7),>
           ,<valor_costas_procesales, decimal(16,2),>
           ,<valor_obligacion, decimal(16,2),>
           ,<valor_interes_moratorios, decimal(16,2),>
           ,<id_cartera, bigint,>
           ,<id_estado_obligacion_coactivo, bigint,>)
GO
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
--select top 10 *from comparendo_proceso

USE [circulemos2]
GO

INSERT INTO [dbo].[comparendo_proceso]
           ([cicomparendo]
           ,[id_proceso])
     VALUES
           (<cicomparendo, bigint,>
           ,<id_proceso, bigint,>)
GO






----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
--select top 10 *from trazabilidad_proceso
USE [circulemos2]
GO

INSERT INTO [dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
           (<id_proceso, bigint,>
           ,<id_estado_proceso, int,>
           ,<fecha_inicio, datetime2(7),>
           ,<fecha_fin, datetime2(7),>
           ,<id_usuario, int,>
           ,<id_sede_proceso, int,>
           ,<id_sede_usuario, int,>)
GO



----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
select top 10 *from obligacion_coactivo
select top 10 *from obligacion_coactivo
select top 10 *from comparendo_proceso
select top 10 *from trazabilidad_proceso

select top 10 *from coactivo_pendiente
select top 10 *from coactivo


select top 10 *from obligacion_coactivo

select top 10
oc.id_obligacion_coactivo,oc.id_coactivo,
oc.codigo_tipo_obligacion,oc.numero_obligacion,
oc.fecha_obligacion,oc.valor_costas_procesales,oc.valor_obligacion,
oc.valor_interes_moratorios,oc.id_cartera,oc.id_estado_obligacion_coactivo

 from obligacion_coactivo oc
inner join coactivo co on co.id_coactivo=oc.id_coactivo
inner join coactivo_pendiente cp on cp.id_tramite=co.id_tramite

select top 2
oc.*
from obligacion_coactivo oc
inner join coactivo co on co.id_coactivo=oc.id_coactivo
inner join coactivo_pendiente cp on cp.id_tramite=co.id_tramite
select top 2
co.*
from obligacion_coactivo oc
inner join coactivo co on co.id_coactivo=oc.id_coactivo
inner join coactivo_pendiente cp on cp.id_tramite=co.id_tramite
select top 2
cp.*
from obligacion_coactivo oc
inner join coactivo co on co.id_coactivo=oc.id_coactivo
inner join coactivo_pendiente cp on cp.id_tramite=co.id_tramite

----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------


USE [circulemos2]
GO

INSERT INTO [dbo].[coactivo]
           ([codigo_organismo]
           ,[id_deudor]
           ,[id_configuracion_coactivo]
           ,[id_cargue_coactivo]
           ,[id_proceso]
           ,[id_funcionario]
           ,[id_direccion]
           ,[id_tramite]
           ,[anio]
           ,[cantidad_obligaciones]
           ,[fecha_notificacion]
           ,[numero_coactivo]
           ,[valor_total_obligaciones]
           ,[valor_total_costas_procesales]
           ,[id_tipo_notificacion_coactivo]
           ,[id_tipo_coactivo])
     VALUES
           (<codigo_organismo, int,>
           ,<id_deudor, bigint,>
           ,<id_configuracion_coactivo, int,>
           ,<id_cargue_coactivo, bigint,>
           ,<id_proceso, bigint,>
           ,<id_funcionario, int,>
           ,<id_direccion, bigint,>
           ,<id_tramite, bigint,>
           ,<anio, int,>
           ,<cantidad_obligaciones, int,>
           ,<fecha_notificacion, date,>
           ,<numero_coactivo, varchar(50),>
           ,<valor_total_obligaciones, decimal(16,2),>
           ,<valor_total_costas_procesales, decimal(16,2),>
           ,<id_tipo_notificacion_coactivo, int,>
           ,<id_tipo_coactivo, int,>)
GO






USE [circulemos2]
GO

INSERT INTO [dbo].[proceso]
           ([id_tipo_proceso]
           ,[numero_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[observacion]
           ,[id_estado_proceso])
     VALUES
           (<id_tipo_proceso, int,>
           ,<numero_proceso, varchar(50),>
           ,<fecha_inicio, datetime2(7),>
           ,<fecha_fin, datetime2(7),>
           ,<observacion, varchar(max),>
           ,<id_estado_proceso, int,>)
GO


USE [circulemos2]
GO

INSERT INTO [dbo].[obligacion_coactivo]
           ([id_coactivo]
           ,[codigo_tipo_obligacion]
           ,[numero_obligacion]
           ,[fecha_obligacion]
           ,[valor_costas_procesales]
           ,[valor_obligacion]
           ,[valor_interes_moratorios]
           ,[id_cartera]
           ,[id_estado_obligacion_coactivo])
     VALUES
           (<id_coactivo, bigint,>
           ,<codigo_tipo_obligacion, int,>
           ,<numero_obligacion, varchar(50),>
           ,<fecha_obligacion, datetime2(7),>
           ,<valor_costas_procesales, decimal(16,2),>
           ,<valor_obligacion, decimal(16,2),>
           ,<valor_interes_moratorios, decimal(16,2),>
           ,<id_cartera, bigint,>
           ,<id_estado_obligacion_coactivo, bigint,>)
GO


USE [circulemos2]
GO

INSERT INTO [dbo].[comparendo_proceso]
           ([cicomparendo]
           ,[id_proceso])
     VALUES
           (<cicomparendo, bigint,>
           ,<id_proceso, bigint,>)
GO



INSERT INTO [dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
           (<id_proceso, bigint,>
           ,<id_estado_proceso, int,>
           ,<fecha_inicio, datetime2(7),>
           ,<fecha_fin, datetime2(7),>
           ,<id_usuario, int,>
           ,<id_sede_proceso, int,>
           ,<id_sede_usuario, int,>)
GO

----------------------------------


select *from  integracion_terceros.dbo.reconstr_notifica_coactivo_multas 
where numero_juicio in('326305-2023','326309-2023','322737-2023','322739-2023',
'322740-2023','3010-2024','3011-2024','3013-2024',
'3014-2024','3015-2024','317073-2023','15583-2024',
'15587-2024','38283-2024')