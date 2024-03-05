select *from circulemos2.dbo.trazabilidad_envio_correo

WHERE f.fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'


--where fecha_de_convenio is not null

select *from circulemos2.dbo.trazabilidad_envio_correo

select *from  
  integracion_terceros.dbo.v_all_financiaciones f 
  JOIN integracion_terceros.dbo.v_all_detallefinanciacion df ON f.numero_financiacion = df.numero_financiacion 
  inner join circulemos2.dbo.persona p on p.numero_identificacion = f.IDENTIFICACION
  inner join integracion_terceros.dbo.V_CUOTASFINANCIACION_pre cou on cou.numero_financiacion=df.numero_financiacion
  WHERE 
  f.fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'
  --and exists (select distinct 1 from integracion_terceros.dbo.v_all_detallefinanciacion df where TIPO_OBLICACION='COA') 
 -- AND df.TIPO_OBLICACION = 'COA' --Nicolai = 'FAQ', Oscar = 'COA'
 
ORDER BY 
  f.fecha_inicio_deuda;




   select *from integracion_terceros.dbo.v_financiaciones_pre a INNER JOIN integracion_terceros.dbo.V_CUOTASFINANCIACION_pre AS b
      ON a.numero_financiacion = b.numero_financiacion



----------------------------------------------------------------------------------
select *from integracion_terceros.dbo.v_detallefinanciacion_pre 
WHERE fecha_registro BETWEEN '2023-12-01' AND '2024-02-23' --No trae datos No hay datos de esa fecha

select *from integracion_terceros.dbo.v_financiaciones_pre 
WHERE fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'--No trae datos

select *from integracion_terceros.dbo.v_detallefinanciacion_pre_ 
WHERE fecha_registro BETWEEN '2023-12-01' AND '2024-02-23' --No aplica está tabla está vacia

select *from integracion_terceros.dbo.V_CUOTASFINANCIACION_pre
WHERE fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'   ---No trae datos porque no hay en el rango de esa fecha


select *from integracion_terceros.dbo.v_all_financiaciones 
WHERE fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'
order by FECHA_REGISTRO asc

select *from integracion_terceros.dbo.v_all_detallefinanciacion
WHERE fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'
order by FECHA_REGISTRO asc


select *from  
  integracion_terceros.dbo.v_all_financiaciones  



select *from integracion_terceros.dbo.v_financiaciones_rec  --Ya se tiene el id_tramite