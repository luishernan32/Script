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
 WHERE  tpcrr.id_proceso is not null --= :idProceso
        AND tpcrr.id_estado_proceso 
		--= 4 
		IN ( 3, 14 )



--259167816

select *from firma_persona
where numero_imagen=122903

select *from persona
where id_persona=455543



select *from trazabilidad_proceso

SELECT TOP 10(fp.numero_imagen)
 FROM   trazabilidad_proceso tpcrr (nolock)
        LEFT JOIN usuario_persona up1 (nolock)
               ON up1.id_usuario = tpcrr.id_usuario
        LEFT JOIN persona pab (nolock)
               ON pab.id_persona = up1.id_persona
        INNER JOIN firma_persona fp
                ON fp.id_persona = pab.id_persona
        LEFT JOIN funcionario fu (nolock)
               ON fu.id_persona = pab.id_persona
 WHERE fp.numero_imagen=122903 

 select *from trazabilidad_proceso


SELECT Max(fp.numero_imagen)
 FROM   trazabilidad_proceso tp (nolock)
        INNER JOIN usuario_persona up (nolock)
                ON up.id_usuario = tp.id_usuario
        LEFT JOIN persona p (nolock)
               ON p.id_persona = up.id_persona
        LEFT JOIN firma_persona fp (nolock)
               ON fp.id_persona = p.id_persona
 WHERE  WHERE fp.numero_imagen=122903


 SELECT top 10(fp.numero_imagen)
 FROM   trazabilidad_proceso tp (nolock)
        INNER JOIN usuario_persona up (nolock)
                ON up.id_usuario = tp.id_usuario
        LEFT JOIN persona p (nolock)
               ON p.id_persona = up.id_persona
        LEFT JOIN firma_persona fp (nolock)
               ON fp.id_persona = p.id_persona
   WHERE fp.numero_imagen=13751        


------------------------------------------------------------------------------------------------------------


select TOP 1 CONCAT(f.titulo_obtenido, '' '', p.nombre1, '' '', p.nombre2, '' '', p.apellido1, '' '', p.apellido2)               
from funcionario f        
join persona p on f.id_persona=p.id_persona        
where id_cargo=11 and fecha_final_vigencia is null   


select TOP 1               
*from funcionario f        
join persona p on f.id_persona=p.id_persona        
where id_cargo=4 and fecha_final_vigencia is null 

select nombre1,nombre2,numero_firma            
from funcionario f        
join persona p on f.id_persona=p.id_persona        
where id_cargo=4 and fecha_final_vigencia is null 



select nombre1,nombre2,numero_firma            
from funcionario f        
join persona p on f.id_persona=p.id_persona
join firma_persona fp on fp.id_persona=f.id_persona
where id_cargo=4 and fecha_final_vigencia is null
and  fp.numero_imagen=258081616

select *from cargo

select *from firma_persona
where numero_imagen=258081616

select *from persona
where id_persona=5181533



--258081616

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
 WHERE  tpcrr.id_proceso is not null
        AND tpcrr.id_estado_proceso = 4

-------------------------------------------------------

SELECT fp.numero_imagen
 FROM   trazabilidad_proceso tpcrr (nolock)
        LEFT JOIN usuario_persona up1 (nolock)
               ON up1.id_usuario = tpcrr.id_usuario
        LEFT JOIN persona pab (nolock)
               ON pab.id_persona = up1.id_persona
        INNER JOIN firma_persona fp
                ON fp.id_persona = pab.id_persona
        LEFT JOIN funcionario fu (nolock)
               ON fu.id_persona = pab.id_persona
 WHERE  tpcrr.id_proceso is not null
        AND tpcrr.id_estado_proceso = 4    
		

select *from proceso
