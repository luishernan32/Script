select nombre_variable, id_variable  from documentos..variable
where nombre_variable in
('NOMBRE_INFRACTOR',
'PLACA_VEHICULO',
'CORREO_ELECTRONICO_INFRACTOR',
'FECHA_IMPOSICION_COMPARENDO',
'HORA_IMPOSICION_COMPARENDO',
'anio_apertura_proceso',
'numero_consecutivo',
'numero_citacion',
'fecha_actual',
'fecha_apertura_impug',
'hora_actual',
'consi_juridica',
'logoATM',
'DOCUMENTO_INFRACTOR',
'NOMBRE_FUNCIONARIO',
'IMAGEN_FIRMA',
'NOMBRE_DELEGADO',
'MEMO_DELEGADO',
'FECHA_DELEGADO',
'CARGO_DELEGADO',
'Logo_ATM_Alcaldia'

)