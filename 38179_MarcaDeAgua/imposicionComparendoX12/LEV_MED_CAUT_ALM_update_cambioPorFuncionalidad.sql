


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=''
WHERE  id_plantilla_config=10133

commit tran






--BANCO,numero_consecutivo,NUMERO_JUICIO,FECHA_TEXTO,HORA,NOMBRE_COMPLETO,N_DOCUMENTO_INFRACTOR,NOMBRE_ABOGADO_ASIG,NOMBRE_ABOGADO,NUMERO_TRAMITE,FIRMA_FUNCIONARIO_,FIRMA_AGENTE,CODIGO_QR,LogoATM_variable,NRO_CUENTA