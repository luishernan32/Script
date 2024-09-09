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
@time_traza time,
@id_factura bigint,
@valor_factura numeric(10,2),
@tipo_identificacion varchar(10),
@numero_identificacion varchar(20),
@id_persona bigint,
@msg varchar(2000),
@cicomparendo bigint,
@id_cartera bigint,
@numero_proceso varchar(20),
@fecha_creacion date,
@TSQL varchar(2000),
@TSQL2 varchar(2000),
@fecha_anulacion date,
@tipo_coactivo Integer
;


	DECLARE reconstr_coactivo_csr CURSOR FOR
	SELECT  cp.NUMERO_COACTIVO
	, rn.FECHA_NOTIFICACION FECHA_NOTIFICACION	
	, case when rn.TIPO_NOTIFICACION ='NOTIFICADO POR EMAIL' then 3
	when rn.TIPO_NOTIFICACION ='NOTIFICADO POR GACETA' then 2
	when rn.TIPO_NOTIFICACION ='NOTIFICADO POR COURIER' then 1 end TIPO_NOTIFICACION
	, cp.id_tramite
	, factura
	, cp.valor_factura
	, cp.tipo_identificacion
	, cp.numero_identificacion
	, cp.numero_proceso
	, cp.fecha_creacion
	, cp.tipo_coactivo
	from circulemos2.dbo.coactivo_pendiente cp
	left join integracion_terceros.dbo.reconstr_notifica_coactivo_multas rn on rn.NUMERO_COACTIVO = cp.numero_coactivo
	where not exists (select 1 from circulemos2.dbo.coactivo co where co.numero_coactivo = cp.numero_coactivo)
	and cp.coactivo_exitoso = 0
    and  cp.numero_coactivo = 13664847
	ORDER BY cp.id_tramite ASC;

	--select * from circulemos2.dbo.tipo_notificacion_coactivo
	-- select * from circulemos2.dbo.estado_proceso where id_tipo_proceso = 4

		OPEN reconstr_coactivo_csr
	FETCH NEXT FROM reconstr_coactivo_csr
	INTO  @numero_coactivo, @fecha_notificacion, @tipo_notificacion,@id_tramite,  @id_factura, @valor_factura, @tipo_identificacion, @numero_identificacion, @numero_proceso, @fecha_creacion, @tipo_coactivo	;

WHILE @@FETCH_STATUS = 0
		BEGIN




	    begin try
		set @id_persona = null
		set @cicomparendo = null
		SET @fecha_anulacion = null
		SET @TSQL = null
	    SET @TSQL2 = null
		set @id_proceso = null
		set @id_coactivo = null

    if @numero_proceso is null
		begin
				set @msg='Debe asignar un numero de proceso disponible.'
			;THROW 50001, @msg , 1;
		end 


	  if	(select count(pr.id_proceso)
		from circulemos2.dbo.proceso pr
		where CONCAT(pr.numero_proceso, '-', YEAR(pr.fecha_inicio))=concat(@numero_proceso,'-', YEAR(@fecha_creacion)))> 0 
			
		begin
				set @msg='Numero Juicio Ocupado.'
			;THROW 50001, @msg , 1;
		end 


	   select @id_persona = pe.id_persona
		from  circulemos2.dbo.persona pe 
		inner join circulemos2.dbo.tipo_identificacion_persona tip on tip.id_tipo_identificacion = pe.id_tipo_identificacion
		where pe.numero_identificacion = @numero_identificacion
		and tip.sigla = @tipo_identificacion 

		if @id_persona is null begin 
		set @msg='La persona no existe. Favor gestionar su registro'
			;THROW 50001, @msg , 1;

         end


	   select @cicomparendo = cicomparendo from circulemos2.dbo.comparendo
	   where id_factura_axis = @id_factura

	   		if @cicomparendo is null begin 
		set @msg='El Comparendo no existe. Favor gestionar su registro'
			;THROW 50001, @msg , 1;

         end


	   select @id_cartera = id_cartera from circulemos2.dbo.cartera
	   where codigo_tipo_obligacion = 1
	   and nombre = @id_factura

	   		if @id_cartera is null begin 
		set @msg='La cartera no existe. Favor gestionar su registro'
			;THROW 50001, @msg , 1;

         end

	

				SET @TSQL = '	SELECT 
							id_factura,
							fecha_anulacion
						FROM fa_facturas_anuladas
						WHERE id_factura = ';
 
		SET  @TSQL2 = 'SELECT * FROM OPENQUERY(SRVBDATMJG, ''' + @TSQL +  CAST(@numero_coactivo AS VARCHAR(25)) + ''''+')';

		        IF OBJECT_ID( N'tempdb..##tmp_datos_anulacion') IS NOT NULL
        DROP TABLE ##tmp_datos_anulacion
		CREATE TABLE ##tmp_datos_anulacion (numero_coactivo BIGINT, fecha_anulacion DATE) 
        INSERT INTO ##tmp_datos_anulacion EXEC (@TSQL2)

	set @fecha_anulacion = null
	SET @fecha_anulacion = (SELECT fecha_anulacion FROM ##tmp_datos_anulacion WHERE numero_coactivo = @numero_coactivo)

	if @fecha_anulacion is null
	begin
		set @msg='No existe fecha anulacion en AXIS'
			;THROW 50001, @msg , 1;
	end

		begin tran

		INSERT INTO circulemos2.[dbo].[proceso]
           ([id_tipo_proceso]
           ,[numero_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[observacion]
           ,[id_estado_proceso])
     VALUES
	        (4,@numero_proceso,@fecha_creacion,@fecha_anulacion,'COACTIVO ANULADO',31)

			set @id_proceso = SCOPE_IDENTITY()
			
INSERT INTO circulemos2.[dbo].[coactivo]
           ([codigo_organismo]
           ,[id_deudor]
           ,[id_configuracion_coactivo]
           ,[id_cargue_coactivo]
           ,[id_proceso]
           ,[id_funcionario]
           ,[id_direccion]
           ,[id_tramite]
           ,[anio]
           ,[cantidad_obligaciones]
           ,[fecha_notificacion]
           ,[numero_coactivo]
           ,[valor_total_obligaciones]
           ,[valor_total_costas_procesales]
           ,[id_tipo_notificacion_coactivo]
           ,[id_tipo_coactivo])
     VALUES
           (11001,@id_persona,4,null,@id_proceso,42,null,@id_tramite,YEAR(@fecha_creacion),1,@fecha_notificacion,@numero_coactivo,@valor_factura,0,@tipo_notificacion,@tipo_coactivo)
		   	set @id_coactivo = SCOPE_IDENTITY()


			/*

			insert obligacion_coactivo
			insert comparendo_proceso
			insert trazabilidad_proceso
			*/



		update circulemos2.dbo.coactivo_pendiente
		set registro_nuevo = 0
		, coactivo_exitoso = 1
		, descripcion_error = null
		where numero_coactivo = @numero_coactivo;

		select 'Coactivo: '+@numero_coactivo as Coactivo,  'Exito' as Resultado

		commit tran

			END TRY
	BEGIN CATCH
		--SELECT ERROR_MESSAGE() AS ErrorMessage;  

		IF @@TRANCOUNT > 0  
	        ROLLBACK TRANSACTION; 

		update circulemos2.dbo.coactivo_pendiente
		set descripcion_error = ERROR_MESSAGE(),
		coactivo_exitoso = 0,
		registro_nuevo = 1
		where numero_coactivo = @numero_coactivo;

	END CATCH


			FETCH NEXT FROM reconstr_coactivo_csr
	INTO  @numero_coactivo, @fecha_notificacion, @tipo_notificacion,@id_tramite,  @id_factura, @valor_factura, @tipo_identificacion, @numero_identificacion, @numero_proceso, @fecha_creacion, @tipo_coactivo	;
END
	CLOSE reconstr_coactivo_csr;
	DEALLOCATE reconstr_coactivo_csr;
