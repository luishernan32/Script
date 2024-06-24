--SENTAR_RAZON_EMBARGO    

SELECT TOP 1   tipoid.codigo AS 'Tipo Identificacion',   per.numero_identificacion AS 'Numero identificacion',   case per.id_tipo_identificacion when 2 then UPPER(perj.nombre_comercial) else UPPER(CONCAT(per.nombre1,' ',per.nombre2,' ',per.apellido1,' ', per.apellido2))  end AS nombre,   (select top 1 Upper(Concat (p.nombre1, ' ', p.nombre2, '  ', p.apellido1, ' ', p.apellido2))     from funcionario f inner join firma_persona fp on fp.id_persona = f.id_persona  inner join persona p on p.id_persona= f.id_persona     WHERE  f.id_subcargo =3) AS abogado,   'Secretario ad hoc' cargo,   (select top 1 fp.numero_imagen    from funcionario f inner join firma_persona fp on fp.id_persona = f.id_persona  inner join persona p on p.id_persona= f.id_persona    WHERE f.id_subcargo =3) AS firmaAbogado,   (select numero_imagen from "imagen" where "id_tipo_imagen" in(SELECT id_tipo_imagen FROM tipo_imagen WHERE codigo = 'LOGGO' ) AND fecha_fin is null) AS logoATM  FROM coactivo c left join     persona per on per.id_persona= c.id_deudor left join    persona_juridica perj on perj.id_persona_juridica = c.id_deudor inner join    proceso p on p.id_proceso = c.id_proceso left join    tipo_identificacion_persona tipoid on tipoid.id_tipo_identificacion = per.id_tipo_identificacion  WHERE c.id_coactivo =:idcoactivo
--T_DOCUMENTO_INFRACTOR,N_DOCUMENTO_INFRACTOR,NOMBRE_COMPLETO,DELEGADO_TITULONOMBRE_,CARGO_DELEGADO,FIRMA_FUNCIONARIO_,LogoATM_variable


,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS





--SENTAR_RAZON_EMBARGO 10120
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   ''               
	   , orden_variables=',TITULO_PLANTILLAS'
WHERE  id_plantilla_config= 10120

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'REGISTRO_FALLO_CAL';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
-------------------------------------------------------------------------------------
--Modificada

SELECT TOP 1 tipoid.codigo                  AS 'Tipo Identificacion',
             per.numero_identificacion      AS 'Numero identificacion',
             CASE per.id_tipo_identificacion
               WHEN 2 THEN Upper(perj.nombre_comercial)
               ELSE Upper(
             Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
                    per.apellido2))
             END                            AS nombre,
             (SELECT TOP 1 Upper(Concat (p.nombre1, ' ', p.nombre2, '  ',
                                 p.apellido1, ' ',
                                 p.apellido2))
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)     AS abogado,
             'Secretario ad hoc'            cargo,
             (SELECT TOP 1 fp.numero_imagen
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)     AS firmaAbogado,
             (SELECT numero_imagen
              FROM   "imagen"
              WHERE  "id_tipo_imagen" IN(SELECT id_tipo_imagen
                                         FROM   tipo_imagen
                                         WHERE  codigo = 'LOGGO')
                     AND fecha_fin IS NULL) AS logoATM
FROM   coactivo c
       LEFT JOIN persona per
              ON per.id_persona = c.id_deudor
       LEFT JOIN persona_juridica perj
              ON perj.id_persona_juridica = c.id_deudor
       INNER JOIN proceso p
               ON p.id_proceso = c.id_proceso
       LEFT JOIN tipo_identificacion_persona tipoid
              ON tipoid.id_tipo_identificacion = per.id_tipo_identificacion
WHERE  c.id_coactivo = :idcoactivo 

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Original


SELECT TOP 1 tipoid.codigo                  AS 'Tipo Identificacion',
             per.numero_identificacion      AS 'Numero identificacion',
             CASE per.id_tipo_identificacion
               WHEN 2 THEN Upper(perj.nombre_comercial)
               ELSE Upper(
             Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
                    per.apellido2))
             END                            AS nombre,
             (SELECT TOP 1 Upper(Concat (p.nombre1, ' ', p.nombre2, '  ',
                                 p.apellido1, ' ',
                                 p.apellido2))
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)     AS abogado,
             'Secretario ad hoc'            cargo,
             (SELECT TOP 1 fp.numero_imagen
              FROM   funcionario f
                     INNER JOIN firma_persona fp
                             ON fp.id_persona = f.id_persona
                     INNER JOIN persona p
                             ON p.id_persona = f.id_persona
              WHERE  f.id_subcargo = 3)     AS firmaAbogado,
             (SELECT numero_imagen
              FROM   "imagen"
              WHERE  "id_tipo_imagen" IN(SELECT id_tipo_imagen
                                         FROM   tipo_imagen
                                         WHERE  codigo = 'LOGGO')
                     AND fecha_fin IS NULL) AS logoATM
FROM   coactivo c
       LEFT JOIN persona per
              ON per.id_persona = c.id_deudor
       LEFT JOIN persona_juridica perj
              ON perj.id_persona_juridica = c.id_deudor
       INNER JOIN proceso p
               ON p.id_proceso = c.id_proceso
       LEFT JOIN tipo_identificacion_persona tipoid
              ON tipoid.id_tipo_identificacion = per.id_tipo_identificacion
WHERE  c.id_coactivo = :idcoactivo 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
