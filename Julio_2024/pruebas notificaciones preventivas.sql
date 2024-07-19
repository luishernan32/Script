
select * from integracion_terceros ..it_multa where estado_lectura=8

--************************Lo que tengo por ejecutar******************************
BEGIN TRAN
UPDATE integracion_terceros.dbo.it_multa
set estado_lectura = 8,
codigo_estado_comparendo = 'AVISO'
where id_factura_axis = 14060525
COMMIT TRAN
--************************************************************************



--Lo que llega al correo
--Ubicación: G.SUR COOP. UNION DE BANANEROS BL.1 MZ. 1 SL#17
--Lugar del evento: METROVIA PARADA SAGRADA FAMILIA SURNORTE



--direccion_basica_infractor
--G.SUR COOP. UNION DE BANANEROS BL.1 MZ. 1 SL#17

--direccion_basica_infraccion
--METROVIA   PARADA SAGRADA FAMILIA SURNORTE

--direccion_basica_infractor==Ubicación                          Sale la dirección de la persona
--direccion_basica_infraccion==Lugar del evento

select direccion_basica_infractor, 
direccion_basica_infraccion,
latitud_direccion_infraccion,
direccion_basica_patio
from 
integracion_terceros ..it_multa where estado_lectura=8


select distinct estado_lectura from integracion_terceros ..it_multa 
begin tran
update integracion_terceros ..it_multa set estado_lectura = 101 where estado_lectura=8
commit tran
--multa bloqueada
--2719601


select * from integracion_terceros.dbo.it_multa where id_multa=2730374
update integracion_terceros ..it_multa set estado_lectura=8 where id_multa = 2730374
update integracion_terceros ..it_multa set estado_lectura=101 where id_multa = 2719601



--14060525
BEGIN TRAN
UPDATE integracion_terceros.dbo.it_multa
set estado_lectura = 8,
codigo_estado_comparendo = 'AVISO'
where id_factura_axis = 2993964
COMMIT TRAN
--Probadas
--1Mer Caso 14060525
--L15 correcto 14060525
--O35 correcto 10417169
--O03 correcto 2811576
--2do Caso
--O01 correcto 3305942
--O34 correcto 10388914
--3cer Caso 
--O02 correcto id_factura_axis = 2985015
--O33 correcto id_factura_axis = 10196735
--4to Caso
--O05 correcto id_factura_axis = 10436842
--O06 Error Servicio no genera documento en base64 para las multas O06 id_factura_axis = 14058462  -- ProcesaComparendoEJB.java linea 729 -- webservice GENERACION_DOCUMENTO_AVISO(76)
--5to Caso
--O07 correcto id_factura_axis = 9940881
--6to Caso
--O10 correcto id_factura_axis = 3443093
--7mo Caso
--O08 No hay O08
--8Vo Caso
--O09 correcto id_factura_axis = 9401883
--9no Caso
--O23 correcto id_factura_axis = 14056830
-- PRUEBA PERSONA JURIDICA
-- correcto id_factura_axis = 13666030
select top 100 id_factura_axis, fecha_infraccion, i.codigo_infraccion, i.codigo_estado_comparendo from integracion_terceros.dbo.it_multa i
where not exists (select 1 from circulemos2.dbo.comparendo c where c.id_factura_axis= i.id_factura_axis )
and codigo_infraccion = 'O02'
order by i.fecha_infraccion desc;

begin tran
update circulemos2.dbo.comparendo set fecha_infraccion = '2024-04-01 00:00:00.000' where id_factura_axis=10399467
commit

--update circulemos2.dbo.comparendo 

select id_multa,fecha_infraccion, estado_lectura, numero_identificacion_infractor,id_factura_axis,codigo_estado_comparendo, codigo_infraccion
from integracion_terceros.dbo.it_multa where id_factura_axis = 10388917

select * from integracion_terceros.dbo.it_multa
where id_factura_axis = 14060525;
 
select * from circulemos2.dbo.persona where numero_identificacion = '0918155086' --0918155086
select * from circulemos2.dbo.persona where id_persona = 8765
select * from circulemos2.dbo.correo_persona where id_persona = 8765

select * from circulemos2.dbo.persona where id_persona = 4236556
--delete from circulemos2.dbo.persona where id_persona = 4236556

update circulemos2.dbo.correo_persona set estado=null where id_persona=119315
update circulemos2.dbo.correo_persona set estado=1 where id_correo_persona=2972865
update circulemos2.dbo.correo_persona set correo_electronico='.' where id_correo_persona=2972865



update circulemos2.dbo.correo_persona set correo_electronico = 'luis.pineda@datatools.com.co', 
fecha_actualizacion = GETDATE(), estado=1 where id_correo_persona=2972865


update circulemos2.dbo.correo_persona set correo_electronico = 'luishernan22@gmail.com', 
fecha_actualizacion = GETDATE(), estado=1 where id_correo_persona=2972865
--inactivo 0, activo 1

select top 10 id_multa,fecha_infraccion, estado_lectura, numero_identificacion_infractor,id_factura_axis,codigo_estado_comparendo, codigo_infraccion, razon_social_infractor, razon_social_empresa, razon_social_propietario
from integracion_terceros.dbo.it_multa where numero_identificacion_infractor='1801577642001'
order by 1 desc

select * from integracion_terceros.dbo.it_multa 
--where numero_identificacion_infractor='1801577642001'
where id_factura_axis=14060525
order by 1 desc

--************************Lo que tengo por ejecutar******************************
BEGIN TRAN
UPDATE integracion_terceros.dbo.it_multa
set estado_lectura = 8,
codigo_estado_comparendo = 'AVISO'
where id_factura_axis = 14060525
COMMIT TRAN
--************************************************************************
select * from integracion_terceros.dbo.V_EVIDENCIA_INFRACCIONES 
where NUMERO_FACTURA = 14060525 --14060525

select * from circulemos2.dbo.descripcion_articulo





select *from correo_envio


select * from circulemos2.dbo.configuracion_email where id_configuracion = 50
select * from circulemos2.dbo.tipo_email where codigo_tipo_email = 43


--nombre_completo_persona, lugarInfraccion, asunto_cuerpo_texto, parrafo, fechaInfraccion, lugarInfraccion

--NOTIFICACIÓN PREVENTIVA


