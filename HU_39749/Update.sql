select pr.* , tp.fecha_inicio from circulemos2.dbo.proceso pr
inner join circulemos2.dbo.trazabilidad_proceso tp on pr.id_proceso =tp.id_proceso and tp.id_estado_proceso = 13
where pr.id_tipo_proceso = 1
and YEAR(pr.fecha_inicio)>=2023
and pr.id_estado_proceso= 13
order by tp.id_trazabilidad_proceso desc



select *from proceso
where --id_estado_proceso='13' and 
numero_proceso='106'

begin tran
update proceso set id_estado_proceso='13'
where id_proceso='2833583'--'2833580'--'2833577'--'2828472'
commit tran

select *from proceso
where id_proceso='2828472' 

begin tran
update documentos..plantilla set fecha_fin='2023-06-21' where id_plantilla=2532
update documentos..plantilla set fecha_inicio='2023-06-22' where id_plantilla=2550
commit tran


--13 estado solitud de pruebas
--where id proceso


select *from estado_proceso

select *from acta_resorteo

-------------------------FUNCIONARIOS--------------------------------------

 use circulemos2
	select f.id_funcionario,f.estado,f.id_cargo, nombre CARGO,f.fecha_inicio_vigencia,
	f.fecha_final_vigencia,per.numero_identificacion,per.apellido1,per.nombre1,f.numero_firma,
	f.memo_nombramiento,f.fecha_nombramiento
	from funcionario f
	join persona per on per.id_persona = f.id_persona
	join cargo c on c.id_cargo = f.id_cargo
	where f.fecha_final_vigencia is null
	and f.id_cargo = 6

	---------------------------------
--Fabiola 0905026639 activo numero_de firma=100200 memo=EPMTG-DGIST-0110-2017 fecha_nombramiento=2017-02-07
--0701911521 felipe LARREATEGUI inactivo 3687927=numero de firma memo=EPMTMG-DGIST-SACK-2023-0007  fecha_nombramiento=2023-09-26

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