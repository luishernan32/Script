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
		    
            ('13542134','15457708',CONVERT(VARCHAR(19), GETDATE(), 120),'13417794','45','CED','1306119304',getdate(),1,0,null,1,'307377'),
            
            
            ('13781036','15631736',CONVERT(VARCHAR(19), GETDATE(), 120),'13621757','135','CED','702663030',getdate(),1,0,null,1,'26863')


GO


-- Juicio true    Juicio false 
-- 307377-2024    497208-2024    
-- 26863-2024     497207-2024

13542134