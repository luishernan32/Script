begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat (p.numero_proceso, '' - '', Year(p.fecha_inicio))
       AS
       numero_proceso,
       Year(p.fecha_inicio)
       AS anioProceso,
       (SELECT TOP 1 fdv.memo_nombramiento
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS memoNombramiento,
       (SELECT TOP 1 fdv.fecha_nombramiento
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS fechaNombramiento,
       (SELECT TOP 1 Upper(Concat (pab.nombre1, '' '', pab.nombre2, '' ''
                           , pab.apellido1,
                           '' ''
                                         , pab.apellido2))
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN funcionario fu(nolock)
                 ON fu.id_funcionario = fdv.id_funcionario
               JOIN persona pab(nolock)
                 ON pab.id_persona = fu.id_persona
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS nombreAbogado,
       (SELECT Max(fpe.numero_imagen)
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN funcionario fu(nolock)
                 ON fu.id_funcionario = fdv.id_funcionario
               JOIN persona pab(nolock)
                 ON pab.id_persona = fu.id_persona
               JOIN firma_persona fpe(nolock)
                 ON fpe.id_persona = pab.id_persona
        WHERE  fdv.id_funcionario = (SELECT TOP 1 fdv1.id_funcionario
                                     FROM   funcionario_devolucion_valores fdv1(
                                            nolock)
                                     WHERE  fdv1.fecha_final_vigencia IS NULL))
       AS
       firmaAbogado,
       (SELECT TOP 1 Isnull(fdv.titulo_obtenido, '''')
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS tituloObtenido,
       (SELECT TOP 1 Concat (c.nombre, '' (E)'')
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN cargo c(nolock)
                 ON c.id_cargo = fdv.id_cargo
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS cargo,
       (SELECT TOP 1 fdv.accion_personal
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS accionPesonal,
       CASE pe.id_tipo_identificacion
         WHEN ''2'' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' ''
                    , pe.apellido2)
              )
       END
       AS nombreCompleto,
       dv.correos_notificados,
       (SELECT TOP 1 Upper(Concat (perAD.nombre1, '' '', perAD.nombre2, '' ''
                           , perAD.apellido1, '' ''
                                               , perAD.apellido2))
        FROM   trazabilidad_proceso tpcrr(nolock)
               LEFT JOIN usuario_persona usuAD(nolock)
                      ON usuAD.id_usuario = tpcrr.id_usuario
               LEFT JOIN persona perAD(nolock)
                      ON perAD.id_persona = usuAD.id_persona
        WHERE  tpcrr.id_proceso = :idProceso
               AND tpcrr.id_estado_proceso IN ( 73, 74 ))
       AS nombreFuncionario,
       (SELECT Max(fpe.numero_imagen)
        FROM   trazabilidad_proceso tpcrr(nolock)
               LEFT JOIN usuario_persona usuAD(nolock)
                      ON usuAD.id_usuario = tpcrr.id_usuario
               LEFT JOIN persona perAD(nolock)
                      ON perAD.id_persona = usuAD.id_persona
               LEFT JOIN firma_persona fpe(nolock)
                      ON fpe.id_persona = perAD.id_persona
        WHERE  tpcrr.id_proceso = :idProceso
               AND tpcrr.id_estado_proceso IN ( 73, 74 ))
       AS firmaFuncionario,
       (SELECT sdv.fecha_inicio
        FROM   subsanacion_devolucion_valores(nolock) sdv
               LEFT JOIN trazabilidad_proceso(nolock) tp
                      ON sdv.id_trazabilidad_proceso =
                         tp.id_trazabilidad_proceso
        WHERE  tp.id_estado_proceso = 74
               AND tp.id_proceso = :idProceso)
       AS fechaInicioSubsanacion,
	   (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso p
       JOIN participante_proceso pp(nolock)
         ON pp.id_proceso = p.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe(nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = pe.id_persona
       LEFT JOIN devolucion_valores dv(nolock)
              ON dv.id_proceso = p.id_proceso
WHERE  p.id_proceso = :idProceso 
'               
	   , orden_variables='numero_consecutivo,anio_apertura_proceso,MEMO_DELEGADO,FECHA_DELEGADO,NOMBRE_ABOGADO,IMAGEN_FIRMA,TITULO,CARGO_DELEGADO,NUMERO_RESOLUCION,NOMBRE_INFRACTOR,CORREO_ELECTRONICO_INFRACTOR,NOMBRE_SECRETARIO,IMAGEN_FIRMA_DOS,FECHA_EVALUACION,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10125

commit tran




-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--Script Modificado 
--Order variable: numero_consecutivo,anio_apertura_proceso,MEMO_DELEGADO,FECHA_DELEGADO,NOMBRE_ABOGADO,IMAGEN_FIRMA,TITULO,CARGO_DELEGADO,NUMERO_RESOLUCION,NOMBRE_INFRACTOR,CORREO_ELECTRONICO_INFRACTOR,NOMBRE_SECRETARIO,IMAGEN_FIRMA_DOS,FECHA_EVALUACION
SELECT Concat (p.numero_proceso, ' - ', Year(p.fecha_inicio))
       AS
       numero_proceso,
       Year(p.fecha_inicio)
       AS anioProceso,
       (SELECT TOP 1 fdv.memo_nombramiento
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS memoNombramiento,
       (SELECT TOP 1 fdv.fecha_nombramiento
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS fechaNombramiento,
       (SELECT TOP 1 Upper(Concat (pab.nombre1, ' ', pab.nombre2, ' '
                           , pab.apellido1,
                           ' '
                                         , pab.apellido2))
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN funcionario fu(nolock)
                 ON fu.id_funcionario = fdv.id_funcionario
               JOIN persona pab(nolock)
                 ON pab.id_persona = fu.id_persona
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS nombreAbogado,
       (SELECT Max(fpe.numero_imagen)
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN funcionario fu(nolock)
                 ON fu.id_funcionario = fdv.id_funcionario
               JOIN persona pab(nolock)
                 ON pab.id_persona = fu.id_persona
               JOIN firma_persona fpe(nolock)
                 ON fpe.id_persona = pab.id_persona
        WHERE  fdv.id_funcionario = (SELECT TOP 1 fdv1.id_funcionario
                                     FROM   funcionario_devolucion_valores fdv1(
                                            nolock)
                                     WHERE  fdv1.fecha_final_vigencia IS NULL))
       AS
       firmaAbogado,
       (SELECT TOP 1 Isnull(fdv.titulo_obtenido, '')
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS tituloObtenido,
       (SELECT TOP 1 Concat (c.nombre, ' (E)')
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN cargo c(nolock)
                 ON c.id_cargo = fdv.id_cargo
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS cargo,
       (SELECT TOP 1 fdv.accion_personal
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS accionPesonal,
       CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' '
                    , pe.apellido2)
              )
       END
       AS nombreCompleto,
       dv.correos_notificados,
       (SELECT TOP 1 Upper(Concat (perAD.nombre1, ' ', perAD.nombre2, ' '
                           , perAD.apellido1, ' '
                                               , perAD.apellido2))
        FROM   trazabilidad_proceso tpcrr(nolock)
               LEFT JOIN usuario_persona usuAD(nolock)
                      ON usuAD.id_usuario = tpcrr.id_usuario
               LEFT JOIN persona perAD(nolock)
                      ON perAD.id_persona = usuAD.id_persona
        WHERE  tpcrr.id_proceso = :idProceso
               AND tpcrr.id_estado_proceso IN ( 73, 74 ))
       AS nombreFuncionario,
       (SELECT Max(fpe.numero_imagen)
        FROM   trazabilidad_proceso tpcrr(nolock)
               LEFT JOIN usuario_persona usuAD(nolock)
                      ON usuAD.id_usuario = tpcrr.id_usuario
               LEFT JOIN persona perAD(nolock)
                      ON perAD.id_persona = usuAD.id_persona
               LEFT JOIN firma_persona fpe(nolock)
                      ON fpe.id_persona = perAD.id_persona
        WHERE  tpcrr.id_proceso = :idProceso
               AND tpcrr.id_estado_proceso IN ( 73, 74 ))
       AS firmaFuncionario,
       (SELECT sdv.fecha_inicio
        FROM   subsanacion_devolucion_valores(nolock) sdv
               LEFT JOIN trazabilidad_proceso(nolock) tp
                      ON sdv.id_trazabilidad_proceso =
                         tp.id_trazabilidad_proceso
        WHERE  tp.id_estado_proceso = 74
               AND tp.id_proceso = :idProceso)
       AS fechaInicioSubsanacion,
	   (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   proceso p
       JOIN participante_proceso pp(nolock)
         ON pp.id_proceso = p.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe(nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = pe.id_persona
       LEFT JOIN devolucion_valores dv(nolock)
              ON dv.id_proceso = p.id_proceso
WHERE  p.id_proceso = :idProceso 



-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--Original

SELECT Concat (p.numero_proceso, ' - ', Year(p.fecha_inicio))
       AS
       numero_proceso,
       Year(p.fecha_inicio)
       AS anioProceso,
       (SELECT TOP 1 fdv.memo_nombramiento
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS memoNombramiento,
       (SELECT TOP 1 fdv.fecha_nombramiento
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS fechaNombramiento,
       (SELECT TOP 1 Upper(Concat (pab.nombre1, ' ', pab.nombre2, ' '
                           , pab.apellido1,
                           ' '
                                         , pab.apellido2))
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN funcionario fu(nolock)
                 ON fu.id_funcionario = fdv.id_funcionario
               JOIN persona pab(nolock)
                 ON pab.id_persona = fu.id_persona
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS nombreAbogado,
       (SELECT Max(fpe.numero_imagen)
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN funcionario fu(nolock)
                 ON fu.id_funcionario = fdv.id_funcionario
               JOIN persona pab(nolock)
                 ON pab.id_persona = fu.id_persona
               JOIN firma_persona fpe(nolock)
                 ON fpe.id_persona = pab.id_persona
        WHERE  fdv.id_funcionario = (SELECT TOP 1 fdv1.id_funcionario
                                     FROM   funcionario_devolucion_valores fdv1(
                                            nolock)
                                     WHERE  fdv1.fecha_final_vigencia IS NULL))
       AS
       firmaAbogado,
       (SELECT TOP 1 Isnull(fdv.titulo_obtenido, '')
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS tituloObtenido,
       (SELECT TOP 1 Concat (c.nombre, ' (E)')
        FROM   funcionario_devolucion_valores fdv(nolock)
               JOIN cargo c(nolock)
                 ON c.id_cargo = fdv.id_cargo
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS cargo,
       (SELECT TOP 1 fdv.accion_personal
        FROM   funcionario_devolucion_valores fdv(nolock)
        WHERE  fdv.fecha_final_vigencia IS NULL)
       AS accionPesonal,
       CASE pe.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' '
                    , pe.apellido2)
              )
       END
       AS nombreCompleto,
       dv.correos_notificados,
       (SELECT TOP 1 Upper(Concat (perAD.nombre1, ' ', perAD.nombre2, ' '
                           , perAD.apellido1, ' '
                                               , perAD.apellido2))
        FROM   trazabilidad_proceso tpcrr(nolock)
               LEFT JOIN usuario_persona usuAD(nolock)
                      ON usuAD.id_usuario = tpcrr.id_usuario
               LEFT JOIN persona perAD(nolock)
                      ON perAD.id_persona = usuAD.id_persona
        WHERE  tpcrr.id_proceso = :idProceso
               AND tpcrr.id_estado_proceso IN ( 73, 74 ))
       AS nombreFuncionario,
       (SELECT Max(fpe.numero_imagen)
        FROM   trazabilidad_proceso tpcrr(nolock)
               LEFT JOIN usuario_persona usuAD(nolock)
                      ON usuAD.id_usuario = tpcrr.id_usuario
               LEFT JOIN persona perAD(nolock)
                      ON perAD.id_persona = usuAD.id_persona
               LEFT JOIN firma_persona fpe(nolock)
                      ON fpe.id_persona = perAD.id_persona
        WHERE  tpcrr.id_proceso = :idProceso
               AND tpcrr.id_estado_proceso IN ( 73, 74 ))
       AS firmaFuncionario,
       (SELECT sdv.fecha_inicio
        FROM   subsanacion_devolucion_valores(nolock) sdv
               LEFT JOIN trazabilidad_proceso(nolock) tp
                      ON sdv.id_trazabilidad_proceso =
                         tp.id_trazabilidad_proceso
        WHERE  tp.id_estado_proceso = 74
               AND tp.id_proceso = :idProceso)
       AS fechaInicioSubsanacion
FROM   proceso p
       JOIN participante_proceso pp(nolock)
         ON pp.id_proceso = p.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe(nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = pe.id_persona
       LEFT JOIN devolucion_valores dv(nolock)
              ON dv.id_proceso = p.id_proceso
WHERE  p.id_proceso = :idProceso 


-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------