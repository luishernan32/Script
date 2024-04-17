begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SET language ''Spanish'';

SELECT TOP 1 cp.id_factura_axis
             numero_factura,
             CASE p.id_tipo_identificacion
               WHEN 2 THEN Upper (pj.nombre_comercial)
               ELSE Upper(
Concat(p.nombre1, '' '', p.nombre2, '' '', p.apellido1, '' '', p.apellido2))
END                                                             AS
             nombreInfractor,
p.numero_identificacion
             documentoInfractor,
tipoid.codigo                                                   tipodocInfractor
             ,
Isnull((SELECT TOP 1 Cast(u.direccion_de_entrega AS VARCHAR(200))
        FROM   integracion_terceros..ubicabilidad_courier_validada u
        WHERE  u.id_factura_axis = cp.id_factura_axis), '''')     AS
direccionInfractor,
cp.numero_citacion                                              numeroCitacion,
( i.codigo_infraccion + '' - '' + ci.descripcion )                descripcionMulta
             ,
CONVERT(VARCHAR(10), cp.fecha_infraccion, 103)
+ '' ''
+ CONVERT(VARCHAR(8), cp.hora_infraccion, 8)                    fechaInfraccion,
(SELECT d.complemento
 FROM   direccion d
 WHERE  cp.id_direccion_comparendo = d.id_direccion)
             direccionInfraccion,
Concat(i.codigo_infraccion, '' - '',
ci.descripcion, '', de acuerdo al artículo '', ci.articulo, '' numeral '', i.numeral_infraccion, '' del '',
(SELECT TOP 1 descripcion
FROM   normatividad
WHERE  id_normatividad = ci.id_normatividad))
             descripcionInfraccion,
(SELECT ca.saldo_capital
 FROM   comparendo_cartera cc (nolock)
        JOIN cartera ca (nolock)
          ON cc.id_cartera = ca.id_cartera
 WHERE  cc.cicomparendo = cp.cicomparendo)                      valorMulta,
cpvh.placa_vehiculo                                             placaVehivulo,
dt.numero_serie                                                 codigoCamara,
CONVERT(VARCHAR(10), dt.fecha_calibracion, 103)                 fechaCalibracion
             ,
dt.velocidad_via
             velocidadPermitida,
dt.velocidad_infraccion
             velocidadInfraccion,
(SELECT Concat(''Ab. Mgs.'', Upper(Concat (p.nombre1, '' '', p.nombre2, '' '',
                                 p.apellido1,
                                         '' '', p.apellido2)), '', - Esp'') AS
        nombre
 FROM   funcionario f
        INNER JOIN firma_persona fp
                ON fp.id_persona = f.id_persona
        INNER JOIN persona p
                ON p.id_persona = f.id_persona
 WHERE  f.id_cargo = 11
        AND f.fecha_final_vigencia IS NULL)                     AS
             nombreDelegrado,
''DIRECTOR DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO'' AS CargoDelegado
             ,
Concat(pa.nombre1, '' '', pa.nombre2, '' '', pa.apellido1, '' '',
pa.apellido2)
    nombreAgente,
ca.placa                                                        placaAgente,
Isnull(cp.placa_agente_transito, '''')                            codigoAgente,
fa.numero_imagen                                                firmaAgente,
(SELECT numero_imagen
 FROM   "imagen"
 WHERE  "id_tipo_imagen" IN(SELECT id_tipo_imagen
                            FROM   tipo_imagen
                            WHERE  codigo = ''LOGGO'')
        AND fecha_fin IS NULL)                                  logoATM,
''El artículo 271 del Código Orgánico Administrativo dispone: "En el acto administrativo que se declare o constituya una obligación dineraria y ponga fin a un procedimiento administrativo en el que se haya contado con el deudor, el órgano a cargo de la resolución requerirá que la o el deudor pague voluntariamente dicha obligación dentro de diez días contados desde la fecha de su notificación, previniéndole que, de no hacerlo, se procederá con la ejecución coactiva.    Le corresponde al órgano ejecutor, el requerimiento de pago de las obligaciones ejecutables originadas en instrumentos distintos a los previstos en el párrafo anterior, el que debe ser notificado junto con una copia certificada de la fuente o título de la que se desprenda. En este acto se concederá a la o al deudor diez días para que pague voluntariamente la obligación, contados desde el día siguiente a la fecha de notificación del requerimiento de pago".''
                                                                parrafo1,
''Se puede acercar a nuestros Centros de Atención Ciudadana, ubicados en: C.C. Alban Borja local 56 A y B, Registro Civil Municipal de Guayaquil (Cdla. Martha de Roldós) y en las instalaciones de la Terminal de Metrovía 25 de julio (Av. Perimetral), previo a la separación de cita a través de la página www.atm.com.ec o atención presencial de manera directa. Para mayor información, puede llamar a nuestra PBX (04) 390-22-90''
                                                                parrafo2,
(SELECT TOP 1 fp.numero_imagen
 FROM   funcionario f
        INNER JOIN firma_persona fp
                ON fp.id_persona = f.id_persona
        INNER JOIN persona p
                ON p.id_persona = f.id_persona
 WHERE  f.id_cargo = 11
        AND f.fecha_final_vigencia IS NULL)                     AS
             firma_delegado,
( CONVERT(VARCHAR, Day(Getdate()))
  + '' dias del mes de ''
  + CONVERT(VARCHAR, Datename(month, Getdate()))
  + '' del '' + CONVERT(VARCHAR, Year(Getdate()))
  + '', a las ''
  + CONVERT(VARCHAR, Datepart(hour, Getdate()))
  + ''h''
  + CONVERT(VARCHAR, Datepart(minute, Getdate())) )             fecha_hoy,
  (SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436) AS cargo_delegado
FROM   comparendo (nolock) cp
       INNER JOIN comparendo_persona (nolock) cper
               ON cper.cicomparendo = cp.cicomparendo
       INNER JOIN persona (nolock) p
               ON p.id_persona = cper.id_persona
       INNER JOIN tipo_identificacion_persona tipoid
               ON tipoid.id_tipo_identificacion = p.id_tipo_identificacion
       LEFT JOIN persona_juridica (nolock) pj
              ON pj.id_persona_juridica = p.id_persona
       LEFT JOIN configuracion_infraccion (nolock) ci
              ON cp.id_infraccion = ci.id_infraccion
                 AND ci.fecha_fin_vigencia IS NULL
       INNER JOIN infraccion (nolock) i
               ON i.id_infraccion = ci.id_infraccion
       LEFT JOIN comparendo_vehiculo (nolock) cpvh
              ON cpvh.id_comparendo_vehiculo = cp.cicomparendo
       LEFT JOIN (SELECT id_factura,
                         numero_serie,
                         fecha_calibracion,
                         CONVERT(VARCHAR, velocidad_via)        AS VELOCIDAD_VIA
                         ,
       CONVERT(VARCHAR, velocidad_infraccion) AS VELOCIDAD_INFRACCION
                  FROM   integracion_terceros..v_datos_infracciones (nolock)) dt
              ON dt.id_factura = cp.id_factura_axis
       LEFT JOIN comparendo_agente (nolock) ca
              ON ca.cicomparendo = cp.cicomparendo
       LEFT JOIN agente ag
              ON ca.id_agente = ag.id_agente
       LEFT JOIN persona pa
              ON pa.id_persona = ag.id_persona
       LEFT JOIN firma_persona fa
              ON fa.id_persona = pa.id_persona
       LEFT JOIN ordenamiento_pais ord
              ON ci.id_ordenamiento_pais = ord.id_ordenamiento_pais
WHERE  cp.id_factura_axis = :numeroObligacion
       AND ord.id_ordenamiento_pais = 1
       AND cp.id_estado_comparendo = 2
ORDER  BY fa.fecha_registro DESC '               
	   , orden_variables='NUMERO_FACTURA,NOMBRE_INFRACTOR,N_DOCUMENTO_INFRACTOR,T_DOCUMENTO_INFRACTOR,UBICACION_INFRACTOR,numero_citacion ,DESCRIPCION_MULTAS,FECHA_INFRACCION,DIRECCION_INFRACCION,DESCRIPCION_INFRACCION ,VALOR_MULTA,PLACA_VEHICULO,CODIGO_CAMARA,FECHA_CALIBRACION,VELOCIDAD_PERMITIDA,VELOCIDAD_INFRACCION,DELEGADO_TITULONOMBRE_,CARGO_DELEGADO,NOMBRE_AGENTE,PLACA_AGENTE,CODIGO_AGENTE,FIRMA_AGENTE,LogoATM_variable,PARRAFO_1,PARRAFO_2,FIRMA_FUNCIONARIO_,FECHA_GENERACION,CARGO_DELEGADO'
WHERE  id_plantilla_config=10104


commit tran




