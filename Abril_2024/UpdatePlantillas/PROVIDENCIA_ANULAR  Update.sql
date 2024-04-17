begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT p.numero_proceso,
       p.fecha_inicio,
	   (SELECT upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434) AS cargo_delegado
FROM   proceso p
WHERE  p.id_proceso = :idProceso '               
	   , orden_variables='numero_consecutivo,anio_apertura_proceso,CARGO_DELEGADO'
WHERE  id_plantilla_config=10061


commit tran







