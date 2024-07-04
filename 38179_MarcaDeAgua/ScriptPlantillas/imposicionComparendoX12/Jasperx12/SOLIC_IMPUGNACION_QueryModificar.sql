  --Query new para ingresar memo y fecha


select /*up.*, id_cargo, id_subcargo*/* from usuario_persona up 
join funcionario f on f.id_persona=up.id_persona
where f.id_cargo in (6)
--and f.id_subcargo=4
and fecha_final_vigencia is null
--and codigo_proceso=1

select f.memo_nombramiento,
f.fecha_nombramiento from usuario_persona up 
join funcionario f on f.id_persona=up.id_persona
where f.id_cargo in (6)
--and f.id_subcargo=4
and fecha_final_vigencia is null



select (Concat (f.memo_nombramiento,', de fecha  ',
f.fecha_nombramiento))
 from usuario_persona up 
join funcionario f on f.id_persona=up.id_persona
where f.id_cargo in (6)
and f.id_subcargo=4
and fecha_final_vigencia is null
and codigo_proceso=1

select (Concat (fu.memo_nombramiento,', de fecha  ',
fu.fecha_nombramiento))
 from usuario_persona up 
join funcionario f on f.id_persona=up.id_persona
where f.id_cargo =6




(SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (fu.titulo_obtenido,' hhhhh',p.nombre1, ' ', nombre2, ' ', apellido1, ' ',
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
                              --  ORDER  BY Newid()
								)
        --ORDER  BY fa.fecha_registro DESC
		)-- delegado 





(Concat (fu.memo_nombramiento,', de fecha  ',
fu.fecha_nombramiento))

(SELECT TOP 1 --fa.numero_imagen
                     --firmaAgente,
                     Concat (fu.memo_nombramiento,', de fecha  ',
            fu.fecha_nombramiento) AS nombre
						   
						   

       
	   FROM   persona p
               LEFT JOIN firma_persona fa
                      ON fa.id_persona = p.id_persona
			   LEFT JOIN funcionario fu
					ON fu.id_persona=p.id_persona
        WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                                FROM   funcionario 
                                WHERE  id_cargo = 6
                                       AND fecha_final_vigencia IS NULL
                              --  ORDER  BY Newid()
								))


-----------------------------------------------------------------


------------------------------------------------------------------
------------------------------------------------------------------
(SELECT TOP 1 Concat (fu.memo_nombramiento, ', de fecha  ',
              fu.fecha_nombramiento) AS nombre
 FROM   persona p
        LEFT JOIN firma_persona fa
               ON fa.id_persona = p.id_persona
        LEFT JOIN funcionario fu
               ON fu.id_persona = p.id_persona
 WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                         FROM   funcionario
                         WHERE  id_cargo = 6
                                AND fecha_final_vigencia IS NULL)) 

------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------





------------------------------------------------------------------





--------------------------------------------------------
--ABG.
select nombre1,nombre2, id_funcionario,titulo_obtenido
from funcionario f
join persona p on f.id_persona=p.id_persona
where nombre1='carlos ' 
--and nombre2 ='Xavier' 
--------------------------------------------------------

begin tran
update funcionario 
set titulo_obtenido='ABG.'
where id_funcionario=182--154 conny y alexis no tienen cargo
commit  tran
--------------------------------------------------

--Autoridad de Tránsito Municipal
--Empresa Pública de Tránsito y Movilidad de Guayaquil, EP.