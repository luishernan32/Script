---------------------------------------------------------------------------
--Update
--CARAT_CURSO_VIRTU	2231 10106
---------------------------------------------------------------------------
---------------------------------------------------------------------------
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables='LogoATM_variable,numero_consecutivo,NOMBRE_INFRACTOR,DESCRIPCION_INFRACCION,DIRECCION_INFRACCION,numero_citacion,FECHA_TEXTO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10106

commit tran
---------------------------------------------------------------------------
---------------------------------------------------------------------------

-------------------------------------------------------------------------------------
--Modificada

SELECT TOP 1 (SELECT img.numero_imagen
              FROM   imagen img (nolock)
              WHERE  img.id_tipo_imagen = 1
                     AND ( ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                             AND img.fecha_fin >=
                                 CONVERT(DATE, c.fecha_registro) )
                            OR ( img.fecha_inicio <=
                                 CONVERT(DATE, c.fecha_registro)
                                 AND img.fecha_fin IS NULL ) )) AS
             LogoATM_variable,
             Concat(:consecutivo, '-', Year(Getdate()))         AS
             numero_consecutivo,
             ( CASE inf.id_tipo_identificacion
                 WHEN 2 THEN pju.nombre_comercial
                 ELSE ( Isnull(inf.nombre1, '') + ' '
                        + Isnull(inf.nombre2, '') + ' '
                        + Isnull(inf.apellido1, '') + ' '
                        + Isnull(inf.apellido2, '') )
               END )                                            AS
             NOMBRE_INFRACTOR,
             ci.descripcion                                     AS
             DESCRIPCION_INFRACCION,
             dir.complemento                                    AS
             DIRECCION_INFRACCION,
             co.numero_citacion                                 AS
             numero_citacion,
             ( CONVERT(VARCHAR, Day(Getdate())) + ' de '
               + Lower(CONVERT(VARCHAR, Datename(month, Getdate())))
               + ' del ' + CONVERT(VARCHAR, Year(Getdate())) )  AS FECHA_TEXTO
FROM   curso c (nolock)
       LEFT JOIN persona inf (nolock)
              ON inf.id_persona = c.id_persona
       LEFT JOIN persona_juridica pju (nolock)
              ON inf.id_persona = pju.id_persona_juridica
       JOIN comparendo co (nolock)
         ON c.id_factura_axis = co.id_factura_axis
       JOIN infraccion i (nolock)
         ON co.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci (nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN direccion dir (nolock)
         ON co.id_direccion_comparendo = dir.id_direccion
WHERE  c.id_curso = :idCurso 

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Order variables
--LogoATM_variable,numero_consecutivo,NOMBRE_INFRACTOR,DESCRIPCION_INFRACCION,DIRECCION_INFRACCION,numero_citacion,FECHA_TEXTO
-------------------------------------------------------------------------------------
--Original


SELECT TOP 1 (SELECT img.numero_imagen
              FROM   imagen img (nolock)
              WHERE  img.id_tipo_imagen = 1
                     AND ( ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                             AND img.fecha_fin >=
                                 CONVERT(DATE, c.fecha_registro) )
                            OR ( img.fecha_inicio <=
                                 CONVERT(DATE, c.fecha_registro)
                                 AND img.fecha_fin IS NULL ) )) AS
             LogoATM_variable,
             Concat(:consecutivo, '-', Year(Getdate()))         AS
             numero_consecutivo,
             ( CASE inf.id_tipo_identificacion
                 WHEN 2 THEN pju.nombre_comercial
                 ELSE ( Isnull(inf.nombre1, '') + ' '
                        + Isnull(inf.nombre2, '') + ' '
                        + Isnull(inf.apellido1, '') + ' '
                        + Isnull(inf.apellido2, '') )
               END )                                            AS
             NOMBRE_INFRACTOR,
             ci.descripcion                                     AS
             DESCRIPCION_INFRACCION,
             dir.complemento                                    AS
             DIRECCION_INFRACCION,
             co.numero_citacion                                 AS
             numero_citacion,
             ( CONVERT(VARCHAR, Day(Getdate())) + ' de '
               + Lower(CONVERT(VARCHAR, Datename(month, Getdate())))
               + ' del ' + CONVERT(VARCHAR, Year(Getdate())) )  AS FECHA_TEXTO
FROM   curso c (nolock)
       LEFT JOIN persona inf (nolock)
              ON inf.id_persona = c.id_persona
       LEFT JOIN persona_juridica pju (nolock)
              ON inf.id_persona = pju.id_persona_juridica
       JOIN comparendo co (nolock)
         ON c.id_factura_axis = co.id_factura_axis
       JOIN infraccion i (nolock)
         ON co.id_infraccion = i.id_infraccion
       JOIN configuracion_infraccion ci (nolock)
         ON ci.id_infraccion = i.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
       JOIN direccion dir (nolock)
         ON co.id_direccion_comparendo = dir.id_direccion
WHERE  c.id_curso = :idCurso 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------




