DECLARE @tipo_de_financiacion INT,
		@numero_de_convenio INT,
		@fecha_de_convenio DATE,
		@ID_ESTADO_DE_INCUMPLIMIENTO INT,
		@estado_de_convenio varchar(30)
		
		
IF OBJECT_ID('tempdb..#tblTemporal') IS NOT NULL
BEGIN
    delete #tblTemporal;
END
ELSE
BEGIN
    select top 10 * into #tblTemporal
	from circulemos2.dbo.trazabilidad_financiacion_incumplida
	where 1= 2
END

--------------------------------
-- Declaración del cursor
--------------------------------	

DECLARE cDatos CURSOR FOR
 select 
        1 as tipo_de_financiacion,----------------------------------------
		a.numero_financiacion as numero_de_convenio,
		CAST(a.fecha_registro AS DATE) as fecha_de_convenio,
		'INCUMPLIDO' as estado_de_convenio,-------------------------------
		2 as ID_ESTADO_DE_INCUMPLIMIENTO------------------------------
		
		-- 0 AS ID_FINANCIACION,
		-- NULL AS ID_COACTIVO,
		-- GETDATE() AS FECHA_REGISTRO_MARCACION
		------------a.*,b.*--numero_financiacion,FECHA_REGISTRO


 --from integracion_terceros.dbo.v_financiaciones_pre a INNER JOIN integracion_terceros.dbo.V_CUOTASFINANCIACION_pre AS b
 --     ON a.numero_financiacion = b.numero_financiacion

from  
  integracion_terceros.dbo.v_financiaciones_rec a
  JOIN integracion_terceros.dbo.v_detallefinanciacion_rec df on a.numero_financiacion=df.numero_financiacion
  inner join integracion_terceros.dbo.V_CUOTASFINANCIACION_pre b on b.numero_financiacion=df.numero_financiacion
  --WHERE 
  --df.fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'
 
ORDER BY 
  a.fecha_inicio_deuda;
    
---------------------------
-- Apertura del cursor-----
---------------------------

OPEN cDatos

---------------------------
-- Bucle de procesamiento
---------------------------

-----------------------------
-- Obtener la siguiente fila
-----------------------------
FETCH NEXT FROM cDatos INTO @tipo_de_financiacion, @numero_de_convenio,@fecha_de_convenio,@estado_de_convenio,@ID_ESTADO_DE_INCUMPLIMIENTO
                                     
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Procesar la fila actual
 --   PRINT 'ID: ' + CONVERT(VARCHAR, @tipo_de_financiacion) + ', NUMERO: ' + CONVERT(VARCHAR, @numero_de_convenio)+' Estado '+@estado_de_convenio
	--+ ' Cuotas incumplidas' +CONVERT(VARCHAR, @CUOTAS_INCUMPLIDAS)+ ' FECHA CONVENIO '+ CAST(@fecha_de_convenio AS VARCHAR)

--Seria como tener la tabla de circulemos
insert into #tblTemporal (
--[id_trazabilidad_financiacion],
[tipo_de_financiacion]
,[numero_de_convenio]   
,[fecha_de_convenio]
,[estado_de_convenio]
,[id_estado_de_incumplimiento]
,[fecha_pago_oportuno]
,[id_financiacion]---------???
,[id_coactivo]
,[fecha_registro_marcacion]
	  )
	  VALUES 
	  ( @tipo_de_financiacion, @numero_de_convenio,@fecha_de_convenio,@estado_de_convenio,@ID_ESTADO_DE_INCUMPLIMIENTO
	   ,0,0,GETDATE()---- IMPLEMENTAR SEGUN LO QUE SE PREGUNTA
	  )

    FETCH NEXT FROM cDatos INTO @tipo_de_financiacion, @numero_de_convenio,@fecha_de_convenio,@estado_de_convenio,@ID_ESTADO_DE_INCUMPLIMIENTO

END

-------------------------------
------ Cierre del cursor ------
-------------------------------
CLOSE cDatos
DEALLOCATE cDatos --Liberar la memoria del cursor



--SELECT *
--FROM #tblTemporal


--       #tblTemporal

--Preguntar
--Dónde se creo la tabla




