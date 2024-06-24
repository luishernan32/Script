--COIP_REQ_PAGO 

SET Language 'Spanish';    SELECT TOP 1    cp.id_factura_axis numero_factura,    CASE p.id_tipo_identificacion WHEN 2 THEN UPPER (pj.nombre_comercial) ELSE UPPER(CONCAT(p.nombre1,' ',p.nombre2,' ',p.apellido1,' ',p.apellido2))   END as nombreInfractor,    p.numero_identificacion documentoInfractor,   tipoid.codigo tipodocInfractor,    isnull((select top 1 cast(u.direccion_de_entrega as varchar(200)) from integracion_terceros..ubicabilidad_courier_validada u where u.id_factura_axis=cp.id_factura_axis),'') as direccionInfractor,     cp.numero_citacion numeroCitacion,    (i.codigo_infraccion +' - '+ ci.descripcion) descripcionMulta,       convert(varchar(10),cp.fecha_infraccion,103) + ' '+convert(varchar(8),cp.hora_infraccion,8) fechaInfraccion,    (select d.complemento from direccion d where cp.id_direccion_comparendo = d.id_direccion) direccionInfraccion,    concat(i.codigo_infraccion ,' - ', ci.descripcion,', de acuerdo al artículo ',ci.articulo,' numeral ',i.numeral_infraccion,' del ',(select top 1 descripcion from normatividad where id_normatividad=ci.id_normatividad)) descripcionInfraccion,    ( select ca.saldo_capital     from comparendo_cartera cc (NOLOCK) join       cartera ca (NOLOCK) on cc.id_cartera = ca.id_cartera     where cc.cicomparendo= cp.cicomparendo ) valorMulta,      cpvh.placa_vehiculo placaVehivulo,      dt.NUMERO_SERIE codigoCamara,      convert(varchar(10),dt.FECHA_CALIBRACION,103) fechaCalibracion,      dt.VELOCIDAD_VIA velocidadPermitida,      dt.VELOCIDAD_INFRACCION velocidadInfraccion,      (select top 1 CONCAT('Ab. ', Upper(Concat (p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2)) )  as nombre   from funcionario f inner join firma_persona fp on fp.id_persona = f.id_persona  inner join persona p on p.id_persona= f.id_persona    WHERE f.id_cargo =11  and f.fecha_final_vigencia is null   ) as nombreDelegrado,      'DIRECTOR DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO' as CargoDelegado,      CONCAT(pa.nombre1, ' ', pa.nombre2, ' ', pa.apellido1, ' ', pa.apellido2) nombreAgente,      ca.placa placaAgente,      isnull(cp.placa_agente_transito,'') codigoAgente,      fa.numero_imagen firmaAgente,      (select numero_imagen from "imagen" where "id_tipo_imagen" in(SELECT id_tipo_imagen FROM tipo_imagen WHERE codigo = 'LOGGO' ) AND fecha_fin is null) logoATM,    'El artículo 271 del Código Orgánico Administrativo dispone: "En el acto administrativo que se declare o constituya una obligación dineraria y ponga fin a un procedimiento administrativo en el que se haya contado con el deudor, el órgano a cargo de la resolución requerirá que la o el deudor pague voluntariamente dicha obligación dentro de diez días contados desde la fecha de su notificación, previniéndole que, de no hacerlo, se procederá con la ejecución coactiva.    Le corresponde al órgano ejecutor, el requerimiento de pago de las obligaciones ejecutables originadas en instrumentos distintos a los previstos en el párrafo anterior, el que debe ser notificado junto con una copia certificada de la fuente o título de la que se desprenda. En este acto se concederá a la o al deudor diez días para que pague voluntariamente la obligación, contados desde el día siguiente a la fecha de notificación del requerimiento de pago".' parrafo1,    'Se puede acercar a nuestros Centros de Atención Ciudadana, ubicados en: C.C. Alban Borja local 56 A y B, Registro Civil Municipal de Guayaquil (Cdla. Martha de Roldós) y en las instalaciones de la Terminal de Metrovía 25 de julio (Av. Perimetral), previo a la separación de cita a través de la página www.atm.com.ec o atención presencial de manera directa. Para mayor información, puede llamar a nuestra PBX (04) 390-22-90' parrafo2,     (select top 1 fp.numero_imagen    from funcionario f inner join      firma_persona fp on fp.id_persona = f.id_persona  inner join     persona p on p.id_persona= f.id_persona    WHERE f.id_cargo =11 and f.fecha_final_vigencia is null) as firma_delegado,      (CONVERT(VARCHAR,DAY(getdate())) + ' dias del mes de ' +       CONVERT(VARCHAR,DATENAME(MONTH, GETDATE())) + ' del ' +       CONVERT(VARCHAR,YEAR(GETDATE())) + ', a las ' +       CONVERT(VARCHAR,DATEPART(hour, getdate())) + 'h' +       CONVERT(VARCHAR,DATEPART(minute, getdate()))) fecha_hoy      from comparendo (NOLOCK) cp inner join        comparendo_persona (NOLOCK) cper on cper.cicomparendo = cp.cicomparendo inner join    persona (NOLOCK) p on p.id_persona = cper.id_persona  inner join     tipo_identificacion_persona tipoid on tipoid.id_tipo_identificacion = p.id_tipo_identificacion left join     persona_juridica (NOLOCK) pj  ON pj.id_persona_juridica = p.id_persona  left join   configuracion_infraccion  (NOLOCK) ci on cp.id_infraccion = ci.id_infraccion and ci.fecha_fin_vigencia is null inner join     infraccion  (NOLOCK) i on i.id_infraccion=ci.id_infraccion left join    comparendo_vehiculo  (NOLOCK) cpvh on cpvh.id_comparendo_vehiculo = cp.cicomparendo left join     (SELECT ID_FACTURA, NUMERO_SERIE,            FECHA_CALIBRACION,      convert(varchar,VELOCIDAD_VIA) as VELOCIDAD_VIA,      convert(varchar,VELOCIDAD_INFRACCION) as VELOCIDAD_INFRACCION    from integracion_terceros..v_datos_infracciones  (NOLOCK)) dt on dt.ID_FACTURA= cp.id_factura_axis left join       comparendo_agente (NOLOCK) ca on ca.cicomparendo = cp.cicomparendo left join     agente ag  on ca.id_agente = ag.id_agente left join      persona pa on pa.id_persona = ag.id_persona left join     firma_persona fa on fa.id_persona = pa.id_persona left join    ordenamiento_pais ord on ci.id_ordenamiento_pais = ord.id_ordenamiento_pais   where cp.id_factura_axis = :numeroObligacion   and ord.id_ordenamiento_pais  = 2 and cp.id_estado_comparendo = 2  order by fa.fecha_registro desc
--NUMERO_FACTURA,NOMBRE_INFRACTOR,N_DOCUMENTO_INFRACTOR,T_DOCUMENTO_INFRACTOR,UBICACION_INFRACTOR,numero_citacion ,DESCRIPCION_MULTAS,FECHA_INFRACCION,DIRECCION_INFRACCION,DESCRIPCION_INFRACCION ,VALOR_MULTA,PLACA_VEHICULO,CODIGO_CAMARA,FECHA_CALIBRACION,VELOCIDAD_PERMITIDA,VELOCIDAD_INFRACCION,DELEGADO_TITULONOMBRE_,CARGO_DELEGADO,NOMBRE_AGENTE,PLACA_AGENTE,CODIGO_AGENTE,FIRMA_AGENTE,LogoATM_variable,PARRAFO_1,PARRAFO_2,FIRMA_FUNCIONARIO_,FECHA_GENERACION


,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--COIP_REQ_PAGO 10103
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=',TITULO_PLANTILLAS'
WHERE  id_plantilla_config= 10103

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'REGISTRO_FALLO_CAL';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)


-------------------------------------------------------------------------------------
--Modificada


SET language 'Spanish';

SELECT TOP 1 cp.id_factura_axis
             numero_factura,
             CASE p.id_tipo_identificacion
               WHEN 2 THEN Upper (pj.nombre_comercial)
               ELSE Upper(
Concat(p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2))
END                                                             AS
             nombreInfractor,
p.numero_identificacion
             documentoInfractor,
tipoid.codigo                                                   tipodocInfractor
             ,
Isnull((SELECT TOP 1 Cast(u.direccion_de_entrega AS VARCHAR(200))
        FROM   integracion_terceros..ubicabilidad_courier_validada u
        WHERE  u.id_factura_axis = cp.id_factura_axis), '')     AS
direccionInfractor,
cp.numero_citacion                                              numeroCitacion,
( i.codigo_infraccion + ' - ' + ci.descripcion )                descripcionMulta
             ,
CONVERT(VARCHAR(10), cp.fecha_infraccion, 103)
+ ' '
+ CONVERT(VARCHAR(8), cp.hora_infraccion, 8)                    fechaInfraccion,
(SELECT d.complemento
 FROM   direccion d
 WHERE  cp.id_direccion_comparendo = d.id_direccion)
             direccionInfraccion,
Concat(i.codigo_infraccion, ' - ',
ci.descripcion, ', de acuerdo al artículo ', ci.articulo, ' numeral ', i.numeral_infraccion, ' del ',
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
(SELECT TOP 1 Concat('Ab. ', Upper(Concat (p.nombre1, ' ', p.nombre2, ' ',
                                   p.apellido1, ' ',
                                                 p.apellido2))) AS nombre
 FROM   funcionario f
        INNER JOIN firma_persona fp
                ON fp.id_persona = f.id_persona
        INNER JOIN persona p
                ON p.id_persona = f.id_persona
 WHERE  f.id_cargo = 11
        AND f.fecha_final_vigencia IS NULL)                     AS
             nombreDelegrado,
'DIRECTOR DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO' AS CargoDelegado
             ,
Concat(pa.nombre1, ' ', pa.nombre2, ' ', pa.apellido1, ' ',
pa.apellido2)
    nombreAgente,
ca.placa                                                        placaAgente,
Isnull(cp.placa_agente_transito, '')                            codigoAgente,
fa.numero_imagen                                                firmaAgente,
(SELECT numero_imagen
 FROM   "imagen"
 WHERE  "id_tipo_imagen" IN(SELECT id_tipo_imagen
                            FROM   tipo_imagen
                            WHERE  codigo = 'LOGGO')
        AND fecha_fin IS NULL)                                  logoATM,
'El artículo 271 del Código Orgánico Administrativo dispone: "En el acto administrativo que se declare o constituya una obligación dineraria y ponga fin a un procedimiento administrativo en el que se haya contado con el deudor, el órgano a cargo de la resolución requerirá que la o el deudor pague voluntariamente dicha obligación dentro de diez días contados desde la fecha de su notificación, previniéndole que, de no hacerlo, se procederá con la ejecución coactiva.    Le corresponde al órgano ejecutor, el requerimiento de pago de las obligaciones ejecutables originadas en instrumentos distintos a los previstos en el párrafo anterior, el que debe ser notificado junto con una copia certificada de la fuente o título de la que se desprenda. En este acto se concederá a la o al deudor diez días para que pague voluntariamente la obligación, contados desde el día siguiente a la fecha de notificación del requerimiento de pago".'
                                                                parrafo1,
'Se puede acercar a nuestros Centros de Atención Ciudadana, ubicados en: C.C. Alban Borja local 56 A y B, Registro Civil Municipal de Guayaquil (Cdla. Martha de Roldós) y en las instalaciones de la Terminal de Metrovía 25 de julio (Av. Perimetral), previo a la separación de cita a través de la página www.atm.com.ec o atención presencial de manera directa. Para mayor información, puede llamar a nuestra PBX (04) 390-22-90'
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
  + ' dias del mes de '
  + CONVERT(VARCHAR, Datename(month, Getdate()))
  + ' del ' + CONVERT(VARCHAR, Year(Getdate()))
  + ', a las '
  + CONVERT(VARCHAR, Datepart(hour, Getdate()))
  + 'h'
  + CONVERT(VARCHAR, Datepart(minute, Getdate())) )             fecha_hoy
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
       AND ord.id_ordenamiento_pais = 2
       AND cp.id_estado_comparendo = 2
ORDER  BY fa.fecha_registro DESC 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Original

SET language 'Spanish';

SELECT TOP 1 cp.id_factura_axis
             numero_factura,
             CASE p.id_tipo_identificacion
               WHEN 2 THEN Upper (pj.nombre_comercial)
               ELSE Upper(
Concat(p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2))
END                                                             AS
             nombreInfractor,
p.numero_identificacion
             documentoInfractor,
tipoid.codigo                                                   tipodocInfractor
             ,
Isnull((SELECT TOP 1 Cast(u.direccion_de_entrega AS VARCHAR(200))
        FROM   integracion_terceros..ubicabilidad_courier_validada u
        WHERE  u.id_factura_axis = cp.id_factura_axis), '')     AS
direccionInfractor,
cp.numero_citacion                                              numeroCitacion,
( i.codigo_infraccion + ' - ' + ci.descripcion )                descripcionMulta
             ,
CONVERT(VARCHAR(10), cp.fecha_infraccion, 103)
+ ' '
+ CONVERT(VARCHAR(8), cp.hora_infraccion, 8)                    fechaInfraccion,
(SELECT d.complemento
 FROM   direccion d
 WHERE  cp.id_direccion_comparendo = d.id_direccion)
             direccionInfraccion,
Concat(i.codigo_infraccion, ' - ',
ci.descripcion, ', de acuerdo al artículo ', ci.articulo, ' numeral ', i.numeral_infraccion, ' del ',
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
(SELECT TOP 1 Concat('Ab. ', Upper(Concat (p.nombre1, ' ', p.nombre2, ' ',
                                   p.apellido1, ' ',
                                                 p.apellido2))) AS nombre
 FROM   funcionario f
        INNER JOIN firma_persona fp
                ON fp.id_persona = f.id_persona
        INNER JOIN persona p
                ON p.id_persona = f.id_persona
 WHERE  f.id_cargo = 11
        AND f.fecha_final_vigencia IS NULL)                     AS
             nombreDelegrado,
'DIRECTOR DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO' AS CargoDelegado
             ,
Concat(pa.nombre1, ' ', pa.nombre2, ' ', pa.apellido1, ' ',
pa.apellido2)
    nombreAgente,
ca.placa                                                        placaAgente,
Isnull(cp.placa_agente_transito, '')                            codigoAgente,
fa.numero_imagen                                                firmaAgente,
(SELECT numero_imagen
 FROM   "imagen"
 WHERE  "id_tipo_imagen" IN(SELECT id_tipo_imagen
                            FROM   tipo_imagen
                            WHERE  codigo = 'LOGGO')
        AND fecha_fin IS NULL)                                  logoATM,
'El artículo 271 del Código Orgánico Administrativo dispone: "En el acto administrativo que se declare o constituya una obligación dineraria y ponga fin a un procedimiento administrativo en el que se haya contado con el deudor, el órgano a cargo de la resolución requerirá que la o el deudor pague voluntariamente dicha obligación dentro de diez días contados desde la fecha de su notificación, previniéndole que, de no hacerlo, se procederá con la ejecución coactiva.    Le corresponde al órgano ejecutor, el requerimiento de pago de las obligaciones ejecutables originadas en instrumentos distintos a los previstos en el párrafo anterior, el que debe ser notificado junto con una copia certificada de la fuente o título de la que se desprenda. En este acto se concederá a la o al deudor diez días para que pague voluntariamente la obligación, contados desde el día siguiente a la fecha de notificación del requerimiento de pago".'
                                                                parrafo1,
'Se puede acercar a nuestros Centros de Atención Ciudadana, ubicados en: C.C. Alban Borja local 56 A y B, Registro Civil Municipal de Guayaquil (Cdla. Martha de Roldós) y en las instalaciones de la Terminal de Metrovía 25 de julio (Av. Perimetral), previo a la separación de cita a través de la página www.atm.com.ec o atención presencial de manera directa. Para mayor información, puede llamar a nuestra PBX (04) 390-22-90'
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
  + ' dias del mes de '
  + CONVERT(VARCHAR, Datename(month, Getdate()))
  + ' del ' + CONVERT(VARCHAR, Year(Getdate()))
  + ', a las '
  + CONVERT(VARCHAR, Datepart(hour, Getdate()))
  + 'h'
  + CONVERT(VARCHAR, Datepart(minute, Getdate())) )             fecha_hoy
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
       AND ord.id_ordenamiento_pais = 2
       AND cp.id_estado_comparendo = 2
ORDER  BY fa.fecha_registro DESC 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------