----------------------------------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @FECHA DATE

SELECT TOP 1 @FECHA = tp.fecha_inicio
FROM   coactivo c(nolock)
       JOIN proceso p(nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = c.id_proceso
            AND tp.id_estado_proceso = 69
WHERE  c.id_coactivo = :idCoactivo
ORDER  BY c.id_coactivo DESC

SELECT c.numero_coactivo,
       tp.fecha_inicio                                             AS fecha1,
       ''Centro Comercial Albán Borja, local 56 A y B''             AS direccion,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
               '' ''
                       , per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' ''
               , per.apellido2)
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))         AS
       nombrefuncionario,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1),
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido)),
               '' ''
                       , per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' ''
               , per.apellido2,
                       '', Mgs'')
        FROM   funcionario f,
               persona per
        WHERE  f.id_cargo = 11
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 11
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))         AS abogado,
       CASE per.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat (per.nombre1, '' '', per.nombre2, '' '', per.apellido1,
                    '' ''
                           , per.apellido2))
       END                                                         AS
       nombreCompleto,
       ''EPMTG-DGIST-0111-2016''                                     AS memorando,
       Cast(''2016-07-12'' AS DATE)                                  AS
       fechaMemorando,
       tp.fecha_inicio                                             AS fecha2,
       per.numero_identificacion,
       tip.codigo,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
        WHERE  fp.id_persona = per.id_persona)                     AS firma,
       (SELECT Concat (f.memo_nombramiento, '', de fecha '', Cast(
                       Format(f.fecha_nombramiento, ''dd \de MMMM \de yyyy'') AS
                       VARCHAR(
                       50)))
        FROM   funcionario_coactivo f(nolock)
               INNER JOIN coactivo_funcionario cf(nolock)
                       ON f.id_funcionario = cf.id_funcionario
        WHERE  cf.id_coactivo = c.id_coactivo
               AND ( ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                       AND f.fecha_final_vigencia >= cf.fecha_creacion )
                      OR ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                           AND f.fecha_final_vigencia IS NULL ) )) AS
       datosNombramiento,
       (SELECT Concat (f.titulo_obtenido, '' '', Upper(
                       Concat (per.nombre1, '' '', per.nombre2, '' '', per.apellido1
                       , '' ''
                                                       , per.apellido2)))
        FROM   funcionario_coactivo f(nolock)
               INNER JOIN persona per(nolock)
                       ON f.id_persona = per.id_persona
               INNER JOIN coactivo_funcionario cf(nolock)
                       ON f.id_funcionario = cf.id_funcionario
        WHERE  cf.id_coactivo = c.id_coactivo
               AND ( ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                       AND f.fecha_final_vigencia >= cf.fecha_creacion )
                      OR ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                           AND f.fecha_final_vigencia IS NULL ) )) AS
       titulo_nombreFuncionario,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario_coactivo f(nolock)
                       ON f.id_persona = fp.id_persona
               INNER JOIN coactivo_funcionario cf(nolock)
                       ON f.id_funcionario = cf.id_funcionario
        WHERE  cf.id_coactivo = c.id_coactivo
               AND ( ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                       AND f.fecha_final_vigencia >= cf.fecha_creacion )
                      OR ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                           AND f.fecha_final_vigencia IS NULL ) )) AS
       firma_funcionario,
       Year(p.fecha_inicio)                                        AS year,
(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434) AS cargo_delegado
FROM   coactivo c(nolock)
       JOIN proceso p(nolock)
         ON p.id_proceso = c.id_proceso
       JOIN funcionario fu(nolock)
         ON fu.id_funcionario = c.id_funcionario
       JOIN persona per(nolock)
         ON per.id_persona = fu.id_persona
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = per.id_persona
       JOIN tipo_identificacion_persona tip(nolock)
         ON tip.id_tipo_identificacion = per.id_tipo_identificacion
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = c.id_proceso
       INNER JOIN titulo_credito t
               ON t.idcoactivo = c.id_coactivo
WHERE  c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 69 '               
	   , orden_variables='numero_consecutivo,FECHA_GENERACION,UBICACION_SEDE,NOMBRE_DELEGADO,NOMBRE_ABOGADO_ASIG,NOMBRE_ABOGADO,NUMERO_MEMORANDO,FECHA_MEMORANDO,FECHA_SOLICITUD,DOCUMENTO_PARTICIPANTE,T_DOCUMENTO_PARTICIPANTE,IMAGEN_FIRMA,DELEGADO_NOMBRAMIENTO_,DELEGADO_TITULONOMBRE_,IMAGEN_FIRMA_DOS,ESTADO,CARGO_DELEGADO'
WHERE  id_plantilla_config=10118


commit tran

-------------------------------------------------------------------------------------------------------
DECLARE @FECHA DATE

SELECT TOP 1 @FECHA = tp.fecha_inicio
FROM   coactivo c(nolock)
       JOIN proceso p(nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = c.id_proceso
            AND tp.id_estado_proceso = 69
WHERE  c.id_coactivo = :idCoactivo
ORDER  BY c.id_coactivo DESC

SELECT c.numero_coactivo,
       tp.fecha_inicio                                             AS fecha1,
       'Centro Comercial Albán Borja, local 56 A y B'             AS direccion,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
               ' '
                       , per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' '
               , per.apellido2)
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))         AS
       nombrefuncionario,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1),
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido)),
               ' '
                       , per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' '
               , per.apellido2,
                       ', Mgs')
        FROM   funcionario f,
               persona per
        WHERE  f.id_cargo = 11
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 11
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))         AS abogado,
       CASE per.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                    ' '
                           , per.apellido2))
       END                                                         AS
       nombreCompleto,
       'EPMTG-DGIST-0111-2016'                                     AS memorando,
       Cast('2016-07-12' AS DATE)                                  AS
       fechaMemorando,
       tp.fecha_inicio                                             AS fecha2,
       per.numero_identificacion,
       tip.codigo,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
        WHERE  fp.id_persona = per.id_persona)                     AS firma,
       (SELECT Concat (f.memo_nombramiento, ', de fecha ', Cast(
                       Format(f.fecha_nombramiento, 'dd \de MMMM \de yyyy') AS
                       VARCHAR(
                       50)))
        FROM   funcionario_coactivo f(nolock)
               INNER JOIN coactivo_funcionario cf(nolock)
                       ON f.id_funcionario = cf.id_funcionario
        WHERE  cf.id_coactivo = c.id_coactivo
               AND ( ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                       AND f.fecha_final_vigencia >= cf.fecha_creacion )
                      OR ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                           AND f.fecha_final_vigencia IS NULL ) )) AS
       datosNombramiento,
       (SELECT Concat (f.titulo_obtenido, ' ', Upper(
                       Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1
                       , ' '
                                                       , per.apellido2)))
        FROM   funcionario_coactivo f(nolock)
               INNER JOIN persona per(nolock)
                       ON f.id_persona = per.id_persona
               INNER JOIN coactivo_funcionario cf(nolock)
                       ON f.id_funcionario = cf.id_funcionario
        WHERE  cf.id_coactivo = c.id_coactivo
               AND ( ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                       AND f.fecha_final_vigencia >= cf.fecha_creacion )
                      OR ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                           AND f.fecha_final_vigencia IS NULL ) )) AS
       titulo_nombreFuncionario,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario_coactivo f(nolock)
                       ON f.id_persona = fp.id_persona
               INNER JOIN coactivo_funcionario cf(nolock)
                       ON f.id_funcionario = cf.id_funcionario
        WHERE  cf.id_coactivo = c.id_coactivo
               AND ( ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                       AND f.fecha_final_vigencia >= cf.fecha_creacion )
                      OR ( f.fecha_inicio_vigencia <= cf.fecha_creacion
                           AND f.fecha_final_vigencia IS NULL ) )) AS
       firma_funcionario,
       Year(p.fecha_inicio)                                        AS year,
(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434) AS cargo_delegado
FROM   coactivo c(nolock)
       JOIN proceso p(nolock)
         ON p.id_proceso = c.id_proceso
       JOIN funcionario fu(nolock)
         ON fu.id_funcionario = c.id_funcionario
       JOIN persona per(nolock)
         ON per.id_persona = fu.id_persona
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = per.id_persona
       JOIN tipo_identificacion_persona tip(nolock)
         ON tip.id_tipo_identificacion = per.id_tipo_identificacion
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = c.id_proceso
       INNER JOIN titulo_credito t
               ON t.idcoactivo = c.id_coactivo
WHERE  c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 69 



--order variables
numero_consecutivo,FECHA_GENERACION,UBICACION_SEDE,NOMBRE_DELEGADO,NOMBRE_ABOGADO_ASIG,NOMBRE_ABOGADO,NUMERO_MEMORANDO,FECHA_MEMORANDO,FECHA_SOLICITUD,DOCUMENTO_PARTICIPANTE,T_DOCUMENTO_PARTICIPANTE,IMAGEN_FIRMA,DELEGADO_NOMBRAMIENTO_,DELEGADO_TITULONOMBRE_,IMAGEN_FIRMA_DOS,ESTADO,CARGO_DELEGADO