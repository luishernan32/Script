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
@id_factura_axis varchar(10),

@tipo_coactivo Integer,
@id_reconstr bigint,
@expediente varchar(20),	
@Tipo_Fallo varchar(50), 
@Motivación_fallo varchar(max),	
@Usuario_Sogit_Fallo varchar(20),
@Fecha_Fallo date,
@Plantilla_Fallo varchar(50),	
@Documento_Fallo varchar(255) ,	
@Estado_Fallo varchar(50),	
@Usuario_Sogit_Resolucion_Estado_Cerrado varchar(20),
@Fecha_resolucion_Estado_Cerrado date,	
@documento_resolucion varchar(50),	
@Estado_SOGIT_resolucion varchar(50),
@fecha_procesamiento datetime,	
@procesado smallint ,	
@error varchar(250) ,	
@path_documento varchar(255) ,
@id_usuario Integer,
@id_tipo_fallo Integer,
@id_usuario_cerrado Integer,
@id_proceso_coactivo Integer,
 @codigoDocumento bigint,
 @id_trazabilidad_cerrado bigint,
  @id_estado_proceso_coactivo Integer ;
declare @consecutivoDocumento bigint;
declare @pathDocumento varchar(1000);
declare @nombreDocumento varchar(100);
declare @path_documento_fallo varchar(1000);



DECLARE cerrar_impugnaciones_csr CURSOR FOR
	SELECT  
 [id_reconstr],
[expediente],
[Tipo Fallo],
[Motivación_fallo],
[Usuario Sogit Fallo],
cast([Fecha Fallo] as date) [Fecha Fallo],
[Plantilla Fallo],
[Documento Fallo],
[Estado Fallo],
[Usuario Sogit Resolucion(Estado_Cerrado)],
cast([Fecha_resolucion(Estado_Cerrado)] as date) [Fecha_resolucion(Estado_Cerrado)] ,
[documento resolucion],
[Estado SOGIT resolucion]
 from   integracion_terceros.dbo.reconstr_estados_impugnacion re
	where re.procesado = 0
	and expediente = '15066-2023'
	and re.error is null


/*	SELECT  *

 from   integracion_terceros.dbo.reconstr_estados_impugnacion re
	where re.procesado = 0
	and re.error is null*/



	
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
		set @path_documento_fallo = null
		SET @id_trazabilidad_cerrado = NULL
		set @id_factura_axis = null


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

set @id_tipo_fallo = null

select @id_tipo_fallo = id_tipo_fallo from circulemos2.dbo.tipo_fallo
where nombre = @Tipo_Fallo

--set @Fecha_Fallo = DATEADD(HOUR, 12, DATEADD(DAY, DATEDIFF(DAY, 0, @Fecha_Fallo), 0))

-- INSERTAR FALLO PROYECTADO
BEGIN TRAN
INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
 
	 (@id_proceso,3,CONCAT(@Fecha_Fallo, ' 12:00:00'),CONCAT(@Fecha_Fallo, ' 12:00:00'),@id_usuario,2,1)


	 set @id_trazabilidad_proceso= SCOPE_IDENTITY()

--**Tabla fallo impugnacion
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
     VALUES (@id_trazabilidad_proceso,@id_tipo_fallo,@Motivación_fallo,0.00,@Plantilla_Fallo,0.00,0.00,null,null,null,null,null)


		set @codigoDocumento = null;
		set @consecutivoDocumento = null;
		set @pathDocumento = null
		set @nombreDocumento = null

	    select @consecutivoDocumento = consecutivo + 1
		from documentos.dbo.consecutivo_documento_reconstruccion 
		where id_consecutivo_documento_reconstruccion = 1

			   
		set @nombreDocumento = CONCAT(@consecutivoDocumento, '.pdf')
		set @pathDocumento = '/documentos/c2/Impugnacion_Fallo/'
		set @pathDocumento = concat(@pathDocumento,YEAR(@Fecha_Fallo),'/',MONTH(@Fecha_Fallo),'/',DAY(@Fecha_Fallo),'/');
 
		INSERT INTO gestor_docs.dbo."data_documento" ("descripcion", "nombre", "folder", "extension", "nombre_real", "Registro_BD") 
		VALUES ('Registro Fallo', @nombreDocumento, @pathDocumento, '.pdf', @consecutivoDocumento, 0);
 
		set @codigoDocumento = SCOPE_IDENTITY();
 
		update  documentos.dbo.consecutivo_documento_reconstruccion
		set consecutivo = @consecutivoDocumento
		where id_consecutivo_documento_reconstruccion = 1

	--	select @Fecha_Fallo as fecha_fallo

		INSERT INTO gestor_docs.dbo."version_data_documento" ( "codigo_documento", "contenido_binario", "fecha", "version") 
		VALUES (@codigoDocumento, 0X, CONCAT(@Fecha_Fallo, ' 12:00:00'), 1);
 
		set @nombreDocumento = CONCAT(@consecutivoDocumento, '_v1.pdf')
 
		INSERT INTO documentos.dbo."documento" ( "nombre_documento", "consecutivo_documento", "version_documento", "id_plantilla", "path_documento", "fecha_generacion", "id_usuario", "id_documento_origen", "descripcion_documento", "firmado", "codigo_documento", "version_documento_cm", "fecha_creacion") 
		VALUES ( @nombreDocumento, @consecutivoDocumento, 1,
		(select MAX(id_plantilla) from documentos.dbo.plantilla
		where codigo_plantilla = @Plantilla_Fallo)

		,concat(@pathDocumento,@nombreDocumento)  , CONCAT(@Fecha_Fallo, ' 12:00:00'), 1, NULL, 'Registro Fallo', 0, @codigoDocumento, 1, CONCAT(@Fecha_Fallo, ' 12:00:00'));

		--205 ;Error de conversión al convertir el valor varchar 'COACTIVO IMPUGNACION JUDICIAL' al tipo de datos int.


			INSERT INTO circulemos2.dbo."documento_proceso" ( "id_trazabilidad_proceso", "numero_documento", "id_comparendo_proceso", "id_tipo_documento_proceso", "id_firma_persona", "responsable_generacion") 
		VALUES ( @id_trazabilidad_proceso, @consecutivoDocumento, NULL, 
		(select max ( id_tipo_documento_proceso)from circulemos2.dbo.tipo_documento_proceso
		where  id_tipo_documento_proceso = 2)
		, NULL, NULL);
           
		   set @path_documento_fallo =  concat(@pathDocumento,@nombreDocumento) 

		   set @id_usuario_cerrado = null

		   select @id_usuario_cerrado =  id_usuario 
from circulemos2.dbo.usuario_persona
where login = @Usuario_Sogit_Resolucion_Estado_Cerrado

set @Fecha_resolucion_Estado_Cerrado = DATEADD(HOUR, 13, DATEADD(DAY, DATEDIFF(DAY, 0, @Fecha_resolucion_Estado_Cerrado), 0))

INSERT INTO circulemos2.[dbo].[trazabilidad_proceso]
           ([id_proceso]
           ,[id_estado_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[id_usuario]
           ,[id_sede_proceso]
           ,[id_sede_usuario])
     VALUES
 
	 (@id_proceso,4,CONCAT(@Fecha_resolucion_Estado_Cerrado, ' 13:00:00'),CONCAT(@Fecha_resolucion_Estado_Cerrado, ' 13:00:00'),@id_usuario_cerrado,2,1)

	 set @id_trazabilidad_cerrado = SCOPE_IDENTITY()
		set @codigoDocumento = null;
		set @consecutivoDocumento = null;
		set @pathDocumento = null
		set @nombreDocumento = null

		select @consecutivoDocumento = consecutivo + 1
		from documentos.dbo.consecutivo_documento_reconstruccion 
		where id_consecutivo_documento_reconstruccion = 1


		set @nombreDocumento = CONCAT(@consecutivoDocumento, '.pdf')
		set @pathDocumento = '/documentos/c2/Impugnacion_Fallo/'
		set @pathDocumento = concat(@pathDocumento,YEAR(@Fecha_Fallo),'/',MONTH(@Fecha_Fallo),'/',DAY(@Fecha_Fallo),'/');
 
		INSERT INTO gestor_docs.dbo."data_documento" ("descripcion", "nombre", "folder", "extension", "nombre_real", "Registro_BD") 
		VALUES ('Aprobacion Fallo', @nombreDocumento, @pathDocumento, '.pdf', @consecutivoDocumento, 0);
 
		set @codigoDocumento = SCOPE_IDENTITY();
 
		update  documentos.dbo.consecutivo_documento_reconstruccion
		set consecutivo = @consecutivoDocumento
		where id_consecutivo_documento_reconstruccion = 1

		INSERT INTO gestor_docs.dbo."version_data_documento" ( "codigo_documento", "contenido_binario", "fecha", "version") 
		VALUES (@codigoDocumento, 0X, CONCAT(@Fecha_Fallo, ' 12:00:00'), 1);
 
		set @nombreDocumento = CONCAT(@consecutivoDocumento, '_v1.pdf')
 
		INSERT INTO documentos.dbo."documento" ( "nombre_documento", "consecutivo_documento", "version_documento", "id_plantilla", "path_documento", "fecha_generacion", "id_usuario", "id_documento_origen", "descripcion_documento", "firmado", "codigo_documento", "version_documento_cm", "fecha_creacion") 
		VALUES ( @nombreDocumento, @consecutivoDocumento, 1,
		(select MAX(id_plantilla) from documentos.dbo.plantilla
		where codigo_plantilla = @Plantilla_Fallo)

		,concat(@pathDocumento,@nombreDocumento)  , CONCAT(@Fecha_Fallo, ' 12:00:00'), 1, NULL, 'Registro Fallo', 0, @codigoDocumento, 1, CONCAT(@Fecha_Fallo, ' 12:00:00'));


			INSERT INTO circulemos2.dbo."documento_proceso" ( "id_trazabilidad_proceso", "numero_documento", "id_comparendo_proceso", "id_tipo_documento_proceso", "id_firma_persona", "responsable_generacion") 
		VALUES ( @id_trazabilidad_cerrado, @consecutivoDocumento, NULL, 
		(select max ( id_tipo_documento_proceso)from circulemos2.dbo.tipo_documento_proceso
		where  id_tipo_documento_proceso = 2)
		, NULL, NULL);


update  circulemos2.[dbo].[proceso]
		set id_estado_proceso = 4, fecha_fin=@Fecha_resolucion_Estado_Cerrado,observacion='CERRADO'
		where id_proceso = @id_proceso;

/* Hasta aqui la actualizacion a estado cerrado */

set @id_proceso_coactivo=null;



select @id_proceso_coactivo=co.id_proceso
, @id_factura_axis = com.id_factura_axis 
from circulemos2.dbo.coactivo co
inner join circulemos2.dbo.proceso po on po.id_proceso=co.id_proceso
inner join circulemos2.dbo.obligacion_coactivo oc on co.id_coactivo=oc.id_coactivo
inner join circulemos2.dbo.comparendo com on cast(com.id_factura_axis as varchar)=cast(oc.numero_obligacion as varchar)
inner join circulemos2.dbo.comparendo_proceso cp on cp.cicomparendo=com.cicomparendo 
inner join circulemos2.dbo.proceso pe on pe.id_proceso=cp.id_proceso and pe.id_tipo_proceso = 1
where concat(pe.numero_proceso,'-',year(pe.fecha_inicio))=@expediente



update circulemos2.[dbo].[trazabilidad_proceso]
set fecha_fin=@Fecha_resolucion_Estado_Cerrado--fecha_fin = fecha_reoslucion_cerrado
where id_proceso=@id_proceso_coactivo
and fecha_fin is null


--select * from circulemos2.dbo.tipo_fallo
select * from circulemos2.dbo.estado_comparendo

set @id_estado_proceso_coactivo= null



if @id_tipo_fallo = 1 begin
set @id_estado_proceso_coactivo=31

update circulemos2.dbo.comparendo
set id_estado_comparendo= 17
where id_factura_axis = @id_factura_axis

end
else
begin
set @id_estado_proceso_coactivo = 23
end



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
 
	 (@id_proceso_coactivo,@id_estado_proceso_coactivo,@Fecha_resolucion_Estado_Cerrado,null,1,2,1)
	 set @id_trazabilidad_proceso= SCOPE_IDENTITY()



update  circulemos2.[dbo].[proceso]
		set id_estado_proceso = @id_estado_proceso_coactivo,
		 fecha_fin = case when @id_estado_proceso_coactivo = 23 then null else @Fecha_resolucion_Estado_Cerrado end
		,observacion=case when @id_estado_proceso_coactivo = 23 then 'NOTIFICADO' else 'ANULADO - ABSOLUTORIO' end
		where id_proceso = @id_proceso_coactivo;




		update integracion_terceros.dbo.reconstr_estados_impugnacion
		set procesado = 1
		, fecha_procesamiento = GETDATE()
		, path_documento = @path_documento_fallo
		, path_documento_cerrado = concat(@pathDocumento,@nombreDocumento)
		, error = NULL
		where id_reconstr = @id_reconstr;

		select 'Coactivo: '+@numero_coactivo as Coactivo,  'Exito' as Resultado, 'id_proceso: '+ cast(@id_proceso as varchar) as Coactivo

		commit tran

			END TRY
	BEGIN CATCH
		--SELECT ERROR_MESSAGE() AS ErrorMessage;  
		--SELECT ERROR_LINE() AS ErrorLine;

		set @msg= ERROR_MESSAGE()

		IF @@TRANCOUNT > 0  
	        ROLLBACK TRANSACTION; 

		update integracion_terceros.dbo.reconstr_estados_impugnacion
		set procesado = 0
		, fecha_procesamiento = GETDATE()
		, error = CONCAT(ERROR_LINE(), ' ;', @msg)
		where id_reconstr = @id_reconstr;

	END CATCH


			FETCH NEXT FROM cerrar_impugnaciones_csr
	INTO  
	     @id_reconstr, @expediente,@Tipo_Fallo,@Motivación_fallo,@Usuario_Sogit_Fallo,@Fecha_Fallo,@Plantilla_Fallo,
         @Documento_Fallo,@Estado_Fallo,@Usuario_Sogit_Resolucion_Estado_Cerrado,@Fecha_resolucion_Estado_Cerrado,
         @documento_resolucion,@Estado_SOGIT_resolucion;
END
	CLOSE cerrar_impugnaciones_csr;
	DEALLOCATE cerrar_impugnaciones_csr;
