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
@Motivaci�n_fallo varchar(max),	
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
@path_documento varchar(255) NULL,
@id_usuario Integer,


@id_proceso_coactivo Integer
;



DECLARE cerrar_impugnaciones_csr CURSOR FOR
	SELECT  
 [id_reconstr],
[expediente],
[Tipo Fallo],
[Motivaci�n_fallo],
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

	
	
OPEN cerrar_impugnaciones_csr
	FETCH NEXT FROM cerrar_impugnaciones_csr
	INTO @id_reconstr, @expediente,@Tipo_Fallo,@Motivaci�n_fallo,@Usuario_Sogit_Fallo,@Fecha_Fallo,@Plantilla_Fallo,
         @Documento_Fallo,@Estado_Fallo,@Usuario_Sogit_Resolucion_Estado_Cerrado,@Fecha_resolucion_Estado_Cerrado,
         @documento_resolucion,@Estado_SOGIT_resolucion;

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
		set @id_usuario = null


		select @id_proceso= pr.id_proceso
		from circulemos2.dbo.proceso pr
		where pr.id_tipo_proceso= 1
		and CONCAT(pr.numero_proceso, '-', YEAR(pr.fecha_inicio))=@expediente

	  if	@id_proceso = null
			
		begin
				set @msg='El expediente no existe en Sogit. Favor validar'
			;THROW 50001, @msg , 1;
		end 

select @id_usuario =  id_usuario 
from circulemos2.dbo.usuario_persona
where login = @Usuario_Sogit_Fallo

-- INSERTAR FALLO PROYECTADO
INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
 
	 (@id_proceso,3,@Fecha_Fallo,@Fecha_Fallo,@id_usuario,2,1)
	 set @id_trazabilidad_proceso= SCOPE_IDENTITY()


	 INSERT INTO [circulemos2].[dbo].[fallo_impugnacion]
           ([id_trazabilidad_proceso]
           ,[id_tipo_fallo]
           ,[motivo]
           ,[porcentaje]
           ,[codigo_plantilla]
           ,[valor_obligacion]
           ,[valor_descuento]
           ,[puntos]
           ,[id_infraccion]
           ,[id_memo_fallo]
           ,[id_funcionario]
           ,[valor_total_devolucion])
     VALUES (@id_trazabilidad_proceso,@Tipo_Fallo,@Motivaci�n_fallo,0.00,@Plantilla_Fallo,0.00,0.00,null,null,null,null,null)
           


SELECT @Tipo_Fallo=[Tipo Fallo] FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Tipo Fallo] is not null

SELECT @Motivaci�n_fallo=[Motivaci�n_fallo] FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Motivaci�n_fallo] is not null

SELECT @Plantilla_Fallo=[Plantilla Fallo] FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Plantilla Fallo] is not null


-- INSERTAR ESTADO CERRADO

update  circulemos2.[dbo].[proceso]
		set id_estado_proceso = 4, fecha_fin=@Fecha_resolucion_Estado_Cerrado,observacion='CERRADO'
		where id_proceso = @id_proceso;

set @id_proceso_coactivo=null;

select @id_proceso_coactivo=co.id_proceso
from coactivo co
inner join proceso po on po.id_proceso=co.id_proceso
inner join obligacion_coactivo oc on co.id_coactivo=oc.id_coactivo
inner join comparendo com on com.id_factura_axis=oc.numero_obligacion
inner join comparendo_proceso cp on cp.cicomparendo=com.cicomparendo 
inner join proceso pe on pe.id_proceso=cp.id_proceso and pe.id_tipo_proceso = 1
where concat(num_proceso,'-',year(p.fecha_inicio))=@expediente


update circulemos2.[dbo].[trazabilidad_proceso]
set fecha_fin=@Fecha_resolucion_Estado_Cerrado

where id_proceso=@id_proceso_coactivo
and fecha_fin is null

--insertarle un trazabildiad_proceso
INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
 
	 (@id_proceso_coactivo,23,@Fecha_resolucion_Estado_Cerrado,null,1,2,1)
	 set @id_trazabilidad_proceso= SCOPE_IDENTITY()



update  circulemos2.[dbo].[proceso]
		set id_estado_proceso = 23, fecha_fin=@Fecha_resolucion_Estado_Cerrado,observacion='NOTIFICADO'
		where id_proceso = @id_proceso_coactivo;


INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
 
	 (@id_proceso,4,@Fecha_resolucion_Estado_Cerrado,@Fecha_resolucion_Estado_Cerrado,@id_usuario,2,1)

 

 select @Usuario_Sogit_Resolucion_Estado_Cerrado=[Usuario Sogit Resolucion(Estado_Cerrado)] FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Usuario Sogit Resolucion(Estado_Cerrado)] is not null

  select @Fecha_resolucion_Estado_Cerrado=[Fecha_resolucion(Estado_Cerrado)] FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Fecha_resolucion(Estado_Cerrado)] is not null

  select @Estado_SOGIT_resolucion= [Estado SOGIT resolucion]  FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Estado SOGIT resolucion] is not null


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

		IF @@TRANCOUNT > 0  
	        ROLLBACK TRANSACTION; 

		update circulemos2.dbo.coactivo_pendiente
		set descripcion_error = ERROR_MESSAGE(),
		coactivo_exitoso = 0,
		registro_nuevo = 0
		where numero_coactivo = @numero_coactivo;

	END CATCH


			FETCH NEXT FROM cerrar_impugnaciones_csr
	INTO  
	     @id_reconstr, @expediente,@Tipo_Fallo,@Motivaci�n_fallo,@Usuario_Sogit_Fallo,@Fecha_Fallo,@Plantilla_Fallo,
         @Documento_Fallo,@Estado_Fallo,@Usuario_Sogit_Resolucion_Estado_Cerrado,@Fecha_resolucion_Estado_Cerrado,
         @documento_resolucion,@Estado_SOGIT_resolucion;
END
	CLOSE cerrar_impugnaciones_csr;
	DEALLOCATE cerrar_impugnaciones_csr;
