begin tran 
INSERT INTO [dbo].[estado_proceso]
           ([id_estado_proceso]
           ,[codigo]
           ,[nombre]
           ,[sigla]
           ,[estado]
           ,[descripcion]
           ,[id_tipo_proceso])
     VALUES
           ( 139,
           '139',
           'ACTA RESORTEO',
           null,
            1,
            'ACTA RESORTEO',
            1)
GO

commit tran