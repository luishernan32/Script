SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro in(430,431,432,432,433,434,435,436,437,438,439,440,441,442)


SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro =434


--Delegado del Director de Gestión de Infracciones y Servicios de Tránsito. -EPMTMG-DGIST-SACK-2023-0056 del 02 de octubre de 2023.



--DELEGADO DEL(LA) DIRECTOR(A) DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO DE LA EMPRESA PÚBLICA DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL, EP.

--DELEGADO DEL(LA) DIRECTOR(A) DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO DE LA EMPRESA PÚBLICA DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL, EP.

--Delegado Funcionario Ejecutor-Coactiva Del(la) Director(a) de Infracciones y Servicios de Tránsito de la Empresa Pública Municipal de Tránsito y Movilidad de Guayaquil EP

--DELEGADO del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito


select * from circulemos2.dbo.cargo
-- 1.- INSERTAR CARGO
-- DELEGADO DEL DIRECTOR DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO   NOMBRE
-- DELEGADO DEL DIRECTOR DE GESTIÓN PARA FINANCIAMIENTOS
 
select * from circulemos2.dbo.funcionario_financiacion
-- 2.- INSERTAr FUNCIONARIO FINANCACION

select *from circulemos2.dbo.funcionario_coactivo fc
inner join persona p on p.id_persona=fc.id_persona

---------------------------------------------------------------
begin tran
USE [circulemos2]
GO

INSERT INTO [dbo].[cargo]
           ([nombre]
           ,[sigla]
           ,[estado]
           ,[codigo]
           ,[descripcion])
     VALUES
           ('DELEGADO DEL DIRECTOR DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO',
           null,
           1,
           17,
           'DELEGADO DEL DIRECTOR DE GESTIÓN PARA FINANCIAMIENTOS')
GO

COMMIT TRAN
---------------------------------------------------------------



--Ariana
--id_funcionario = 174
--Con piero hay que dar el id_cargo 17
begin tran
USE [circulemos2]
GO

INSERT INTO [dbo].[funcionario_financiacion]
           ([id_funcionario]
           ,[id_cargo]
           ,[fecha_inicio_vigencia]
           ,[fecha_final_vigencia]
           ,[memo_nombramiento]
           ,[fecha_nombramiento]
           ,[motivo]
           ,[estado]
           ,[id_subcargo]
           ,[titulo_obtenido]
           ,[id_persona])
     VALUES
           (156,
           17,
           '2022-11-21',
           null,
           'EPMTMG-DGIST-2024-005',
           '2024-03-01',
           null,
           'vigente',
           4,
           'ABG',
           5442545)
GO

----------------------------------------------------------------------------------------------------------
Select id_funcionario, id_cargo, fecha_inicio_vigencia, fecha_final_vigencia,memo_nombramiento,fecha_nombramiento,
motivo, f.estado,f.id_subcargo, 
f.titulo_obtenido,per.id_persona
from funcionario f
INNER JOIN persona per (nolock)
ON f.id_persona = per.id_persona
where nombre1='Piero'
AND f.estado = 'VIGENTE'





--EPMTMG-DGIST-2024-002

--Delegado del Director de Gestión de Infracciones y Servicios de Tránsito. 
---EPMTMG-DGIST-SACK-2023-0056 del 02 de octubre de 2023.

----------------------------------------------------------------------------------------------------------






USE [circulemos2]
GO

INSERT INTO [dbo].[funcionario_financiacion]
           ([id_funcionario]
           ,[id_cargo]
           ,[fecha_inicio_vigencia]
           ,[fecha_final_vigencia]
           ,[memo_nombramiento]
           ,[fecha_nombramiento]
           ,[motivo]
           ,[estado]
           ,[id_subcargo]
           ,[titulo_obtenido]
           ,[id_persona])
     VALUES
           (<id_funcionario, int,>
           ,<id_cargo, int,>
           ,<fecha_inicio_vigencia, date,>
           ,<fecha_final_vigencia, date,>
           ,<memo_nombramiento, varchar(150),>
           ,<fecha_nombramiento, date,>
           ,<motivo, varchar(11),>
           ,<estado, varchar(11),>
           ,<id_subcargo, int,>
           ,<titulo_obtenido, varchar(10),>
           ,<id_persona, bigint,>)
GO



Select f.id_funcionario, id_cargo, fecha_inicio_vigencia, fecha_final_vigencia,memo_nombramiento,fecha_nombramiento,
motivo, f.estado,f.id_subcargo, 
f.titulo_obtenido,per.id_persona
from funcionario_financiacion f
INNER JOIN persona per (nolock)
ON f.id_persona = per.id_persona
where f.fecha_final_vigencia is null





select 
--nombre 
*from circulemos2.dbo.cargo
where id_cargo=17


--Delegado del Director de Gestión de Infracciones y Servicios de Tránsito. -EPMTMG-DGIST-SACK-2023-0056 del 02 de octubre de 2023.

--****************************************************************
(SELECT Max(fp.numero_imagen)
        FROM   funcionario_financiacion fun (nolock)
               INNER JOIN firma_persona fp (nolock)
                       ON fp.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 17
               AND fun.estado = 'Vigente') 
--****************************************************************


SELECT TOP 1 Concat(fun.titulo_obtenido, ' ', pf.nombre1, ' ',
                     pf.nombre2, ' ',
                     pf.apellido1,
                                   ' ', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario_financiacion fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 17
               AND fun.estado = 'Vigente'

---******************************************************
Select top 1 Concat(ca.nombre,'.  -',f.memo_nombramiento,'  ',
RIGHT ( '0' + CONVERT ( varchar (2), day (f.fecha_nombramiento)), 2) + ' de ' + datename( month ,f.fecha_nombramiento) + ' del ' + CONVERT ( varchar (4),
year (f.fecha_nombramiento)),'.')
from funcionario_financiacion f
INNER JOIN persona per (nolock)
ON f.id_persona = per.id_persona
inner join cargo ca (nolock)
on f.id_cargo=ca.id_cargo
where f.fecha_final_vigencia is null
--****************************************************************
--Delegado del Director de Gestión de Infracciones y Servicios de Tránsito. -EPMTMG-DGIST-SACK-2023-0056 del 02 de octubre de 2023.

DECLARE @fecha DATE = '2023-10-02' ;
SELECT RIGHT ( '0' + CONVERT ( varchar (2), day (@fecha)), 2) + ' de ' + datename( month , @fecha) + ' del ' + CONVERT ( varchar (4),
year (@fecha)) AS fecha_formateada;