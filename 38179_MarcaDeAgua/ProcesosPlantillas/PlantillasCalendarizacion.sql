--CALENDARIZACION
--Todas tienen la variable cambio
-- https://tomeko.net/online_tools/hex_to_file.php?lang=en
-- https://www.dpriver.com/pp/sqlformat.htm




--APERT_ANUCAL_SIN_TER  El titulo de la variable no sale en negrilla


--Todas las plantillas salen de este video : https://www.youtube.com/watch?v=8_0XGwFcpyY   desde el min 8 empieza CALENDARIZACI�N

--FALLO_CALEND_FIRMA 2643 10158 ok  +++

--APERTURA_ANU_CAL 2644 10145 Darle unos espacios en la segunda hoja cedula que va a pedir 0917206658 ok  ++

--APERT_ANUCAL_SIN_TER 2645 10144 min 10  tiene justificacion para insertar datos https://www.youtube.com/watch?v=8_0XGwFcpyY en el  min 31 es tiempo perdido ok +++

--DOC_INCOMPLETA_CAL 2646 10153 no se deja descargar se toma como un virus ok   ++++


--RECH_FALTA_SOPOR_CAL 2647 10154 pendiente

--(2643,2644,2645,2646,2647)

--**********************************
--REGISTRO_FALLO_CAL 2648 10146 ok
--(2648)
--**********************************

--APERT_ANUCAL_SIN_TER	GRY7811	- El t�tulo sigue siendo Autoridad de tr�nsito municipal 2645 10144 calendarizacion <Sin Abs> OK
--DOC_INCOMPLETA_CAL	GRY7811	- El t�tulo sigue siendo Autoridad de tr�nsito municipal - No muestra el "Abg." en la firma 2646 10153 calendarizacion  OK r
--RECH_FALTA_SOPOR_CAL	GRY7811	- El t�tulo sigue siendo Autoridad de tr�nsito municipal - No muestra el "Abg." en la firma 2647  10154   calendarizacion ok
--APERTURA_ANU_CAL	HB161I  - El t�tulo sigue siendo Autoridad de tr�nsito municipal - El texto se cruza con el logo   <Sin Abs> ok
--REGISTRO_FALLO_CAL	HB161I  - El t�tulo sigue siendo Autoridad de tr�nsito municipal - No muestra el "Abg." en la firma <Calendarizacion Fallo>
--FALLO_CALEND_FIRMA	HB161I  - El t�tulo sigue siendo Autoridad de tr�nsito municipal - No muestra el "Abg." en la firma   Ok r


--**********************************************************************************
--INCIDENCIAS




--**********************************************************************************


--PROVIDENCIA_PAGO
--PROVIDENCIA_ANULAR
declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'REGISTRO_FALLO_CAL';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE COACTIVO
update documentos..plantilla set fecha_inicio='2024-05-28' where id_plantilla in(2643,2644,2645,2646,2647,2648)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran


-- C�digos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
--where id_plantilla in(2612,2611,2610,2609)
where id_plantilla in(2643,2644,2645,2646,2647,2648)--(2324,2325,2581,2582,2229)--(2616,2617,2618,2619,2620,2621,2622,2623,2624,2625,2626,2627,2628,2629,2630,2631,2632,2633,2634,2635,2636,2637,2638,2639,2640,2641,2642)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISI�N DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=2652--2648--2645--2650--2648--2604  -    *
																																	   *
select top 200 *from [documentos].[dbo].[documento] order by 1 desc																	   *
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
--GPN0289 +
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
------------------------------------------------------------------------------------
--Query para traer est� texto
--EMPRESA P�BLICA MUNICIPAL DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL EP.
SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439

--TITULO_PLANTILLAS
--EMPRESA P�BLICA MUNICIPAL DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL EP.


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--Query para traer est� texto
--EMPRESA P�BLICA MUNICIPAL DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL EP.
SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439

--TITULO_PLANTILLAS
--EMPRESA P�BLICA MUNICIPAL DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL EP.

begin tran
update parametro
set valor_parametro_defecto='EMPRESA P�BLICA DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL. EP.'
WHERE  codigo_parametro = 439
commit tran

--EMPRESA P�BLICA DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL. EP.
--EMPRESA P�BLICA DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL. EP.
--EMPRESA P�BLICA MUNICIPAL DE TR�NSITO Y MOVILIDAD DE GUAYAQUIL EP.
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=',TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10146xxx

commit tran

------------------------------------------------------------------------------------
--************************************************************************************
--Cambio para el titulo del delegado

Concat(f.titulo_obtenido, ' ',per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
       per.apellido2) AS
       nombreAbogadoFirma,

--************************************************************************************
------------------------------------------------------------------------------------







select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo=6--11 
and fecha_final_vigencia is null


select CONCAT(f.titulo_obtenido, ' ', p.nombre1, ' ', p.nombre2, ' ', p.apellido1, ' ', p.apellido2) 
from funcionario f
join persona p on f.id_persona=p.id_persona
where id_cargo=11 and fecha_final_vigencia is null

--Abg. FELIPE HIPOLITO LARREATEGUI AVILES

select *from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1 ='FELIPE'




-------------------------------------------------------------------------


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--------------------ANEXOS----------------------------------------------------------
------------------------------------------------------------------------------------
--Se intentar�n obtener los titulos

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
--DELEGADO DEL DIRECTOR DE GESTI�N DE INFRACCIONES Y SERVICIOS DE TR�NSITO
--DE INFRACCIONES Y SERVICIOS DE TR�NSITO 136 cony

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