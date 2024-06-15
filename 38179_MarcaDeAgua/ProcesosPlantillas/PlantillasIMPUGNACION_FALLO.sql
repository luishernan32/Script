--******************IMPUGNACION FALLO**********************
-- https://tomeko.net/online_tools/hex_to_file.php?lang=en
-- https://www.dpriver.com/pp/sqlformat.htm



--REGISTRO_FALLO 2662 2 Tiene AUTORIDAD DE TRÁNSISTO MUNICIPAL variable ok +query Generada "Ver imagenes"
--APELACION_REG_FALLO 2663 10095  Presenta fallo
--ARCH_DESIST_COND 2664 10194 AUTORIDAD DE TRÁNSISTO MUNICIPAL variable ok +query Generada
--COA_JUNIO_2019 2665 10195 AUTORIDAD DE TRÁNSISTO MUNICIPAL variable ok +query   Generada

--REG_FALL_CONS_PP 2666 10196 Tiene AUTORIDAD DE TRÁNSISTO MUNICIPAL variable ok +query Generada
--COA_SV_ACT_FC 2667 10198 Tiene AUTORIDAD DE TRÁNSISTO MUNICIPAL Generada

--***********************************************************************************************
--COA_D_P_F_ABS 2668  no tiene id_plantilla config Tiene AUTORIDAD DE TRÁNSISTO MUNICIPAL
--COA_IMCL_SN_DC_P  2669  no tiene id_plantilla config Tiene AUTORIDAD DE TRÁNSISTO MUNICIPAL
--***********************************************************************************************
--COA_ACT_NV_FA 2672 10199 AUTORIDAD DE TRÁNSISTO MUNICIPAL variable ok +query Generada



--(2662,2663,2664,2665,2666,2667,2668,2669,2672)

--********************************************************/
--************************importante**********************/
--Ver los nombres ya que se generar en una sola pantalla
--*********************************************************


--Registro fallo	                                                           REGISTRO_FALLO                             No se presenta el Abg. previo al nombre del delegado en la parte de la firma   ok
--Apelación -  Registro Fallo *                                                APELACION_REG_FALLO
--Desistimiento - Archivo - Fallo condenatorio	                               ARCH_DESIST_COND                           No se presenta el Abg. previo al nombre del delegado en la parte de la firma OK
--junio 2019 coa	                                                           COA_JUNIO_2019                             No se presenta el Abg. previo al nombre del delegado en la parte de la firma ok
--Registro fallo - Con período probatorio	                                   REG_FALL_CONS_PP                           No se presenta el Abg. previo al nombre del delegado en la parte de la firma ok
--COA - Sí vino ACT - Fallo condenatorio	                                   COA_SV_ACT_FC                              No se presenta el Abg. previo al nombre del delegado en la parte de la firma  ok
--COA - Docs de prueba - Fallo absolutorio	                                   COA_D_P_F_ABS                              No se presenta el Abg. previo al nombre del delegado en la parte de la firma
--COA - Imagen clara sin docs de prueba - Fallo condenatorio	               COA_IMCL_SN_DC_P                           No se presenta el Abg. previo al nombre del delegado en la parte de la firma
--COA - ACT no vino - Fallo absolutorio	                                       COA_ACT_NV_FA                              No se presenta el Abg. previo al nombre del delegado en la parte de la firma ok


--***********************************************************************************************************************
--OBSERVACIONES: APELACION_REG_FALLO presenta error y las plantillas COA_D_P_F_ABS y COA_IMCL_SN_DC_P no tienen id_config
--***********************************************************************************************************************


--TITULO_PLANTILLAS
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.
--------------------------------------------------------------------------------------------------------------------------------
--INCIDENCIAS

--IMPUGNACIÓN FALLO
--REGISTRO_FALLO		9924257  - No se presenta el Abg. previo al nombre del delegado en la parte de la firma +
--ARCH_DESIST_COND	9921030  - No se presenta el Abg. previo al nombre del delegado en la parte de la firma +
--COA_JUNIO_2019		8680060  - No se presenta el Abg. previo al nombre del delegado en la parte de la firma +
--REG_FALL_CONS_PP	8680471  - No se presenta el Abg. previo al nombre del delegado en la parte de la firma  +
--COA_SV_ACT_FC		8680151  - No se presenta el Abg. previo al nombre del delegado en la parte de la firma  +
--COA_D_P_F_ABS		8679885  - No se presenta el Abg. previo al nombre del delegado en la parte de la firma    +
--COA_IMCL_SN_DC_P	8679845  - No se presenta el Abg. previo al nombre del delegado en la parte de la firma  +
--COA_ACT_NV_FA		8679553  - No se presenta el Abg. previo al nombre del delegado en la parte de la firma

--------------------------------------------------------------------------------------------------------------------------------

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'COA_JUNIO_2019';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE SENTAR RAZÓN
update documentos..plantilla set fecha_inicio='2024-06-04' where id_plantilla in(2662,2663,2664,2665,2666,2667,2668,2669,2672)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran



-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
where id_plantilla in(2662,2663,2664,2665,2666,2667,2668,2669,2672)

commit tran


------------------------------------------------------------------------------------------

--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=3685--3681----2662--2672--2667--2666--2664--2659--2633--2664--2659--2662--2659--2648--2604  -    *
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


begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   
WHERE  id_plantilla_config=54


commit tran

-------------------------------------------------------------------------------


--COA_D_P_F_ABS 2668  no tiene id_plantilla config 
--COA_IMCL_SN_DC_P  2669  no tiene id_plantilla config 

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
WHERE  id_plantilla_config=10199xx

commit tran

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

--ANEXOS

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
,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439) AS TITULO_PLANTILLAS 


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--Query para traer esté texto
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.
SELECT *--valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439

--TITULO_PLANTILLAS
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.


------------------------------------------------------------------------------------

select *from parametro 
------------------------------------------------------------------------------------

begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=',TITULO_PLANTILLAS'
WHERE  id_plantilla_config=10126xxx

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

--------------------------------------------------------
select *from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1 ='conny'

--------------------------------------------------------
--ABG.
select --titulo_obtenido
*from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1 ='conny' 


begin tran
update funcionario 
set titulo_obtenido='ABG.'
where id_funcionario=12--154
commit  tran
--------------------------------------------------


--[15:04] Nicolas Montañez Rozo
--Devolución de valores

select distinct top 10000 numero_identificacion, fecha_infraccion, fecha_notificacion, c.id_factura_axis, c.numero_citacion, c.* from comparendo c inner join

comparendo_persona cp on c.cicomparendo=cp.cicomparendo

where c.id_estado_comparendo in(3,17,19,20)

and fecha_infraccion>'2019-12-31'

order by c.fecha_infraccion asc



------------------------------------------------


--Devolución de valores

select distinct top 10000 numero_identificacion, fecha_infraccion, fecha_notificacion, c.id_factura_axis, c.numero_citacion, c.* from comparendo c inner join

comparendo_persona cp on c.cicomparendo=cp.cicomparendo

where c.id_estado_comparendo in(3,17,19,20)

and fecha_infraccion>'2019-12-31'

order by c.fecha_infraccion asc


--NOMBRE DEL APROBADOR

(SELECT TOP 1 Upper(Concat (fu.titulo_obtenido, ' ',pab.nombre1, ' ', pab.nombre2, ' ', pab.apellido1,
                    ' '
                                  , pab.apellido2))
 FROM   trazabilidad_proceso tpcrr(nolock)
        LEFT JOIN usuario_persona up1(nolock)
               ON up1.id_usuario = tpcrr.id_usuario
        LEFT JOIN persona pab(nolock)
               ON pab.id_persona = up1.id_persona
        LEFT JOIN funcionario fu(nolock)
               ON fu.id_persona = pab.id_persona
 WHERE  tpcrr.id_proceso = :idProceso
        AND tpcrr.id_estado_proceso IN( 4, 118 ))  AS nombreAprobador,









----------------------------------------------------------------


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
