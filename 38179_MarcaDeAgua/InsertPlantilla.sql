--INSERT DE PAGOS TDC
INSERT INTO integracion_terceros.dbo.it_recaudo (codigo_organismo ,fecha_transaccion ,hora_transaccion ,numero_recaudo ,numero_cuenta ,codigo_tipo_cuenta,
codigo_banco ,total_efectivo ,total_cheque ,total_recaudo, codigo_tipo_identificacion ,numero_identificacion ,estado_lectura ,numero_obligacion,
valor_obligacion ,numero_cuota ,codigo_tipo_recaudo ,fecha_creacion ,usuario,total_tcr) VALUES
(11001,'2024-08-06' ,'08:08:00.0000000',6767676812600, --nro recaudo ir aumentando, que no se repita
NULL,NULL,'BPA',
NULL, --total pago
NULL,21.0, --total pago
NULL,NULL,1,10396782, --factura finan --4007661 3087948 --
21.0, --total pago
0, --cuota
'02', -- tipo recaudo -- 01 recaudo de citacion 02 coactivo 05 recaudo de patios
getdate(),
'axis',
21.0) ---total_tcr


select *from persona 
where id_persona=245960




