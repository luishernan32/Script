select * from circulemos2.dbo.coactivo_pendiente
order by 1 asc
-- ID_COACTIVO_PENDIENTE NO COLOCAR, SE GENERA AUTOMÁTICO
-- FECHA_REGISTO GETDATE()
-- REGISTRO NUEVO 1
--COACTIVO EXITOSO 0
--DESCRIPCION ERROR NULL
--TIPO COACTIVO 1
--NUMERO_PROCE



USE [circulemos2]
GO
begin tran
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

commit tran



begin tran
update circulemos2.dbo.coactivo_pendiente
set fecha_creacion=CONVERT(VARCHAR(19), GETDATE(), 120)
where id_coactivo_pendiente in(141440,141441,141442,141443,141444,141445,141446,141447,141448)
commit tran


begin tran
delete circulemos2.dbo.coactivo_pendiente
--set fecha_creacion=CONVERT(VARCHAR(19), GETDATE(), 120)
where id_coactivo_pendiente in(141440,141441,141442,141443,141444,141445,141446,141447,141448)
commit tran

--(141440,141441,141442,141443,141444,141445,141446,141447,141448)






CONVERT(VARCHAR(19), GETDATE(), 126) AS FechaHoraUniversal;





USE [circulemos2]
GO
begin tran
INSERT INTO [dbo].[coactivo_pendiente]
           (
           ,
           ,
           ,
           ,
           ,
           ,
           ,
           ,
           ,
           ,
           ,
           ,)
     VALUES
		    ('13664847','15533042',,,,,,,,,,,''),
            ('13531331','15449879',getdate(),'10646923','127.5','CED','0953355104',getdate(),1,0,null,1,'304104'),
            ('13702052','15555310',getdate(),'13479633','31.5','CED','1310609084',getdate(),1,0,null,1,'15862'),
            ('13686076','15542918',getdate(),'13533549','112.5','CED','0921903662',getdate(),1,0,null,1,'13477'),
            ('13680335','15539965',getdate(),'13539746','135','CED','105672463',getdate(),1,0,null,1,'11055'),
            ('13542134','15457708',getdate(),'13417794','45','CED','1306119304',getdate(),1,0,null,1,'307377'),
            ('13546182','15460539',getdate(),'10688515','127.5','CED','0919765487',getdate(),1,0,null,1,'308542'),
            ('13757561','15608065',getdate(),'13753265','69','CED','0919765487',getdate(),1,0,null,1,'22481'),
            ('13781036','15631736',getdate(),'13621757','135','CED','702663030',getdate(),1,0,null,1,null,'26863');


GO











            ('13664847','15533042',	null,'13506744','31,5','CED','953355104',null,1,0,null,1,null),
            ('13531331','15449879',	null,'10646923','127,5','CED','953355104',null,1,0,null,2,null),
            ('13702052','15555310',	null,'13479633','31,5','CED','1310609084',null,1,0,null,3,null),
            ('13686076','15542918',	null,'13533549','112,5','CED','921903662',null,1,0,null,4,null),
            ('13680335','15539965',	null,'13539746','135','CED','105672463',null,1,0,null,5,null),
            ('13542134','15457708',	null,'13417794','45','CED','1306119304',null,1,0,null,6,null),
            ('13546182','15460539',	null,'10688515','127,5','CED','919765487',null,1,0,null,7,null),
            ('13757561','15608065',	null,'13753265','69','CED','919765487',null,1,0,null,8,null),
            ('13781036','15631736',	null,'13621757','135','CED','702663030',null,1,0,null,9,null)




			--('13664847','15533042',getdate(),'13506744','31,5','CED','0953355104',getdate(),1,0,null,1,NULL),














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
           (<numero_coactivo, varchar(50),>
           ,<id_tramite, varchar(20),>
           ,<fecha_creacion, varchar(80),>--
           ,<factura, varchar(20),>
           ,<valor_factura, varchar(50),>
           ,<tipo_identificacion, varchar(10),>
           ,<numero_identificacion, varchar(20),>
           ,<fecha_registro, datetime2(7),>--
           ,<registro_nuevo, smallint,>
           ,<coactivo_exitoso, smallint,>
           ,<descripcion_error, varchar(250),>
           ,<tipo_coactivo, int,>
           ,<numero_proceso, varchar(50),>)
GO



SELECT 
    CONVERT(VARCHAR(10), GETDATE(), 103) AS FechaEuropea,
    CONVERT(VARCHAR(10), GETDATE(), 101) AS FechaAmericana,
    CONVERT(VARCHAR(19), GETDATE(), 120) AS FechaHoraFormatoExtendido,


    CONVERT(VARCHAR(19), GETDATE(), 126) AS FechaHoraUniversal;