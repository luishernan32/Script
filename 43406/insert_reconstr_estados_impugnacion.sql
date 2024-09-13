
--El insert

USE [integracion_terceros]
GO

INSERT INTO [dbo].[reconstr_estados_impugnacion]
           ([expediente]
           ,[Tipo Fallo]
           ,[Motivación_fallo]
           ,[Usuario Sogit Fallo]
           ,[Fecha Fallo]
           ,[Plantilla Fallo]
           ,[Documento Fallo]
           ,[Estado Fallo]
           ,[Usuario Sogit Resolucion(Estado_Cerrado)]
           ,[Fecha_resolucion(Estado_Cerrado)]
           ,[documento resolucion]
           ,[Estado SOGIT resolucion]
           ,[fecha_procesamiento]
           ,[procesado]
           ,[error]
           ,[path_documento])
     VALUES



('14807-2023','Condenatorio','texto grande','darling.magallanes','7-12-2023','Registro Fallo','RESOLUCION ADMINISTRATIVA 14807-2023.pdf','FALLO PROYECTADO',
'felipe.larreategui','07-12-2023','RESOLUCION ADMINISTRATIVA 14807-2023.pdf','CERRADO',null,1,null,null)