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
@fecha_creacion datetime2,
@TSQL varchar(2000),
@TSQL2 varchar(2000),
@fecha_anulacion dateTIME,
@fecha_infraccion dateTIME,

@tipo_coactivo Integer,
@id_reconstr bigint,
@expediente varchar(20),	
@Tipo_Fallo varchar(50), 
@Motivación_fallo varchar(max),	
@Usuario_Sogit_Fallo varchar(20),
@Fecha_Fallo datetime,
@Plantilla_Fallo varchar(50),	
@Documento_Fallo varchar(255) NULL,	
@Estado_Fallo varchar(50),	
@Usuario_Sogit_Resolucion_Estado_Cerrado varchar(20),
@Fecha_resolucion_Estado_Cerrado datetime,	
@documento_resolucion varchar(50),	
@Estado_SOGIT_resolucion varchar(50),
@fecha_procesamiento datetime,	
@procesado smallint NOT NULL,	
@error varchar(250) NULL,	
@path_documento varchar(255) NULL
;



DECLARE cerrar_impugnaciones_csr CURSOR FOR
	SELECT  
 [id_reconstr],
[expediente],
[Tipo Fallo],
[Motivación_fallo],
[Usuario Sogit Fallo],
[Fecha Fallo],
[Plantilla Fallo],
[Documento Fallo],
[Estado Fallo],
[Usuario Sogit Resolucion(Estado_Cerrado)],
[Fecha_resolucion(Estado_Cerrado)],
[documento resolucion],
[Estado SOGIT resolucion]
 from   integracion_terceros.dbo.reconstr_estados_impugnacion re
	where re.procesado = 0
	and re.error is null
	
	 if	(select count(pr.id_proceso)
		from circulemos2.dbo.proceso pr
		where pr.id_tipo_proceso= 1
		and CONCAT(pr.numero_proceso, '-', YEAR(pr.fecha_inicio))=concat(@numero_proceso,'-', YEAR(@fecha_creacion)))> 0 
		
		begin
				set @msg='El número de expediente no existe'
			;THROW 50001, @msg , 1;
		end


		if @numero_proceso is null
		begin
		IF LEN(@expediente)<1
		begin
		set @msg='El expediente no existe';
		THROW 50001, @msg , 1;
		
		
		--Consultar por número de expediente, se ese select devuelve cero del número del expediente no existe

		--select top 2 *from circulemos2.dbo.proceso

		--if	(select count(pr.id_proceso)
		--from circulemos2.dbo.proceso pr
		--where pr.id_tipo_proceso= 4
		--and CONCAT(pr.numero_proceso, '-', YEAR(pr.fecha_inicio))=concat(@numero_proceso,'-', YEAR(@fecha_creacion)))> 0 
		--begin
		--		set @msg='Numero Juicio Ocupado.'
		--	;THROW 50001, @msg , 1;
		--end


		--algo parecido a esto
 
  --      pero ahora debe validar que el expediente sí exista

		--recuerde que los expediente son id_tipo_proceso = 1
 


	--select * from circulemos2.dbo.tipo_notificacion_coactivo
	-- select * from circulemos2.dbo.estado_proceso where id_tipo_proceso = 4

		OPEN cerrar_impugnaciones_csr
	FETCH NEXT FROM cerrar_impugnaciones_csr
	INTO  --@id_reconstr, @expediente, @Tipo_Fallo--,@id_tramite,  @id_factura, @valor_factura, @tipo_identificacion, @numero_identificacion, @numero_proceso, @fecha_creacion, @tipo_coactivo	;

	     --@tipo_coactivo,@id_reconstr,
		 @expediente,@Tipo_Fallo,@Motivación_fallo,@Usuario_Sogit_Fallo,@Fecha_Fallo,@Plantilla_Fallo,
         @Documento_Fallo,@Estado_Fallo,@Usuario_Sogit_Resolucion_Estado_Cerrado,@Fecha_resolucion_Estado_Cerrado,
         @documento_resolucion,@Estado_SOGIT_resolucion,@fecha_procesamiento,@procesado,@error,@path_documento;

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
		set @fecha_infraccion = null

    if @numero_proceso is null
		begin
				set @msg='Debe asignar un numero de proceso disponible.'
			;THROW 50001, @msg , 1;
		end 


	  if	(select count(pr.id_proceso)
		from circulemos2.dbo.proceso pr
		where pr.id_tipo_proceso= 4
		and CONCAT(pr.numero_proceso, '-', YEAR(pr.fecha_inicio))=concat(@numero_proceso,'-', YEAR(@fecha_creacion)))> 0 
			
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


	   select @cicomparendo = cicomparendo,@fecha_infraccion = fecha_infraccion  from circulemos2.dbo.comparendo
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

		BEGIN TRAN

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


INSERT INTO circulemos2.[dbo].[obligacion_coactivo]
           ([id_coactivo]
           ,[codigo_tipo_obligacion]
           ,[numero_obligacion]
           ,[fecha_obligacion]
           ,[valor_costas_procesales]
           ,[valor_obligacion]
           ,[valor_interes_moratorios]
           ,[id_cartera]
           ,[id_estado_obligacion_coactivo])
     VALUES
	      (@id_coactivo,1,@id_factura,@fecha_infraccion,0,@valor_factura,0,@id_cartera,1)


INSERT INTO circulemos2.[dbo].[comparendo_proceso]
           ([cicomparendo]
           ,[id_proceso])
     VALUES
	           (@cicomparendo,@id_proceso)


INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
 
	 (@id_proceso,21,@fecha_creacion,@fecha_creacion,1,2,1)

INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
 
	 (@id_proceso,22, DATEADD(SECOND, 2, @fecha_creacion),DATEADD(SECOND, 2, @fecha_creacion),1,2,1)

INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
 
	 (@id_proceso,24, DATEADD(SECOND,4 , @fecha_creacion),DATEADD(SECOND, 4, @fecha_creacion),1,2,1)

if @fecha_notificacion is not null begin

set @fecha_notificacion = DATEADD(HOUR, 12, DATEADD(DAY, DATEDIFF(DAY, 0, @fecha_notificacion), 0))

INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
 
	 (@id_proceso,23, @fecha_notificacion,DATEADD(SECOND, 4, @fecha_notificacion),1,2,1)

end
INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
 
	 (@id_proceso,31, @fecha_anulacion,DATEADD(SECOND, 4, @fecha_anulacion),1,2,1)



		update circulemos2.dbo.coactivo_pendiente
		set registro_nuevo = 0
		, coactivo_exitoso = 1
		, descripcion_error = null
		where numero_coactivo = @numero_coactivo;

		select 'Coactivo: '+@numero_coactivo as Coactivo,  'Exito' as Resultado, 'id_proceso: '+ cast(@id_proceso as varchar) as Coactivo

		commit tran

			END TRY
	BEGIN CATCH
		--SELECT ERROR_MESSAGE() AS ErrorMessage;  
		--SELECT ERROR_LINE() AS ErrorLine;

		IF @@TRANCOUNT > 0  
	        ROLLBACK TRANSACTION; 

		update circulemos2.dbo.coactivo_pendiente
		set descripcion_error = ERROR_MESSAGE(),
		coactivo_exitoso = 0,
		registro_nuevo = 0
		where numero_coactivo = @numero_coactivo;

	END CATCH


			FETCH NEXT FROM cerrar_impugnaciones_csr
	INTO  @numero_coactivo, @fecha_notificacion, @tipo_notificacion,@id_tramite,  @id_factura, @valor_factura, @tipo_identificacion, @numero_identificacion, @numero_proceso, @fecha_creacion, @tipo_coactivo	
	     @expediente,@Tipo_Fallo,@Motivación_fallo,@Usuario_Sogit_Fallo,@Fecha_Fallo,@Plantilla_Fallo,
         @Documento_Fallo,@Estado_Fallo,@Usuario_Sogit_Resolucion_Estado_Cerrado,@Fecha_resolucion_Estado_Cerrado,
         @documento_resolucion,@Estado_SOGIT_resolucion,@fecha_procesamiento,@procesado,@error,@path_documento;
END
	CLOSE cerrar_impugnaciones_csr;
	DEALLOCATE cerrar_impugnaciones_csr;






