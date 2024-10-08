USE [circulemos2]
GO
/****** Object:  StoredProcedure [dbo].[sp_reconstruir_solicitud_bienes_coactivo_documentos]    Script Date: 25/9/2024 13:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_reconstruir_solicitud_bienes_coactivo_documentos] 
AS
declare @numeroJuicio varchar(20);
declare @numeroOficio varchar(20);
declare @fechaCreacionOficio varchar(80);
declare @idProceso bigint;
declare @idTrazaProceso bigint;
declare @idEstadoSolicitudBusqueda int = 29;
declare @idEstadoProceso int;
declare @idCoactivo bigint;
declare @idReconstruccion bigint;
declare @idSolicitudOficioBien bigint;
declare @idOficioBien bigint;
declare @valorProyectado numeric(10,2);
declare @fecha_fin_proceso_coactivo date;
declare @fecha_inicio_convenio date;
declare @fecha_anulacion date;
declare @codigoDocumento bigint;
declare @consecutivoDocumento bigint;
declare @nombreDocumento varchar(100);
declare @documentoSolicitud varchar(100);
declare @pathDocumentoSolicitud varchar(1000);
declare @documentoOficio varchar(100);
declare @pathDocumentoOficio varchar(1000);
declare @documentoSentarRazon varchar(100);
declare @pathDocumentoSentarRazon varchar(1000);
declare @actualizaEstadoProceso tinyint 
declare @fechaFinTrazaProceso date;
declare @fechaInicioImpugnacion date;
declare @tipoIdentificacion varchar(50);
declare @identificacion varchar(50);
declare @cantidadCoactivosPersona  Integer;
declare @integridadDatos bigint;
declare @resultados INT;
declare @msg varchar(1000); 

declare pCursor cursor for
select 
	id_reconstruccion,
	numero_juicio,
	valor_proyectado,
	numero_oficio,
	CONVERT(datetime, fecha_creacion_oficio, 120),
	documento_solicitud,
	documento_oficio,
	documento_sentar_razon,
	id_coactivo,
	tipo_identificacion,
	identificacion
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
where procesado=0 and error is null;

OPEN pCursor;

FETCH NEXT FROM pCursor INTO 
    @idReconstruccion,
	@numeroJuicio,
	@valorProyectado,
	@numeroOficio,
	@fechaCreacionOficio,
	@documentoSolicitud,
	@documentoOficio,
	@documentoSentarRazon,
	@idCoactivo,
	@tipoIdentificacion,
	@identificacion
WHILE @@FETCH_STATUS = 0
BEGIN
	BEGIN TRANSACTION;
	begin try
		set @integridadDatos = 1; -- Los datos son íntegros hasta demostrar lo contrario
	    set @resultados = 0;
		set @idProceso = null;
		set @idEstadoProceso = null;
		set @fecha_fin_proceso_coactivo = null;
		set @fecha_inicio_convenio = null;
		set @fecha_anulacion = null;
		set @actualizaEstadoProceso=1
		set @fechaFinTrazaProceso= null
		set @msg = null
	    set @cantidadCoactivosPersona=0;
		set @idSolicitudOficioBien = null;
		set @idOficioBien = null;

		if	(select count(pr.id_proceso)
		from circulemos2.dbo.proceso pr
		inner join circulemos2.dbo.coactivo co on pr.id_proceso = co.id_proceso
		where co.id_tramite > 0
		and CONCAT(numero_proceso, '-', YEAR(fecha_inicio))=@numeroJuicio
		and pr.id_estado_proceso != 31
		and id_tipo_proceso=4)>1 begin

	    select @cantidadCoactivosPersona= count(pr.id_proceso)
		from circulemos2.dbo.proceso pr
		inner join circulemos2.dbo.coactivo co on pr.id_proceso = co.id_proceso
		inner join circulemos2.dbo.persona pe on pe.id_persona = co.id_deudor
		inner join circulemos2.dbo.tipo_identificacion_persona tip on tip.id_tipo_identificacion = pe.id_tipo_identificacion
		where co.id_tramite > 0
		and CONCAT(numero_proceso, '-', YEAR(fecha_inicio))=@numeroJuicio
		and id_tipo_proceso=4
		and pe.numero_identificacion = @identificacion
		and pr.id_estado_proceso !=31
		and tip.sigla = @tipoIdentificacion 

		if @cantidadCoactivosPersona > 1 begin 
		set @msg='El proceso coactivo está repetido para la misma persona Identificacion'
		set	@integridadDatos = 0
			;THROW 50001, @msg , 1;

       end

		end 

		if @cantidadCoactivosPersona = 0 begin
		select 
			@idProceso = pr.id_proceso,
			@idEstadoProceso = pr.id_estado_proceso,
			@fecha_fin_proceso_coactivo =pr.fecha_fin
		from circulemos2.dbo.proceso pr
		inner join circulemos2.dbo.coactivo co on pr.id_proceso = co.id_proceso
		where co.id_tramite > 0
		and CONCAT(numero_proceso, '-', YEAR(fecha_inicio))=@numeroJuicio
		and id_tipo_proceso=4;
		end
		else if @cantidadCoactivosPersona = 1 begin


	    select 	@idProceso = pr.id_proceso,
			@idEstadoProceso = pr.id_estado_proceso,
			@fecha_fin_proceso_coactivo =pr.fecha_fin
		from circulemos2.dbo.proceso pr
		inner join circulemos2.dbo.coactivo co on pr.id_proceso = co.id_proceso
		inner join circulemos2.dbo.persona pe on pe.id_persona = co.id_deudor
		inner join circulemos2.dbo.tipo_identificacion_persona tip on tip.id_tipo_identificacion = pe.id_tipo_identificacion
		where co.id_tramite > 0
		and CONCAT(numero_proceso, '-', YEAR(fecha_inicio))=@numeroJuicio
		and id_tipo_proceso=4
		and pe.numero_identificacion = @identificacion
		and tip.sigla = @tipoIdentificacion 

		end
		-- Valida si el proceso existe
		if (@idProceso is null)
		begin
			set	@integridadDatos = 0
			;THROW 50001, 'El proceso coactivo no existe', 1;
		end
		-- Valida si el proceso está CERRADO
	   if (@idEstadoProceso = 27) 
	       set @actualizaEstadoProceso= 0
		   set @fechaFinTrazaProceso = @fecha_fin_proceso_coactivo
	   		begin
			    if convert(date,@fechaCreacionOficio) > convert(date,@fecha_fin_proceso_coactivo)
				begin
				set	@integridadDatos = 0
			;THROW 50001, 'El proceso se encuentra CERRADO, y la fecha de Oficio de Bienes es mayor a la fecha de estado Cerrado', 1;
			end
		end

		-- Valida si el proceso está en COACTIVO EN CONVENIO
		if (@idEstadoProceso = 28) 
		begin

		select top 1 @fecha_inicio_convenio = tp.fecha_inicio 
		from circulemos2.dbo.trazabilidad_proceso tp
		where tp.id_estado_proceso = 28
		and tp.id_proceso = @idProceso
		order by fecha_inicio desc

		     set @actualizaEstadoProceso= 0
			  set @fechaFinTrazaProceso = @fecha_inicio_convenio

		if CONVERT(date,@fechaCreacionOficio  )> CONVERT(date, @fecha_inicio_convenio )
		    begin
			set	@integridadDatos = 0
			;THROW 50001, 'El proceso se encuentra en COACTIVO EN CONVENIO, y la fecha de Oficio de Bienes es mayor a la fecha del convenio', 1;
			end
		end

		-- Valida si el proceso está en COACTIVO IMPUGNADO
		if (@idEstadoProceso = 54) 
		begin

		     		select top 1 @fechaInicioImpugnacion = tp.fecha_inicio 
					from circulemos2.dbo.trazabilidad_proceso tp
					where tp.id_estado_proceso = 54
					and tp.id_proceso = @idProceso
					order by fecha_inicio desc

		     set @actualizaEstadoProceso= 0
			  set @fechaFinTrazaProceso = @fechaInicioImpugnacion
	
			if CONVERT(date,@fechaCreacionOficio  )> CONVERT(date, @fechaInicioImpugnacion )
		    begin
			set	@integridadDatos = 0
			;THROW 50001, 'El proceso se encuentra en COACTIVO IMPUGNADO, y la fecha de Oficio de Bienes es mayor a la fecha de la Impugnacion', 1;
			end
		end

		-- Valida si el proceso está en COACTIVO ANULADO
		if (@idEstadoProceso = 31) 
		begin
	
		select top 1 @fecha_anulacion = tp.fecha_inicio 
		from circulemos2.dbo.trazabilidad_proceso tp
		where tp.id_estado_proceso = 31
		and tp.id_proceso = @idProceso
		order by fecha_inicio desc

			     set @actualizaEstadoProceso= 0
				 set @fechaFinTrazaProceso = @fecha_anulacion

		  if CONVERT(date,@fechaCreacionOficio  )> CONVERT(date, @fecha_anulacion )
		  begin
		    set	@integridadDatos = 0
			;THROW 50001, 'El proceso se encuentra en COACTIVO ANULADO, y la fecha de Oficio de Bienes es mayor a la fecha de la anulación', 1;
			end
		end

		-- Valida si el coactivo fue NOTIFICADO
		--select * from trazabilidad_proceso where id_proceso=@idProceso and id_estado_proceso=23
		if not exists (select id_trazabilidad_proceso from trazabilidad_proceso where id_proceso=@idProceso and id_estado_proceso=23) 
		begin
		--select @idProceso id_proceso, @numeroJuicio nummero_juicio
		    set	@integridadDatos = 0
			;THROW 50001, 'El coactivo no ha sido NOTIFICADO', 1;
		end

		--select concat('@@idProceso=',@idProceso)

		set @idTrazaProceso = null;

		select @idTrazaProceso = id_trazabilidad_proceso from circulemos2.dbo.trazabilidad_proceso where id_proceso=@idProceso and fecha_inicio between @fechaCreacionOficio and DATEADD(MINUTE, 1, @fechaCreacionOficio)

		--select concat('idTrazaProceso=',@idTrazaProceso)

		if (@idTrazaProceso is null)
		begin
			-- no existe la trazabilidad de solicitud de busqueda de bienes
			set @idCoactivo = null;

			select @idCoactivo = id_coactivo from circulemos2.dbo.coactivo
			where id_proceso = @idProceso;

			if (@idCoactivo is null)
			begin
				-- no existe el coactivo
				set	@integridadDatos = 0
				;THROW 50001, 'El coactivo no existe', 1;
			end
			
			-- valida existecia de datos en la tabla solicitud_oficio_bien
			set @resultados = null;
			select @resultados = COUNT(*)
			from circulemos2.dbo.solicitud_oficio_bien
			where id_coactivo = @idCoactivo 
			and fecha_solicitud = @fechaCreacionOficio;

			select @idSolicitudOficioBien = id_solicitud_oficio_bien
			from circulemos2.dbo.solicitud_oficio_bien
			where id_coactivo = @idCoactivo 
			and fecha_solicitud = @fechaCreacionOficio;

			if @resultados = 0
			begin
				set	@integridadDatos = 0
				;THROW 50001, 'No hay registro en tabla solicitud_oficio_bien', 1;
			end
			
			-- valida existecia de datos en la tabla oficio_bien
			set @resultados = null;
			select @resultados = COUNT(*)
			from circulemos2.dbo.oficio_bien
			where numero_oficio = @numeroOficio
			and fecha_generacion = @fechaCreacionOficio
			and id_estado_oficio = 1;

			if @resultados = 0
			begin
				set	@integridadDatos = 0
				;THROW 50001, 'No hay registro en tabla oficio_bien', 1;
			end
			
			select top 1 @idOficioBien = id_oficio_bien
			from circulemos2.dbo.oficio_bien
			where numero_oficio = @numeroOficio
			and fecha_generacion = @fechaCreacionOficio
			and id_estado_oficio = 1
			order by id_oficio_bien desc;

			-- valida existecia de datos en la tabla solicitud_bien_entidad
			set @resultados = null;
			select @resultados = COUNT(*)
			from circulemos2.dbo.solicitud_bien_entidad
			where id_solicitud_oficio_bien = @idSolicitudOficioBien
			and id_configuracion_entidad = 1
			and id_oficio_bien = @idOficioBien;

			if @resultados = 0
			begin
				set	@integridadDatos = 0
				;THROW 50001, 'No hay registro en tabla solicitud_bien_entidad', 1;
			end

			if @actualizaEstadoProceso = 1 
			begin
				-- valida existecia de datos en la tabla proceso
				set @resultados = null;
				select @resultados = COUNT(*)
				from circulemos2.dbo.proceso
				where id_proceso=@idProceso;

				if @resultados = 0
				begin
					set	@integridadDatos = 0
					;THROW 50001, 'No hay registro en tabla proceso', 1;
				end

				-- valida existecia de datos en la tabla trazabilidad_proceso
				set @resultados = null;
				select @resultados = COUNT(*) 
				from circulemos2.dbo.trazabilidad_proceso
				where id_proceso=@idProceso
				and fecha_fin = @fechaCreacionOficio;

				if @resultados = 0
				begin
					set	@integridadDatos = 0
					;THROW 50001, 'No hay registro en tabla trazabilidad_proceso', 1;
				end
			end

			-- valida existecia de datos en la tabla coactivo_oficio_bien
			set @resultados = null;
			select @resultados = COUNT(*) 
			from circulemos2.dbo.coactivo_oficio_bien
			where id_oficio_bien = @idOficioBien
			and id_coactivo = @idCoactivo
			and valor_proyectado = @valorProyectado
			and fecha_registro = @fechaCreacionOficio;

			if @resultados = 0
			begin
				set	@integridadDatos = 0
				;THROW 50001, 'No hay registro en tabla coactivo_oficio_bien', 1;
			end
		end

		---*********************************************************** VERIFICACION DE DOCUMENTOS **********************************************
		---DOCUMENTO SOLICITUD OFICIO BIEN
		set @pathDocumentoOficio = null;
		if @integridadDatos = 1
		begin
			select @pathDocumentoOficio = dd.path_documento --path documento
			from proceso pr
			join trazabilidad_proceso tp on pr.id_proceso = tp.id_proceso
			join documento_proceso dp on tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso
			join tipo_documento_proceso tdp on  dp.id_tipo_documento_proceso = tdp.id_tipo_documento_proceso
			join [documentos].[dbo].[documento] dd on dd.consecutivo_documento = dp.numero_documento
			join [documentos].[dbo].[plantilla]   dpl on dpl.id_plantilla = dd.id_plantilla
			join usuario_persona upe on upe.id_usuario = tp.id_usuario
			join estado_proceso ep on tp.id_estado_proceso = ep.id_estado_proceso
			where pr.id_tipo_proceso = 4 --coactivo
			and tp.id_estado_proceso in (29) --solicitud busqueda de bienes
			and CONCAT(numero_proceso, '-', YEAR(pr.fecha_inicio))= @numeroJuicio -- numero de juicio
			and convert(date, dd.fecha_generacion) = convert(date, @fechaCreacionOficio) --- fecha_creacion_oficio
			and dpl.codigo_plantilla = 'OFICIO_BANCO_CARTA' --codigo plantilla para DOCUMENTO SOLICITUD
			order by dd.id_documento;
		end
		
		/*
		* Si encuentra el path del documento SOLICITUD lo guarda en la tabla base
		* si no crear el path nuevamente y lo guarda en la tabla base
		*/
		if @pathDocumentoOficio is not null
		begin
			update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
			set path_documento_oficio = @pathDocumentoOficio,
				path_doc_oficio_reconstruido = 0
			where id_reconstruccion = @idReconstruccion;
		end
		else
		begin
		    -- Insertar Documento  solicitud de oficio bien
			set @codigoDocumento = null;
			set @consecutivoDocumento = null;
			set @pathDocumentoOficio = null;
			set @nombreDocumento = null

			select @consecutivoDocumento = consecutivo + 1
			from documentos.dbo.consecutivo_documento_reconstruccion 
			where id_consecutivo_documento_reconstruccion = 1

			set @nombreDocumento = CONCAT(@consecutivoDocumento, '.pdf')
			set @pathDocumentoOficio = '/documentos/c2/Solicitud_oficio_bien/'
			set @pathDocumentoOficio = concat(@pathDocumentoOficio,YEAR(@fechaCreacionOficio),'/',MONTH(@fechaCreacionOficio),'/',DAY(@fechaCreacionOficio),'/');

			INSERT INTO gestor_docs.dbo."data_documento" ("descripcion", "nombre", "folder", "extension", "nombre_real", "Registro_BD")
			VALUES ( 'Generacion de solicitud de oficio bien', @nombreDocumento, @pathDocumentoOficio, '.pdf', @consecutivoDocumento, 0);
			set @codigoDocumento = SCOPE_IDENTITY();

			update  documentos.dbo.consecutivo_documento_reconstruccion
			set consecutivo = @consecutivoDocumento
			where id_consecutivo_documento_reconstruccion = 1
			INSERT INTO gestor_docs.dbo."version_data_documento" ( "codigo_documento", "contenido_binario", "fecha", "version") 
			VALUES (@codigoDocumento, 0x, @fechaCreacionOficio, 1);

			set @nombreDocumento = CONCAT(@consecutivoDocumento, '_v1.pdf')

			INSERT INTO documentos.dbo."documento" ( "nombre_documento", "consecutivo_documento", "version_documento", "id_plantilla", "path_documento", "fecha_generacion", "id_usuario", "id_documento_origen", "descripcion_documento", "firmado", "codigo_documento", "version_documento_cm", "fecha_creacion") 
			VALUES ( @nombreDocumento, @consecutivoDocumento, 1, 2545,concat(@pathDocumentoOficio,@nombreDocumento)  , @fechaCreacionOficio, 1, NULL, 'Generacion de solicitud de oficio bien', 0, @codigoDocumento, 1, @fechaCreacionOficio);

			INSERT INTO circulemos2.dbo."documento_proceso" ( "id_trazabilidad_proceso", "numero_documento", "id_comparendo_proceso", "id_tipo_documento_proceso", "id_firma_persona", "responsable_generacion") 
			VALUES ( @idTrazaProceso, @consecutivoDocumento, NULL, 12, NULL, NULL);

			update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
			set path_documento_oficio = concat(@pathDocumentoOficio,@nombreDocumento),
				path_doc_oficio_reconstruido = 1
			where id_reconstruccion = @idReconstruccion;
		end

		---DOCUMENTO SENTAR RAZON DEL PAGO
		set @pathDocumentoSentarRazon = null;
		if @integridadDatos = 1
		begin
			select @pathDocumentoSentarRazon = dd.path_documento --path documento
			from proceso pr
			join trazabilidad_proceso tp on pr.id_proceso = tp.id_proceso
			join documento_proceso dp on tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso
			join tipo_documento_proceso tdp on  dp.id_tipo_documento_proceso = tdp.id_tipo_documento_proceso
			join [documentos].[dbo].[documento] dd on dd.consecutivo_documento = dp.numero_documento
			join [documentos].[dbo].[plantilla] dpl on dpl.id_plantilla = dd.id_plantilla
			join usuario_persona upe on upe.id_usuario = tp.id_usuario
			join estado_proceso ep on tp.id_estado_proceso = ep.id_estado_proceso
			where pr.id_tipo_proceso = 4 --coactivo
			and tp.id_estado_proceso in (29) --solicitud busqueda de bienes
			and CONCAT(numero_proceso, '-', YEAR(pr.fecha_inicio))= @numeroJuicio -- numero de juicio
			and convert(date, dd.fecha_generacion) = convert(date, @fechaCreacionOficio) --- fecha_creacion_oficio
			and dpl.codigo_plantilla = 'SENTAR_RAZON_PAGO' --codigo plantilla para SENTAR RAZON DEL PAGO
			order by dd.id_documento;
		end
		/*
		* Si encuentra el path del documento SENTAR RAZON DEL PAGO lo guarda en la tabla base
		* si no crear el path nuevamente y lo guarda en la tabla base
		*/
		if @pathDocumentoSentarRazon is not null
		begin
			update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
			set path_documento_sentar_razon = @pathDocumentoSentarRazon,
				path_doc_sentar_razon_reconstruido = 0
			where id_reconstruccion = @idReconstruccion;
		end
		else
		begin
			-- Insertar Documento  Coactivo sentar razon del pago
			set @codigoDocumento = null;
			set @consecutivoDocumento = null;
			set @pathDocumentoSentarRazon = null
			set @nombreDocumento = null
 
			select @consecutivoDocumento = consecutivo + 1
			from documentos.dbo.consecutivo_documento_reconstruccion 
			where id_consecutivo_documento_reconstruccion = 1
 
			set @nombreDocumento = CONCAT(@consecutivoDocumento, '.pdf')
			set @pathDocumentoSentarRazon = '/documentos/c2/coa_sentar_razon/'
			set @pathDocumentoSentarRazon = concat(@pathDocumentoSentarRazon,YEAR(@fechaCreacionOficio),'/',MONTH(@fechaCreacionOficio),'/',DAY(@fechaCreacionOficio),'/');
 
			INSERT INTO gestor_docs.dbo."data_documento" ("descripcion", "nombre", "folder", "extension", "nombre_real", "Registro_BD") 
			VALUES ('Coactivo sentar razon del pago', @nombreDocumento, @pathDocumentoSentarRazon, '.pdf', @consecutivoDocumento, 0);
 
			set @codigoDocumento = SCOPE_IDENTITY();
 
			update  documentos.dbo.consecutivo_documento_reconstruccion
			set consecutivo = @consecutivoDocumento
			where id_consecutivo_documento_reconstruccion = 1
			INSERT INTO gestor_docs.dbo."version_data_documento" ( "codigo_documento", "contenido_binario", "fecha", "version") 
			VALUES (@codigoDocumento, 0X, @fechaCreacionOficio, 1);
 
			set @nombreDocumento = CONCAT(@consecutivoDocumento, '_v1.pdf')
 
			INSERT INTO documentos.dbo."documento" ( "nombre_documento", "consecutivo_documento", "version_documento", "id_plantilla", "path_documento", "fecha_generacion", "id_usuario", "id_documento_origen", "descripcion_documento", "firmado", "codigo_documento", "version_documento_cm", "fecha_creacion") 
			VALUES ( @nombreDocumento, @consecutivoDocumento, 1, 2388,concat(@pathDocumentoSentarRazon,@nombreDocumento)  , @fechaCreacionOficio, 1, NULL, 'Coactivo sentar razon del pago', 0, @codigoDocumento, 1, @fechaCreacionOficio);
 
			INSERT INTO circulemos2.dbo."documento_proceso" ( "id_trazabilidad_proceso", "numero_documento", "id_comparendo_proceso", "id_tipo_documento_proceso", "id_firma_persona", "responsable_generacion") 
			VALUES ( @idTrazaProceso, @consecutivoDocumento, NULL, 22, NULL, NULL);

			update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
			set path_documento_sentar_razon = concat(@pathDocumentoSentarRazon,@nombreDocumento),
			    path_doc_sentar_razon_reconstruido = 1
			where id_reconstruccion = @idReconstruccion;
		end
		---DOCUMENTO PROVIDENCIA
		set @pathDocumentoSolicitud = null;
		if @integridadDatos = 1
		begin
			select @pathDocumentoSolicitud = dd.path_documento --path documento
			from proceso pr
			join trazabilidad_proceso tp on pr.id_proceso = tp.id_proceso
			join documento_proceso dp on tp.id_trazabilidad_proceso = dp.id_trazabilidad_proceso
			join tipo_documento_proceso tdp on  dp.id_tipo_documento_proceso = tdp.id_tipo_documento_proceso
			join [documentos].[dbo].[documento] dd on dd.consecutivo_documento = dp.numero_documento
			join [documentos].[dbo].[plantilla] dpl on dpl.id_plantilla = dd.id_plantilla
			join usuario_persona upe on upe.id_usuario = tp.id_usuario
			join estado_proceso ep on tp.id_estado_proceso = ep.id_estado_proceso
			where pr.id_tipo_proceso = 4 --coactivo
			and tp.id_estado_proceso in (29) --solicitud busqueda de bienes
			and CONCAT(numero_proceso, '-', YEAR(pr.fecha_inicio))= @numeroJuicio -- numero de juicio
			and convert(date, dd.fecha_generacion) = convert(date, @fechaCreacionOficio) --- fecha_creacion_oficio
			and dpl.codigo_plantilla = 'PROVIDENCIA_RETENCIO' --codigo plantilla para PROVIDENCIA
			order by dd.id_documento;
		end
		/*
		* Si encuentra el path del documento PROVIDENCIA lo guarda en la tabla base
		* si no crear el path nuevamente y lo guarda en la tabla base
		*/
		if @pathDocumentoSolicitud is not null
		begin
			update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
			set path_documento_solicitud = @pathDocumentoSolicitud,
			    path_doc_solicitud_reconstruido = 0
			where id_reconstruccion = @idReconstruccion;
		end
		else
		begin
			-- Insertar Documento  PROVIDENCIA_RETENCIO
			set @codigoDocumento = null;
			set @consecutivoDocumento = null;
			set @pathDocumentoSolicitud = null
			set @nombreDocumento = null
 
			select @consecutivoDocumento = consecutivo + 1
			from documentos.dbo.consecutivo_documento_reconstruccion 
			where id_consecutivo_documento_reconstruccion = 1
 
			set @nombreDocumento = CONCAT(@consecutivoDocumento, '.pdf')
			set @pathDocumentoSolicitud = '/documentos/c2/providencia_retencion/'
			set @pathDocumentoSolicitud = concat(@pathDocumentoSolicitud,YEAR(@fechaCreacionOficio),'/',MONTH(@fechaCreacionOficio),'/',DAY(@fechaCreacionOficio),'/');
 
			INSERT INTO gestor_docs.dbo."data_documento" ("descripcion", "nombre", "folder", "extension", "nombre_real", "Registro_BD") 
			VALUES ('Coactivo providencia retencion', @nombreDocumento, @pathDocumentoSolicitud, '.pdf', @consecutivoDocumento, 0);
 
			set @codigoDocumento = SCOPE_IDENTITY();
 
			update  documentos.dbo.consecutivo_documento_reconstruccion
			set consecutivo = @consecutivoDocumento
			where id_consecutivo_documento_reconstruccion = 1
			INSERT INTO gestor_docs.dbo."version_data_documento" ( "codigo_documento", "contenido_binario", "fecha", "version") 
			VALUES (@codigoDocumento, 0X, @fechaCreacionOficio, 1);
 
			set @nombreDocumento = CONCAT(@consecutivoDocumento, '_v1.pdf')
 
			INSERT INTO documentos.dbo."documento" ( "nombre_documento", "consecutivo_documento", "version_documento", "id_plantilla", "path_documento", "fecha_generacion", "id_usuario", "id_documento_origen", "descripcion_documento", "firmado", "codigo_documento", "version_documento_cm", "fecha_creacion") 
			VALUES ( @nombreDocumento, @consecutivoDocumento, 1, 2584,concat(@pathDocumentoSolicitud,@nombreDocumento)  , @fechaCreacionOficio, 1, NULL, 'Coactivo providencia retencion', 0, @codigoDocumento, 1, @fechaCreacionOficio);
 
			INSERT INTO circulemos2.dbo."documento_proceso" ( "id_trazabilidad_proceso", "numero_documento", "id_comparendo_proceso", "id_tipo_documento_proceso", "id_firma_persona", "responsable_generacion") 
			VALUES ( @idTrazaProceso, @consecutivoDocumento, NULL, 23, NULL, NULL);

			update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
			set path_documento_solicitud = concat(@pathDocumentoSolicitud,@nombreDocumento),
				path_doc_solicitud_reconstruido = 1
			where id_reconstruccion = @idReconstruccion;
		end
		
		-- actualiza solicitud_oficio_bien con genera_oficio=1 luego de generación de documentos
		if (@idSolicitudOficioBien is not null)
		begin
			-- valida existecia de datos en la tabla solicitud_oficio_bien
			set @resultados = null;
			select @resultados = COUNT(*)
			from circulemos2.dbo.solicitud_oficio_bien
			where id_solicitud_oficio_bien = @idSolicitudOficioBien;

			if @resultados = 0
			begin
				set	@integridadDatos = 0
				;THROW 50001, 'No hay registro en tabla solicitud_oficio_bien', 1;
			end
		end

		update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
		set procesado = 1
		, 	fecha_procesamiento = GETDATE()
		,   integridad_datos = @integridadDatos
		where id_reconstruccion = @idReconstruccion;
		
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		--SELECT ERROR_MESSAGE() AS ErrorMessage;  

		IF @@TRANCOUNT > 0  
	        ROLLBACK TRANSACTION; 

		update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
		set error = ERROR_MESSAGE()
		, 	fecha_procesamiento = GETDATE()
		,   integridad_datos = @integridadDatos
		where id_reconstruccion = @idReconstruccion;

	END CATCH

	--IF @@TRANCOUNT > 0  
	--COMMIT TRANSACTION;   

	FETCH NEXT FROM pCursor INTO 
    @idReconstruccion,
	@numeroJuicio,
	@valorProyectado,
	@numeroOficio,
	@fechaCreacionOficio,
	@documentoSolicitud,
	@documentoOficio,
	@documentoSentarRazon,
	@idCoactivo,
	@tipoIdentificacion,
	@identificacion
end;

CLOSE pCursor;
DEALLOCATE pCursor;