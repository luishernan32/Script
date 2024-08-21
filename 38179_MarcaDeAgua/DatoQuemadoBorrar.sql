DECLARE @DIAS_COBRO INT

SELECT TOP 1 @DIAS_COBRO = 8

SELECT f.id_financiacion,
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2))
       END                                          AS NombreInfractor,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Telefonopersona(pe.id_persona, 1)        telefono,
       dbo.Correopersona(pe.id_persona)             correo,
       dbo.Direccionpersona(pe.id_persona, DEFAULT) direccion,
       f.tasa_interes,
       f.valor_total_intereses_moratorios,
       f.valor_total_saldo_capital_obliga,
       f.valor_total,
       f.valor_total_financiar_interes,
       dpc.porcentaje_cuota_inicial,
       f.numero_cuotas,
       f.id_tramite,
       f.numero_financiacion,
       @DIAS_COBRO                                  AS diasCobro,
       (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)              AS TITULO_PLANTILLAS,
       (SELECT Max(fp.numero_imagen)
        FROM   funcionario_financiacion fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 17
               AND fun.estado = 'Vigente')          AS FIRMA,
       (SELECT TOP 1 Concat(fun.titulo_obtenido, ' ', pf.nombre1, ' ',
                     pf.nombre2, ' ',
                     pf.apellido1,
                                   ' ', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario_financiacion fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 17
               AND fun.estado = 'Vigente')          AS NOMBRE_DELEGADO,
       (SELECT TOP 1 Concat(ca.nombre, '.  -', f.memo_nombramiento, '  ',
                                   RIGHT ( '0' + CONVERT ( VARCHAR (2), Day
                                   (f.fecha_nombramiento)),
                                   2)
                                                                          +
                                   ' de '
                                                                          +
                                   Datename(
                                   month,
                     f.fecha_nombramiento)
                                                                          +
                                   ' del '
                                                                          +
                                   CONVERT (
                                   VARCHAR (4),
                                   Year
                                   (f.fecha_nombramiento)), '.')
        FROM   funcionario_financiacion f
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
               INNER JOIN cargo ca (nolock)
                       ON f.id_cargo = ca.id_cargo
        WHERE  f.fecha_final_vigencia IS NULL)      AS cargo_delegado,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp
        WHERE  fp.id_persona = pe.id_persona)       AS IMAGEN_FIRMA_PERSONA
FROM   financiacion f
       JOIN configuracion_financiacion cf
         ON cf.id_configuracion_financiacion = f.id_configuracion_financiacion
       JOIN detalle_porcentaje_cuota_inici dpc
         ON dpc.id_configuracion_financiacion = cf.id_configuracion_financiacion
       JOIN persona pe
         ON pe.id_persona = f.id_deudor
       LEFT JOIN persona_juridica pj
              ON pj.id_persona_juridica = f.id_deudor
       JOIN tipo_identificacion_persona tip
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       LEFT JOIN direccion_persona dp
              ON dp.id_persona = pe.id_persona
       LEFT JOIN direccion d
              ON d.id_direccion = dp.id_direccion
       JOIN proceso p
         ON p.id_proceso = f.id_proceso
WHERE  f.id_financiacion in('346515', '346514', '346513', '346512', '346511', '346510', '346509', '346508', '346507', '346506') 

--256317354
--256317354