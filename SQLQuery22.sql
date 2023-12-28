	   begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT CASE pe.id_tipo_identificacion
         WHEN ''2'' THEN pj.nombre_comercial
         ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
              pe.apellido2))
       END                                               AS nombreCompleto,
       pr.numero_proceso,
       tip.codigo,
       pe.numero_identificacion,
       pr.fecha_inicio,
       Year(pr.fecha_inicio)                             AS anio_proceso,
       c.fecha_infraccion,
       c.hora_infraccion,
       CASE i.numeral_infraccion
         WHEN '' '' THEN Concat(''art?culo '', ci.articulo, '' - '', nm.nombre)
         ELSE Concat(''art?culo '', ci.articulo, '',         numeral '',
              i.numeral_infraccion,
''                                                                                                                                                                                                        - ''
, nm.nombre)
END                                               AS infraccion,
ci.descripcion,
(SELECT mp.descripcion_hechos
 FROM   motivacion_impugnacion mp (nolock)
 WHERE  mp.id_trazabilidad_proceso = (SELECT tpdh.*
                                      FROM
        (SELECT
                Max(tpmi.id_trazabilidad_proceso) AS idTraza
                                              FROM
                motivacion_impugnacion midh (nolock)
                INNER JOIN trazabilidad_proceso tpmi
                        ON tpmi.id_trazabilidad_proceso =
                           midh.id_trazabilidad_proceso
                INNER JOIN proceso pdh
                        ON pdh.id_proceso = tpmi.id_proceso
                                              WHERE  pdh.id_proceso = :idProceso
        )
        tpdh))                                    AS descripcionHechos,
(SELECT eimp.consideracion_juridica
 FROM   evaluar_impugnacion eimp (nolock)
        INNER JOIN trazabilidad_proceso trei
                ON trei.id_trazabilidad_proceso = eimp.id_trazabilidad_proceso
 WHERE  trei.id_trazabilidad_proceso = (SELECT fiei.*
                                        FROM   (SELECT
                Max(tpei2.id_trazabilidad_proceso) AS idTraza
                                                FROM
                evaluar_impugnacion eimp2 (nolock)
                INNER JOIN trazabilidad_proceso tpei2
                        ON tpei2.id_trazabilidad_proceso =
                           eimp2.id_trazabilidad_proceso
                INNER JOIN proceso pei
                        ON pei.id_proceso = tpei2.id_proceso
                                                WHERE  pei.id_proceso =
                                                       :idProceso) fiei
                                               )) AS consideracionJuridica,
(SELECT fi.motivo
 FROM   fallo_impugnacion fi (nolock)
 WHERE  fi.id_trazabilidad_proceso = (SELECT fimp.*
                                      FROM
        (SELECT
                Max(tpfi.id_trazabilidad_proceso) AS idTraza
                                              FROM   fallo_impugnacion fip (
                                                     nolock)
                INNER JOIN trazabilidad_proceso
                           tpfi
                        ON tpfi.id_trazabilidad_proceso =
                           fip.id_trazabilidad_proceso
                INNER JOIN proceso pfi
                        ON pfi.id_proceso = tpfi.id_proceso
                                              WHERE  pfi.id_proceso = :idProceso
        )
        fimp))                                    AS motivo,
ec.nombre,
c.numero_citacion,
(SELECT trei.fecha_inicio
 FROM   evaluar_impugnacion eimp (nolock)
        INNER JOIN trazabilidad_proceso trei
                ON trei.id_trazabilidad_proceso = eimp.id_trazabilidad_proceso
 WHERE  trei.id_trazabilidad_proceso = (SELECT fiei.*
                                        FROM   (SELECT
                Max(tpei2.id_trazabilidad_proceso) AS idTraza
                                                FROM
                evaluar_impugnacion eimp2 (nolock)
                INNER JOIN trazabilidad_proceso tpei2
                        ON tpei2.id_trazabilidad_proceso =
                           eimp2.id_trazabilidad_proceso
                INNER JOIN proceso pei
                        ON pei.id_proceso = tpei2.id_proceso
                                                WHERE  pei.id_proceso =
                                                       :idProceso) fiei
                                               )) AS fechaEvaluacion,
dir.complemento,
cv.placa_vehiculo                                 AS placa,
( car.saldo_capital + car.saldo_interes )         AS valorMulta,
( car.saldo_capital + car.saldo_interes )         AS valorletras,
(SELECT TOP 1 CASE fu.id_cargo
                WHEN 3 THEN Concat(co.nombre, '' '',
                            ''delegado del director de gesti?n'')
                WHEN 1 THEN ''delegado del director de gesti?n''
                ELSE co.nombre
              END
 FROM   trazabilidad_proceso tpcrr (nolock)
        LEFT JOIN usuario_persona up1 (nolock)
               ON up1.id_usuario = tpcrr.id_usuario
        LEFT JOIN persona pab (nolock)
               ON pab.id_persona = up1.id_persona
        LEFT JOIN funcionario fu (nolock)
               ON fu.id_persona = pab.id_persona
        LEFT JOIN cargo co (nolock)
               ON co.id_cargo = fu.id_cargo
 WHERE  tpcrr.id_proceso = :idProceso
        AND tpcrr.id_estado_proceso = 4)          AS cargo,
(SELECT TOP 1 fu.memo_nombramiento
 FROM   trazabilidad_proceso tpcrr (nolock)
        LEFT JOIN usuario_persona up1 (nolock)
               ON up1.id_usuario = tpcrr.id_usuario
        LEFT JOIN persona pab (nolock)
               ON pab.id_persona = up1.id_persona
        LEFT JOIN funcionario fu (nolock)
               ON fu.id_persona = pab.id_persona
 WHERE  tpcrr.id_proceso = :idProceso
        AND tpcrr.id_estado_proceso = 4)          AS memo_nombramiento,
(SELECT TOP 1 fu.fecha_nombramiento
 FROM   trazabilidad_proceso tpcrr (nolock)
        LEFT JOIN usuario_persona up1 (nolock)
               ON up1.id_usuario = tpcrr.id_usuario
        LEFT JOIN persona pab (nolock)
               ON pab.id_persona = up1.id_persona
        LEFT JOIN funcionario fu (nolock)
               ON fu.id_persona = pab.id_persona
 WHERE  tpcrr.id_proceso = :idProceso
        AND tpcrr.id_estado_proceso = 4)          AS fecha_nombramiento,
(SELECT Max(fp.numero_imagen)
 FROM   trazabilidad_proceso tpcrr (nolock)
        LEFT JOIN usuario_persona up1 (nolock)
               ON up1.id_usuario = tpcrr.id_usuario
        LEFT JOIN persona pab (nolock)
               ON pab.id_persona = up1.id_persona
        INNER JOIN firma_persona fp
                ON fp.id_persona = pab.id_persona
        LEFT JOIN funcionario fu (nolock)
               ON fu.id_persona = pab.id_persona
 WHERE  tpcrr.id_proceso = :idProceso
        AND tpcrr.id_estado_proceso = 4)          AS numero_imagen,
(SELECT TOP 1 Upper(Concat(pab.nombre1, '' '', pab.nombre2, '' '', pab.apellido1,
                    '' '',
                                  pab.apellido2))
 FROM   trazabilidad_proceso tpcrr (nolock)
        LEFT JOIN usuario_persona up1 (nolock)
               ON up1.id_usuario = tpcrr.id_usuario
        LEFT JOIN persona pab (nolock)
               ON pab.id_persona = up1.id_persona
        LEFT JOIN funcionario fu (nolock)
               ON fu.id_persona = pab.id_persona
 WHERE  tpcrr.id_proceso = :idProceso
        AND tpcrr.id_estado_proceso = 4)          AS nombreAprobador,
(SELECT TOP 1 Concat(p.nombre1, '' '', p.nombre2, '' '', p.apellido1, '' '',
              p.apellido2)
 FROM   trazabilidad_proceso tp (nolock)
        INNER JOIN usuario_persona up (nolock)
                ON up.id_usuario = tp.id_usuario
        LEFT JOIN persona p (nolock)
               ON p.id_persona = up.id_persona
        LEFT JOIN firma_persona fp (nolock)
               ON fp.id_persona = p.id_persona
 WHERE  tp.id_estado_proceso IN ( 3, 14 )
        AND tp.id_proceso = pr.id_proceso
 ORDER  BY tp.fecha_inicio DESC)                  AS nombreProyectado,
(SELECT TOP 1 cp.correo_electronico
 FROM   correo_persona cp (nolock)
 WHERE  cp.estado = 1
        AND cp.id_persona = pe.id_persona
 ORDER  BY cp.fecha_registro DESC)                AS correos,
(SELECT TOP 1 (fp.numero_imagen)
 FROM   trazabilidad_proceso tp (nolock)
        INNER JOIN usuario_persona up (nolock)
                ON up.id_usuario = tp.id_usuario
        LEFT JOIN persona p (nolock)
               ON p.id_persona = up.id_persona
        LEFT JOIN firma_persona fp (nolock)
               ON fp.id_persona = p.id_persona
 WHERE  tp.id_estado_proceso IN ( 3, 14 )
        AND tp.id_proceso = pr.id_proceso
		ORDER  BY tp.fecha_inicio DESC)        AS firmaSecretario,
(SELECT TOP 1 Concat(p.nombre1, '' '', p.nombre2, '' '', p.apellido1, ''         '',
              p.apellido2)
 FROM   trazabilidad_proceso tp (nolock)
        INNER JOIN usuario_persona up (nolock)
                ON up.id_usuario = tp.id_usuario
        LEFT JOIN persona p (nolock)
               ON p.id_persona = up.id_persona
        LEFT JOIN firma_persona fp (nolock)
               ON fp.id_persona = p.id_persona
 WHERE  tp.id_estado_proceso IN ( 3, 14 )
        AND tp.id_proceso = pr.id_proceso
 ORDER  BY tp.fecha_inicio DESC)                  AS nombreSecretario,
(SELECT CASE
          WHEN funt.id_cargo = 11 THEN ''''
          ELSE ''delegado del''
        END
 FROM   usuario_persona upet (nolock)
        INNER JOIN funcionario funt (nolock)
                ON upet.id_persona = funt.id_persona
 WHERE  upet.id_usuario = tp.id_usuario)          TEXTO_NOMBRE_1,
(SELECT TOP 1 Concat(f.titulo_obtenido, '' '', p.nombre1, '' '', p.nombre2, '' '',
              p.apellido1, '' '',
                            p.apellido2)
 FROM   funcionario f
        JOIN persona p
          ON f.id_persona = p.id_persona
 WHERE  id_cargo = 11
        AND fecha_final_vigencia IS NULL)         AS nombreDirector
FROM   proceso pr (nolock)
       JOIN comparendo_proceso cp (nolock)
         ON cp.id_proceso = pr.id_proceso
       JOIN comparendo c (nolock)
         ON cp.cicomparendo = c.cicomparendo
       JOIN estado_comparendo ec (nolock)
         ON ec.id_estado_comparendo = c.id_estado_comparendo
       JOIN infraccion i (nolock)
         ON c.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci (nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN normatividad nm (nolock)
         ON nm.id_normatividad = ci.id_normatividad
       JOIN participante_proceso pp (nolock)
         ON pp.id_proceso = pr.id_proceso
            AND pp.id_tipo_participante = 2
       JOIN persona pe (nolock)
         ON pp.id_persona = pe.id_persona
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON pe.id_tipo_identificacion = tip.id_tipo_identificacion
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = pr.id_proceso
       JOIN direccion dir (nolock)
         ON dir.id_direccion = c.id_direccion_comparendo
       LEFT JOIN comparendo_vehiculo cv (nolock)
              ON cv.id_comparendo_vehiculo = c.cicomparendo
       JOIN comparendo_cartera cca (nolock)
         ON cca.cicomparendo = c.cicomparendo
       JOIN cartera car (nolock)
         ON car.id_cartera = cca.id_cartera
WHERE  ( tp.id_trazabilidad_proceso = (SELECT Max(tz1.id_trazabilidad_proceso)
                                       FROM   trazabilidad_proceso tz1 (nolock)
                                       WHERE  tz1.id_proceso = pr.id_proceso) )
       AND pr.id_proceso = :idProceso
       AND c.id_estado_comparendo != 14 '               
	   
WHERE  id_plantilla_config=10185

commit tran