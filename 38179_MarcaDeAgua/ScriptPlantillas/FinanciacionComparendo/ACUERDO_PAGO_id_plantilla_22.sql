begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   '	SELECT CASE df.numero_cuota
         WHEN 0 THEN ''Cuota inicial''
         ELSE Cast(df.numero_cuota AS VARCHAR)
       END,
       df.fecha_pago_oportuno,
       df.valor_total
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   financiacion f
       JOIN detalle_financiacion df
         ON df.id_financiacion = f.id_financiacion
WHERE  f.id_financiacion = :idFinanciacion '               
	   , orden_variables='NUMERO_CUOTAS,FECHA_PAGO_OPORTUNO,VALOR_CUOTA,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=22

commit tran

---------------------------------------------------------------------------------------------------------------------------------------------------

--Query modificado




		SELECT CASE df.numero_cuota
         WHEN 0 THEN 'Cuota inicial'
         ELSE Cast(df.numero_cuota AS VARCHAR)
       END,
       df.fecha_pago_oportuno,
       df.valor_total
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   financiacion f
       JOIN detalle_financiacion df
         ON df.id_financiacion = f.id_financiacion
WHERE  f.id_financiacion = :idFinanciacion 
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
--Query original

SELECT CASE df.numero_cuota
         WHEN 0 THEN 'Cuota inicial'
         ELSE Cast(df.numero_cuota AS VARCHAR)
       END,
       df.fecha_pago_oportuno,
       df.valor_total
FROM   financiacion f
       JOIN detalle_financiacion df
         ON df.id_financiacion = f.id_financiacion
WHERE  f.id_financiacion = :idFinanciacion 
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------