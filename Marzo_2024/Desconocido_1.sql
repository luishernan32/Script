from  
  integracion_terceros.dbo.v_all_financiaciones a 
  JOIN integracion_terceros.dbo.v_all_detallefinanciacion df ON a.numero_financiacion = df.numero_financiacion 
  inner join circulemos2.dbo.persona p on p.numero_identificacion = a.IDENTIFICACION
  inner join integracion_terceros.dbo.V_CUOTASFINANCIACION_pre b on b.numero_financiacion=df.numero_financiacion
  --WHERE 
  --a.fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'
  ----and exists (select distinct 1 from integracion_terceros.dbo.v_all_detallefinanciacion df where TIPO_OBLICACION='COA') 
  --AND df.TIPO_OBLICACION = 'COA' --Nicolai = 'FAQ', Oscar = 'COA'

  select *from integracion_terceros.dbo.v_detallefinanciacion_rec
WHERE fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'
order by FECHA_REGISTRO asc


  select *from integracion_terceros.dbo.v_financiaciones_rec a
  JOIN integracion_terceros.dbo.v_detallefinanciacion_rec df on a.numero_financiacion=df.numero_financiacion
  ---inner join integracion_terceros.dbo.V_CUOTASFINANCIACION_pre b on b.numero_financiacion=df.numero_financiacion
  WHERE 
  df.fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'
  --and exists (select distinct 1 from integracion_terceros.dbo.v_all_detallefinanciacion df where TIPO_OBLICACION='COA') 
  --AND df.TIPO_OBLICACION = 'COA' --Nicolai = 'FAQ', Oscar = 'COA'

  select *from circulemos2.dbo.trazabilidad_financiacion_incumplida
  WHERE 
  fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'


  select 
  *FROM integracion_terceros.dbo.v_financiaciones_rec
  WHERE 
  fecha_registro BETWEEN '2023-12-01' AND '2024-02-16'
  --and exists (select distinct 1 from integracion_terceros.dbo.v_all_detallefinanciacion df where TIPO_OBLICACION='COA') 
--  AND df.TIPO_OBLICACION = 'FAC' --Nicolai = 'FAC', Oscar = 'COA'
 -- AND TIPO_CONVENIO = 'FINANCIACION MULTAS CORRIENTE'
  AND NUMERO_FINANCIACION = 532577
ORDER BY 
  numero_financiacion ;

