CREATE TABLE integracion_terceros.[dbo].[reconstr_estados_impugnacion](
 [id_reconstr][bigint] IDENTITY(1,1) NOT NULL,
 [expediente] [varchar](20),	
 [Tipo Fallo] [varchar](50), --Es un valor grandeeeee	
 [Motivación_fallo] [varchar](max),	
 [Usuario Sogit Fallo] [varchar](20),
 [Fecha Fallo] [datetime],--GETDATE() AÑO, MES , DIA
 [Plantilla Fallo] [varchar](50),	
 [Documento Fallo] [varchar](255) NULL,	
 [Estado Fallo] [varchar](50),	
 [Usuario Sogit Resolucion(Estado_Cerrado)][varchar](20),
 [Fecha_resolucion(Estado_Cerrado)][datetime],	
 [documento resolucion][varchar](50),	
 [Estado SOGIT resolucion][varchar](50),
 [fecha_procesamiento] [datetime],	--Parece que esté es el final datetime
 [procesado][smallint] NOT NULL,	
 [error] [varchar](250) NULL,	
 [path_documento][varchar](255) NULL,
 [path_documento_cerrado][varchar](1000) NULL
 );




 