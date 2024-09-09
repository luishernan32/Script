
--- Reprocesamiento  -- Debe ser enviado a DBA.
BEGIN TRAN
update circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes
set error = null
where procesado = 0
and error is not null
and numero_juicio in('2087-2024','304104-2023','15862-2024','13477-2024','11055-2024','308542-2023','22481-2024')
COMMIT TRAN

exec circulemos2.dbo.sp_reconstruir_solicitud_bienes_coactivo



