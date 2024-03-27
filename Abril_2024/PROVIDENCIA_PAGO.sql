--INSERT DE PAGOS TDC
INSERT INTO integracion_terceros.dbo.it_recaudo (codigo_organismo ,fecha_transaccion ,hora_transaccion ,numero_recaudo ,numero_cuenta ,codigo_tipo_cuenta,
codigo_banco ,total_efectivo ,total_cheque ,total_recaudo, codigo_tipo_identificacion ,numero_identificacion ,estado_lectura ,numero_obligacion,
valor_obligacion ,numero_cuota ,codigo_tipo_recaudo ,fecha_creacion ,usuario,total_tcr) VALUES
(11001,'2023-11-28' ,'08:08:00.0000000',6776767681199, --nro recaudo ir aumentando, que no se repita
NULL,NULL,'BPA',
NULL, --total pago
NULL,35.19, --total pago
NULL,NULL,1,10398042, --factura finan --4007661 3087948
35.19, --total pago
0, --cuota
'02', -- tipo recaudo -- 01 recaudo de citacion 02 coactivo 05 recaudo de patios
getdate(),
'axis',
35.19) ---total_tcr
-------------------------------------------------------------------------------------

--Para sacar el dato la consulta es ésta:
select top 10000 pe.numero_identificacion, numero_coactivo, numero_obligacion, co.fecha_notificacion,c.id_tramite, op.nombre,co.codigo_medio_imposicion, * from proceso p
--inner join trazabilidad_proceso tp on tp.id_proceso=p.id_proceso and tp.id_estado_proceso=38
inner join coactivo c on p.id_proceso=c.id_proceso
inner join obligacion_coactivo oc on c.id_coactivo=oc.id_coactivo
inner join persona pe on c.id_deudor=pe.id_persona
inner join comparendo co on convert(varchar,co.id_factura_axis)=oc.numero_obligacion
inner join configuracion_infraccion ci on co.id_infraccion=ci.id_infraccion
inner join ordenamiento_pais op on ci.id_ordenamiento_pais=op.id_ordenamiento_pais
--inner join cartera ca on ca.nombre=co.id_factura_axis
where p.id_estado_proceso in(29) and anio=2021
--and ci.id_ordenamiento_pais=2
and c.id_tipo_coactivo=1
and c.cantidad_obligaciones=1
--and c.fecha_notificacion is null
--and oc.valor_interes_moratorios0
--and oc.valor_costas_procesales0
and ci.fecha_fin_vigencia is null
--and exists (select * from obligacion_coactivo_historico och where och.id_obligacion_coactivo=oc.id_obligacion_coactivo)
and not exists (select 1 from circulemos2.dbo.trazabilidad_proceso tp where tp.id_proceso = p.id_proceso and tp.id_estado_proceso = 36)
order by p.fecha_inicio desc

------------------------------------------------------------------------------------

--INSERT DE PAGOS TDC
INSERT INTO integracion_terceros.dbo.it_recaudo (codigo_organismo ,fecha_transaccion ,hora_transaccion ,numero_recaudo ,numero_cuenta ,codigo_tipo_cuenta,
codigo_banco ,total_efectivo ,total_cheque ,total_recaudo, codigo_tipo_identificacion ,numero_identificacion ,estado_lectura ,numero_obligacion,
valor_obligacion ,numero_cuota ,codigo_tipo_recaudo ,fecha_creacion ,usuario,total_tcr) VALUES
(11001,'2024-03-27' ,'08:08:00.0000000',67767776812201, --nro recaudo ir aumentando, que no se repita
NULL,NULL,'BPA',
NULL, --total pago
NULL,35.19, --total pago
NULL,NULL,1,10398351, --factura finan --4007661 3087948
35.19, --total pago
0, --cuota
'02', -- tipo recaudo -- 01 recaudo de citacion 02 coactivo 05 recaudo de patios
getdate(),
'axis',
35.19) ---total_tcr

-----------------------------------------------------------------------------------------------------------

(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436)                         AS cargo_delegado

select top 100 *from coactivo order by 1 desc