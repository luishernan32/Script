--15/05/2024
--12032396 MEMO_SOLICIT_PRUEBAS salio con ese numero de obligación
--***********************************************************************************************************************                           
--*						   -- Impugnación proceso de pruebas x2        x2                       *
-- https://www.dpriver.com/pp/sqlformat.htm  "Dar formato a la query"
--***********************************************************************************************************************

--MEMO_SOLICIT_PRUEBAS 3695 19   OK update variable
--OFICIO_SOLIC_PRUEBAS 3696 55
--(3695,3696)

--*************************************************************************************
--*************************************************************************************

--4	Impugnación proceso de pruebas	Memo solicitud de pruebas	MEMO_SOLICIT_PRUEBAS
--4	Impugnación proceso de pruebas	Oficio de solicitud de pruebas	OFICIO_SOLIC_PRUEBAS   https://www.youtube.com/watch?v=sSyFWDx7-Xo

--*************************************************************************************
--*************************************************************************************

--Seleccione...
--Direccion de Control de Tránsito
--Dirección de Informática
--Dirección de Transporte Público
--Dirección de Registro Técnico Vehicular
--OTRAS instituciones  <con está opcion genera OFICIO_SOLIC_PRUEBAS de resto genera el MEMO_SOLICIT_PRUEBAS>



--***********************************************************************************************************************
--Videos y descripcion
--Socialización: Nicolas generación
--https://www.youtube.com/watch?v=NQv9SZPyU0M

--Generacion de las plantillas
--https://www.youtube.com/watch?v=sSyFWDx7-Xo

--***********************************************************************************************************************
--Temporal
--Datos usado numero de obligacion: 12030369
--***********************************************************************************************************************
--OBSERVACIONES: 
--***********************************************************************************************************************
-- TIP para tener en cuenta con la elaboración de las plantillas
--Despues de crear la new versión de plantilla no se te olvide cambiar las fechas
--Actualizar la marca de agua
--****************************************************************************************************************************************************************
declare @codigoPlantilla varchar(20);
set @codigoPlantilla ='OFICIO_SOLIC_PRUEBAS'--'OFIC_BAN_CARTA_SEPS'-- 'AI_EXV_SGPS_TP';--AUTO_PAGO_PATIO  
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
--****************************************************************************************************************************************************************

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZÓN
update documentos..plantilla set fecha_inicio='2024-05-14' where id_plantilla in(3695,3696)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran






-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(3695,3696)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=3695--3696--2383--2621--2259--2289--2287--2288--2287--2286--2639--2625--2258--2258--3692--3690--
--Impugnación de comparendo	Apertura impugnación sin tercero	APERT_IMPUG_SIN_TERC
																																	   *
select top 20 *from [documentos].[dbo].[documento] order by 1 desc																	   *
--**************************************************************************************************************************************

select top 100 *from [documentos].[dbo].[documento] where id_plantilla='2647' order by 1 desc


select *from parametro
select upper(nombre) cargo(NOLOCK) where id_cargo==11

select (valor_parametro_defecto) from parametro
where codigo_parametro=434

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select top 5 p.codigo_plantilla from documentos.dbo.documento d
inner join documentos.dbo.plantilla p on d.id_plantilla=p.id_plantilla
order by 1 desc
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--DATOS PARA PRUEBA
--GLT0230
--gqh0010
--GNA0319
--RTB0950
--GPN0289
--GBL0616
--HZ370D
--GS09740
--GPJ0369
--GQH0870
--GLL0890 
--GIK0109 *
--GRW7830 x
------------------------------------------------------------------------------------

select *from interes

------------------------------------------------------------------------------------
--Query para traer esté texto
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.
SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439

--TITULO_PLANTILLAS
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.


------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--Query para traer esté texto
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.
SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439

--TITULO_PLANTILLAS
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=',TITULO_PLANTILLAS'
WHERE  id_plantilla_config=55xx

commit tran





------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--------------------ANEXOS----------------------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------

------------------------------------------------------------------------













------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--------------------ANEXOS----------------------------------------------------------
------------------------------------------------------------------------------------
--Se intentarón obtener los titulos

SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 437


			   SELECT Concat(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ',
               p.apellido1, ' ',
                       p.apellido2)
        FROM   funcionario f (nolock)
               JOIN persona p (nolock)
                 ON f.id_persona = p.id_persona
        WHERE  id_cargo = 11
               AND fecha_final_vigencia IS NULL


--Ab. ERIKA JAQUELINE ZAMBRANO REYNA

------------------------------------------------------------------------

------------------------------------------------------------------------

select *from funcionario

Concat(fu.titulo_obtenido,' ',per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
       per.apellido2) AS
       nombreAbogadoFirma,



SELECT TOP 1 Concat(fun.titulo_obtenido, ' ', pf.nombre1, ' ',
                     pf.nombre2, ' ',
                     pf.apellido1,
                                   ' ', pf.apellido2)
        FROM   persona pf
               INNER JOIN funcionario fun
                       ON pf.id_persona = fun.id_persona
        WHERE  fun.id_cargo = 1
               AND fun.estado = 'Vigente'

--Abg. Esp. FRANCISCO XAVIER ROJAS ESTEVES

----------------------------------------------------------

select --per.nombre1, per.nombre2
*from funcionario fu
inner join persona per on per.id_persona=fu.id_persona 
where id_funcionario=154
order by 1 desc


select per.nombre1, per.nombre2, fu.titulo_obtenido
from funcionario fu
inner join persona per on per.id_persona=fu.id_persona 
where id_funcionario=154
order by 1 desc


--CONNY YANINA ARREGUI MIRANDA
--DELEGADO DEL DIRECTOR DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO
--DE INFRACCIONES Y SERVICIOS DE TRÁNSITO 136 cony

--ALEXIS 

--Cambio para que aparezca el titulo del funcionario
--fu.titulo_obtenido, ' ',  
------------------------------------------------------------------


select *from plantilla_configuracion
where id_plantilla


select *from plantilla_configuracion
order by id_plantilla  desc
where id_plantilla=1430
--------------------------------------

select *from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1 ='FELIPE'

--------------------------------------------------------
select *from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1 ='ALEXIS'

--------------------------------------------------------
--ABG.
select --titulo_obtenido
*from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1 ='conny' 


begin tran
update funcionario 
set titulo_obtenido='ABG.'
where id_funcionario=182--154 conny y alexis no tienen cargo
commit  tran
--------------------------------------------------





