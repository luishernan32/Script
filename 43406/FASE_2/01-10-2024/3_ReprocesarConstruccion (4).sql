--- Reprocesamiento  -- Debe ser enviado a DBA.
--Rconstrucción de solicitud de bienes DB fase 2
BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes_documentos
set error = null
where procesado = 0
and error is not null
and numero_juicio in('239514-2023','239529-2023','239565-2023','239583-2023','239663-2023')
COMMIT TRAN

EXEC circulemos2.[dbo].[sp_reconstruir_solicitud_bienes_coactivo_documentos] 