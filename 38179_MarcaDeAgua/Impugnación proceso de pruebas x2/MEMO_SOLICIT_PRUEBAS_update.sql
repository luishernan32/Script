begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @FECHA DATE

SELECT @FECHA = fecha_inicio
FROM   trazabilidad_proceso
WHERE  id_proceso = :idProceso
       AND ( id_estado_proceso = 2
              OR id_estado_proceso = 6 )

SELECT Concat(spb.consecutivo_documento, ''-'', Year(Getdate())),
       pr.numero_proceso,
       CASE pe.id_tipo_identificacion
         WHEN ''2'' THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat
(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '', pe.apellido2))
END                   AS nombreCompleto,
Year(pr.fecha_inicio) AS anio,
@FECHA                AS fechaSolicitud,
spb.descripcion,
tdp.nombre            AS para,
cp.nombre,
pr.fecha_inicio,
(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso pr
       JOIN trazabilidad_proceso tp
         ON tp.id_proceso = pr.id_proceso
       JOIN solicitud_pruebas_back spb
         ON spb.id_trazabilidad_proceso = tp.id_trazabilidad_proceso
       JOIN caracteristica_prueba cp
         ON cp.id_caracteristica_prueba = spb.id_caracteristica_prueba
       JOIN tipo_destino_prueba_impug tdp
         ON tdp.id_tipo_destino_prueba = spb.id_tipo_destino_prueba
       JOIN participante_proceso pp
         ON pp.id_proceso = pr.id_proceso
       JOIN persona pe
         ON pe.id_persona = pp.id_persona
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = pe.id_persona
WHERE  pr.id_proceso = :idProceso
       AND spb.id_solicitud_pruebas_back = :idSolicitud
       AND pp.id_tipo_participante = 2'               
	   , orden_variables='CONSECUTIVO_PRUEBAS,numero_consecutivo,NOMBRE_INFRACTOR,anio_apertura_proceso,FECHA_SOLICITUD,DESCRIPCION_PRUEBA,PARA,CARACTERISTICA_PRUEBA,fecha_apertura_impug,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=19

commit tran


 