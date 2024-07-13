--COACTIVO


--COACTIVOSOLICITUD_OFICIO_BIEN_SEPS

-- Hay que registrar un bien (DISPONER EMBARGO-----RAZON DE NO PAGO)
--Tambien se generarn 2623 2625 2624
--Regitrando un bien y tomando la opcion SEPT se genera 2639 2638 2623


--**********************************************************************************
--OFICIO_BANCO_CARTA 2616 Presenta error									   Ok https://www.youtube.com/watch?v=zc557WYlBn4
--SENTAR_RAZON_PAGO 2617                                    lista para pruebas Ok https://www.youtube.com/watch?v=zc557WYlBn4
--PROVIDENCIA_RETENCIO 2618                                 lista para pruebas OK https://www.youtube.com/watch?v=zc557WYlBn4

--Se generan de la misma manera
--https://www.youtube.com/watch?v=zc557WYlBn4

--**********************************************************************************


--**********************************************************************************
--OFIC_BAN_CARTA_SEPS 2619 Presenta error Ok          https://www.youtube.com/watch?v=qLKO0mnxLEE
--PROVIDENCI_RET_SEPS 2620                                  lista para pruebas Ok https://www.youtube.com/watch?v=qLKO0mnxLEE

--**********************************************************************************

--NOTIFICACION_COAC 2621                                    acomodar probar   radio button "ENVIO NOTIFICACION"1:30  https://www.youtube.com/watch?v=qLKO0mnxLEE
--ACTA_EMBARGO_COACTIV 2622                                 acomodar probar /


--**********************************************************************************
--ACTA_POSESION_DEP 2623                                    acomodar probar Ok  https://www.youtube.com/watch?v=OeFKzBwB-i4

--ORDEN_EMBARGO 2624                                        lista para pruebas Ok  https://www.youtube.com/watch?v=OeFKzBwB-i4

--OFICIO_EMBARGO 2625                                       lista para pruebas Ok  https://www.youtube.com/watch?v=OeFKzBwB-i4

--https://www.youtube.com/watch?v=OeFKzBwB-i4

--**********************************************************************************



--PROVIDENCIA_PAGO_EMB 2626                                 lista para pruebas Ok   https://www.youtube.com/watch?v=M-1sI2atJNM
--COA_TITULO_CREDITO 2627                                   Acomodar probar            https://www.youtube.com/watch?v=yf639kyy5Iw  

--COA_DOC_DETER_DEUDA 2628                                  Acomodar probar Ok min 26 "select top 1000 *from periodo_precoactivo order by 1 desc" https://www.youtube.com/watch?v=UtXTT0AH4IE Hay que lanzar un job
--AUTO_PAGO_PATIO 2629                                      Acomodar probar  https://www.youtube.com/watch?v=1RRltFt0Iss
--LEV_MED_RET_PAGO_PAR 2630                                 Acomodar probar/

--LEVANTAMIENT_EMBARGO 2631                                 Acomodar probar/
--AUTO_PAGO 2632				                            Acomodar probar  radio button "AUTO DE PAGO" 1:30  https://www.youtube.com/watch?v=qLKO0mnxLEE
--ACTA_DE_POSESION 2633                                     Acomodar probar radio button "AUTO DE PAGO"  1:30   https://www.youtube.com/watch?v=qLKO0mnxLEE
--PROVIDENCIA_PAGO 2634  Se genera similar que providencia_pago_em pero hay que cambiar unas lineas de la query Lista para pruebas https://www.youtube.com/watch?v=M-1sI2atJNM 

--ORDEN_COBRO_COIP jasper
--DOC_DETER_DEUDA_COU 2635                                  Acomodar probar Ok  se realiza igual a coa_titulo_credito pero el tipo de file es determinacion tributaria min 20 https://www.youtube.com/watch?v=UtXTT0AH4IE
--PROVIDENCIA_ANULAR 2636                                   Lista para pruebas min30 "Tomar un número de coactivo y anularlo"  https://www.youtube.com/watch?v=UtXTT0AH4IE

--ORDEN_COBRO_ORDENANZ jasper

--LEV_MEDIDA_RETENCION 2637                                  Acomodar probar   no se está utilizando

--ORDEN_COBRO_COIP_ELE jasper


--OFICIO_EMBARGO_SEPS 2638                                   Lista para pruebas min 9 Opcion SEPS admon bien  https://www.youtube.com/watch?v=qLKO0mnxLEE
--ORDEN_EMBARGO_SEPS 2639                                    Lista Para pruebas min 9 Opcion SEPS admon bien  https://www.youtube.com/watch?v=qLKO0mnxLEE  Hay que registrar un bien  procesos Juridicos, administración bien <cedula + #juicio> tipo entidad:SEPS  "ver seguimiento" DISPONER EMBARGO
--ORDEN_COBRO_ORDE_ELE jasper								 min 1 https://www.youtube.com/watch?v=WH7phU6c0Xg

--ACTA_DE_POSESION_P 2640   Es del grupo de 8 de Rafael      Acomodar probar https://www.youtube.com/watch?v=1RRltFt0Iss  
--AUTO_PAGO_PATIO_V2 2641                                    Acomodar probar https://www.youtube.com/watch?v=1RRltFt0Iss
--COA_ORDEN_PAGO_P 2642                                      Acomodar probar https://www.youtube.com/watch?v=1RRltFt0Iss  JobProcesarCoactivoPatios ejecutar + query    select top 100 *from coactivo order by 1 desc
--ORDENANZA_REQ_PAGO jasper                                  COMPLICADA AÚN NO SE SABE GENERAR

--(2616,2617,2618,2619,2620,2621,2622,2623,2624,2625,2626,2627,2628,2629,2630,2631,2632,2633,2634,2635,2636,2637,2638,2639,2640,2641,2642)

--ORDEN_COBRO_COIP jasper 2324 10135
--ORDEN_COBRO_ORDENANZ jasper 2325 10136
--ORDEN_COBRO_COIP_ELE jasper 2581 10200 dato con medio_imposicion=1    https://www.youtube.com/watch?v=WH7phU6c0Xg   
--Procesos Juridicos, consultar cobros coactivos <numero del coactivo> generar documentos "COACTIVO ORDEN DE COBRO COIP" (ver seguimiento) radicar cobro coactivo
--Se genera con codigo_medio_imposición=2
--ORDEN_COBRO_ORDE_ELE jasper 2582 10201 dato con medio_imposicion=2    https://www.youtube.com/watch?v=WH7phU6c0Xg
--Procesos Juridicos, consultar cobros coactivos <numero del coactivo> generar documentos "COACTIVO ORDEN DE COBRO COIP" (ver seguimiento) radicar cobro coactivo
--Se genera con codigo_medio_imposición=1

--ORDENANZA_REQ_PAGO 2229  10104
--(2324,2325,2581,2582)

--**********************************************************************************
--INCIDENCIAS
--Observaciones plantilla coactivo

--COA_TITULO_CREDITO		 - Parte de la segunda página está saliendo en la primera
--COA_ORDEN_PAGO_P	306314	 - Se está generando en dos páginas. Toda la información debe quedar en la primera    https://www.youtube.com/watch?v=evJbQ-vznzA

--Punto 1
--ACTA_EMBARGO_COACTIV	ACTA_EMBARGO_COACTIV


--Incidencias word cambios por realizar
--Cambios ACTA_EMBARGO_COACTIV
--Punto 2
--ACTA_DE_POSESION 2633 39

--***************************************************************************************************************
--Punto 3
--ACTA_DE_POSESION_P
--Falta hacer un update en la tabla funcionario_coactivo para el campo titulo del funcionario porque esta en null
--***************************************************************************************************************


--***************************************************************
--punto: 4 --Devuelta por Nicolas okkkkk
--Acta posesión depositario	ACTA_POSESION_DEP   NECESITA UNA SEGUNDA REVISIÓN falta generarla

--Revisar la firma del delegado que aparezca con los titulos
--***************************************************************

--punto: 5
--Auto de pago	AUTO_PAGO
-- Revisar lo de la firma

--punto: 6
--AUTO_PAGO_PATIO

--***************************************************************
--punto: 7  AUTO_PAGO   --Reportada por Nicolas       Generar documentos/COACTIVO_AUTO PAGO_______"Ver seguimiento"/AUTO DE PAGO
--7. AUTO DE PAGO 2 :(
--Francisco Xavier Rojas Esteves. Hay que update su titulo
--Tiene 3 id_plantilla hay que identificar
--Generarla o revisarla por el script

--Los datos tienen que generarce a travez de está query

select *from coactivo
where id_tipo_coactivo='4'
order by id_coactivo desc

--***************************************************************

SELECT Concat(f.titulo_obtenido, ' ', Upper(
               Concat(per.nombre1, ' ', per.nombre2, ' ',
                       per.apellido1, ' ',
               per.apellido2)))
        FROM   funcionario_coactivo f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, getdate()
               --AND f.fecha_final_vigencia >= CONVERT(DATE, getdate()
                --OR ( f.id_cargo = 1
                     --AND f.fecha_inicio_vigencia <= CONVERT(DATE, getdate()
                    -- AND f.fecha_final_vigencia IS NULL 
					--)
					)       					 
					 
					 --AS
      -- titulo_nombreFuncionario, --Aquí es------------------------------------------------------------------

	  begin tran
update funcionario 
set titulo_obtenido='Abg. Esp.'
where id_funcionario=180--154 conny y alexis no tienen cargo
commit  tran


select *from coactivo
where id_tipo_coactivo='1'
order by id_coactivo desc

--punto: 8
-- COA_ORDEN_PAGO_P
--Ok


--punto: 9



--punto: 10
--DOC_DETERMINACION_DEUDA	COA_DOC_DETER_DEUDA 
--Revisar variable
--Ok

--punto: 11
--DOC_DETERMINACION_DEUDA_COURIER	 DOC_DETER_DEUDA_COU
--ok


--***************************************************************
--Reportada por Nicolas OKKKKK
--punto: 12 
--Levantamiento medidas de retención y ejecución	LEVANTAMIENT_EMBARGO   El titulo esta quemaddo
--Ok
--Hay que hacer una correcion 
--Segunda corrección oK
--Revisar que el script de las plantillas ten TITULO_PLANTILLAS
--Datos quemados en autoridad de transito municipal
--Revisarlo por script

--***************************************************************



--***************************************************************
--Reportada por Nicolas Okkkk
--punto: 13
--Levantamiento por embargo	LEV_MED_RET_PAGO_PAR     El titulo esta quemaddo
--En el script ver que se generen dos titulos diferentes
--Ok  ok
--***************************************************************



--punto: 14
--Notificación coactivo	NOTIFICACION_COAC
--Ok

--***************************************************************
--punto: 15 reportada por Nicolas okkkkkk
--Oficio de bancos carta	OFICIO_BANCO_CARTA
--Falta generar

--***************************************************************

--***************************************************************
--reportada por Nicolas okkkkkk
--punto: 16 Es de firmas revisar un poco mas
--Oficio de bancos carta SEPS	OFIC_BAN_CARTA_SEPS
--Ok
--***************************************************************


--********
--***************************************************************
--punto: 17 reportada por Nicolas okkkkkk
--Oficio de embargo	OFICIO_EMBARGO
--En dado caso que no funcione es porque los funcionarios tienen el titulo en null
--Colocar CARGO_DELEGADO y nombre de los titulos están quemados
--***************************************************************
--punto: 18  <Revisar la firma>
--Oficio de embargo SEPS	OFICIO_EMBARGO_SEPS
--Se soluciona de la misma manera que el punto 17
--Ok
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--punto: 19 Jasper   Falta hacer la prueba
--Presente error en el sistema
--ORDEN_COBRO_COIP	ORDEN_COBRO_COIP
--PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--punto: 20  Jasper
--Presente error en el sistema
--ORDENANZA_REQ_PAGO	ORDENANZA_REQ_PAGO
--PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--punto: 21  Jasper
--Orden de Cobro COIP Electrónica	ORDEN_COBRO_COIP_ELE
--Ok

--punto: 22  jasper
--Presente error en el sistema
--Orden de Cobro Ordenanza Electrónica	ORDEN_COBRO_ORDE_ELE
--Ok


--punto: 23
--ORDEN_EMBARGO

--punto: 24
--ORDEN_EMBARGO_SEPS
select nombre1,nombre2, id_funcionario,titulo_obtenido
from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1='PABLO ' 
and nombre2 ='ENRIQUE'

--nombre1	nombre2	id_funcionario	titulo_obtenido
--PABLO	ENRIQUE	142	NULL

--punto: 25
--PROVIDENCIA_ANULAR


--punto: 26
--Incidencia mas complicada
--Providencia pago por Embargo	PROVIDENCIA_PAGO_EMB
--ok tener en el radar

--punto: 27
--Providencia por pago	PROVIDENCIA_PAGO
--Ok


--punto: 28
--PROVIDENCIA RETENCIÓN	PROVIDENCIA_RETENCIO
--Ok

--punto: 29
--PROVIDENCI_RET_SEPS 
--Segunda revisión: Parece estar ok

--punto: 30
--Sentar Razon del Pago	SENTAR_RAZON_PAGO
--Segunda revisión: parece estár ok
--Ejecutar Script ok


----------------------------------------------------------------

begin tran
update parametro
set valor_parametro_defecto= 'DELEGADO DEL (A) DIRECTOR (A) DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO PARA EL EJERCICIO DE LA JURISDICCIÓN COACTIVA DE LA EMPRESA PÚBLICA DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL,EP.'
where codigo_parametro = 434
commit tran
--Anterio texto
--DELEGADO del(la) Director(a) de Gestión de Infracciones y Servicios de Tránsito


--**********************************************************************************
--436: DELEGADO FUNCIONARIO EJECUTOR-COACTIVA DEL(LA) DIRECTOR(A) DE INFRACCIONES Y SERVICIOS DE TRÁNSITO DE LA AUTORIDAD DE TRÁNSITO MUNICIPAL
--441: DELEGADO DEL (A) DIRECTOR (A) DE GESTIÓN DE INFRACCIONES Y SERVICIOS DE TRÁNSITO PARA EL EJERCICIO DE LA JURISDICCIÓN COACTIVA DE LA EMPRESA PÚBLICA DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL,EP.
--**********************************************************************************

--**********************************************************************************
--NUMERO_PROCESO,fecha_actual,hora_actual,NOMBRE_INFRACTOR,T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,FECHA_GENERACION,  VALOR_SALDO,VALOR_TOTAL_LETRAS,IMAGEN_FIRMA, LogoATM_variable,NOMBRE_DELEGADO,IMAGEN_FIRMA_DOS,CARGO_DELEGADO,TITULO_PLANTILLAS
--**********************************************************************************
--**********************************************************************************

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'ORDEN_EMBARGO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

begin tran
--update documentos..plantilla set fecha_fin='2022-03-11' where id_plantilla=2080   --2532
update documentos..plantilla set fecha_fin='2024-03-20' where id_plantilla=2611
--TODAS LAS PLANTILLAS DE COACTIVO
update documentos..plantilla set fecha_inicio='2024-07-09' where id_plantilla in(2616,2617,2618,2619,2620,2621,2622,2623,2624,2625,2626,2627,2628,2629,2630,2631,2632,2633,2634,2635,2636,2637,2638,2639,2640,2641,2642)
--update documentos..plantilla set fecha_inicio='2024-04-11' where id_plantilla in(2616,2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)
commit tran



-- Códigos de plantillas afectados "APERT_IMPUG_SIN_TERC APERTURA_IMPUGNACION"
begin tran
update documentos.dbo.plantilla set marca_agua=1
--where id_plantilla in(2612,2611,2610,2609)
where id_plantilla in(2324,2325,2581,2582,2229)--(2616,2617,2618,2619,2620,2621,2622,2623,2624,2625,2626,2627,2628,2629,2630,2631,2632,2633,2634,2635,2636,2637,2638,2639,2640,2641,2642)

commit tran


------------------------------------------------------------------------------------------
--2259 SENTAR_RAZON_EMBARGO No está en la lista

--2624 ORDEN_EMBARGO
--2625 OFICIO_EMBARGO pagina de mas Ok
--2623 ACTA_POSESION_DEP pagina de mas
--2628 COA_DOC_DETER_DEUDA

--Puedo revisar el codigo de la plantilla que se acabo de generar


--************************************REVISIÓN DE LAS PLANTILLAS GENERADAS**************************************************************
select *from [documentos].[dbo].[plantilla] where id_plantilla=2619--2638--2324--2581--2324--2584--2641--2641--2625--4745--2628--4707--2659--2626  --2413--2596--2597  --2324--2596--2413--2596--2597--2685--2663    *
																																	   *
select top 20 *from [documentos].[dbo].[documento] order by 1 desc																	   *
--**************************************************************************************************************************************

select top 100 *from [documentos].[dbo].[documento] where id_plantilla='2608' order by 1 desc


select *from parametro
select upper(nombre) cargo(NOLOCK) where id_cargo==11

select (valor_parametro_defecto) from parametro
where codigo_parametro=434

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select top 5 p.codigo_plantilla from documentos.dbo.documento d
inner join documentos.dbo.plantilla p on d.id_plantilla=p.id_plantilla
order by 1 desc
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
--COACTIVO

--OFICIO_BANCO_CARTA 2616 Presenta error
--OFIC_BAN_CARTA_SEPS 2619 Presenta error


--SENTAR_RAZON_PAGO 2617                                    lista para pruebas
--PROVIDENCIA_RETENCIO 2618                                 lista para pruebas

--PROVIDENCI_RET_SEPS 2620                                  lista para pruebas
--ORDEN_EMBARGO 2624                                        lista para pruebas

--OFICIO_EMBARGO 2625                                       lista para pruebas
--PROVIDENCIA_PAGO_EMB 2626                                 lista para pruebas Ok   https://www.youtube.com/watch?v=M-1sI2atJNM
--PROVIDENCIA_PAGO 2634                                     Lista para pruebas
--PROVIDENCIA_ANULAR 2636                                   Lista para pruebas
--OFICIO_EMBARGO_SEPS 2638                                  Lista para pruebas
--ORDEN_EMBARGO_SEPS 2639                                   Lista Para pruebas

--(2617,2618,2620,2624,2625,2626,2634,2636,2638,2639)


--NOTIFICACION_COAC 2621                                    acomodar
--ACTA_EMBARGO_COACTIV 2622                                 acomodar
--ACTA_POSESION_DEP 2623                                    acomodar
--COA_TITULO_CREDITO 2627                                   Acomodar    
--COA_DOC_DETER_DEUDA 2628                                  Acomodar
--AUTO_PAGO_PATIO 2629                                      Acomodar
--LEV_MED_RET_PAGO_PAR 2630                                 Acomodar
--LEVANTAMIENT_EMBARGO 2631                                 Acomodar
--AUTO_PAGO 2632				                            Acomodar
--ACTA_DE_POSESION 2633                                     Acomodar
--DOC_DETER_DEUDA_COU 2635                                  Acomodar
--LEV_MEDIDA_RETENCION 2637                                  Acomodar
--ACTA_DE_POSESION_P 2640                                    Acomodar
--AUTO_PAGO_PATIO_V2 2641                                    Acomodar
--COA_ORDEN_PAGO_P 2642                                      Acomodar







use circulemos2
select pr.numero_proceso,year(pr.fecha_inicio) año, pr.fecha_inicio, tp.fecha_inicio fecha_estado, tp.id_estado_proceso, ep.nombre estado_proceso
from proceso pr
join trazabilid
-----------------------------------------


--------------------------------------------------------------------------------------------------------------------

--2259 SENTAR_RAZON_EMBARGO No está en la lista

--2624 ORDEN_EMBARGO
--2625 OFICIO_EMBARGO pagina de mas Ok
--2623 ACTA_POSESION_DEP pagina de mas
--2628 COA_DOC_DETER_DEUDA

--https://www.youtube.com/watch?v=OeFKzBwB-i4

--------------------------------------------------------------------------------------------------------------------


--COA_TITULO_CREDITO coactivo
--AUTO_PAGO_PATIO  coactivo
--PROVIDENCIA_PAGO  coactivo
--PROVIDENCIA_ANULAR coactivo
--ACTA_DE_POSESION_P  coactivo
--AUTO_PAGO_PATIO_V2 coactivo
--COA_ORDEN_PAGO_P   coactivo

--PROVIDENCIA_PAGO   coactivo
--COA_TITULO_CREDITO coactivo





--PROVIDENCIA_PAGO 
--PROVIDENCIA_ANULAR


--PROVIDENCIA_PAGO  




----*********************************************
--  * Consejos para la generación de plantillas *
----*********************************************



----***********************************************************************************************************************************************************
--se pueden crear al mismo tiempo
--AUTO_PAGO 2632				                            Acomodar probar  radio button "AUTO DE PAGO" 1:30  https://www.youtube.com/watch?v=qLKO0mnxLEE
--ACTA_DE_POSESION 2633                                     Acomodar probar radio button "AUTO DE PAGO"  1:30   https://www.youtube.com/watch?v=qLKO0mnxLEE
--NOTIFICACION_COAC 2621    leerrrr                          acomodar probar   radio button "ENVIO NOTIFICACION"1:30  https://www.youtube.com/watch?v=qLKO0mnxLEE aunque no aparece en el video se está generando

----***********************************************************************************************************************************************************



----***********************************************************************************************************************************************************
---Se generan al tiempo con el mismo dato

--ACTA_DE_POSESION_P  autopago  <radio button> coactivo acta de posicion  ACTA_DE_POSESION_P OK   parece que falta algo en la firma https://www.youtube.com/watch?v=1RRltFt0Iss
--AUTO_PAGO_PATIO_V2 autopago <radio button> coactivo autopago		https://www.youtube.com/watch?v=1RRltFt0Iss
--COA_ORDEN_PAGO_P  Radicar cobro coactivo  https://www.youtube.com/watch?v=1RRltFt0Iss
--AUTO_PAGO_PATIO Envio de notificacion   https://www.youtube.com/watch?v=1RRltFt0Iss

--DOC_DETER_DEUDA_COU y COA_TITULO_CREDITO se pueden crear al mismo tiempo

----***********************************************************************************************************************************************************

--Faltantes
--ACTA_EMBARGO_COACTIV
--LEV_MED_RET_PAGO_PAR
--LEVANTAMIENT_EMBARGO



------------------------------------------------------------------------------------
--Query para traer esté texto
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.
SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439


,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS

--TITULO_PLANTILLAS
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL EP.


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




--************************************************************************************
------------------------------------------------------------------------------------


--COA_TITULO_CREDITO
--PRECOACTIVOS VÁLIDOS PARA COURIER - TÍTULO CRÉDITO   datos para generar está plantilla
select pp.*, t.* from precoactivo p
inner join periodo_precoactivo pp on pp.id_precoactivo=p.id_precoactivo
inner join titulo_credito t on t.id_periodo_precoactivo=pp.id_periodo
where  p.id_estado_vehiculo_patio=2
and pp.estado_periodo in('activo','inactivo')
and t.fecha_notificacion is null 
and fecha_notificacion_titulo is null
and exists (select * from integracion_terceros..ubicabilidad_courier_validada u where u.id_persona=p.id_deudor)
and (select top 1 estado_periodo from periodo_precoactivo where id_precoactivo=pp.id_precoactivo and estado_periodo<>'ANULADO' order by id_periodo desc) = 'activo' 
order by pp.id_precoactivo desc

--Formato cargue courier
--Numero servicio;Numero periodo
--GP-220230085236;2

--------------------------------------------------------------

--COA_ORDEN_PAGO_P https://www.youtube.com/watch?v=evJbQ-vznzA

-- Lanzar el job: JobProcesarCoactivoPatios

--CONSULTA QUE HACE EL JOB DE COACTIVO PATIOS
select distinct top(1000) p.*,per.*,t.idProceso, pp.id_periodo from precoactivo p 
inner join periodo_precoactivo pp on pp.id_precoactivo=p.id_precoactivo
inner join titulo_credito t on t.id_periodo_precoactivo=pp.id_periodo
inner join persona per on per.id_persona=p.id_deudor 
where /*t.fecha_notificacion is not null and*/ pp.estado_periodo in ('activo','inactivo')
/*and pp.fecha_notificacion_titulo is not null*/ and idCoactivo=0 and id_estado_vehiculo_patio=2
and cast(GETDATE() as date)>=(select dbo.sumar_dias_habiles(t.fecha_notificacion,8))
and (select top 1 estado_periodo from periodo_precoactivo where id_precoactivo=pp.id_precoactivo and estado_periodo<>'ANULADO' order by fecha_fin_periodo desc) = 'activo'
order by p.id_precoactivo asc
update periodo_precoactivo set fecha_notificacion_titulo='2024-05-01' where id_periodo=46759
update titulo_credito set fecha_notificacion='2024-05-01' where id_periodo_precoactivo=46759
 
select top 1000 * from coactivo c
join proceso p on c.id_proceso=p.id_proceso 
join trazabilidad_proceso tp on p.id_proceso=tp.id_proceso and tp.id_estado_proceso=24 and tp.fecha_fin is null 
where id_tipo_coactivo=4 
--and tp.id_estado_proceso=70 
order by tp.fecha_inicio desc




















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
 where nombre1 ='Xavier'
--where nombre1 ='ALEXIS'  

--------------------------------------------------------
select *from funcionario_coactivo f
join persona p on f.id_persona=p.id_persona
 where nombre2 ='Xavier'
--------------------------------------------------------
--ABG.
select nombre1,nombre2, id_funcionario,apellido1,titulo_obtenido
from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1='Beudys ' and nombre2 ='Xavier' 
--------------------------------------------------------

begin tran
update funcionario 
set titulo_obtenido='ABG.'
where id_funcionario=55--182--154 conny y alexis no tienen cargo
commit  tran
--------------------------------------------------


--------------------------------------------------------
--ABG.
select 
--nombre1,nombre2, id_funcionario,apellido1,titulo_obtenido
*from funcionario_coactivo f
join persona p on f.id_persona=p.id_persona
where nombre1='Francisco ' and nombre2 ='Xavier' 
--------------------------------------------------------

begin tran
update funcionario_coactivo 
set titulo_obtenido='Abg. Esp.'
where id_funcionario=24--154 conny y alexis no tienen cargo
commit  tran
--------------------------------------------------