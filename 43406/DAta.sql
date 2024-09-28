--Verificar si el numero de juicio está aquí
select * FROM  integracion_terceros.dbo.reconstr_notifica_coactivo_multas r
	where r.NUMERO_JUICIO in('21643-2024','26698-2024','2443-2024','302138-2023','28186-2024','313080-2023','13525-2024','23525-2024')--('302138-2023')--('15862-2024')-- ('24072-2024')
 
 --Este va a ser el cursor
 SELECT  r.NUMERO_COACTIVO, r.FECHA_NOTIFICACION
	, case when r.TIPO_NOTIFICACION ='NOTIFICADO POR EMAIL' then 3
	when r.TIPO_NOTIFICACION ='NOTIFICADO POR GACETA' then 2
	when r.TIPO_NOTIFICACION ='NOTIFICADO POR COURIER' then 1 end TIPO_NOTIFICACION
	, co.id_coactivo, co.id_proceso, pr.id_estado_proceso, co.id_tramite
	FROM  integracion_terceros.dbo.reconstr_notifica_coactivo_multas r
	inner join circulemos2.dbo.coactivo co on r.numero_coactivo = co.numero_coactivo
	inner join circulemos2.dbo.proceso pr on pr.id_proceso = co.id_proceso
	WHERE co.id_tipo_coactivo in (1,2,3) 
	and r.TIPO_NOTIFICACION in (
	'NOTIFICADO POR EMAIL',
    'NOTIFICADO POR GACETA',
    'NOTIFICADO POR COURIER')
	and estado_lectura =1	
	and 1=1
	and NUMERO_JUICIO in ('22274-2024')
 
	declare
	@fecha_fin_proceso datetime,
	@time_traza TIME
 
					select top 1 @fecha_fin_proceso = fecha_inicio 
		from circulemos2.dbo.trazabilidad_proceso
		where id_proceso = 2843777
		and id_estado_proceso  in (21,22,23,24)
		--and convert(date,fecha_inicio) >= CONVERT(date, '2023-12-01')
		order by fecha_inicio desc
 
		select @fecha_fin_proceso
 
	 SET 	@time_traza=   DATEADD(SECOND, 1, convert(time,@fecha_fin_proceso))
 
		SELECT DATEADD(SECOND, 
               DATEDIFF(SECOND, '00:00:00', @time_traza), 
               CAST(CAST('2023-12-01' AS DATE) AS DATETIME)
              )  NUEVAfechatime
 
 
 
 --('307377-2024','26863-2024')
 --

  select 
  --CONCAT(p.numero_proceso,'-',YEAR(p.fecha_inicio)) 
  *from circulemos2.dbo.proceso p
  where id_tipo_proceso = 4
  and CONCAT(p.numero_proceso,'-',YEAR(p.fecha_inicio)) in('307377-2024','26863-2024')
  
  
  
  
  ('298954-2023',
'303102-2023',
'299205-2023',
'304048-2023',
'304109-2023',
'304119-2023',
'304121-2023',
'304126-2023',
'304127-2023',
'304128-2023',
'304145-2023',
'304148-2023',
'304149-2023',
'304150-2023',
'304151-2023',
'304152-2023',
'301255-2023',
'302138-2023',
'302309-2023',
'302312-2023',
'302381-2023',
'308475-2023',
'308497-2023',
'308530-2023',
'308533-2023',
'308555-2023',
'308557-2023',
'308578-2023',
'308580-2023',
'308581-2023',
'308582-2023',
'308583-2023',
'308584-2023',
'324830-2023',
'326305-2023',
'326307-2023',
'326309-2023',
'309732-2023',
'310418-2023',
'311780-2023',
'313080-2023',
'314353-2023',
'314769-2023',
'315625-2023',
'315739-2023',
'319493-2023',
'319875-2023',
'319876-2023',
'319877-2023',
'319878-2023',
'319879-2023',
'319880-2023',
'319882-2023',
'319883-2023',
'319884-2023',
'322043-2023',
'322262-2023',
'322358-2023',
'322737-2023',
'322739-2023',
'322740-2023',
'324327-2023',
'2443-2024',
'3003-2024',
'3010-2024',
'3011-2024',
'3013-2024',
'3014-2024',
'3015-2024',
'991-2024',
'317073-2023',
'317850-2023',
'324406-2023',
'324828-2023',
'12599-2024',
'13525-2024',
'15045-2024',
'15583-2024',
'15587-2024',
'15591-2024',
'15595-2024',
'15826-2024',
'15931-2024',
'28186-2024',
'18554-2024',
'19298-2024',
'19299-2024',
'19563-2024',
'20046-2024',
'21280-2024',
'21643-2024',
'23525-2024',
'24072-2024',
'22274-2024',
'26698-2024',
'38283-2024'
)


--299205


----------------------------------------------------------------------------------------------------
--Con datos ya filtrados del excel del correo
--Verificar si el numero de juicio está aquí
select * FROM  integracion_terceros.dbo.reconstr_notifica_coactivo_multas r
	where r.NUMERO_JUICIO in



  select CONCAT(p.numero_proceso,'-',YEAR(p.fecha_inicio)) from circulemos2.dbo.proceso p
  where id_tipo_proceso = 4
  and CONCAT(p.numero_proceso,'-',YEAR(p.fecha_inicio)) in ('298954-2023',
'303102-2023',
'299205-2023',
'304048-2023',
'304109-2023',
'304119-2023',
'304121-2023',
'304126-2023',
'304127-2023',
'304128-2023',
'304145-2023',
'304148-2023',
'304149-2023',
'304150-2023',
'304151-2023',
'304152-2023',
'301255-2023',
'302138-2023',
'302309-2023',
'302312-2023',
'302381-2023',
'308475-2023',
'308497-2023',
'308530-2023',
'308533-2023',
'308555-2023',
'308557-2023',
'308578-2023',
'308580-2023',
'308581-2023',
'308582-2023',
'308583-2023',
'308584-2023',
'309732-2023',
'310418-2023',
'311780-2023',
'313080-2023',
'314353-2023',
'315625-2023',
'315739-2023',
'319493-2023',
'322043-2023',
'322262-2023',
'322358-2023',
'324327-2023',
'2443-2024',
'991-2024',
'317850-2023',
'324406-2023',
'12599-2024',
'13525-2024',
'15045-2024',
'15826-2024',
'15931-2024',
'28186-2024',
'18554-2024',
'19298-2024',
'19299-2024',
'19563-2024',
'21643-2024',
'23525-2024',
'24072-2024',
'22274-2024',
'26698-2024'
)





----------------------------------------------------------------------------------
select * FROM  integracion_terceros.dbo.reconstr_notifica_coactivo_multas r
	where r.NUMERO_JUICIO in('302138-2023',
'24072-2024',
'313080-2023',
'22274-2024',
'315625-2023',
'28186-2024',
'298954-2023',
'19299-2024',
'18554-2024',
'2443-2024',
'15826-2024',
'302381-2023',
'13525-2024',
'23525-2024',
'19298-2024',
'303102-2023',
'26698-2024',
'324406-2023',
'19563-2024',
'299205-2023',
'322262-2023',
'21643-2024'
) and ESTADO_LECTURA=1


------------------------------------------------------------

 SELECT  r.NUMERO_COACTIVO, r.FECHA_NOTIFICACION
	, case when r.TIPO_NOTIFICACION ='NOTIFICADO POR EMAIL' then 3
	when r.TIPO_NOTIFICACION ='NOTIFICADO POR GACETA' then 2
	when r.TIPO_NOTIFICACION ='NOTIFICADO POR COURIER' then 1 end TIPO_NOTIFICACION
	, co.id_coactivo, co.id_proceso, pr.id_estado_proceso, co.id_tramite
	FROM  integracion_terceros.dbo.reconstr_notifica_coactivo_multas r
	inner join circulemos2.dbo.coactivo co on r.numero_coactivo = co.numero_coactivo
	inner join circulemos2.dbo.proceso pr on pr.id_proceso = co.id_proceso
	WHERE co.id_tipo_coactivo in (1,2,3) 
	and r.TIPO_NOTIFICACION in (
	'NOTIFICADO POR EMAIL',
    'NOTIFICADO POR GACETA',
    'NOTIFICADO POR COURIER')
	and estado_lectura =1	
	and 1=1
	and NUMERO_JUICIO in ('21643-2024','26698-2024','2443-2024','302138-2023','28186-2024','313080-2023','13525-2024','23525-2024')
	
	
	
	
	('302138-2023',
'24072-2024',
'313080-2023',
'22274-2024',
'315625-2023',
'28186-2024',
'298954-2023',
'19299-2024',
'18554-2024',
'2443-2024',
'15826-2024',
'302381-2023',
'13525-2024',
'23525-2024',
'19298-2024',
'303102-2023',
'26698-2024',
'324406-2023',
'19563-2024',
'299205-2023',
'322262-2023',
'21643-2024'
)


---------------------------------------------------

--28/08/2024

--Verificar si el numero de juicio está aquí
select * FROM  integracion_terceros.dbo.reconstr_notifica_coactivo_multas r
	where r.NUMERO_JUICIO in('310418-2023','315739-2023','21643-2024','322043-2023','308582-2023','309732-2023','24072-2024','308581-2023','301255-2023','311780-2023','304127-2023',
'304119-2023','26698-2024','303102-2023','15045-2024','317850-2023','322262-2023','308475-2023','2443-2024','298954-2023','308555-2023','304152-2023','304145-2023','15931-2024','304126-2023','322358-2023',
'308557-2023','304121-2023','18554-2024','314353-2023','302138-2023','19563-2024','304150-2023','308497-2023','302312-2023','308584-2023','315625-2023','28186-2024','304048-2023','304151-2023',
'308530-2023','308533-2023','319493-2023','304128-2023','308583-2023','15826-2024','304148-2023','313080-2023','13525-2024','324327-2023','302381-2023','12599-2024','308578-2023','324406-2023','304109-2023','23525-2024',
'22274-2024','991-2024','19298-2024','308580-2023','302309-2023','304149-2023','19299-2024','299205-2023')




 SELECT  r.NUMERO_COACTIVO, r.FECHA_NOTIFICACION
	, case when r.TIPO_NOTIFICACION ='NOTIFICADO POR EMAIL' then 3
	when r.TIPO_NOTIFICACION ='NOTIFICADO POR GACETA' then 2
	when r.TIPO_NOTIFICACION ='NOTIFICADO POR COURIER' then 1 end TIPO_NOTIFICACION
	, co.id_coactivo, co.id_proceso, pr.id_estado_proceso, co.id_tramite
	FROM  integracion_terceros.dbo.reconstr_notifica_coactivo_multas r
	inner join circulemos2.dbo.coactivo co on r.numero_coactivo = co.numero_coactivo
	inner join circulemos2.dbo.proceso pr on pr.id_proceso = co.id_proceso
	WHERE co.id_tipo_coactivo in (1,2,3) 
	and r.TIPO_NOTIFICACION in (
	'NOTIFICADO POR EMAIL',
    'NOTIFICADO POR GACETA',
    'NOTIFICADO POR COURIER')
	and estado_lectura =1	
	and 1=1
	and NUMERO_JUICIO in ('310418-2023','315739-2023','21643-2024','322043-2023','308582-2023','309732-2023','24072-2024','308581-2023','301255-2023','311780-2023','304127-2023',
'304119-2023','26698-2024','303102-2023','15045-2024','317850-2023','322262-2023','308475-2023','2443-2024','298954-2023','308555-2023','304152-2023','304145-2023','15931-2024','304126-2023','322358-2023',
'308557-2023','304121-2023','18554-2024','314353-2023','302138-2023','19563-2024','304150-2023','308497-2023','302312-2023','308584-2023','315625-2023','28186-2024','304048-2023','304151-2023',
'308530-2023','308533-2023','319493-2023','304128-2023','308583-2023','15826-2024','304148-2023','313080-2023','13525-2024','324327-2023','302381-2023','12599-2024','308578-2023','324406-2023','304109-2023','23525-2024',
'22274-2024','991-2024','19298-2024','308580-2023','302309-2023','304149-2023','19299-2024','299205-2023')



--32 numeros de juicio


select * FROM  integracion_terceros.dbo.reconstr_notifica_coactivo_multas r
	where r.NUMERO_JUICIO in
('3011-2024','15587-2024','319876-2023','319880-2023','326305-2023','322740-2023','3013-2024','15591-2024',
'319877-2023','319882-2023','326307-2023','20046-2024','314769-2023','3003-2024','3014-2024','15595-2024',
'38283-2024','319878-2023','319883-2023','324828-2023','326309-2023','322737-2023','21280-2024','3010-2024',
'3015-2024','15583-2024','319875-2023','319879-2023','319884-2023','317073-2023','324830-2023','322739-2023')



select  rs.* from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs



--497207



































































































































































































































































































































































































































































































































































































































































































































































































































































































































































