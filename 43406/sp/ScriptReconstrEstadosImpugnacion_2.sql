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
@path_documento varchar(255) NULL,
@id_usuario Integer,
@id_usuario2 Integer
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

	
	
OPEN cerrar_impugnaciones_csr
	FETCH NEXT FROM cerrar_impugnaciones_csr
	INTO @id_reconstr, @expediente,@Tipo_Fallo,@Motivación_fallo,@Usuario_Sogit_Fallo,@Fecha_Fallo,@Plantilla_Fallo,
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

/*select * from circulemos2.dbo.estado_proceso
where nombre like '%FALLO PRO%'*/

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

--.1 Verificar la asignación de las variables del cursor, que esté la misma cantidad del cursor y en el mismo orden.
--.2.-Borrar registro de la tabla reconstruccion reconstr_estados_impugnacion e insertar el primer registro del nuevo listado.
--3.- Insertar la trazabilidad del estado cerrado 

-- INSERTAR ESTADO CERRADO

SELECT *FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Estado SOGIT resolucion] like '%CERRADO%'

  select @id_usuario2 =  id_usuario 
from circulemos2.dbo.usuario_persona
where login = @Usuario_Sogit_Resolucion_Estado_Cerrado

INSERT INTO integracion_terceros.[dbo].[reconstr_estados_impugnacion]
           ([expediente]
           ,[Tipo Fallo]
           ,[Motivación_fallo]
           ,[Usuario Sogit Fallo]
           ,[Fecha Fallo]
           ,[Plantilla Fallo]
           ,[Documento Fallo]
           ,[Estado Fallo]
           ,[Usuario Sogit Resolucion(Estado_Cerrado)]
           ,[Fecha_resolucion(Estado_Cerrado)]
           ,[documento resolucion]
           ,[Estado SOGIT resolucion]
           ,[fecha_procesamiento]
           ,[procesado]
           ,[error]
           ,[path_documento])
     VALUES
	 (@expediente,@Tipo_Fallo,@Motivación_fallo,@id_usuario,@Fecha_Fallo,@Plantilla_Fallo,@Documento_Fallo,@Estado_Fallo,@id_usuario2,@Fecha_resolucion_Estado_Cerrado,
         @documento_resolucion,@Estado_SOGIT_resolucion

--('14807-2023','Condenatorio','texto grande','darling.magallanes','7-12-2023','Registro Fallo','RESOLUCION ADMINISTRATIVA 14807-2023.pdf','FALLO PROYECTADO',
--'felipe.larreategui','07-12-2023','RESOLUCION ADMINISTRATIVA 14807-2023.pdf','CERRADO',null,1,null,null)



		/*

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
		 */

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
	INTO  
	     @id_reconstr, @expediente,@Tipo_Fallo,@Motivación_fallo,@Usuario_Sogit_Fallo,@Fecha_Fallo,@Plantilla_Fallo,
         @Documento_Fallo,@Estado_Fallo,@Usuario_Sogit_Resolucion_Estado_Cerrado,@Fecha_resolucion_Estado_Cerrado,
         @documento_resolucion,@Estado_SOGIT_resolucion;
END
	CLOSE cerrar_impugnaciones_csr;
	DEALLOCATE cerrar_impugnaciones_csr;






