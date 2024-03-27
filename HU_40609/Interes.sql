declare @fecha date='2024-03-08';
select *from interes
where id_clase_interes=3
and @fecha >= fecha_inicial
and(@fecha<= fecha_final or fecha_final is null)


declare @fecha date='2024-02-19';
select *from interes
where id_clase_interes=3
and @fecha >= fecha_inicial
and(@fecha<= fecha_final or fecha_final is null)



select *from interes 
where 
id_clase_interes=3 
--and 
--id_interes=76
order by fecha_inicial desc

--0.0082800000
begin tran
update interes
set porcentaje_tasa_interes='0.0082800000'
,porcentaje_interes_diario='0.0082800000'
where id_interes=76
commit tran