declare
@id_proceso bigint;
begin 
begin tran
select @id_proceso = id_proceso from circulemos2.dbo.proceso
where id_tipo_proceso = 1
and YEAR(fecha_inicio)=2024
and numero_proceso = 126;
 
update circulemos2.dbo.proceso
set id_estado_proceso = 13, observacion = 'SOLICITUD PRUEBAS'
where id_proceso = @id_proceso;
 
delete circulemos2.dbo.documento_proceso
where id_trazabilidad_proceso in (select tp.id_trazabilidad_proceso
from circulemos2.dbo.trazabilidad_proceso tp
where tp.id_proceso = @id_proceso
and tp.id_estado_proceso in (10, 139)
)
 
delete circulemos2.dbo.acta_resorteo
where id_trazabilidad_proceso in (select tp.id_trazabilidad_proceso
from circulemos2.dbo.trazabilidad_proceso tp
where tp.id_proceso = @id_proceso
and tp.id_estado_proceso in ( 139)
)
 
delete circulemos2.dbo.trazabilidad_proceso
where id_proceso = @id_proceso
and id_estado_proceso in (10, 139)
 
commit
 
end


--120 2024 felipe activo  


--Sirve para traer el id_proceso y

select * from circulemos2.dbo.proceso p
where p.id_tipo_proceso = 1
and YEAR(p.fecha_inicio)=2024
and p.numero_proceso = '116'

select *from funcionario



	 use circulemos2
	select f.id_funcionario,f.estado,f.id_cargo, nombre CARGO,f.fecha_inicio_vigencia,f.fecha_final_vigencia,per.numero_identificacion,per.apellido1,per.nombre1 from funcionario f
	join persona per on per.id_persona = f.id_persona
	join cargo c on c.id_cargo = f.id_cargo
	where f.fecha_final_vigencia is null
	and f.id_cargo = 6

	---------------------------------
--Fabiola 0905026639 activo



--0701911521 felipe LARREATEGUI inactivo

--Está asignando a Fabiola hay que inactivarla y activar a felipe


-----------------------

	select top 1  Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
               ' '
                       , per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' '
               , per.apellido2)
	from funcionario f
	join persona per on per.id_persona = f.id_persona
	join cargo c on c.id_cargo = f.id_cargo
	where f.fecha_final_vigencia is null
	and f.id_cargo = 6