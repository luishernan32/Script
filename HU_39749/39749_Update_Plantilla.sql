begin tran
update documentos..plantilla
set id_proceso='25'
where codigo_plantilla='ACTA_RESORTEO'
commit tran