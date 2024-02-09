begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=''
WHERE  id_plantilla_config=75

commit tran


