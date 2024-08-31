USE [circulemos2]
GO

INSERT INTO [dbo].[coactivo_pendiente]
           ([numero_coactivo]
           ,[id_tramite]
           ,[fecha_creacion]
           ,[factura]
           ,[valor_factura]
           ,[tipo_identificacion]
           ,[numero_identificacion]
           ,[fecha_registro]
           ,[registro_nuevo]
           ,[coactivo_exitoso]
           ,[descripcion_error]
           ,[tipo_coactivo]
           ,[numero_proceso])
     VALUES
		    ('13664847','15533042',CONVERT(VARCHAR(19), GETDATE(), 120),'13506744','31.5','CED','0953355104',getdate(),1,0,null,1,'2087'),
            ('13531331','15449879',CONVERT(VARCHAR(19), GETDATE(), 120),'10646923','127.5','CED','0953355104',getdate(),1,0,null,1,'304104'),
            ('13702052','15555310',CONVERT(VARCHAR(19), GETDATE(), 120),'13479633','31.5','CED','1310609084',getdate(),1,0,null,1,'15862'),
            ('13686076','15542918',CONVERT(VARCHAR(19), GETDATE(), 120),'13533549','112.5','CED','0921903662',getdate(),1,0,null,1,'13477'),
            ('13680335','15539965',CONVERT(VARCHAR(19), GETDATE(), 120),'13539746','135','CED','105672463',getdate(),1,0,null,1,'11055'),
            ('13542134','15457708',CONVERT(VARCHAR(19), GETDATE(), 120),'13417794','45','CED','1306119304',getdate(),1,0,null,1,'307377'),
            ('13546182','15460539',CONVERT(VARCHAR(19), GETDATE(), 120),'10688515','127.5','CED','0919765487',getdate(),1,0,null,1,'308542'),
            ('13757561','15608065',CONVERT(VARCHAR(19), GETDATE(), 120),'13753265','69','CED','0919765487',getdate(),1,0,null,1,'22481'),
            ('13781036','15631736',CONVERT(VARCHAR(19), GETDATE(), 120),'13621757','135','CED','702663030',getdate(),1,0,null,1,'26863')


GO