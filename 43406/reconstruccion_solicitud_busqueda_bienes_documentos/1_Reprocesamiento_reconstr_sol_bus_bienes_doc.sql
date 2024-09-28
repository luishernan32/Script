--- Reprocesamiento  -- Debe ser enviado a DBA.
BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
set error = null
where procesado = 0
and error is not null
COMMIT TRAN

EXEC circulemos2.[dbo].[sp_reconstruir_solicitud_bienes_coactivo_documentos]