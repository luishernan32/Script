select *from integracion_terceros.dbo.V_EVIDENCIA_INFRACCIONES
where NUMERO_FACTURA=12622841



--12622841
--12622841

USE [integracion_terceros]
GO
















-------------------------------------------------------------------
INSERT INTO [dbo].[V_EVIDENCIA_INFRACCIONES]
           ([NUMERO_FACTURA]
           ,[nro_evidencia]
           ,[TIPO_EVIDENCIA]
           ,[FECHA_REGISTRO]
           ,[archivo]
           ,[estado_lectura])
     VALUES
           (<NUMERO_FACTURA, decimal(38,0),>
           ,<nro_evidencia, smallint,>
           ,<TIPO_EVIDENCIA, nvarchar(6),>
           ,<FECHA_REGISTRO, smalldatetime,>
           ,<archivo, varchar(100),>
           ,<estado_lectura, smallint,>)
GO

