SELECT Max(fp.numero_imagen)
 FROM   trazabilidad_proceso tpcrr (nolock)
        LEFT JOIN usuario_persona up1 (nolock)
               ON up1.id_usuario = tpcrr.id_usuario
        LEFT JOIN persona pab (nolock)
               ON pab.id_persona = up1.id_persona
        INNER JOIN firma_persona fp
                ON fp.id_persona = pab.id_persona
        LEFT JOIN funcionario fu (nolock)
               ON fu.id_persona = pab.id_persona
 WHERE  tpcrr.id_proceso = 84819--20616--18163--:idProceso
        AND tpcrr.id_estado_proceso = 4



20616
15725
72697
39238
84819


SELECT TOP 1 Concat(p.nombre1, ' ', p.nombre2, ' ', p.apellido1, '         ',
              p.apellido2), tp.id_proceso
 FROM   trazabilidad_proceso tp (nolock)
        INNER JOIN usuario_persona up (nolock)
                ON up.id_usuario = tp.id_usuario
        LEFT JOIN persona p (nolock)
               ON p.id_persona = up.id_persona
        LEFT JOIN firma_persona fp (nolock)
               ON fp.id_persona = p.id_persona
 WHERE  tp.id_estado_proceso IN ( 3, 14 )
        AND tp.id_proceso is not null --= pr.id_proceso
 ORDER  BY tp.fecha_inicio DESC                -- AS nombreSecretario,

 select *from trazabilidad_proceso


 SELECT Max(fp.numero_imagen)
 FROM   trazabilidad_proceso tpcrr (nolock)
        LEFT JOIN usuario_persona up1 (nolock)
               ON up1.id_usuario = tpcrr.id_usuario
        LEFT JOIN persona pab (nolock)
               ON pab.id_persona = up1.id_persona
        INNER JOIN firma_persona fp
                ON fp.id_persona = pab.id_persona
        LEFT JOIN funcionario fu (nolock)
               ON fu.id_persona = pab.id_persona

 WHERE  tpcrr.id_proceso is not null---= :idProceso
        AND tpcrr.id_estado_proceso = 4          --AS numero_imagen,

WHERE  tp.id_estado_proceso IN ( 3, 14 )
        AND tp.id_proceso is not null --= pr.id_proceso
 ORDER  BY tp.fecha_inicio DESC                -- AS nombreSecretario,


 select *from estado_proceso