--DOC_DETER_DEUDA_COU 2635 10165
--DOC_DETER_DEUDA_COU

--DOC_DETER_DEUDA_COU 2635                                  Acomodar probar Ok  se realiza igual a coa_titulo_credito pero el tipo de file es determinacion tributaria min 20 https://www.youtube.com/watch?v=UtXTT0AH4IE

begin tran 
update documentos..plantilla set fecha_inicio='2024-08-12' where id_plantilla=2635
update documentos..plantilla set fecha_inicio='2024-08-10' where id_plantilla=2635
commit tran

select *from gestor_docs.dbo.version_data_documento
where codigo_documento=2461082--256317354
                     --256317354


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables='TITULO,NOMBRE_INFRACTOR,DIRECCION_INFRACTOR,hora_actual,FECHA_DELEGADO,NOMBRE_COMPLETO,DIRECCION_COACTIVA,placa,N_DOCUMENTO_INFRACTOR,TEXTO_NOTIFICACION,VALOR_DEUDA_CARTERA,NUMERO_OBLIGACION,FECHA_INFRACCION,FECHA_EVALUACION,FECHA_SENTAR_RAZON_FALLO,FECHA_SOLICITUD,DIAS_COBRO_LETRA,DIAS_COBRO,FECHA_INFRACCION3,NOTIFICACION,IMAGEN_FIRMA,NOMBRE_ABOGADO,FECHA_INFRACCION4,FECHA_INFRACCION2,OTROS,VALOR_INTERES2,INF_IMPUGNANTE,NOMBRE_DELEGADO,NUMERO_LOTE,LONGITUD,VALOR_INTERES,TEXTO_NOMBRE_1,TIPO_BIEN,PARRAFO_1,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10165

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'DOC_DETER_DEUDA_COU';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------

SELECT Concat (Year(pre.fecha_actual), '-', pre.consecutivo)        AS
       consecutivo,
       CASE p.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' '
                    , p.apellido2))
       END                                                          AS
       nombreCompleto,
       Isnull((SELECT TOP 1 Cast(direccion_de_entrega AS VARCHAR(200))
               FROM   integracion_terceros..ubicabilidad_courier_validada
               WHERE  numero_identificacion = p.numero_identificacion
                      AND tipo_identificacion = tip.codigo
               ORDER  BY fecha_registro DESC), 'GUAYAS, GUAYAQUIL') AS direccion
       ,
       Getdate()                                                    AS
       hora,
       Getdate()                                                    AS
       fecha_actual,
       pa.nombre_patio,
       (SELECT di.complemento
        FROM   direccion di
        WHERE  pa.id_patio = di.id_direccion)                       AS
       direccionPatio,
       pre.placa_vehiculo,
       p.numero_identificacion,
       ti.nombre                                                    AS
       motivoRetencion,
       tp.tarifa,
       pre.numero_obligacion,
       pp.fecha_ingreso,
       pp.fecha_ingreso                                             AS
       fechaIngreso,
       pp.fecha_inicio_periodo,
       pp.fecha_fin_periodo,
       pp.valor_tasa,
       (SELECT Datediff(day, Min(fecha_inicio_periodo), Max(fecha_fin_periodo))
               + 1
        FROM   periodo_precoactivo
        WHERE  numero_periodo <= pp.numero_periodo
               AND estado_periodo <> 'ANULADO'
               AND id_precoactivo = pre.id_precoactivo)             AS dias,
       Getdate()                                                    AS
       fecha_actual2,
       (SELECT [dbo].[Convertirnumeroletra]((SELECT Sum(Cast(valor_tasa AS
                                                             DECIMAL(10, 2)))
                                             FROM   periodo_precoactivo
                                             WHERE
               numero_periodo <= pp.numero_periodo
               AND estado_periodo <> 'ANULADO'
               AND id_precoactivo =
                   pre.id_precoactivo),
                       ''))                                         AS
       valorTotal,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario fu(nolock)
                       ON fu.id_persona = fp.id_persona
        WHERE  fu.id_funcionario = (SELECT Max(f.id_funcionario)
                                    FROM   funcionario f
                                    WHERE  f.id_cargo = 4
                                           AND f.id_subcargo = 3))  AS firma,
       (SELECT DISTINCT Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' '
                        , p.apellido2) AS s
        FROM   persona p
               INNER JOIN funcionario fu
                       ON fu.id_persona = p.id_persona
                          AND fu.id_cargo = 13
                          AND fecha_final_vigencia IS NULL)         AS
       nombreFuncionario,
       pp.fecha_inicio_periodo                                      AS
       fechaInicio,
       pp.fecha_fin_periodo                                         AS fechaFin,
       tip.nombre                                                   AS
       tipoIdentificacion,
       pre.valor_liquidacion                                        AS
       valorLiquidacion,
       pre.numero_chasis,
       (SELECT DISTINCT Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' '
                        , p.apellido2) AS s
        FROM   persona p
               INNER JOIN funcionario fu
                       ON fu.id_persona = p.id_persona
               INNER JOIN precoactivo pre
                       ON (SELECT Max(f.id_funcionario)
                           FROM   funcionario f
                           WHERE  f.id_cargo = 4
                                  AND f.id_subcargo = 3) = fu.id_funcionario),
       pp.numero_periodo,
       (SELECT Sum(Cast(valor_tasa AS DECIMAL(10, 2)))
        FROM   periodo_precoactivo
        WHERE  numero_periodo < pp.numero_periodo
               AND estado_periodo <> 'ANULADO'
               AND id_precoactivo = pre.id_precoactivo)             AS
       valoresanteriores,
       (SELECT Sum(Cast(valor_tasa AS DECIMAL(10, 2)))
        FROM   periodo_precoactivo
        WHERE  numero_periodo <= pp.numero_periodo
               AND estado_periodo <> 'ANULADO'
               AND id_precoactivo = pre.id_precoactivo)             AS v,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))))
        FROM   funcionario f,
               persona per
        WHERE  per.id_persona = f.id_persona
               AND f.fecha_final_vigencia IS NULL
               AND id_cargo = 13
               AND fecha_final_vigencia IS NULL)                    AS titulo,
       CASE
         WHEN ti.articulo IS NULL THEN ''
         WHEN ti.articulo <> '' THEN Concat (ti.articulo, ' -')
         ELSE ''
       END                                                          AS articulo,
       CASE
         WHEN pp.id_periodo IN ( 144933, 175647, 145895, 175648,
                                 145901, 148753, 175650, 148754,
                                 175651, 151713, 177016, 155644,
                                 155712, 155831, 155832, 155835,
                                 173791, 173792, 174550, 174551,
                                 175234, 175236, 175238, 175239,
                                 175240, 175540, 175550, 175552,
                                 175551, 175549, 175558, 175559,
                                 176362, 176913, 176915, 176916,
                                 176918, 176919, 177063, 177066,
                                 177993, 177995, 177998, 177999,
                                 178829, 178822, 178823, 178832,
                                 178831, 178839, 178845, 178840,
                                 178843, 178859, 178860, 178862,
                                 138118, 175621, 138120, 175622,
                                 138126, 175623, 138130, 175624,
                                 138132, 175625, 138141, 175626,
                                 139079, 175627, 168989, 139083,
                                 175628, 139084, 175629, 139085,
                                 175630, 139103, 175631, 139107,
                                 139109, 175632, 139131, 175634,
                                 139142, 175635, 139167, 139168,
                                 139190, 139206, 175637, 139219,
                                 139221, 175639, 139228, 139234,
                                 175641, 141110, 175642, 141116,
                                 143011, 143027, 175644, 143032,
                                 175645, 143041, 175646, 149147,
                                 175652, 149152, 149154, 175653,
                                 149293, 149358, 149365, 175654,
                                 149372, 175655, 149389, 175656,
                                 149417, 149419, 149528, 175657,
                                 149537, 175658, 149576, 175659,
                                 149620, 175660, 153781, 179290,
                                 153786, 179446, 158664, 161492,
                                 163424, 165717, 165743, 167632,
                                 167633, 167634, 167795, 167798,
                                 168006, 169001, 169132, 169140,
                                 169142, 169265, 169515, 169517,
                                 169982, 169983, 169984, 171144,
                                 172061, 172062, 172063, 172066,
                                 172078, 172079, 172988, 172990,
                                 179130, 179282, 179277, 179441 ) THEN
'El presente documento sustituye cualquier otro emitido por el mismo concepto y hechos'
  ELSE ''
END                                                          AS textoMostrar
,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   precoactivo pre
       INNER JOIN persona p
               ON p.id_persona = pre.id_deudor
       INNER JOIN tipo_identificacion_persona tip
               ON p.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = p.id_persona
       INNER JOIN motivo_inmovilizacion_vehiculo ti
               ON ti.id_motivo_inmovilizacion_vehiculo = pre.motivo_retencion
       INNER JOIN patio pa
               ON pa.id_patio = pre.id_patio
       INNER JOIN periodo_precoactivo pp
               ON pp.id_precoactivo = pre.id_precoactivo
       LEFT JOIN tarifa_patio tp
              ON tp.id_unidad_vehicular = pre.tipo_vehiculo
                 AND ( tp.fecha_inicio_vigencia <= pp.fecha_fin_periodo
                       AND tp.fecha_fin_vigencia >= pp.fecha_fin_periodo )
WHERE  pp.id_periodo = :periodo
       AND p.id_persona = :idPersona
       AND pre.id_precoactivo is not null 






---------------------------------------------------
--Original
-------------------------------------------------------------------------------------
SELECT CONCAT (    YEAR(pre.fecha_actual)    ,'-'    ,pre.consecutivo    ) AS consecutivo   ,CASE p.id_tipo_identificacion    WHEN '2'     THEN pj.nombre_comercial    ELSE UPPER(CONCAT (       p.nombre1       ,' '       ,p.nombre2       ,' '       ,p.apellido1       ,' '       ,p.apellido2       ))    END AS nombreCompleto   ,ISNULL((     SELECT TOP 1 CAST(direccion_de_entrega AS VARCHAR(200))     FROM integracion_terceros..ubicabilidad_courier_validada     WHERE numero_identificacion = p.numero_identificacion      AND tipo_identificacion = tip.codigo     ORDER BY fecha_registro DESC     ), 'GUAYAS, GUAYAQUIL') AS direccion   ,GETDATE() AS hora   ,GETDATE() AS fecha_actual   ,pa.nombre_patio   ,(    SELECT di.complemento    FROM direccion di    WHERE pa.id_patio = di.id_direccion    ) AS direccionPatio   ,pre.placa_vehiculo   ,p.numero_identificacion   ,ti.nombre AS motivoRetencion   ,tp.tarifa   ,pre.numero_obligacion   ,pp.fecha_ingreso   ,pp.fecha_ingreso AS fechaIngreso   ,pp.fecha_inicio_periodo   ,pp.fecha_fin_periodo   ,pp.valor_tasa   ,(    SELECT DATEDIFF(DAY, MIN(fecha_inicio_periodo), MAX(fecha_fin_periodo)) + 1    FROM periodo_precoactivo    WHERE numero_periodo <= pp.numero_periodo     AND estado_periodo <> 'ANULADO'     AND id_precoactivo = pre.id_precoactivo    ) AS dias   ,GETDATE() AS fecha_actual2   ,(    SELECT [dbo].[convertirNumeroLetra]((       SELECT SUM(CAST(valor_tasa AS DECIMAL(10, 2)))       FROM periodo_precoactivo       WHERE numero_periodo <= pp.numero_periodo        AND estado_periodo <> 'ANULADO'        AND id_precoactivo = pre.id_precoactivo       ), '')    ) AS valorTotal   ,(    SELECT MAX(fp.numero_imagen)    FROM firma_persona fp(NOLOCK)    INNER JOIN funcionario fu(NOLOCK) ON fu.id_persona = fp.id_persona    WHERE fu.id_funcionario = (      SELECT MAX(f.id_funcionario)      FROM funcionario f      WHERE f.id_cargo = 4       AND f.id_subcargo = 3      )    ) AS firma   ,(    SELECT DISTINCT CONCAT (      p.nombre1      ,' '      ,p.nombre2      ,' '      ,p.apellido1      ,' '      ,p.apellido2      ) AS s    FROM persona p    INNER JOIN funcionario fu ON fu.id_persona = p.id_persona     AND fu.id_cargo = 13     AND fecha_final_vigencia IS NULL    ) AS nombreFuncionario   ,pp.fecha_inicio_periodo AS fechaInicio   ,pp.fecha_fin_periodo AS fechaFin   ,tip.nombre AS tipoIdentificacion   ,pre.valor_liquidacion AS valorLiquidacion   ,pre.numero_chasis   ,(    SELECT DISTINCT CONCAT (      p.nombre1      ,' '      ,p.nombre2      ,' '      ,p.apellido1      ,' '      ,p.apellido2      ) AS s    FROM persona p    INNER JOIN funcionario fu ON fu.id_persona = p.id_persona    INNER JOIN precoactivo pre ON (      SELECT MAX(f.id_funcionario)      FROM funcionario f      WHERE f.id_cargo = 4       AND f.id_subcargo = 3      ) = fu.id_funcionario    )   ,pp.numero_periodo   ,(    SELECT SUM(CAST(valor_tasa AS DECIMAL(10, 2)))    FROM periodo_precoactivo    WHERE numero_periodo < pp.numero_periodo     AND estado_periodo <> 'ANULADO'     AND id_precoactivo = pre.id_precoactivo    ) AS valoresanteriores   ,(    SELECT SUM(CAST(valor_tasa AS DECIMAL(10, 2)))    FROM periodo_precoactivo    WHERE numero_periodo <= pp.numero_periodo     AND estado_periodo <> 'ANULADO'     AND id_precoactivo = pre.id_precoactivo    ) AS v   ,(    SELECT CONCAT (      SUBSTRING(f.titulo_obtenido, 1, 1)      ,LOWER(SUBSTRING(f.titulo_obtenido, 2, LEN(f.titulo_obtenido)))      )    FROM funcionario f     ,persona per    WHERE per.id_persona = f.id_persona     AND f.fecha_final_vigencia IS NULL     AND id_cargo = 13     AND fecha_final_vigencia IS NULL    ) AS titulo   ,CASE     WHEN ti.articulo IS NULL     THEN ''    WHEN ti.articulo <> ''     THEN CONCAT (       ti.articulo       ,' -'       )    ELSE ''    END AS articulo    ,CASE WHEN pp.id_periodo IN (144933,175647,145895,175648,145901,148753,175650,148754,175651,151713,177016,155644,155712,155831,155832,155835,173791,173792,174550,174551,175234,175236,175238,175239,175240,175540,175550,175552,175551,175549,175558,175559,176362,176913,176915,176916,176918,176919,177063,177066,177993,177995,177998,177999,178829,178822,178823,178832,178831,178839,178845,178840,178843,178859,178860,178862,138118,175621,138120,175622,138126,175623,138130,175624,138132,175625,138141,175626,139079,175627,168989,139083,175628,139084,175629,139085,175630,139103,175631,139107,139109,175632,139131,175634,139142,175635,139167,139168,139190,139206,175637,139219,139221,175639,139228,139234,175641,141110,175642,141116,143011,143027,175644,143032,175645,143041,175646,149147,175652,149152,149154,175653,149293,149358,149365,175654,149372,175655,149389,175656,149417,149419,149528,175657,149537,175658,149576,175659,149620,175660,153781,179290,153786,179446,158664,161492,163424,165717,165743,167632,167633,167634,167795,167798,168006,169001,169132,169140,169142,169265,169515,169517,169982,169983,169984,171144,172061,172062,172063,172066,172078,172079,172988,172990,179130,179282,179277,179441)     THEN 'El presente documento sustituye cualquier otro emitido por el mismo concepto y hechos'    ELSE ''    END AS textoMostrar  FROM precoactivo pre  INNER JOIN persona p ON p.id_persona = pre.id_deudor  INNER JOIN tipo_identificacion_persona tip ON p.id_tipo_identificacion = tip.id_tipo_identificacion  LEFT JOIN persona_juridica pj(NOLOCK) ON pj.id_persona_juridica = p.id_persona  INNER JOIN motivo_inmovilizacion_vehiculo ti ON ti.id_motivo_inmovilizacion_vehiculo = pre.motivo_retencion  INNER JOIN patio pa ON pa.id_patio = pre.id_patio  INNER JOIN periodo_precoactivo pp ON pp.id_precoactivo = pre.id_precoactivo  LEFT JOIN tarifa_patio tp ON tp.id_unidad_vehicular = pre.tipo_vehiculo   AND (    tp.fecha_inicio_vigencia <= pp.fecha_fin_periodo    AND tp.fecha_fin_vigencia >= pp.fecha_fin_periodo    )  WHERE pp.id_periodo = :periodo   AND p.id_persona = :idPersona   AND pre.id_precoactivo is not null
-------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--                                    *************************
--PRECOACTIVOS VÁLIDOS PARA COURIER - DETERMINACIÓN TRIBUTARIA
--                                   ***************************
select pp.*, p.* from precoactivo p

inner join periodo_precoactivo pp on pp.id_precoactivo=p.id_precoactivo

where  p.id_estado_vehiculo_patio=2 

and pp.estado_periodo in('activo','inactivo')

and pp.fecha_notificacion_determinacion is null 

and exists (select * from integracion_terceros..ubicabilidad_courier_validada u where u.id_persona=p.id_deudor)

and (select top 1 estado_periodo from periodo_precoactivo where id_precoactivo=pp.id_precoactivo and estado_periodo<>'ANULADO' order by id_periodo desc) = 'activo' 

order by pp.id_precoactivo desc
 


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Datos para hacer pruebas


--PRECOACTIVOS VÁLIDOS PARA COURIER - TÍTULO CRÉDITO
select pp.*, t.* from precoactivo p
inner join periodo_precoactivo pp on pp.id_precoactivo=p.id_precoactivo
inner join titulo_credito t on t.id_periodo_precoactivo=pp.id_periodo
where  p.id_estado_vehiculo_patio=2
and pp.estado_periodo in('activo','inactivo')
and t.fecha_notificacion is null 
and fecha_notificacion_titulo is null
and exists (select * from integracion_terceros..ubicabilidad_courier_validada u where u.id_persona=p.id_deudor)
and (select top 1 estado_periodo from periodo_precoactivo where id_precoactivo=pp.id_precoactivo and estado_periodo<>'ANULADO' order by id_periodo desc) = 'activo' 
order by pp.id_precoactivo desc
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------



















--Antiguo query update


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT Concat (Year(pre.fecha_actual), ''-'', pre.consecutivo)        AS
       consecutivo,
       CASE p.id_tipo_identificacion
         WHEN ''2'' THEN pj.nombre_comercial
         ELSE Upper(Concat (p.nombre1, '' '', p.nombre2, '' '', p.apellido1, '' ''
                    , p.apellido2))
       END                                                          AS
       nombreCompleto,
       Isnull((SELECT TOP 1 Cast(direccion_de_entrega AS VARCHAR(200))
               FROM   integracion_terceros..ubicabilidad_courier_validada
               WHERE  numero_identificacion = p.numero_identificacion
                      AND tipo_identificacion = tip.codigo
               ORDER  BY fecha_registro DESC), ''GUAYAS, GUAYAQUIL'') AS direccion
       ,
       Getdate()                                                    AS
       hora,
       Getdate()                                                    AS
       fecha_actual,
       pa.nombre_patio,
       (SELECT di.complemento
        FROM   direccion di
        WHERE  pa.id_patio = di.id_direccion)                       AS
       direccionPatio,
       pre.placa_vehiculo,
       p.numero_identificacion,
       ti.nombre                                                    AS
       motivoRetencion,
       tp.tarifa,
       pre.numero_obligacion,
       pp.fecha_ingreso,
       pp.fecha_ingreso                                             AS
       fechaIngreso,
       pp.fecha_inicio_periodo,
       pp.fecha_fin_periodo,
       pp.valor_tasa,
       (SELECT Datediff(day, Min(fecha_inicio_periodo), Max(fecha_fin_periodo))
               + 1
        FROM   periodo_precoactivo
        WHERE  numero_periodo <= pp.numero_periodo
               AND estado_periodo <> ''ANULADO''
               AND id_precoactivo = pre.id_precoactivo)             AS dias,
       Getdate()                                                    AS
       fecha_actual2,
       (SELECT [dbo].[Convertirnumeroletra]((SELECT Sum(Cast(valor_tasa AS
                                                             DECIMAL(10, 2)))
                                             FROM   periodo_precoactivo
                                             WHERE
               numero_periodo <= pp.numero_periodo
               AND estado_periodo <> ''ANULADO''
               AND id_precoactivo =
                   pre.id_precoactivo),
                       ''''))                                         AS
       valorTotal,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario fu(nolock)
                       ON fu.id_persona = fp.id_persona
        WHERE  fu.id_funcionario = (SELECT Max(f.id_funcionario)
                                    FROM   funcionario f
                                    WHERE  f.id_cargo = 4
                                           AND f.id_subcargo = 3))  AS firma,
       (SELECT DISTINCT Concat (p.nombre1, '' '', p.nombre2, '' '', p.apellido1, '' ''
                        , p.apellido2) AS s
        FROM   persona p
               INNER JOIN funcionario fu
                       ON fu.id_persona = p.id_persona
                          AND fu.id_cargo = 13
                          AND fecha_final_vigencia IS NULL)         AS
       nombreFuncionario,
       pp.fecha_inicio_periodo                                      AS
       fechaInicio,
       pp.fecha_fin_periodo                                         AS fechaFin,
       tip.nombre                                                   AS
       tipoIdentificacion,
       pre.valor_liquidacion                                        AS
       valorLiquidacion,
       pre.numero_chasis,
       (SELECT DISTINCT Concat (p.nombre1, '' '', p.nombre2, '' '', p.apellido1, '' ''
                        , p.apellido2) AS s
        FROM   persona p
               INNER JOIN funcionario fu
                       ON fu.id_persona = p.id_persona
               INNER JOIN precoactivo pre
                       ON (SELECT Max(f.id_funcionario)
                           FROM   funcionario f
                           WHERE  f.id_cargo = 4
                                  AND f.id_subcargo = 3) = fu.id_funcionario),
       pp.numero_periodo,
       (SELECT Sum(Cast(valor_tasa AS DECIMAL(10, 2)))
        FROM   periodo_precoactivo
        WHERE  numero_periodo < pp.numero_periodo
               AND estado_periodo <> ''ANULADO''
               AND id_precoactivo = pre.id_precoactivo)             AS
       valoresanteriores,
       (SELECT Sum(Cast(valor_tasa AS DECIMAL(10, 2)))
        FROM   periodo_precoactivo
        WHERE  numero_periodo <= pp.numero_periodo
               AND estado_periodo <> ''ANULADO''
               AND id_precoactivo = pre.id_precoactivo)             AS v,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))))
        FROM   funcionario f,
               persona per
        WHERE  per.id_persona = f.id_persona
               AND f.fecha_final_vigencia IS NULL
               AND id_cargo = 13
               AND fecha_final_vigencia IS NULL)                    AS titulo,
       CASE
         WHEN ti.articulo IS NULL THEN ''''
         WHEN ti.articulo <> '''' THEN Concat (ti.articulo, '' -'')
         ELSE ''''
       END                                                          AS articulo,
       CASE
         WHEN pp.id_periodo IN ( 144933, 175647, 145895, 175648,
                                 145901, 148753, 175650, 148754,
                                 175651, 151713, 177016, 155644,
                                 155712, 155831, 155832, 155835,
                                 173791, 173792, 174550, 174551,
                                 175234, 175236, 175238, 175239,
                                 175240, 175540, 175550, 175552,
                                 175551, 175549, 175558, 175559,
                                 176362, 176913, 176915, 176916,
                                 176918, 176919, 177063, 177066,
                                 177993, 177995, 177998, 177999,
                                 178829, 178822, 178823, 178832,
                                 178831, 178839, 178845, 178840,
                                 178843, 178859, 178860, 178862,
                                 138118, 175621, 138120, 175622,
                                 138126, 175623, 138130, 175624,
                                 138132, 175625, 138141, 175626,
                                 139079, 175627, 168989, 139083,
                                 175628, 139084, 175629, 139085,
                                 175630, 139103, 175631, 139107,
                                 139109, 175632, 139131, 175634,
                                 139142, 175635, 139167, 139168,
                                 139190, 139206, 175637, 139219,
                                 139221, 175639, 139228, 139234,
                                 175641, 141110, 175642, 141116,
                                 143011, 143027, 175644, 143032,
                                 175645, 143041, 175646, 149147,
                                 175652, 149152, 149154, 175653,
                                 149293, 149358, 149365, 175654,
                                 149372, 175655, 149389, 175656,
                                 149417, 149419, 149528, 175657,
                                 149537, 175658, 149576, 175659,
                                 149620, 175660, 153781, 179290,
                                 153786, 179446, 158664, 161492,
                                 163424, 165717, 165743, 167632,
                                 167633, 167634, 167795, 167798,
                                 168006, 169001, 169132, 169140,
                                 169142, 169265, 169515, 169517,
                                 169982, 169983, 169984, 171144,
                                 172061, 172062, 172063, 172066,
                                 172078, 172079, 172988, 172990,
                                 179130, 179282, 179277, 179441 ) THEN
''El presente documento sustituye cualquier otro emitido por el mismo concepto y hechos''
  ELSE ''''
END                                                          AS textoMostrar
,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   precoactivo pre
       INNER JOIN persona p
               ON p.id_persona = pre.id_deudor
       INNER JOIN tipo_identificacion_persona tip
               ON p.id_tipo_identificacion = tip.id_tipo_identificacion
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = p.id_persona
       INNER JOIN motivo_inmovilizacion_vehiculo ti
               ON ti.id_motivo_inmovilizacion_vehiculo = pre.motivo_retencion
       INNER JOIN patio pa
               ON pa.id_patio = pre.id_patio
       INNER JOIN periodo_precoactivo pp
               ON pp.id_precoactivo = pre.id_precoactivo
       LEFT JOIN tarifa_patio tp
              ON tp.id_unidad_vehicular = pre.tipo_vehiculo
                 AND ( tp.fecha_inicio_vigencia <= pp.fecha_fin_periodo
                       AND tp.fecha_fin_vigencia >= pp.fecha_fin_periodo )
WHERE  pp.id_periodo = :periodo
       AND p.id_persona = :idPersona
       AND pre.id_precoactivo is not null '               
	   , orden_variables='TITULO,NOMBRE_INFRACTOR,DIRECCION_INFRACTOR,hora_actual,FECHA_DELEGADO,NOMBRE_COMPLETO,DIRECCION_COACTIVA,placa,N_DOCUMENTO_INFRACTOR,TEXTO_NOTIFICACION,VALOR_DEUDA_CARTERA,NUMERO_OBLIGACION,FECHA_INFRACCION,FECHA_EVALUACION,FECHA_SENTAR_RAZON_FALLO,FECHA_SOLICITUD,DIAS_COBRO_LETRA,DIAS_COBRO,FECHA_INFRACCION3,NOTIFICACION,IMAGEN_FIRMA,NOMBRE_ABOGADO,FECHA_INFRACCION4,FECHA_INFRACCION2,OTROS,VALOR_INTERES2,INF_IMPUGNANTE,NOMBRE_DELEGADO,NUMERO_LOTE,LONGITUD,VALOR_INTERES,TEXTO_NOMBRE_1,TIPO_BIEN,PARRAFO_1,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10165

commit tran