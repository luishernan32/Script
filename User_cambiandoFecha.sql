select *from seguridad.dbo.usuario
where login='luis.pineda'

update seguridad.dbo.usuario set fecha_modifica_password=cast( '2030-10-20' as date) 
where login='luis.pineda'