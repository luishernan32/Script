declare 

DECLARE @numero_financiacion INT;


if object_id('tempdb..#LogTemporal') is not null
	drop table #LogTemporal
CREATE TABLE #LogTemporal (
    numero_financiacion INT,
    tipo_id VARCHAR(50),
    identificacion VARCHAR(50),
    mensaje VARCHAR(255)
);

DECLARE cursor_datos CURSOR FOR
SELECT top 1 

f.numero_financiacion AS numero_financiacion 

FROM 
  integracion_terceros.dbo.v_all_financiaciones f 
  JOIN integracion_terceros.dbo.v_all_detallefinanciacion df ON f.numero_financiacion = df.numero_financiacion 
  inner join circulemos2.dbo.persona p on p.numero_identificacion = f.IDENTIFICACION
WHERE 
  f.fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'
  --and exists (select distinct 1 from integracion_terceros.dbo.v_all_detallefinanciacion df where TIPO_OBLICACION='COA') 
  AND df.TIPO_OBLICACION = 'COA' --Nicolai = 'FAQ', Oscar = 'COA'



  OPEN cursor_datos;

	FETCH NEXT FROM cursor_datos INTO 
		  @numero_financiacion, @numero_cuotas, @anio 
		  

	WHILE @@FETCH_STATUS = 0