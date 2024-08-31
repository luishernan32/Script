--select top 200 * from log_ejecucion_ws 
----where ruta_envio='
--https://devapistamp.digitalabus.com/digital-stamp-lab-bff/email/send'
 
----where ruta_envio='
--http://axisweb-val.datatools.local:7001/IntegracionServices/webresources/coactiva/registrarCoactivaRef'
 
--order by id_log_ejecucion_ws desc

select *from circulemos2.dbo.coactivo_proceso
where numero_coactivo='10396305'


select top 20 * from circulemos2.dbo.log_ejecucion_ws 
where convert(date,fecha_envio)=convert(date,getdate())
order by 1 desc
--http://axisweb-val.datatools.local:7001/IntegracionServices/webresources/financiamientos/registrarFinanciamiento


--http://axisweb-val.datatools.local:7001/IntegracionServices/webresources/intereses/calcularMulta
--{factura=10163485, fechaCalculo=2024-08-21}
--CRM_FIN_003 - Error al intentar calcular los recargos de la multa en AXIS