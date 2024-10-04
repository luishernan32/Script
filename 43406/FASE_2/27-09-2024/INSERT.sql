select * from integracion_terceros.dbo.reconstr_notifica_coactivo_multas
where numero_juicio in('239514-2023',
'239529-2023',
'239565-2023',
'239583-2023',
'239663-2023')

--Los campos mas importantes son:
--numero_juicio, fecha , tipo de notifica, estado lectura=1


USE [integracion_terceros]


INSERT INTO [dbo].[reconstr_notifica_coactivo_multas]
           ([NUMERO_JUICIO]
           ,[NUMERO_COACTIVO]
           ,[ID_TRAMITE]
           ,[FECHA_REGISTRO]
           ,[FACTURA_AXIS]
           ,[VALOR_FACTURA]
           ,[TIPO_IDENTIFICACION]
           ,[NUMERO_IDENTIFICACION]
           ,[ID_TIPO_COACTIVO]
           ,[TIPO_NOTIFICACION]
           ,[FECHA_NOTIFICACION]
           ,[ESTADO_LECTURA]
           ,[ERROR])
     VALUES
	 --('239514-2023','13271177',15204525,'25/9/2024 0:00',13154935,31.5,'RUC','0991256911001','1','NOTIFICADO POR EMAIL','10/6/2023 0:00',1,null),
     ('239514-2023','13271177',15204525,'25/9/2024 0:00',13154935,31.5,'RUC','0991256911001','1','NOTIFICADO POR EMAIL','06/10/2023 0:00',1,null),
     ('239529-2023','13271193',15204540,'25/9/2024 0:00',13155597,31.5,'CED','0913559753','1','NOTIFICADO POR EMAIL','06/10/2023 0:00',1,null),
     ('239565-2023','13271230',15204576,'25/9/2024 0:00',13155927,31.5,'CED','0925776189','1','NOTIFICADO POR EMAIL','06/10/2023 0:00',1,null),
     ('239583-2023','13271250',15204595,'25/9/2024 0:00',13156093,31.5,'CED','0961478807','1','NOTIFICADO POR EMAIL','29/09/2023 0:00',1,null),
     ('239663-2023','13271329',15204674,'25/9/2024 0:00',13157746,135,'RUC','1791354907001','1','NOTIFICADO POR EMAIL','29/09/2023 0:00',1,null)



           (<NUMERO_JUICIO, varchar(50),>
           ,<NUMERO_COACTIVO, varchar(50),>
           ,<ID_TRAMITE, bigint,>
           ,<FECHA_REGISTRO, date,>
           ,<FACTURA_AXIS, bigint,>
           ,<VALOR_FACTURA, numeric(38,2),>
           ,<TIPO_IDENTIFICACION, varchar(50),>
           ,<NUMERO_IDENTIFICACION, varchar(50),>
           ,<ID_TIPO_COACTIVO, varchar(50),>
           ,<TIPO_NOTIFICACION, varchar(50),>
           ,<FECHA_NOTIFICACION, date,>
           ,<ESTADO_LECTURA, tinyint,>
           ,<ERROR, varchar(4000),>)



select *from [dbo].[reconstr_notifica_coactivo_multas]
where --ID_TRAMITE=15204525
id_tramite in('15204525','15204540','15204576','15204595','15204674')

begin tran
delete  [dbo].[reconstr_notifica_coactivo_multas]
where --ID_TRAMITE=15204525
id_tramite in('15204525','15204540','15204576','15204595','15204674')
commit tran





----------------------------------------

('239514-2023','239529-2023','239565-2023','239583-2023','239663-2023')

USE [integracion_terceros]
GO

INSERT INTO [dbo].[reconstr_notifica_coactivo_multas]
           ([NUMERO_JUICIO]
           ,[NUMERO_COACTIVO]
           ,[ID_TRAMITE]
           ,[FECHA_REGISTRO]
           ,[FACTURA_AXIS]
           ,[VALOR_FACTURA]
           ,[TIPO_IDENTIFICACION]
           ,[NUMERO_IDENTIFICACION]
           ,[ID_TIPO_COACTIVO]
           ,[TIPO_NOTIFICACION]
           ,[FECHA_NOTIFICACION]
           ,[ESTADO_LECTURA]
           ,[ERROR])
     VALUES
           (<NUMERO_JUICIO, varchar(50),>
           ,<NUMERO_COACTIVO, varchar(50),>
           ,<ID_TRAMITE, bigint,>
           ,<FECHA_REGISTRO, date,>
           ,<FACTURA_AXIS, bigint,>
           ,<VALOR_FACTURA, numeric(38,2),>
           ,<TIPO_IDENTIFICACION, varchar(50),>
           ,<NUMERO_IDENTIFICACION, varchar(50),>
           ,<ID_TIPO_COACTIVO, varchar(50),>
           ,<TIPO_NOTIFICACION, varchar(50),>
           ,<FECHA_NOTIFICACION, date,>
           ,<ESTADO_LECTURA, tinyint,>
           ,<ERROR, varchar(4000),>)
GO

-----------------------------------------------------------

INSERT INTO [dbo].[reconstr_notifica_coactivo_multas]
           ([NUMERO_JUICIO]
           ,[NUMERO_COACTIVO]
           ,[ID_TRAMITE]
           ,[FECHA_REGISTRO]
           ,[FACTURA_AXIS]
           ,[VALOR_FACTURA]
           ,[TIPO_IDENTIFICACION]
           ,[NUMERO_IDENTIFICACION]
           ,[ID_TIPO_COACTIVO]
           ,[TIPO_NOTIFICACION]
           ,[FECHA_NOTIFICACION]
           ,[ESTADO_LECTURA]
           ,[ERROR])
     VALUES
		   ('127885-2022'  -- NUMERO_JUICIO (varchar)
           ,'10992875'  -- NUMERO_COACTIVO (varchar)
           ,12307258  -- ID_TRAMITE (bigint)
           ,CAST('2022-04-21' AS date)  -- FECHA_REGISTRO (date)
           ,10792269  -- FACTURA_AXIS (bigint)
           ,127.50  -- VALOR_FACTURA (numeric(38,2))
           ,'CED'  -- TIPO_IDENTIFICACION (varchar)
           ,'0917913394'  -- NUMERO_IDENTIFICACION (varchar)
           ,'1'  -- ID_TIPO_COACTIVO (varchar)
           ,'NOTIFICADO POR COURIER'  -- TIPO_NOTIFICACION (varchar)
           ,CAST('2022-08-11' AS date)  -- FECHA_NOTIFICACION (date)
           ,1  -- ESTADO_LECTURA (tinyint)
           ,NULL  -- ERROR (NULL)
		   )


----------------------------

INSERT INTO [dbo].[reconstr_notifica_coactivo_multas]
           ([NUMERO_JUICIO]
           ,[NUMERO_COACTIVO]
           ,[ID_TRAMITE]
           ,[FECHA_REGISTRO]
           ,[FACTURA_AXIS]
           ,[VALOR_FACTURA]
           ,[TIPO_IDENTIFICACION]
           ,[NUMERO_IDENTIFICACION]
           ,[ID_TIPO_COACTIVO]
           ,[TIPO_NOTIFICACION]
           ,[FECHA_NOTIFICACION]
           ,[ESTADO_LECTURA]
           ,[ERROR])
     VALUES
		   ('127885-2022'  -- NUMERO_JUICIO (varchar)
           ,'10992875'  -- NUMERO_COACTIVO (varchar)
           ,12307258  -- ID_TRAMITE (bigint)
           ,CAST('2022-04-21' AS date)  -- FECHA_REGISTRO (date)
           ,10792269  -- FACTURA_AXIS (bigint)
           ,127.50  -- VALOR_FACTURA (numeric(38,2))
           ,'CED'  -- TIPO_IDENTIFICACION (varchar)
           ,'0917913394'  -- NUMERO_IDENTIFICACION (varchar)
           ,'1'  -- ID_TIPO_COACTIVO (varchar)
           ,'NOTIFICADO POR COURIER'  -- TIPO_NOTIFICACION (varchar)
           ,CAST('2022-08-11' AS date)  -- FECHA_NOTIFICACION (date)
           ,1  -- ESTADO_LECTURA (tinyint)
           ,NULL  -- ERROR (NULL)
		   )

-------------------------------------------

USE [integracion_terceros]


INSERT INTO [dbo].[reconstr_notifica_coactivo_multas]
           ([NUMERO_JUICIO]
           ,[NUMERO_COACTIVO]
           ,[ID_TRAMITE]
           ,[FECHA_REGISTRO]
           ,[FACTURA_AXIS]
           ,[VALOR_FACTURA]
           ,[TIPO_IDENTIFICACION]
           ,[NUMERO_IDENTIFICACION]
           ,[ID_TIPO_COACTIVO]
           ,[TIPO_NOTIFICACION]
           ,[FECHA_NOTIFICACION]
           ,[ESTADO_LECTURA]
           ,[ERROR])
     VALUES
     ('239514-2023','13271177',15204525,CAST('2024-09-25 0:00'AS date),13154935,31.5,'RUC','0991256911001','1','NOTIFICADO POR EMAIL',CAST('2023-10-06 0:00'AS date),1,null),
     ('239529-2023','13271193',15204540,CAST('2024-09-25 0:00'AS date),13155597,31.5,'CED','0913559753','1','NOTIFICADO POR EMAIL',CAST('2023-10-06 0:00'AS date),1,null),
     ('239565-2023','13271230',15204576,CAST('2024-09-25 0:00'AS date),13155927,31.5,'CED','0925776189','1','NOTIFICADO POR EMAIL',CAST('2023-10-06 0:00'AS date),1,null),
     ('239583-2023','13271250',15204595,CAST('2024-09-25 0:00'AS date),13156093,31.5,'CED','0961478807','1','NOTIFICADO POR EMAIL',CAST('2023-09-29 0:00'AS date),1,null),
     ('239663-2023','13271329',15204674,CAST('2024-09-25 0:00'AS date),13157746,135,'RUC','1791354907001','1','NOTIFICADO POR EMAIL',CAST('2023-09-29 0:00'AS date),1,null)