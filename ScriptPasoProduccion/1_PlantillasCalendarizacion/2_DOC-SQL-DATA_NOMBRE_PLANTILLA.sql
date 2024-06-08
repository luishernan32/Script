USE documentos
BEGIN TRANSACTION;  
  
BEGIN TRY  

-- Declaraciones
declare @fechaFin as varchar(10),
@fechaInicio as varchar(10)

set @fechaInicio = '2024-06-04'	-- Fecha siguiente
set @fechaFin = '2024-06-03' -- Fecha actual


declare @idP as int
set @idP = (select max(id_plantilla) from plantilla) + 1


update documentos.dbo.plantilla
set fecha_fin = @fechaFin
where id_plantilla = 2410;


SET IDENTITY_INSERT plantilla ON

INSERT INTO "plantilla" ("id_plantilla", "codigo_plantilla", "id_proceso", "nombre_plantilla", "version_plantilla", "fecha_inicio", "fecha_fin", "fecha_creacion", "id_usuario", "plantilla_bloqueada", "id_plantilla_origen", "jasper_studio") VALUES (@idP, 'ACT_PERSONA_JUR', 6, 'Actualizar_Ubicabilidad Juridica', 4,convert(date, @fechaInicio) , NULL, convert(date, @fechaInicio), 90, 0, 16, 0);

SET IDENTITY_INSERT plantilla OFF

UPDATE  "plantilla_configuracion" 
SET consulta = 'SELECT
  p.numero_identificacion,
  tip.codigo,
  UPPER(pj.nombre_comercial) AS NombreComercial,
  dbo.direccionPersona(p.id_persona, DEFAULT) AS Direccion,
  mo.nombre
FROM persona p
JOIN persona_juridica pj
  ON pj.id_persona_juridica = p.id_persona
WHERE p.id_persona = :idPersona',
orden_variables = 'DOCUMENTO_INFRACTOR,T_DOCUMENTO_INFRACTOR,NOMBRE_COMERCIAL'
where  id_plantilla_config = 6


INSERT INTO "variable_plantilla" ("id_plantilla", "id_variable") VALUES (@idP, 99);
INSERT INTO "variable_plantilla" ("id_plantilla", "id_variable") VALUES (@idP, 102);
INSERT INTO "variable_plantilla" ("id_plantilla", "id_variable") VALUES (@idP, 230);
INSERT INTO "variable_plantilla" ("id_plantilla", "id_variable") VALUES (@idP, 1387);
INSERT INTO "variable_plantilla" ("id_plantilla", "id_variable") VALUES (@idP, 1395);


INSERT INTO "jasper_plantilla" ( "id_plantilla", "codigo_documento") VALUES (@idP, (select max(gdd.codigo_documento) from gestor_docs..data_documento gdd where gdd.nombre = 'ACT_PERSONA_JUR.jasper'));
INSERT INTO "jasper_plantilla" ( "id_plantilla", "codigo_documento") VALUES (@idP, (select max(gdd.codigo_documento) from gestor_docs..data_documento gdd where gdd.nombre = 'ACT_PERSONA_JUR.jasper'));


INSERT INTO "xml_plantilla" ("id_xml_plantilla", "nombre_xml_plantilla", "contenido_xml_plantilla", "id_xml_plantilla_padre", "codigo_documento_html") VALUES (@idP, 'Actualizar_Ubicabilidad Juridica', 0x3c68746c3e, NULL, NULL);


END TRY  
BEGIN CATCH  
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;  
 
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;   

GO  
