---------------------------------------------------------------------

begin tran
update proceso
set numero_proceso='137578x'
where id_proceso=1173085
commit tran


-----------------------------------------------------------------------
 

 --- Reprocesamiento  -- Debe ser enviado a DBA.
BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
and numero_juicio in('137578-2019')
COMMIT TRAN

exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo


----------------------------------------------------------------------