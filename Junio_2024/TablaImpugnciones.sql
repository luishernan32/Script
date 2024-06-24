select *from circulemos2.dbo.reconstr_docs_impugnaciones

-- observacion_estado_impugnacion  observacion_estado_enviado_evaluacion, observacion_estado_cierre_prueba, observacion_estado_cerrado


USE [Documentos]

alter table reconstr_docs_impugnaciones add observaciones varchar(200);

ALTER TABLE reconstr_docs_impugnaciones
DROP COLUMN observaciones;



alter table reconstr_docs_impugnaciones add observacion_estado_impugnacion varchar(200);
alter table reconstr_docs_impugnaciones add observacion_estado_enviado_evaluacion varchar(200);
alter table reconstr_docs_impugnaciones add observacion_estado_cierre_prueba varchar(200);
alter table reconstr_docs_impugnaciones add observacion_estado_cerrado varchar(200);




