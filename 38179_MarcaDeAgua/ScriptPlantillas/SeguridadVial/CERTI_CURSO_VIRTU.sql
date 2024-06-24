---------------------------------------------------------------------------
--Update
--CERTI_CURSO_VIRTU	 2235 10110
---------------------------------------------------------------------------
---------------------------------------------------------------------------
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables='NOMBRE_INFRACTOR,CALIFICACION_CURSO,DESCRIPCION_INFRACCION,FECHA_APROBACION_CURSO,NUMERO_RESOLUCION, TEXTO_NOMBRE_1, IMAGEN_FONDO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10110

commit tran
---------------------------------------------------------------------------
---------------------------------------------------------------------------

-------------------------------------------------------------------------------------
--Modificada
SELECT ( CASE inf.id_tipo_identificacion
           WHEN 2 THEN pju.nombre_comercial
           ELSE ( Isnull(inf.nombre1, '') + ' '
                  + Isnull(inf.nombre2, '') + ' '
                  + Isnull(inf.apellido1, '') + ' '
                  + Isnull(inf.apellido2, '') )
         END )                                                AS
       NOMBRE_INFRACTOR,
       c.calificacion                                         AS
       CALIFICACION_CURSO,
       ci.descripcion                                         AS
       DESCRIPCION_INFRACCION,
       CONVERT(VARCHAR, c.fecha_acogimiento_sustitucion, 106) AS
       FECHA_APROBACION_CURSO,
       c.numero_resolucion                                    AS
       NUMERO_RESOLUCION,
       'Haciéndose acreedor del '
       + Cast(CONVERT(NUMERIC(3, 0), ci.porcentaje_descuento) AS VARCHAR)
       + '% de descuento de su multa por:'                    AS TEXTO_NOMBRE_1,
       (SELECT img.numero_imagen
        FROM   imagen img (nolock)
        WHERE  img.id_tipo_imagen = 3
               AND ( ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                       AND img.fecha_fin >= CONVERT(DATE, c.fecha_registro) )
                      OR ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                           AND img.fecha_fin IS NULL ) ))     AS IMAGEN_FONDO
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
WHERE  c.id_curso = :idCurso 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Order variables
--NOMBRE_INFRACTOR,CALIFICACION_CURSO,DESCRIPCION_INFRACCION,FECHA_APROBACION_CURSO,NUMERO_RESOLUCION, TEXTO_NOMBRE_1, IMAGEN_FONDO
-------------------------------------------------------------------------------------
--Original

SELECT ( CASE inf.id_tipo_identificacion
           WHEN 2 THEN pju.nombre_comercial
           ELSE ( Isnull(inf.nombre1, '') + ' '
                  + Isnull(inf.nombre2, '') + ' '
                  + Isnull(inf.apellido1, '') + ' '
                  + Isnull(inf.apellido2, '') )
         END )                                                AS
       NOMBRE_INFRACTOR,
       c.calificacion                                         AS
       CALIFICACION_CURSO,
       ci.descripcion                                         AS
       DESCRIPCION_INFRACCION,
       CONVERT(VARCHAR, c.fecha_acogimiento_sustitucion, 106) AS
       FECHA_APROBACION_CURSO,
       c.numero_resolucion                                    AS
       NUMERO_RESOLUCION,
       'Haciéndose acreedor del '
       + Cast(CONVERT(NUMERIC(3, 0), ci.porcentaje_descuento) AS VARCHAR)
       + '% de descuento de su multa por:'                    AS TEXTO_NOMBRE_1,
       (SELECT img.numero_imagen
        FROM   imagen img (nolock)
        WHERE  img.id_tipo_imagen = 3
               AND ( ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                       AND img.fecha_fin >= CONVERT(DATE, c.fecha_registro) )
                      OR ( img.fecha_inicio <= CONVERT(DATE, c.fecha_registro)
                           AND img.fecha_fin IS NULL ) ))     AS IMAGEN_FONDO
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
WHERE  c.id_curso = :idCurso 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

