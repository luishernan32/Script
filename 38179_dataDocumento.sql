USE [gestor_docs]
GO

INSERT INTO [dbo].[data_documento]
           ([descripcion]
           ,[nombre]
           ,[folder]
           ,[extension]
           ,[nombre_real]
           ,[Registro_BD])
     VALUES
           (<descripcion, varchar(512),>
           ,<nombre, varchar(100),>
           ,<folder, varchar(256),>
           ,<extension, varchar(20),>
           ,<nombre_real, varchar(100),>
           ,<Registro_BD, bit,>)
GO


--------------------------------------------------------------
begin tran
USE [gestor_docs]

INSERT INTO [dbo].[data_documento]
           ([descripcion]
           ,[nombre]
           ,[folder]
           ,[extension]
           ,[nombre_real]
           ,[Registro_BD])
     VALUES
           ('logo atm-alcaldia 2023_11_01'
           ,'LogoATMEncabezadoVariable.png'
           ,null
           ,'.png'
           ,'LOGOATM.png'
           ,1)
--rollback 
begin tran


--------------------------------------------------------------
LogoATMPieVariable


begin tran
USE [gestor_docs]

INSERT INTO [dbo].[data_documento]
           ([descripcion]
           ,[nombre]
           ,[folder]
           ,[extension]
           ,[nombre_real]
           ,[Registro_BD])
     VALUES
           ('logo LogoATMPieVariable 2023_11_01'
           ,'LogoATMPieVariable.png'
           ,null
           ,'.png'
           ,'LOGOALCALDIA.png'
           ,1)
 
 commit tran

begin tran


-- 4.- crear 2 registros en la tabla data_documento
select * from gestor_docs.dbo.data_documento where codigo_documento = 260268558


--Al realizar la actualización de datos del participante se genera un documento donde autoriza que las notificaciones se realicen a estos datos


-- 3-- Crear dos registros en imagen que se relacionen al registro anterior
select * from circulemos2.dbo.imagen
where id_tipo_imagen = 1
--Se tienen que relacionar numero_imagen con codigo_imagen
-- 4.- crear 2 registros en la tabla data_documento
select * from gestor_docs.dbo.data_documento where codigo_documento = 259154776