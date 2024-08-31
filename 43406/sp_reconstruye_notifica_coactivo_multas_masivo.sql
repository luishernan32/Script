

use integracion_terceros
DECLARE

@numero_coactivo varchar(50),
@fecha_notificacion datetime,
@tipo_notificacion tinyint,
@id_coactivo bigint,
@id_proceso bigint,
@id_estado_proceso tinyint,
@id_trazabilidad_proceso bigint,
@fecha_fin_proceso datetime,
@id_tramite bigint,
@time_traza time
;


	DECLARE notificaciones_coactivo_csr CURSOR FOR
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
	and NUMERO_JUICIO in('298954-2023','22274-2024','299205-2023','21643-2024','26698-2024','303102-2023','322262-2023','2443-2024','18554-2024','302138-2023','19563-2024','315625-2023','28186-2024','15826-2024','313080-2023','13525-2024','302381-2023','324406-2023','23525-2024','19298-2024','19299-2024')
	


	ORDER BY r.ID_TRAMITE ASC;

	--select * from circulemos2.dbo.tipo_notificacion_coactivo
	-- select * from circulemos2.dbo.estado_proceso where id_tipo_proceso = 4

		OPEN notificaciones_coactivo_csr
	FETCH NEXT FROM notificaciones_coactivo_csr
	INTO  @numero_coactivo, @fecha_notificacion, @tipo_notificacion,@id_coactivo, @id_proceso, @id_estado_proceso, @id_tramite	;

WHILE @@FETCH_STATUS = 0
		BEGIN
	    begin try
		begin tran

		set @time_traza = null

		update circulemos2.dbo.coactivo
		set id_tipo_notificacion_coactivo = @tipo_notificacion
		, fecha_notificacion = @fecha_notificacion
		where id_coactivo = @id_coactivo

				select top 1 @fecha_fin_proceso = fecha_inicio 
		from circulemos2.dbo.trazabilidad_proceso
		where id_proceso = @id_proceso
		and id_estado_proceso  in (21,22,23,24)
	--	and convert(date,fecha_inicio) >= CONVERT(date, @fecha_notificacion)
		order by fecha_inicio desc

		if @fecha_fin_proceso is not null
		begin
		set @time_traza =  DATEADD(SECOND, 1, convert(time,@fecha_fin_proceso)) 
		end
	select @fecha_notificacion received
	if @time_traza is not null begin

	    set @fecha_notificacion =  DATEADD(SECOND, 
               DATEDIFF(SECOND, '00:00:00', @time_traza), 
               CAST(CAST(@fecha_notificacion AS DATE) AS DATETIME)
              ) 
	   select @fecha_notificacion modified
			  end 

		set @id_trazabilidad_proceso = null

		select top 1 @id_trazabilidad_proceso = id_trazabilidad_proceso 
		from circulemos2.dbo.trazabilidad_proceso
		where id_proceso = @id_proceso
		and id_estado_proceso = 23
		and convert(date,fecha_inicio) = CONVERT(date, @fecha_notificacion)
		order by id_trazabilidad_proceso desc


		if @id_estado_proceso = 24 begin
		update circulemos2.dbo.proceso
		set id_estado_proceso = 23,
		observacion = 'NOTIFICADO'
		where id_proceso = @id_proceso

		if @id_trazabilidad_proceso is  null begin
	    

			select @fecha_notificacion insertada_1
		INSERT INTO circulemos2.dbo.trazabilidad_proceso (id_proceso, id_estado_proceso, fecha_inicio, id_usuario, id_sede_proceso, id_sede_usuario)
		values (@id_proceso, 23, @fecha_notificacion, 1, 2, 2);

		update circulemos2.dbo.trazabilidad_proceso 
		set fecha_fin = @fecha_notificacion
		where id_proceso = @id_proceso
		and fecha_fin is null

		end

		end 
		else

		begin 
		set @fecha_fin_proceso = null
				

     select @fecha_notificacion insertada_2
		INSERT INTO circulemos2.dbo.trazabilidad_proceso (id_proceso, id_estado_proceso, fecha_inicio, fecha_fin,id_usuario, id_sede_proceso, id_sede_usuario)
		values (@id_proceso, 23, @fecha_notificacion, @fecha_notificacion, 1, 2, 2);

		end

		update integracion_terceros.dbo.reconstr_notifica_coactivo_multas
		set ESTADO_LECTURA = 2
		where id_tramite = @id_tramite;

		select 'Coactivo: '+@numero_coactivo as Coactivo,  'Exito' as Resultado

		commit tran

			END TRY
	BEGIN CATCH
		--SELECT ERROR_MESSAGE() AS ErrorMessage;  

		IF @@TRANCOUNT > 0  
	        ROLLBACK TRANSACTION; 

		update integracion_terceros.dbo.reconstr_notifica_coactivo_multas
		set error = ERROR_MESSAGE(),
		ESTADO_LECTURA = 3
		where id_tramite = @id_tramite;

	END CATCH


			FETCH NEXT FROM notificaciones_coactivo_csr
			INTO  @numero_coactivo, @fecha_notificacion, @tipo_notificacion	,@id_coactivo, @id_proceso, @id_estado_proceso, @id_tramite;
END
	CLOSE notificaciones_coactivo_csr;
	DEALLOCATE notificaciones_coactivo_csr;
