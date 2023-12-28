select *from persona
where correo_electronico='sctx_auditores@hotmail.com'

'HECTORSUAREZERCONTAX@HOTMAIL.COM'

'2477113@aaaaaa.aa'
'sctx_auditores@hotmail.com'

select *from correo_persona cp
inner join persona p
on p.id_persona=cp.id_persona
where --estado=0 and 
p.numero_identificacion='0917053290001'

select *from persona


--Rut con el que falla
--RUC 0990392218001
--ruc 0917053290001
--ruc : 0991316043001
--usuario: 0920357902001

--cedulas normales
--0921303996

select top 10*from persona
where numero_identificacion='0990392218001'

select top 10*from persona_juridica
where id_persona_juridica=0990392218001

--con cedular
select *from correo_persona
where id_persona=132342

--Con rut
select *from correo_persona
where id_persona=485429
--485429