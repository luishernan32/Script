SET language 'Spanish';

SELECT proceso.expediente,
       proceso.nombre_infractor,
       (SELECT Concat('Ab. ', Upper(Concat (pf.nombre1, ' ', pf.nombre2, ' ',
                                    pf.apellido1, ' '
                                            ,
                              pf.apellido2))) AS nombre
        FROM   funcionario f
               INNER JOIN persona pf
                       ON pf.id_persona = f.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_final_vigencia IS NULL)
       AS funcionario,
'DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO' AS
CARGO_DELEGADO,
delegado.nombre,
(SELECT im.numero_imagen
 FROM   imagen im
 WHERE  im.id_tipo_imagen = 1
        AND fecha_fin IS NULL)
       logoATM,
delegado.firmaagente,
CONVERT(VARCHAR, Day(Getdate())) + ' de '
+ CONVERT(VARCHAR, Datename(month, Getdate()))
+ ' de ' + CONVERT(VARCHAR, Year(Getdate()))
+ ', a las '
+ CONVERT(VARCHAR, Datepart(hour, Getdate()))
+ 'h'
+ CONVERT(VARCHAR, Datepart(minute, Getdate()))                            AS
       fechaSolicitud,
(SELECT TOP 1 mi.documento_faltante
 FROM   trazabilidad_proceso trz
        INNER JOIN motivacion_impugnacion mi
                ON mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso
 WHERE  trz.id_proceso = proceso.id_proceso
 ORDER  BY fecha_inicio DESC)
       desc_motivacion,
(SELECT valor_parametro_defecto
 FROM   parametro(nolock)
 WHERE  codigo_parametro = 439)                                            AS
       TITULO_PLANTILLAS,


 (
    SELECT 
      valor_parametro_defecto 
    FROM 
      parametro(nolock) 
    WHERE 
      codigo_parametro = 439
  ) AS TITULO_PLANTILLAS, 
  (
    select 
      (
        Concat (
          f.memo_nombramiento, ', de fecha  ', 
          f.fecha_nombramiento
        )
      ) 
    from 
      usuario_persona up 
      join funcionario f on f.id_persona = up.id_persona 
    where 
      f.id_persona = delegado.id_persona
  ) AS fecha_nombramiento


FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + ' - '
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN '2' THEN pj.nombre_comercial
                 ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                            pe.apellido1, ' '
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
        WHERE  pr.id_proceso 
		=1865701-- 
		--= :idproceso
		) proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,fu.id_persona,
                     Upper(Concat (fu.titulo_obtenido,' ',nombre1, ' ', nombre2, ' ', apellido1, ' ',
                           apellido2)) AS nombre
        FROM   persona p
               LEFT JOIN firma_persona fa
                      ON fa.id_persona = p.id_persona
			  LEFT JOIN funcionario fu
					ON fu.id_persona=p.id_persona
        WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                                FROM   funcionario
                                WHERE  id_cargo = 6
                                       AND fecha_final_vigencia IS NULL
									   AND id_subcargo = 4
                                ORDER  BY Newid()
								)
        ORDER  BY fa.fecha_registro DESC) delegado