UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @FECHA DATETIME2

SELECT TOP 1 @FECHA = CASE co.id_tipo_coactivo
                        WHEN 3 THEN trp.fecha_inicio
                        ELSE pr.fecha_inicio
                      END
FROM   coactivo co
       JOIN proceso pr (nolock)
         ON pr.id_proceso = co.id_proceso
       JOIN trazabilidad_proceso trp (nolock)
         ON trp.id_proceso = pr.id_proceso
WHERE  co.id_coactivo is not null
       AND trp.id_estado_proceso = 24
ORDER  BY trp.fecha_inicio DESC

SELECT c.id_coactivo,
       Concat(p.numero_proceso, ''-'', Year(p.fecha_inicio))            AS
       ''numeroJuicio'',
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, ''11111111111 '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                                            AS
       nombreCompleto,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Direccionpersona(pe.id_persona, DEFAULT)                   AS
       Direccion,
       @FECHA                                                         AS
       fechaInicio,
       Cast((SELECT DISTINCT Substring((SELECT ( Concat(''-'', c1.numero_citacion)
                                               ) AS
                                                    [text()]
                                        FROM   obligacion_coactivo cp1 (nolock)
                                               JOIN comparendo c1 (nolock)
                                                 ON cp1.numero_obligacion =
                                                    c1.id_factura_axis
                                        WHERE  cp1.id_coactivo = cp2.id_coactivo
                                        ORDER  BY cp1.id_coactivo
                                        FOR xml path ('''')), 1, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max)) citacion,
       Cast((SELECT DISTINCT Substring((SELECT '', '' + Concat(c.numero_citacion,
                                               '' de fecha ''
                                                    ,
            Format(c.fecha_infraccion,
            ''dd \de MMMM \de yyyy''),
            '', tipificada y sancionada en el artículo '',
            ci.articulo, CASE i.id_infraccion WHEN 104 THEN '' '' WHEN 105
            THEN '' ''
            ELSE
            '', numeral '' +
            i.numeral_infraccion END, '' - '', nm.nombre) AS [text()]
            FROM   obligacion_coactivo cp1 (nolock)
            INNER JOIN comparendo c (nolock)
            ON cp1.numero_obligacion = c.id_factura_axis
            INNER JOIN infraccion i (nolock)
            ON c.id_infraccion = i.id_infraccion
            INNER JOIN configuracion_infraccion ci (nolock)
            ON i.id_infraccion = ci.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
            INNER JOIN normatividad nm (nolock)
            ON nm.id_normatividad = ci.id_normatividad
            WHERE  cp1.id_coactivo = cp2.id_coactivo
            ORDER  BY cp1.id_coactivo
            FOR xml path ('''')), 2, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max))
       descripcion,
       Upper(Concat(per.nombre1, ''1111111111111111111111 '', per.nombre2, '' '', per.apellido1, '' '',
             per.apellido2))                                          AS
       nombreAbogado,
       Day(@FECHA)                                                    AS
       diaInicio,
       @FECHA                                                         AS
       horaActual,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
        WHERE  fp.id_persona = per.id_persona)                        AS firma,
       (SELECT Concat(f.memo_nombramiento, '', de fecha '', Cast(
                       Format(f.fecha_nombramiento, ''dd \de MMMM \de yyyy'') AS
                       VARCHAR(
                       50)))
        FROM   funcionario_coactivo f (nolock)
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       datosNombramiento,
       (SELECT Concat(f.titulo_obtenido, '' '', Upper(
               Concat(per.nombre1, '' '', per.nombre2, '' '',
                       per.apellido1, '' '',
               per.apellido2)))
        FROM   funcionario_coactivo f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       titulo_nombreFuncionario,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
               INNER JOIN funcionario_coactivo f (nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       firma_funcionario,
       (SELECT o.norma
        FROM   organismo_normatividad o (nolock)
        WHERE  ( o.estado = 1
                 AND o.codigo_organismo = 11001
                 AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                 AND o.fecha_final_vigencia >= CONVERT(DATE, @FECHA) )
                OR ( o.estado = 1
                     AND o.codigo_organismo = 11001
                     AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND o.fecha_final_vigencia IS NULL ))            AS norma,
       (SELECT Concat(f.titulo_obtenido, '' '', Upper(
               Concat(per.nombre1, ''111111111111111111111 '', per.nombre2, '' 111111111111'',
                       per.apellido1, '' '',
               per.apellido2)), '', Mgs'')
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 11
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       nombreDirector,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434)                                AS
       cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 434)) )                     AS
       cargo_delegado_mayusculas
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   coactivo c (nolock)
       JOIN proceso p (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       JOIN funcionario fu (nolock)
         ON fu.id_funcionario = c.id_funcionario
       JOIN persona per (nolock)
         ON per.id_persona = fu.id_persona
WHERE  c.id_coactivo is not null '               
	   , orden_variables='ID_COACTIVO,NUMERO_PROCESO,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,DIRECCION_INFRACTOR,FECHA_SOLICITUD,numero_citacion,DESCRIPCION_MULTAS,NOMBRE_ABOGADO,DIA_FECHA,HORA_SOLICITUD,IMAGEN_FIRMA,DELEGADO_NOMBRAMIENTO_,DELEGADO_TITULONOMBRE_,IMAGEN_FIRMA_DOS,NORMA,NOMBRE_COMPLETO,PROFESION,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=33

--commit tran

--begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @FECHA DATETIME2

SELECT TOP 1 @FECHA = CASE co.id_tipo_coactivo
                        WHEN 3 THEN trp.fecha_inicio
                        ELSE pr.fecha_inicio
                      END
FROM   coactivo co
       JOIN proceso pr (nolock)
         ON pr.id_proceso = co.id_proceso
       JOIN trazabilidad_proceso trp (nolock)
         ON trp.id_proceso = pr.id_proceso
WHERE  co.id_coactivo is not null
       AND trp.id_estado_proceso = 24
ORDER  BY trp.fecha_inicio DESC

SELECT c.id_coactivo,
       Concat(p.numero_proceso, ''-'', Year(p.fecha_inicio))            AS
       ''numeroJuicio'',
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, ''2222222222222222 '', pe.nombre2, '' 2222222222222222222222'', pe.apellido1, '' '',
                    pe.apellido2))
       END                                                            AS
       nombreCompleto,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Direccionpersona(pe.id_persona, DEFAULT)                   AS
       Direccion,
       @FECHA                                                         AS
       fechaInicio,
       Cast((SELECT DISTINCT Substring((SELECT ( Concat(''-'', c1.numero_citacion)
                                               ) AS
                                                    [text()]
                                        FROM   obligacion_coactivo cp1 (nolock)
                                               JOIN comparendo c1 (nolock)
                                                 ON cp1.numero_obligacion =
                                                    c1.id_factura_axis
                                        WHERE  cp1.id_coactivo = cp2.id_coactivo
                                        ORDER  BY cp1.id_coactivo
                                        FOR xml path ('''')), 1, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max)) citacion,
       Cast((SELECT DISTINCT Substring((SELECT '', '' + Concat(c.numero_citacion,
                                               '' de fecha ''
                                                    ,
            Format(c.fecha_infraccion,
            ''dd \de MMMM \de yyyy''),
            '', tipificada y sancionada en el artículo '',
            ci.articulo, CASE i.id_infraccion WHEN 104 THEN '' '' WHEN 105
            THEN '' ''
            ELSE
            '', numeral '' +
            i.numeral_infraccion END, '' - '', nm.nombre) AS [text()]
            FROM   obligacion_coactivo cp1 (nolock)
            INNER JOIN comparendo c (nolock)
            ON cp1.numero_obligacion = c.id_factura_axis
            INNER JOIN infraccion i (nolock)
            ON c.id_infraccion = i.id_infraccion
            INNER JOIN configuracion_infraccion ci (nolock)
            ON i.id_infraccion = ci.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
            INNER JOIN normatividad nm (nolock)
            ON nm.id_normatividad = ci.id_normatividad
            WHERE  cp1.id_coactivo = cp2.id_coactivo
            ORDER  BY cp1.id_coactivo
            FOR xml path ('''')), 2, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max))
       descripcion,
       Upper(Concat(per.nombre1, ''2222222222222 '', per.nombre2, ''2222222222222 '', per.apellido1, '' '',
             per.apellido2))                                          AS
       nombreAbogado,
       Day(@FECHA)                                                    AS
       diaInicio,
       @FECHA                                                         AS
       horaActual,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
        WHERE  fp.id_persona = per.id_persona)                        AS firma,
       (SELECT Concat(f.memo_nombramiento, '', de fecha '', Cast(
                       Format(f.fecha_nombramiento, ''dd \de MMMM \de yyyy'') AS
                       VARCHAR(
                       50)))
        FROM   funcionario_coactivo f (nolock)
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       datosNombramiento,
       (SELECT Concat(f.titulo_obtenido, '' '', Upper(
               Concat(per.nombre1, '' '', per.nombre2, '' '',
                       per.apellido1, '' '',
               per.apellido2)))
        FROM   funcionario_coactivo f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       titulo_nombreFuncionario,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
               INNER JOIN funcionario_coactivo f (nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       firma_funcionario,
       (SELECT o.norma
        FROM   organismo_normatividad o (nolock)
        WHERE  ( o.estado = 1
                 AND o.codigo_organismo = 11001
                 AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                 AND o.fecha_final_vigencia >= CONVERT(DATE, @FECHA) )
                OR ( o.estado = 1
                     AND o.codigo_organismo = 11001
                     AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND o.fecha_final_vigencia IS NULL ))            AS norma,
       (SELECT Concat(f.titulo_obtenido, '' '', Upper(
               Concat(per.nombre1, '' '', per.nombre2, '' '',
                       per.apellido1, '' '',
               per.apellido2)), '', Mgs'')
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 11
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       nombreDirector,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434)                                AS
       cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 434)) )                     AS
       cargo_delegado_mayusculas
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   coactivo c (nolock)
       JOIN proceso p (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       JOIN funcionario fu (nolock)
         ON fu.id_funcionario = c.id_funcionario
       JOIN persona per (nolock)
         ON per.id_persona = fu.id_persona
WHERE  c.id_coactivo is not null '               
	   , orden_variables='ID_COACTIVO,NUMERO_PROCESO,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,DIRECCION_INFRACTOR,FECHA_SOLICITUD,numero_citacion,DESCRIPCION_MULTAS,NOMBRE_ABOGADO,DIA_FECHA,HORA_SOLICITUD,IMAGEN_FIRMA,DELEGADO_NOMBRAMIENTO_,DELEGADO_TITULONOMBRE_,IMAGEN_FIRMA_DOS,NORMA,NOMBRE_COMPLETO,PROFESION,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=34

--commit tran


--begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @FECHA DATETIME2

SELECT TOP 1 @FECHA = CASE co.id_tipo_coactivo
                        WHEN 3 THEN trp.fecha_inicio
                        ELSE pr.fecha_inicio
                      END
FROM   coactivo co
       JOIN proceso pr (nolock)
         ON pr.id_proceso = co.id_proceso
       JOIN trazabilidad_proceso trp (nolock)
         ON trp.id_proceso = pr.id_proceso
WHERE  co.id_coactivo is not null
       AND trp.id_estado_proceso = 24
ORDER  BY trp.fecha_inicio DESC

SELECT c.id_coactivo,
       Concat(p.numero_proceso, ''-'', Year(p.fecha_inicio))            AS
       ''numeroJuicio'',
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, ''333333333333333 '', pe.nombre2, ''33333333 '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                                            AS
       nombreCompleto,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Direccionpersona(pe.id_persona, DEFAULT)                   AS
       Direccion,
       @FECHA                                                         AS
       fechaInicio,
       Cast((SELECT DISTINCT Substring((SELECT ( Concat(''-'', c1.numero_citacion)
                                               ) AS
                                                    [text()]
                                        FROM   obligacion_coactivo cp1 (nolock)
                                               JOIN comparendo c1 (nolock)
                                                 ON cp1.numero_obligacion =
                                                    c1.id_factura_axis
                                        WHERE  cp1.id_coactivo = cp2.id_coactivo
                                        ORDER  BY cp1.id_coactivo
                                        FOR xml path ('''')), 1, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max)) citacion,
       Cast((SELECT DISTINCT Substring((SELECT '', '' + Concat(c.numero_citacion,
                                               '' de fecha ''
                                                    ,
            Format(c.fecha_infraccion,
            ''dd \de MMMM \de yyyy''),
            '', tipificada y sancionada en el artículo '',
            ci.articulo, CASE i.id_infraccion WHEN 104 THEN '' '' WHEN 105
            THEN '' ''
            ELSE
            '', numeral '' +
            i.numeral_infraccion END, '' - '', nm.nombre) AS [text()]
            FROM   obligacion_coactivo cp1 (nolock)
            INNER JOIN comparendo c (nolock)
            ON cp1.numero_obligacion = c.id_factura_axis
            INNER JOIN infraccion i (nolock)
            ON c.id_infraccion = i.id_infraccion
            INNER JOIN configuracion_infraccion ci (nolock)
            ON i.id_infraccion = ci.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
            INNER JOIN normatividad nm (nolock)
            ON nm.id_normatividad = ci.id_normatividad
            WHERE  cp1.id_coactivo = cp2.id_coactivo
            ORDER  BY cp1.id_coactivo
            FOR xml path ('''')), 2, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max))
       descripcion,
       Upper(Concat(per.nombre1, '' 333333333333'', per.nombre2, ''33333333 '', per.apellido1, '' '',
             per.apellido2))                                          AS
       nombreAbogado,
       Day(@FECHA)                                                    AS
       diaInicio,
       @FECHA                                                         AS
       horaActual,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
        WHERE  fp.id_persona = per.id_persona)                        AS firma,
       (SELECT Concat(f.memo_nombramiento, '', de fecha '', Cast(
                       Format(f.fecha_nombramiento, ''dd \de MMMM \de yyyy'') AS
                       VARCHAR(
                       50)))
        FROM   funcionario_coactivo f (nolock)
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       datosNombramiento,
       (SELECT Concat(f.titulo_obtenido, '' 33333333333333333'', Upper(
               Concat(per.nombre1, '' '', per.nombre2, '' 3333333333333333'',
                       per.apellido1, '' '',
               per.apellido2)))
        FROM   funcionario_coactivo f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       titulo_nombreFuncionario,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
               INNER JOIN funcionario_coactivo f (nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       firma_funcionario,
       (SELECT o.norma
        FROM   organismo_normatividad o (nolock)
        WHERE  ( o.estado = 1
                 AND o.codigo_organismo = 11001
                 AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                 AND o.fecha_final_vigencia >= CONVERT(DATE, @FECHA) )
                OR ( o.estado = 1
                     AND o.codigo_organismo = 11001
                     AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND o.fecha_final_vigencia IS NULL ))            AS norma,
       (SELECT Concat(f.titulo_obtenido, '' '', Upper(
               Concat(per.nombre1, '' '', per.nombre2, '' '',
                       per.apellido1, '' '',
               per.apellido2)), '', Mgs'')
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 11
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       nombreDirector,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434)                                AS
       cargo_delegado,
       ( Upper((SELECT valor_parametro_defecto
                FROM   parametro(nolock)
                WHERE  codigo_parametro = 434)) )                     AS
       cargo_delegado_mayusculas
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   coactivo c (nolock)
       JOIN proceso p (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       JOIN funcionario fu (nolock)
         ON fu.id_funcionario = c.id_funcionario
       JOIN persona per (nolock)
         ON per.id_persona = fu.id_persona
WHERE  c.id_coactivo is not null '               
	   , orden_variables='ID_COACTIVO,NUMERO_PROCESO,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,DIRECCION_INFRACTOR,FECHA_SOLICITUD,numero_citacion,DESCRIPCION_MULTAS,NOMBRE_ABOGADO,DIA_FECHA,HORA_SOLICITUD,IMAGEN_FIRMA,DELEGADO_NOMBRAMIENTO_,DELEGADO_TITULONOMBRE_,IMAGEN_FIRMA_DOS,NORMA,NOMBRE_COMPLETO,PROFESION,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=35