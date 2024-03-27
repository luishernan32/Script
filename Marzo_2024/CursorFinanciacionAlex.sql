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
if object_id('tempdb..#DetalleFinanciacion') is not null
	drop table #DetalleFinanciacion
create table #DetalleFinanciacion(
	id_detalle_financiacion bigint identity(1,1) primary key,
	id_financiacion bigint,
	numero_cuota int,
	valor_total decimal(16,2),
	fecha_pago_oportuno date not null,
	valor_capital decimal(16,2) not null,
	valor_intereses decimal(16,2) not null,
	id_documento bigint,
	numero_volante bigint,
	fecha_pago datetime2(7),
	valor_saldo_obligacion decimal(16,2) not null,
	nueva_fecha_pago date
);
if object_id('tempdb..#Financiacion') is not null
	drop table #Financiacion
create table #Financiacion(
	id_financiacion bigint identity(1,1) primary key,
	numero_financiacion varchar(50) not null,
	numero_cuotas int not null,
	anio int not null,
	id_deudor bigint not null,
	id_codeudor bigint,
	codigo_organismo int not null,
	valor_total_costas_procesales decimal(16,2) not null,
	id_configuracion_financiacion int,
	justificacion varchar(500),
	codigo_fuente_informacion int not null,
	id_proceso bigint not null,
	cantidad_obligaciones int not null,
	tasa_interes numeric(6,3) not null,
	valor_mora decimal(16,2) not null,
	valor_total_saldo_capital_obliga decimal(16,2) not null,
	valor_total_intereses_moratorios decimal(16,2) not null,
	valor_total decimal(16,2) not null,
	valor_total_financiar_interes decimal(16,2) not null,
	numero_referencia_terceros varchar(50),
	id_tramite bigint,
	id_tipo_financiacion int
);

if object_id('tempdb..#Proceso') is not null
	drop table #Proceso
create table #Proceso(
	[id_proceso] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipo_proceso] [int] NOT NULL,
	[numero_proceso] [varchar](50) NOT NULL,
	[fecha_inicio] [datetime2](7) NOT NULL,
	[fecha_fin] [datetime2](7) NULL,
	[observacion] [varchar](max) NOT NULL,
	[id_estado_proceso] [int] NOT NULL,
);

if object_id('tempdb..#Obligacion_Financiacion') is not null
	drop table #Obligacion_Financiacion
create table #Obligacion_Financiacion(
	id_obligacion_financiacion bigint IDENTITY(1,1) not null,
	codigo_tipo_obligacion int not null,
	id_financiacion int not null,
	numero_obligacion varchar(50) not null,
	fecha_obligacion datetime2(7) not null,
	valor_costas_procesales decimal(16,2) not null,
	valor_obligacion decimal(16,2) not null,
	valor_interes_moratorios decimal(16,2) not null
)

if object_id('tempdb..#tmp_v_financiaciones_rec') is not null
	drop table #tmp_v_financiaciones_rec

select case when id_tipo_convenio = '1' and 
(select COUNT(1) from 
V_DETALLEFINANCIACION_REC vdr
where f.NUMERO_FINANCIACION = vdr.NUMERO_FINANCIACION 
and vdr.id_tipo_factura= 1)> 0 
THEN 'FINANCIACION MULTAS CORRIENTE'
when id_tipo_convenio = '1' and 
(select COUNT(1) from 
V_DETALLEFINANCIACION_REC vdr
where f.NUMERO_FINANCIACION = vdr.NUMERO_FINANCIACION 
and vdr.id_tipo_factura= 4)> 0 
THEN 'FINANCIACION MULTAS COACTIVO'
WHEN f.ID_TIPO_CONVENIO = 'CRV' THEN 'FINANCIACION CRV' END TIPO_CONVENIO,
*
INTO #tmp_v_financiaciones_rec
from v_financiaciones_rec f

-------------------------------------
---Declaracion del cursor
------------------------------------

DECLARE cursor_datos CURSOR FOR
SELECT top 6
  f.numero_financiacion AS numero_financiacion, 
  f.nro_cuotas AS nro_cuotas, 
  YEAR(f.fecha_registro) AS anio, 
  f.fecha_registro,
  NULL AS id_deudor, 
  NULL AS id_codeudor,
  f.agencia_transito AS codigo_organismo,
  0 as valor_total_costas_procesales, --valor costas procesales rectificar valor
  14 as id_configuracion_financiacion, --Nicolai = 14, Oscar verificar Alexander / nicolas dice 14 tambien
  'Reconstruccion FEB-2024' as justificacion, 
  23 as codigo_fuente_informacion, -- valor rectificar
  0 as id_proceso, -- Se asigna en el cursor
  0 AS cantidad_obligaciones,
  NULL as tasa_interes, -- pendiente
  0 as valor_mora, 
  0 as valor_total_saldo_capital_obliga, --Se asigna en el cursor
  0 as valor_total_intereses_moratorios, --pendiente
  f.VALOR_CAPITAL as valor_total,
  f.VALOR_TOTAL_FINANCIADO as valor_total_financiar_interes,
  0 as numero_referencia_terceros, --Se asigna en el cursor
  f.ID_TRAMITE as id_tramite, --pendiente de entrega por parte de alexander
  1 as id_tipo_financiacion --Nicolai = 1, Oscar = 2

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

FROM #tmp_v_financiaciones_rec f 
  WHERE 
  f.fecha_registro BETWEEN '2023-12-01' AND '2024-02-16'
  --and exists (select distinct 1 from integracion_terceros.dbo.v_all_detallefinanciacion df where TIPO_OBLICACION='COA') 
--  AND df.TIPO_OBLICACION = 'FAC' --Nicolai = 'FAC', Oscar = 'COA'
  AND TIPO_CONVENIO = 'FINANCIACION MULTAS CORRIENTE'
  AND F.NUMERO_FINANCIACION = 532577
ORDER BY 
  f.numero_financiacion ;

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
 
--------------------------------------
--------- Apertura del cursor--------- 
--------------------------------------
OPEN cursor_datos;

--------------------------------------
-- Bucle de procesamiento------------
-------------------------------------

	FETCH NEXT FROM cursor_datos INTO 
		  @numero_financiacion, @numero_cuotas, @anio, @fechaRegistro,
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

		select @numeroProceso = ''
		select @fechaRegistro = GETDATE() 

		---TABLA PROCESO
		--INSERT INTO [circulemos2].[dbo].[proceso]

		SET @id_proceso = NULL
		insert into circulemos2.dbo.proceso
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
	  set 	@id_proceso = SCOPE_IDENTITY();
	
		--id_proceso from circulemos2.dbo.proceso order by 1 desc
		--select @numero_referencia_terceros = numero_proceso from circulemos2.dbo.proceso where id_proceso=@id_proceso
		select @numero_referencia_terceros = numero_proceso from  circulemos2.dbo.proceso where id_proceso=@id_proceso
		-- TABLA FINANCIACION
		--INSERT INTO circulemos2.dbo.financiacion 
		--select top 10 * from circulemos2.dbo.financiacion order by 1 desc


		-- Para obtener Interes
		select top 1 @tasa_interes =  
		ROUND(porcentaje_interes_diario *100, 2)
		from circulemos2.dbo.interes
         where @fechaRegistro 		 
		 between fecha_inicial and fecha_final



		
		SET @id_financiacion = NULL
		--select * from #Financiacion
		insert into circulemos2.dbo.financiacion
		(numero_financiacion, numero_cuotas, anio, id_deudor, id_codeudor,
        codigo_organismo, valor_total_costas_procesales,
        id_configuracion_financiacion, justificacion, codigo_fuente_informacion,
        id_proceso, cantidad_obligaciones, tasa_interes, valor_mora,
        valor_total_saldo_capital_obliga, valor_total_intereses_moratorios,
        valor_total, valor_total_financiar_interes,
        numero_referencia_terceros, id_tramite, id_tipo_financiacion)
		VALUES (@numero_financiacion, @numero_cuotas, @anio, @id_deudor, NULL,
				11001, @valor_total_costas_procesales,
				@id_configuracion_financiacion, @justificacion, 23,
				@id_proceso,
				(select COUNT(OBLIGACION) FROM integracion_terceros.dbo.v_detallefinanciacion_rec vdr
				 where vdr.numero_financiacion = @numero_financiacion )  
				, @tasa_interes, 
				@valor_mora,
				(select SUM(CAPITAL_CONVENIO) FROM integracion_terceros.dbo.v_detallefinanciacion_rec vdr
				 where vdr.numero_financiacion = @numero_financiacion )  --@valor_total_saldo_capital_obliga
				
				, (select SUM(INTERES_CONVENIO) FROM integracion_terceros.dbo.v_detallefinanciacion_rec vdr
				 where vdr.numero_financiacion = @numero_financiacion ) , --@valor_total_intereses_moratorios
				@valor_total
				, @valor_total_financiar_interes,
				@numero_referencia_terceros,
				@id_tramite,
				@id_tipo_financiacion);
				
				SET @id_financiacion = SCOPE_IDENTITY()

			
				

--- OBLIGACION FINANCIACION
		insert into circulemos2.dbo.obligacion_financiacion (id_financiacion, codigo_tipo_obligacion,
		numero_obligacion, fecha_obligacion, valor_costas_procesales,valor_obligacion,valor_interes_moratorios)
		select @id_financiacion,
		 1, obligacion, CAST (fecha_obligacion as date), 0,capital_convenio,interes_convenio
		from integracion_terceros.dbo.v_detallefinanciacion_rec
		where numero_financiacion = @numero_financiacion

		
		--TABLA DETALLE_FINANCIACION
		declare @id_financiacion bigint
		--select top 1 @id_financiacion = id_financiacion from circulemos2.dbo.financiacion order by 1 asc
		select top 1 @id_financiacion = id_financiacion from #Financiacion order by 1 desc
		--Cursor anidado
		--df= datos de detalle_financiacion
		declare @df_numero_financiacion int
		declare @df_nro_cuota int
		declare @df_inicio_cuota date
		declare @df_vencimiento_cuota date
		declare @df_valor_cuota decimal(38,6)
		declare @df_recargo_cuota decimal(38,6)
		declare @df_saldo_cuota decimal(38,6)
		declare @df_saldo_interes decimal(38,6)
		declare @df_usuario nvarchar
		declare @df_estado_lectura nvarchar
		declare @df_fecha_registro nvarchar

		declare cursor_detalle_financiacion cursor for 
		 select * from integracion_terceros.dbo.v_all_cuotasfinanciacion where NUMERO_FINANCIACION=@numero_financiacion
		 order by NRO_CUOTA asc
		open cursor_detalle_financiacion
			fetch next from cursor_detalle_financiacion into 
			@df_numero_financiacion,@df_nro_cuota,@df_inicio_cuota,@df_vencimiento_cuota,
			@df_valor_cuota,@df_recargo_cuota,@df_saldo_cuota,@df_saldo_interes,@df_usuario,
			@df_estado_lectura,@df_fecha_registro

			while @@fetch_status=0
			begin
			--mostrando datos
			/*
			select @df_numero_financiacion as numero_financiacion,@df_nro_cuota as nro_cuota,
			@df_inicio_cuota as inicio_cuota,@df_vencimiento_cuota as vencimiento_cuota,
			@df_valor_cuota as valor_cuota ,@df_recargo_cuota as recargo_cuota ,@df_saldo_cuota as saldo_cuota,
			@df_saldo_interes as saldo_interes ,@df_usuario as usuario,
			@df_estado_lectura as estado_lectura,@df_fecha_registro as fecha_registro*/
			
			--select * from circulemos2.dbo.detalle_financiacion where id_financiacion=345285 order by 1 desc
			
			declare @df_valor_capital decimal(38,6)
			select @df_valor_capital=@df_valor_cuota-@df_recargo_cuota

			declare @fecha_hora_pago date
			select @fecha_hora_pago = FECHA_HORA_PAGO from integracion_terceros.dbo.v_all_detalles_pagos where
			NUMERO_DOCUMENTO=@numero_financiacion and NUMERO_CUOTA=@df_nro_cuota

			declare @valor_saldo_obligacion decimal(16,2)
			--select top 1 valor_saldo_obligacion from #DetalleFinanciacion--circulemos2.dbo.detalle_financiacion 
				--where id_financiacion=@id_financiacion order by 1 desc
			if @df_nro_cuota=0
				select @valor_saldo_obligacion = @valor_total-@df_valor_capital
			else
				select @valor_saldo_obligacion = 
				(select top 1 valor_saldo_obligacion from #DetalleFinanciacion--circulemos2.dbo.detalle_financiacion 
				where id_financiacion=@id_financiacion order by 1 asc) - @df_valor_capital 
			--select * from #DetalleFinanciacion
			--insert
			--select * from #DetalleFinanciacion
			insert into #DetalleFinanciacion--circulemos2.dbo.detalle_financiacion 
			(id_financiacion,
			numero_cuota, valor_total,
			fecha_pago_oportuno, valor_capital,
			valor_intereses,
			id_documento, numero_volante,
			fecha_pago,
			valor_saldo_obligacion, nueva_fecha_pago)
			values
			(@id_financiacion,
			@df_nro_cuota, @df_valor_cuota,
			@df_vencimiento_cuota ,@df_valor_capital,
			@df_recargo_cuota,--df_recargo_cuota
			null,null,--id_documento--numeroVolante
			@fecha_hora_pago, --fecha_pago
			@valor_saldo_obligacion,null)--valor_saldo_obligacion, nueva_fecha_pago
			
			/*
			select 0 as id_detalle_financiacion,
			@id_financiacion as id_financiacion,
			@df_nro_cuota as numero_cuota,
			@df_valor_cuota as valor_total,
			@df_vencimiento_cuota as fecha_pago_oportuno,
			@df_valor_capital as valor_capital,
			@df_recargo_cuota as valor_intereses,
			null as id_documento, null numero_volante,
			@fecha_hora_pago as fecha_pago,
			@valor_saldo_obligacion as valor_saldo_obligacion,
			null as nueva_fecha_pago 
			*/

			--------------------------------------------------------------
			-- Obtener la siguiente fila
			--------------------------------------------------------------

			--pasando al siguiente registro del cursor_detalle_financiacion
			fetch next from cursor_detalle_financiacion into 
			@df_numero_financiacion,@df_nro_cuota,@df_inicio_cuota,@df_vencimiento_cuota,
			@df_valor_cuota,@df_recargo_cuota,@df_saldo_cuota,@df_saldo_interes,@df_usuario,
			@df_estado_lectura,@df_fecha_registro

			end
        ----------------------------------------------
		-- Cierre del cursor-------------------------
		----------------------------------------------

		close cursor_detalle_financiacion
		deallocate cursor_detalle_financiacion

		--TABLA OBLIGACION_FINANCIACION
		
		--select top 1 * from circulemos2.dbo.financiacion order by 1 desc
		--select top 1 * from circulemos2.dbo.obligacion_financiacion where numero_obligacion=535729 order by 1 desc
		
		


		--select * from #Financiacion
		--select * from #DetalleFinanciacion
		--select * from #DetalleFinanciacion
		--select * from #Obligacion_Financiacion

		
		

		--insert tabla proceso
		--insert tabla financiacion
		--insert tabla detalle_financiacion
		--insert tabla obligacion_financiacion
		--select * from circulemos2.dbo.coactivo where id_deudor = @id_deudor


		--BLOQUE FALTANTE

		-- insertar la cartera del convenio
		-- 
---------------------------------------------------------------------------
			-- Obtener la siguiente fila
---------------------------------------------------------------------------
		FETCH NEXT FROM cursor_datos INTO 
		  @numero_financiacion, @numero_cuotas, @anio, @fechaRegistro,
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

 ----------------------------------------------
		-- Cierre del cursor-------------------------
		---------------------------------------------- 
CLOSE cursor_datos;
DEALLOCATE cursor_datos;

--Según este desarrollo hay dos cursores cursor_datos y cursor_detalle_financiacion