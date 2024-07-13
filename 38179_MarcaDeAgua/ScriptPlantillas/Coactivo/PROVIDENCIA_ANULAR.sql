--PROVIDENCIA_ANULAR 2636 10061

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT p.numero_proceso,
       p.fecha_inicio,
       (SELECT Upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437) AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p
WHERE  p.id_proceso = :idProceso '               
	   , orden_variables='numero_consecutivo,anio_apertura_proceso,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10061

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'PROVIDENCIA_ANULAR';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS



--Modifcada
-------------------------------------------------------------------------------------

SELECT p.numero_proceso,
       p.fecha_inicio,
       (SELECT Upper(valor_parametro_defecto)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 441) AS cargo_delegado
		,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   proceso p
WHERE  p.id_proceso = :idProceso 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--Original
-------------------------------------------------------------------------------------
SELECT p.numero_proceso,         p.fecha_inicio,      (SELECT upper(valor_parametro_defecto)          FROM   parametro(nolock)          WHERE  codigo_parametro = 434) AS cargo_delegado  FROM   proceso p  WHERE  p.id_proceso = :idProceso 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------