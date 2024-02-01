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