DECLARE @numero_financiacion INT;
DECLARE @numero_cuotas INT;
DECLARE @anio INT;
DECLARE @id_deudor INT;
DECLARE @id_codeudor INT;
DECLARE @codigo_organismo INT;
DECLARE @valor_total_costas_procesales DECIMAL(18,2);
DECLARE @id_configuracion_financiacion INT;
DECLARE @justificacion VARCHAR(255);
DECLARE @codigo_fuente_informacion INT;
DECLARE @id_proceso INT;
DECLARE @cantidad_obligaciones INT;
DECLARE @tasa_interes DECIMAL(18,2);
DECLARE @valor_mora DECIMAL(18,2);
DECLARE @valor_total_saldo_capital_obliga DECIMAL(18,2);
DECLARE @valor_total_intereses_moratorios DECIMAL(18,2);
DECLARE @valor_total DECIMAL(18,2);
DECLARE @valor_total_financiar_interes DECIMAL(18,2);
DECLARE @numero_referencia_terceros INT;
DECLARE @id_tramite INT;
DECLARE @id_tipo_financiacion INT;
DECLARE @numeroProceso BIGINT;
DECLARE @fechaRegistro DATE;
DECLARE @identificacion varchar(20);
DECLARE @tipo_id int;

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
  f.numero_financiacion AS numero_financiacion, 
  f.nro_cuotas AS nro_cuotas, 
  YEAR(f.fecha_registro) AS anio, 
  p.id_persona AS id_deudor, 
  NULL AS id_codeudor,
  f.agencia_transito AS codigo_organismo,
  0 as valor_total_costas_procesales, --valor costas procesales rectificar valor
  14 as id_configuracion_financiacion, --Nicolai = 14, Oscar verificar Alexander
  'Reconstruccion FEB-2024' as justificacion, 
  23 as codigo_fuente_informacion, -- valor rectificar
  0 as id_proceso, -- Se asigna en el cursor
  COUNT(df.NUMERO_FINANCIACION) AS cantidad_obligaciones,
  0 as tasa_interes, -- pendiente
  0 as valor_mora, -- pendiente 
  0 as valor_total_saldo_capital_obliga, --Se asigna en el cursor
  0 as valor_total_intereses_moratorios, --pendiente
  f.VALOR_CAPITAL as valor_total,
  f.VALOR_TOTAL_FINANCIADO as valor_total_financiar_interes,
  0 as numero_referencia_terceros, --Se asigna en el cursor
  0 as id_tramite, --pendiente de entrega por parte de alexander
  2 as id_tipo_financiacion --Nicolai = 1, Oscar = 2
FROM 
   integracion_terceros.dbo.v_all_financiaciones f 
  JOIN integracion_terceros.dbo.v_all_detallefinanciacion df ON f.numero_financiacion = df.numero_financiacion 
  inner join circulemos2.dbo.persona p on p.numero_identificacion = f.IDENTIFICACION
  inner join integracion_terceros.dbo.V_CUOTASFINANCIACION_pre cou on cou.numero_financiacion=df.numero_financiacion
WHERE 
  f.fecha_registro BETWEEN '2023-12-01' AND '2024-02-23'
  --and exists (select distinct 1 from integracion_terceros.dbo.v_all_detallefinanciacion df where TIPO_OBLICACION='COA') 
  AND df.TIPO_OBLICACION = 'COA' --Nicolai = 'FAQ', Oscar = 'COA'
GROUP BY 
  f.numero_financiacion, 
  f.nro_cuotas, 
  YEAR(f.fecha_registro), 
  f.agencia_transito, 
  f.FECHA_INICIO_DEUDA,
  f.VALOR_CAPITAL,
  f.VALOR_TOTAL_FINANCIADO,
  f.IDENTIFICACION,
  p.id_persona,
  df.NUMERO_FINANCIACION
ORDER BY 
  f.fecha_inicio_deuda;
 
 
OPEN cursor_datos;

	FETCH NEXT FROM cursor_datos INTO 
		  @numero_financiacion, @numero_cuotas, @anio, 
		  @id_deudor, @id_codeudor,@codigo_organismo, 
		  @valor_total_costas_procesales, @id_configuracion_financiacion,
		  @justificacion,@codigo_fuente_informacion,
		  @id_proceso,@cantidad_obligaciones,
		  @tasa_interes,@valor_mora, 
		  @valor_total_saldo_capital_obliga, @valor_total_intereses_moratorios,
		  @valor_total,@valor_total_financiar_interes,
		  @numero_referencia_terceros,@id_tramite,
		  @id_tipo_financiacion;

	WHILE @@FETCH_STATUS = 0
 
	BEGIN

		IF @id_deudor IS NULL
		BEGIN
			INSERT INTO #LogTemporal (numero_financiacion, tipo_id, identificacion, mensaje)
			VALUES (@numero_financiacion, @tipo_id, @identificacion, 'No existe persona con esta identificación');
		END

		select @valor_total_saldo_capital_obliga = sum (VALOR_OBLIGACION) from integracion_terceros.dbo.v_all_detallefinanciacion where NUMERO_FINANCIACION=@numero_financiacion

		select @numero_financiacion as numero_financiacion, @numero_cuotas as numero_cuotas, @anio as anio, 
		  @id_deudor as id_deudor, @id_codeudor as id_codeudor ,@codigo_organismo as codigo_organismo, 
		  @valor_total_costas_procesales as valor_total_costas_procesales, @id_configuracion_financiacion as id_configuracion_financiacion,
		  @justificacion as justificacion, @codigo_fuente_informacion as codigo_fuente_informacion,
		  @id_proceso as id_proceso, @cantidad_obligaciones as cantidad_obligacion,
		  @tasa_interes as tasa_interes, @valor_mora as valor_mora, 
		  @valor_total_saldo_capital_obliga as valor_total_saldo_capital_obliga, @valor_total_intereses_moratorios as valor_total_intereses_moratorios,
		  @valor_total as valor_total, @valor_total_financiar_interes as valor_total_financiar_interes,
		  @numero_referencia_terceros as numero_referencia_terceros,@id_tramite as id_tramite,
		  @id_tipo_financiacion as id_tipo_financiacion;

		select @numeroProceso = NULL
		select @fechaRegistro = GETDATE() 

		---TABLA PROCESO
		
		INSERT INTO [circulemos2].[dbo].[proceso]
           ([id_tipo_proceso]
           ,[numero_proceso]
           ,[fecha_inicio]
           ,[fecha_fin]
           ,[observacion]
           ,[id_estado_proceso])
		 VALUES
			   (2,
				@numeroProceso
			   ,@fechaRegistro --rectificar con alexander
			   ,NULL
			   ,'Reconstrucción Feb2024'
			   ,15);
		
		select top 1 @id_proceso = id_proceso from circulemos2.dbo.proceso order by 1 desc
		select @numero_referencia_terceros = numero_proceso from circulemos2.dbo.proceso where id_proceso=@id_proceso
		-- TABLA FINANCIACION
		
		INSERT INTO circulemos2.dbo.financiacion (numero_financiacion, numero_cuotas, anio, id_deudor, id_codeudor,
                                               codigo_organismo, valor_total_costas_procesales,
                                               id_configuracion_financiacion, justificacion, codigo_fuente_informacion,
                                               id_proceso, cantidad_obligaciones, tasa_interes, valor_mora,
                                               valor_total_saldo_capital_obliga, valor_total_intereses_moratorios,
                                               valor_total, valor_total_financiar_interes,
                                               numero_referencia_terceros, id_tramite, id_tipo_financiacion)
		VALUES (@numero_financiacion, @numero_cuotas, @anio, @id_deudor, NULL,
				11001, @valor_total_costas_procesales,
				@id_configuracion_financiacion, @justificacion, 23,
				@id_proceso, @cantidad_obligaciones, @tasa_interes, --pendiente validar alexander
				@valor_mora, --pendiente validar alexander
				@valor_total_saldo_capital_obliga, @valor_total_intereses_moratorios,--pendiente validar alexander
				@valor_total, @valor_total_financiar_interes,
				@numero_referencia_terceros,
				@id_tramite,--pendiente de validar con alexander
				@id_tipo_financiacion);
 
		FETCH NEXT FROM cursor_datos INTO 
		  @numero_financiacion, @numero_cuotas, @anio, 
		  @id_deudor, @id_codeudor,@codigo_organismo, 
		  @valor_total_costas_procesales, @id_configuracion_financiacion,
		  @justificacion,@codigo_fuente_informacion,
		  @id_proceso,@cantidad_obligaciones,
		  @tasa_interes,@valor_mora, 
		  @valor_total_saldo_capital_obliga, @valor_total_intereses_moratorios,
		  @valor_total,@valor_total_financiar_interes,
		  @numero_referencia_terceros,@id_tramite,
		  @id_tipo_financiacion;
	END;
 
CLOSE cursor_datos;
DEALLOCATE cursor_datos;



