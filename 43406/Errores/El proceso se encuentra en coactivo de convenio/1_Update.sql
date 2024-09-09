
 begin tran
 update proceso
 set id_estado_proceso='24',observacion='ENVIO NOTIFICACION'
 where id_proceso=2966538
 commit tran