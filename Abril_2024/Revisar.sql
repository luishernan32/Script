 

-- PASO 1 OBTENER MULTAS PENDIENTES EN AXIS SIN COACTIVA

 

     IF OBJECT_ID( N'tempdb..#tmp_facturas') IS NOT NULL
        DROP TABLE #tmp_facturas;

 

 

select f.* 
into #tmp_facturas 
from openquery(SRVPRATM, 'SELECT F.ID_FACTURA , F.SECUENCIA_4 PLACA
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
and extract (year from F.FECHA_EMISION) = 2023
--and extract (month from F.FECHA_EMISION) = 8
--and extract (day from F.FECHA_EMISION) = 26
--and d.id_rubro = ''906''
--and not exists (select 1 from fa_creditos_debitos fcd
--where fcd.id_origen = ''RRM''
--and fcd.id_factura_relacionada = f.id_factura )
order by f.id_factura desc
'

 

) F

 
-----------------------------------------------------------------------------------------------
 

--2.- OBTENER MULTAS PENDIENTES SOGIT

 

         IF OBJECT_ID( N'tempdb..#tmp_comparendos') IS NOT NULL
        DROP TABLE  #tmp_comparendos ;

 

 

use circulemos2
SELECT comparendo0_.id_factura_axis
,comparendo0_.numero_citacion
--, persona6_.numero_identificacion
, comparendo0_.fecha_infraccion
, comparendo0_.fecha_notificacion
, infraccion4_ .codigo_infraccion
, persona6_.numero_identificacion
, persona6_.id_persona
, comparendo0_.cicomparendo
, cv.placa_vehiculo
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
       INNER JOIN configuracion_infraccion configurac9_ 
               ON infraccion4_.id_infraccion = configurac9_.id_infraccion 
     /* LEFT OUTER JOIN comparendo_proceso comparendo7_ 
                    ON comparendo0_.cicomparendo = comparendo7_.cicomparendo */


 

WHERE  1 = 1 
-- AND persona6_.id_persona = @id_persona
  -- AND persona6_.id_tipo_identificacion = @id_tipo_identificacion
--AND persona6_.numero_identificacion = @numero_identificacion 
    AND ( estadocomp3_.id_estado_comparendo IN (1,2) )

 

AND YEAR(comparendo0_.fecha_infraccion)=2023
--AND CONVERT (DATE,Getdate()) <= Dateadd(dd, 100, comparendo0_.fecha_infraccion) 
--AND CONVERT (DATE,Getdate()) <= Dateadd(dd, 10, comparendo0_.fecha_notificacion) 
--AND NOT EXISTS(SELECT 1 FROM Proceso pro  WHERE pro.id_proceso IN (SELECT cpro.id_proceso FROM comparendo_proceso cpro WHERE cpro.cicomparendo = comparendo0_.cicomparendo) AND pro.fecha_fin is NULL) 
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
       /* AND configurac9_.aplica_descuento = 1
AND NOT ( EXISTS (SELECT curso12_.id_curso 
                         FROM   curso curso12_ 
                         WHERE  ( curso12_.id_estado_curso IN ( 3, 4 ) ) 
                                AND curso12_.id_persona = personalis5_.id_persona--@id_persona 
                                AND curso12_.fecha_registro >= Getdate() - 365
                                AND curso12_.fecha_registro <= Getdate()) ) 
     AND 1> (SELECT Count(curso13_.id_curso) 
                FROM   curso curso13_ 
                WHERE 1=1  
                and curso13_.id_persona = personalis5_.id_persona--@id_persona
                       AND curso13_.fecha_registro >=Getdate() -365
                       AND curso13_.fecha_registro <= Getdate()) 
AND NOT ( EXISTS (SELECT curso14_.id_curso 
                         FROM   curso curso14_ 
                         WHERE  curso14_.id_infraccion = 
                                infraccion4_.id_infraccion 
                                 AND curso14_.id_persona = personalis5_.id_persona--@id_persona 
                                ) ) */
--and comparendo0_.id_factura_axis in ()
--  and comparendo0_.id_infraccion = 107

 

-----------------------------------------------------------------------------------------------
 

select tc.* from #tmp_comparendos tc
join #tmp_facturas tf on  tf.id_factura = tc.id_factura_axis
--join #tmp_notificadas tn on tn.multa = tc.id_factura_axis
where 1=1
--and id_factura_axis='12246346'

-----------------------------------------------------------------------------------------------

--12256079 
--1790403343001
--12241715  0992324236001
--12285839 0908145931 31,50
BEGIN TRAN
UPDATE circulemos2.DBO.cartera
SET saldo_capital = 212.50
WHERE NOMBRE = '12147512'

 

commit tran

 
------------------------------------------------------------------------------------------------------------
--12255788 12256079 12246346
select * from openquery (srvpratm, 'select * from fa_documentos_coactiva where id_documento =12220681')
------------------------------------------------------------------------------------------------------------
 

select * from circulemos2.dbo.coactivo_pendiente where factura = 12147512

 

 

USE [circulemos2]
begin tran

 

INSERT INTO [dbo].[coactivo_pendiente]
           ([numero_coactivo]
           ,[id_tramite]
           ,[fecha_creacion]
           ,[factura]
           ,[valor_factura]
           ,[tipo_identificacion]
           ,[numero_identificacion]
           ,[fecha_registro]
           ,[registro_nuevo]
           ,[coactivo_exitoso]
           ,[descripcion_error]
           ,[tipo_coactivo])
     VALUES
           ('12910141'
           ,'14824072'
           ,'2023-08-30 05:13:22'
           ,'12220681'
           ,'225'
           ,'RUT'
           ,'0992541075001'
           ,getdate()
           ,1
           ,0
           ,null
           ,1)

 

 

           commit tran

 

           begin tran
           update circulemos2.dbo.coactivo_pendiente
           set registro_nuevo = 1
           where factura = 12147512
           commit tran