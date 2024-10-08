



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
,
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
 @path_documento varchar(255) NULL 


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
	and NUMERO_JUICIO in('303067-2023')
	


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





















----------------------------------------------------------------------------------------------------------------------
--Con base a est� consulta hacer el cursor

select co.numero_coactivo,oc.numero_obligacion, concat(po.numero_proceso,'-',year(po.fecha_inicio)) as juicio
, concat(pe.numero_proceso,'-',year(pe.fecha_inicio)) as expediente
, cast( pe.fecha_inicio as date) fecha_inicio_expediente
, pe.observacion estado_expediente
from   circulemos2.dbo.coactivo co
inner join proceso po on po.id_proceso=co.id_proceso
inner join obligacion_coactivo oc on co.id_coactivo=oc.id_coactivo
inner join comparendo com on com.id_factura_axis=oc.numero_obligacion
inner join comparendo_proceso cp on cp.cicomparendo=com.cicomparendo 
inner join proceso pe on pe.id_proceso=cp.id_proceso and pe.id_tipo_proceso = 1
where po.numero_proceso in('276972','269279','274477','281588','284544','284591','287643','287470','290353')
and year(po.fecha_inicio)='2023'
--and  po.id_proceso=cp.id_proceso
--and  po.id_tipo_proceso = 1
DEALLOCATE notificaciones_coactivo_csr;


-------------------------Cursor LOAD.....-----------------------------
DECLARE cerrar_impugnaciones_csr CURSOR FOR
	SELECT  

	* from   integracion_terceros.[dbo].[reconstr_estados_impugnacion] re
     
	 OPEN cerrar_impugnaciones_csr--notificaciones_coactivo_csr
	FETCH NEXT FROM cerrar_impugnaciones_csr--cerrar_impugnaciones_csr--
	DEALLOCATE cerrar_impugnaciones_csr; --notificaciones_coactivo_csr;





--ANTIGUA
DECLARE cerrar_impugnaciones_csr CURSOR FOR
	SELECT  
	       --co.numero_coactivo,oc.numero_obligacion, concat(po.numero_proceso,'-',year(po.fecha_inicio)) as juicio
        --   , concat(pe.numero_proceso,'-',year(pe.fecha_inicio)) as expediente
        --   , cast( pe.fecha_inicio as date) fecha_inicio_expediente
        --   , pe.observacion estado_expediente
		--po.id_proceso, po.id_estado_proceso, , concat(po.numero_proceso,'-',year(po.fecha_inicio)) as expediente
	
	--, case when r.TIPO_NOTIFICACION ='NOTIFICADO POR EMAIL' then 3
	--when r.TIPO_NOTIFICACION ='NOTIFICADO POR GACETA' then 2
	--when r.TIPO_NOTIFICACION ='NOTIFICADO POR COURIER' then 1 end TIPO_NOTIFICACION
	--, co.id_coactivo, co.id_proceso, pr.id_estado_proceso, co.id_tramite

	 from   integracion_terceros.[dbo].[reconstr_estados_impugnacion] co
     --inner join proceso po on po.id_proceso=co.id_proceso
     --inner join obligacion_coactivo oc on co.id_coactivo=oc.id_coactivo
     --inner join comparendo com on com.id_factura_axis=oc.numero_obligacion
     --inner join comparendo_proceso cp on cp.cicomparendo=com.cicomparendo 
     --inner join proceso pe on pe.id_proceso=cp.id_proceso and pe.id_tipo_proceso = 1
     --where po.numero_proceso in('276972','269279','274477','281588','284544','284591','287643','287470','290353')
     --and year(po.fecha_inicio)='2023'
     --and  po.id_proceso=cp.id_proceso
     --and  po.id_tipo_proceso = 1
	 OPEN cerrar_impugnaciones_csr--notificaciones_coactivo_csr
	FETCH NEXT FROM cerrar_impugnaciones_csr--cerrar_impugnaciones_csr--
	DEALLOCATE cerrar_impugnaciones_csr; --notificaciones_coactivo_csr;
--------------------------------------------------------------------------------------------------

	DECLARE cerrar_impugnaciones_csr CURSOR FOR
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
	and NUMERO_JUICIO in('303067-2023')

	ORDER BY r.ID_TRAMITE ASC;

	--select * from circulemos2.dbo.tipo_notificacion_coactivo
	-- select * from circulemos2.dbo.estado_proceso where id_tipo_proceso = 4

		OPEN notificaciones_coactivo_csr
	FETCH NEXT FROM notificaciones_coactivo_csr
	INTO  @numero_coactivo, @fecha_notificacion, @tipo_notificacion,@id_coactivo, @id_proceso, @id_estado_proceso, @id_tramite	;