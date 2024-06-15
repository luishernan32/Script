begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT co.numero_citacion                    numero_citacion,
       tio.nombre                            AS tipo,
       c.fecha_creacion,
       ( c.saldo_capital + c.saldo_interes ) AS valor,
       c.nombre                              AS obligacion

	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   financiacion f WITH (nolock)
       JOIN obligacion_financiacion ofi
         ON ofi.id_financiacion = f.id_financiacion
       JOIN tipo_obligacion tio WITH (nolock)
         ON tio.codigo_tipo_obligacion = ofi.codigo_tipo_obligacion
       JOIN cartera c WITH (nolock)
         ON c.nombre = ofi.numero_obligacion
       JOIN comparendo co WITH (nolock)
         ON co.id_factura_axis = c.nombre
WHERE  f.id_financiacion = :idFinanciacion '               
	   , orden_variables='numero_citacion,T_OBLIGACION,fecha_imposicion,DEUDA_CARTERA,NUMERO_OBLIGACION,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=23

commit tran

---------------------------------------------------------------------------------------------------------------------------------------------------

--Query modificado



SELECT co.numero_citacion                    numero_citacion,
       tio.nombre                            AS tipo,
       c.fecha_creacion,
       ( c.saldo_capital + c.saldo_interes ) AS valor,
       c.nombre                              AS obligacion

	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS
FROM   financiacion f WITH (nolock)
       JOIN obligacion_financiacion ofi
         ON ofi.id_financiacion = f.id_financiacion
       JOIN tipo_obligacion tio WITH (nolock)
         ON tio.codigo_tipo_obligacion = ofi.codigo_tipo_obligacion
       JOIN cartera c WITH (nolock)
         ON c.nombre = ofi.numero_obligacion
       JOIN comparendo co WITH (nolock)
         ON co.id_factura_axis = c.nombre
WHERE  f.id_financiacion = :idFinanciacion 

---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
--Query original
---------------------------------------------------------------------------------------------------------------------------------------------------

SELECT co.numero_citacion                    numero_citacion,
       tio.nombre                            AS tipo,
       c.fecha_creacion,
       ( c.saldo_capital + c.saldo_interes ) AS valor,
       c.nombre                              AS obligacion
FROM   financiacion f WITH (nolock)
       JOIN obligacion_financiacion ofi
         ON ofi.id_financiacion = f.id_financiacion
       JOIN tipo_obligacion tio WITH (nolock)
         ON tio.codigo_tipo_obligacion = ofi.codigo_tipo_obligacion
       JOIN cartera c WITH (nolock)
         ON c.nombre = ofi.numero_obligacion
       JOIN comparendo co WITH (nolock)
         ON co.id_factura_axis = c.nombre
WHERE  f.id_financiacion = :idFinanciacion 
---------------------------------------------------------------------------------------------------------------------------------------------------