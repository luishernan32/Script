-- 1.- Ejecutar query en AXIS para multas pendientes en AXIS del 2020
-- Se puede descomentar filtros para acortar tiempo de Ejecución de Query
 
        -- eliminando si existe
        IF OBJECT_ID( N'tempdb..#tmp_facturas') IS NOT NULL
        DROP TABLE #tmp_facturas;
        

select f.* 
into #tmp_facturas 
from openquery(SRVPRATM, 'SELECT F.ID_FACTURA 
FROM   FA_FACTURAS F,
        FA_DETALLES_FACTURAS B,
        GE_RUBROS D
WHERE B.ID_FACTURA = F.ID_FACTURA
   AND D.ID_RUBRO = B.ID_RUBRO
   AND D.ID_RUBRO <> ''MUL''
AND F.ID_TIPO_FACTURA in (1)
and pagada = ''N''
and anulada = ''N''
and reclamo = ''N''
and convenio = ''N''
and legal = ''N''
--and f.id_oficina = ''PLAVIT''
--and d.id_tasa_multa = ''ORD''
--and extract (year from F.FECHA_EMISION) = 2020
--and extract (month from F.FECHA_EMISION) = 5
--and extract (day from F.FECHA_EMISION) = 26
-- L15 = MULTAS METROVIA
--and d.id_rubro = ''L15''
and not exists (select 1 from fa_creditos_debitos fcd
where fcd.id_origen = ''RRM''
and fcd.id_factura_relacionada = f.id_factura )
--order by f.id_factura desc'

) F
 

--2.- Ejecutar query en SOGIT para multas pendientes del 2020

         IF OBJECT_ID( N'tempdb..#tmp_comparendos') IS NOT NULL
        DROP TABLE  #tmp_comparendos ;



use circulemos2
SELECT comparendo0_.id_factura_axis
,comparendo0_.numero_citacion
, comparendo0_.fecha_infraccion
, comparendo0_.fecha_notificacion
, infraccion4_ .codigo_infraccion
, persona6_.numero_identificacion
, persona6_.id_persona
, comparendo0_.cicomparendo
, cartera1_.saldo_capital

 into #tmp_comparendos 

FROM   comparendo comparendo0_ 
        INNER JOIN medio_imposicion_comparendo medioimpos1_ 
               ON comparendo0_.codigo_medio_imposicion = 
                  medioimpos1_.codigo_medio_imposicion 
       INNER JOIN direccion direccion2_ 
               ON comparendo0_.id_direccion_comparendo = 
                  direccion2_.id_direccion 
       INNER JOIN estado_comparendo estadocomp3_ 
               ON comparendo0_.id_estado_comparendo = 
                  estadocomp3_.id_estado_comparendo 
       INNER JOIN infraccion infraccion4_ 
               ON comparendo0_.id_infraccion = infraccion4_.id_infraccion 

       INNER JOIN comparendo_persona personalis5_ 
               ON comparendo0_.cicomparendo = personalis5_.cicomparendo 
       INNER JOIN persona persona6_ 
               ON personalis5_.id_persona = persona6_.id_persona 
      
	  LEFT OUTER JOIN comparendo_vehiculo cv 
	           ON cv.id_comparendo_vehiculo = comparendo0_.cicomparendo

       INNER JOIN comparendo_cartera comparendo8_ 
               ON comparendo0_.cicomparendo = comparendo8_.cicomparendo 
       INNER JOIN cartera cartera1_
			   ON comparendo8_.id_cartera=cartera1_.id_cartera
       INNER JOIN configuracion_infraccion configurac9_ 
               ON infraccion4_.id_infraccion = configurac9_.id_infraccion 
	  LEFT OUTER JOIN comparendo_proceso comparendo7_ 
                    ON comparendo0_.cicomparendo = comparendo7_.cicomparendo 
 

WHERE  1 = 1 
     AND ( estadocomp3_.id_estado_comparendo IN (1,2 ) ) 

 --AND YEAR(comparendo0_.fecha_infraccion)=2020
AND NOT EXISTS(SELECT 1 FROM Proceso pro  WHERE pro.id_proceso IN (SELECT cpro.id_proceso FROM comparendo_proceso cpro WHERE cpro.cicomparendo = comparendo0_.cicomparendo) AND pro.fecha_fin is NULL) 
AND ( EXISTS (SELECT cartera10_.id_cartera 
                     FROM   cartera cartera10_ 
                     WHERE  cartera10_.saldo_capital > 0 
                            AND 
           cartera10_.id_cartera = comparendo8_.id_cartera) ) 

         AND ( EXISTS (SELECT cartera11_.id_cartera 
                     FROM   cartera cartera11_ 
                     WHERE  cartera11_.codigo_estado_obligacion = 2 
                            AND 
           cartera11_.id_cartera = comparendo8_.id_cartera) ) 

        AND configurac9_.fecha_inicio_vigencia <=GETDATE() 
	  

            AND ( configurac9_.fecha_fin_vigencia IS NULL 
              OR configurac9_.fecha_fin_vigencia >=GETDATE() ) 
              

--3.- Presenta Multas Pendientes en AXIS y SOGIT  

select tc.*, tf.* from #tmp_comparendos tc
join #tmp_facturas tf on  tf.id_factura = tc.id_factura_axis
where 1=1 