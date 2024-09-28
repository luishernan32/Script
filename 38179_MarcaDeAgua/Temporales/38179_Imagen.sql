USE [circulemos2]
GO

INSERT INTO [dbo].[tipo_imagen]
           ([codigo]
           ,[estado]
           ,[descripcion])
     VALUES
           (<codigo, varchar(10),>
           ,<estado, tinyint,>
           ,<descripcion, varchar(150),>)
GO

-------------------------------------------------------
begin tran
SET IDENTITY_INSERT [dbo].[tipo_imagen] ON
USE [circulemos2]

INSERT INTO [dbo].[tipo_imagen]
           ([id_tipo_imagen]
		    ,[codigo]
           ,[estado]
           ,[descripcion])
     VALUES
           (4
		   ,'LogoATMEncabezadoVariable'
           ,1
           ,'Imagen de tipo logo'
		   )

commit tran

-----------------------------------------
USE [circulemos2]
begin tran
SET IDENTITY_INSERT [dbo].[tipo_imagen] ON
 

INSERT INTO [dbo].[tipo_imagen]
           ([id_tipo_imagen]
		    ,[codigo]
           ,[estado]
           ,[descripcion])
     VALUES
           (5
		   ,'ATMPieVar'
           ,1
           ,'Imagen de tipo PieVariable - LogoATMPieVariable'
		   )
commit tran
-----------------------------------------

--SET IDENTITY_INSERT [dbo].[tipo_imagen] OFF  


-- 2-- Crear dos registros en tipo_imagen 
select * from tipo_imagen
--LogoATMEncabezadoVariable
--LogoATMPieVariable


id_tipo_imagen


-----------------------------------------------------
--  [imagen]
----------------------------------------------------

USE [circulemos2]
GO

INSERT INTO [dbo].[imagen]
           ([fecha_inicio]
           ,[fecha_fin]
           ,[numero_imagen]
           ,[id_tipo_imagen])
     VALUES
           (<fecha_inicio, date,>
           ,<fecha_fin, date,>
           ,<numero_imagen, bigint,>
           ,<id_tipo_imagen, int,>)
GO

--------------------------------------------------------------------------------------------------------

USE [circulemos2]
begin tran

INSERT INTO [dbo].[imagen]
           ([fecha_inicio]
           ,[fecha_fin]
           ,[numero_imagen]
           ,[id_tipo_imagen])
     VALUES
           (GETDATE()
           ,null
           ,259187099
           ,1)

commit tran

--------------------------------------------------------------------------------------------------------


USE [circulemos2]
begin tran

INSERT INTO [dbo].[imagen]
           ([fecha_inicio]
           ,[fecha_fin]
           ,[numero_imagen]
           ,[id_tipo_imagen])
     VALUES
           (GETDATE()
           ,null
           ,259187105
           ,1)

commit tran

-- 3-- Crear dos registros en imagen que se relacionen al registro anterior
select * from circulemos2.dbo.imagen
where id_tipo_imagen = 1
--Se tienen que relacionar numero_imagen con codigo_imagen
-- 4.- crear 2 registros en la tabla data_documento
select * from gestor_docs.dbo.data_documento where codigo_documento = 259154776