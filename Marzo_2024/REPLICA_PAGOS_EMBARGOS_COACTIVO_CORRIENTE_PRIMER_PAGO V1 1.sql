-- id_credito: 1622540 - factura_coactiva: 3089412 -  factura_coactivada: 2043428
USE integracion_terceros;


--- CTE PRIMER PAGO EMBARGO PARA COACTIVOS TIPO 1
/*WITH cte_pagos_embargos_corriente_primer_pago AS (
    SELECT * FROM (
        SELECT vpe.* 
        , row_number() OVER (PARTITION BY vpe.id_factura_coactiva ORDER BY id_credito ASC) AS orden_pago
        FROM integracion_terceros.dbo.v_pagos_embargos_axis_hist vpe
        INNER JOIN integracion_terceros.dbo.v_pagos_embargos_coactivos_rec vec ON vec.id_factura_coactiva = vpe.ID_FACTURA_COACTIVA
        WHERE CONVERT(DATE, FECHA_PAGO)>=CONVERT(DATE, '2023-12-01')
        AND  CONVERT(DATE, FECHA_PAGO)<=CONVERT(DATE, '2024-02-16')
        AND vec.id_tipo_coactivo = 1
        ) t
    WHERE orden_pago = 1
)*/


--- verifica si existe la tabla antes de crearla
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'v_pagos_embargos_log_errores_insercion')
BEGIN
    CREATE TABLE v_pagos_embargos_log_errores_insercion (
        id_pago_embargo_error INT IDENTITY(1,1) PRIMARY KEY,
        id_creditos_embargos FLOAT NOT NULL,
        id_coactivo VARCHAR(20), 
        id_registro_pago_embargo bigint,
        id_pago_embargo_axis BIGINT,
        id_pago_embargo_axis_obligacion BIGINT,
        id_recaudo BIGINT,
        mensaje_error VARCHAR(MAX),
        fecha_registro DATETIME
    );
END;

DECLARE
@id_factura_coactiva VARCHAR(20),
@id_factura_coactivada VARCHAR(20),
@id_credito VARCHAR(20),
@id_registro_pago_embargo BIGINT,
@id_pago_embargo_axis  BIGINT,
@id_coactivo VARCHAR(20),
@fecha_pago DATETIME2(7),
@valor_cred_apl FLOAT,
@valor_capital_multa_vol FLOAT,
@valor_recargos_mora_vol FLOAT,
@valor_costa_procesal_multa_vol FLOAT,
@cred_aplicado_coactivo FLOAT,
@cred_aplicado_recargo_mora FLOAT,
@cred_aplicado_costa_procesal FLOAT,
@saldo_capital_multa FLOAT,
@saldo_recargos_mora FLOAT,
@saldo_costa_procesal_multa FLOAT,
@fecha_transaccion DATE,
@hora_transaccion TIME(7),
@mensaje_error VARCHAR(MAX),
@id_pago_embargo_axis_obligacion bigint,
@UltimoNumeroRecaudo varchar(MAX),
@NuevoNumeroRecaudo varchar(MAX),
@id_recaudo bigint



DECLARE cursor_pagos_embargos CURSOR FOR
  /*  SELECT 
        cast(Cast(id_factura_coactiva AS numeric(10,0)) AS VARCHAR),
        cast(Cast(id_factura_coactivada AS numeric(10,0)) AS VARCHAR),
        cast(Cast(id_credito AS numeric(10,0)) AS VARCHAR),
        fecha_pago,
        valor_cred_apl,
        valor_capital_multa_vol,
        valor_recargos_mora_vol,
        valor_costa_procesal_multa_vol,
        cred_aplicado_coactivo,
        cred_aplicado_recargo_mora,
        cred_aplicado_costa_procesal,
        saldo_capital_multa,
        saldo_recargos_mora,
        saldo_costa_procesal_multa
    FROM cte_pagos_embargos_corriente_primer_pago
    where id_credito = 1680010 -- id_credito: 1622540 - factura_coactiva: 3089412 -  factura_coactivada: 2043428
    ORDER BY fecha_pago DESC;*/
	   SELECT cast(Cast(id_factura_coactiva AS numeric(10,0)) AS VARCHAR),
        cast(Cast(id_factura_coactivada AS numeric(10,0)) AS VARCHAR),
        cast(Cast(id_credito AS numeric(10,0)) AS VARCHAR),
        fecha_pago,
        valor_cred_apl,
        valor_capital_multa_vol,
        valor_recargos_mora_vol,
        valor_costa_procesal_multa_vol,
        cred_aplicado_coactivo,
        cred_aplicado_recargo_mora,
        cred_aplicado_costa_procesal,
        saldo_capital_multa,
        saldo_recargos_mora,
        saldo_costa_procesal_multa FROM (
        SELECT vpe.* 
        , row_number() OVER (PARTITION BY vpe.id_factura_coactiva ORDER BY id_credito ASC) AS orden_pago
        FROM integracion_terceros.dbo.v_pagos_embargos_axis_hist vpe
        INNER JOIN integracion_terceros.dbo.v_pagos_embargos_coactivos_rec vec ON vec.id_factura_coactiva = vpe.ID_FACTURA_COACTIVA
        WHERE CONVERT(DATE, FECHA_PAGO)>=CONVERT(DATE, '2023-12-01')
        AND  CONVERT(DATE, FECHA_PAGO)<=CONVERT(DATE, '2024-02-16')
        AND vec.id_tipo_coactivo = 1
        ) t
    WHERE orden_pago = 1
	and ID_CREDITO = 1679049

	--rollback
OPEN cursor_pagos_embargos
    FETCH NEXT FROM cursor_pagos_embargos 
    INTO 
        @id_factura_coactiva,
        @id_factura_coactivada,
        @id_credito,
        @fecha_pago,
        @valor_cred_apl,
        @valor_capital_multa_vol,
        @valor_recargos_mora_vol,
        @valor_costa_procesal_multa_vol,
        @cred_aplicado_coactivo,
        @cred_aplicado_recargo_mora,
        @cred_aplicado_costa_procesal,
        @saldo_capital_multa,
        @saldo_recargos_mora,
        @saldo_costa_procesal_multa

    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY 
            BEGIN TRANSACTION

            USE circulemos2;
            --- obtiene el id coactivo (ES DIFERENTE DE NUMERO DE COACTIVO)
            SELECT TOP 1 @id_coactivo = oc.id_coactivo 
            FROM obligacion_coactivo oc 
            WHERE oc.codigo_tipo_obligacion = 1 AND oc.numero_obligacion = @id_factura_coactivada;

            ---1. INSERT [registro_pago_embargo]
            INSERT INTO [circulemos2].[dbo].[registro_pago_embargo]
            (
                [valor_cheque]
                ,[fecha_recibido_cheque]
                ,[id_usuario_registro]
                ,[fecha_registro]
                ,[valor_transferencia]
                ,[fecha_transferencia]
                ,numero_cheque
                , numero_cuenta_cheque
                , id_banco_cheque
                , nombre_funcionario_banco 
            )
            VALUES
            (
                0
                ,NULL
                ,1
                ,@fecha_pago
                ,@valor_cred_apl
                ,@fecha_pago
                , 'RECONST-02-2024' 
                , 'RECONST-02=2024' 
                , 1
                , 'RECONST-02-2024' 
            );

            SET @id_registro_pago_embargo = SCOPE_IDENTITY(); 

            ---2. INSERT [pago_embargo_axis]
            INSERT INTO [circulemos2].[dbo].[pago_embargo_axis]
            (
                [id_coactivo]
                ,[codMensaje]
                ,[mensaje]
                ,[idCredito_PEM]
                ,[idCredito_EXC]
                ,[saldoCoactivo_APL]
                ,[saldoCostaProcesal_APL]
                ,[saldoRecargos_APL]
                ,[identificaAplicacion]
                ,[creditoAplicadoCoactivo]
                ,[creditoAplicadoCostaProcesal]
                ,[creditoAplicadoRecargoMoratorio]
                ,[id_registro_pago_embargo]
                ,[tipo_recaudo]
            )
            VALUES
            (
                @id_coactivo
                ,0
                ,'EXITO'
                ,@id_credito
                ,0
                ,@saldo_capital_multa
                ,@saldo_costa_procesal_multa
                ,@saldo_recargos_mora
                ,0.00
                ,@cred_aplicado_coactivo
                ,@cred_aplicado_costa_procesal
                ,@cred_aplicado_recargo_mora
                ,@id_registro_pago_embargo
                ,'Transferencia'
            );

            SET @id_pago_embargo_axis = SCOPE_IDENTITY(); 

            -- 3. INSERT [pago_embargo_axis_obligacion]
            INSERT INTO [circulemos2].[dbo].[pago_embargo_axis_obligacion]
            (
                [id_pago_embargo_axis]
                ,[id_coactivo]
                ,[numero_coactivo]
                ,[numero_obligacion]
                ,[idCredito_PEM]
                ,[idCredito_EXC]
                ,[saldoObligacion_VOL]
                ,[saldoCostaProcesal_VOL]
                ,[saldoRecargos_VOL]
                ,[saldoObligacion_APL]
                ,[saldoCostaProcesal_APL]
                ,[saldoRecargos_APL]
                ,[identificaAplicacion]
                ,[creditoAplicadoObligacion]
                ,[creditoAplicadoCostaProcesal]
                ,[creditoAplicadoRecargoMoratorio]
                ,[id_registro_pago_embargo]
                ,[tipo_recaudo]
                ,[nuevoCostaProcesal_VOL]
                ,[nuevoRecargos_VOL]
            )
            VALUES
            (
                @id_pago_embargo_axis
                ,@id_coactivo
                ,@id_factura_coactiva
                ,@id_factura_coactivada
                ,@id_credito
                ,0
                ,@valor_capital_multa_vol
                ,@valor_costa_procesal_multa_vol
                ,@valor_recargos_mora_vol
                ,@saldo_capital_multa
                ,@saldo_costa_procesal_multa
                ,@saldo_recargos_mora
                ,0.00
                ,@cred_aplicado_coactivo
                ,@cred_aplicado_costa_procesal
                ,@cred_aplicado_recargo_mora
                ,@id_registro_pago_embargo
                ,'Transferencia'
                ,@valor_costa_procesal_multa_vol -- PRIMER PAGO EMBARGO COACTIVO CORRIENTE
                ,@valor_recargos_mora_vol        -- PRIMER PAGO EMBARGO COACTIVO CORRIENTE
            );

            SET @id_pago_embargo_axis_obligacion = SCOPE_IDENTITY();

            -- 4. INSERT [it_recaudo]
            USE integracion_terceros;

            -- obtenemos la fecha y la hora
            SET @fecha_transaccion = CONVERT(DATE, @fecha_pago);
            SET @hora_transaccion = CONVERT(TIME(7), @fecha_pago);

            -- obtenemos el valor de recaudo mas alto
            SET @UltimoNumeroRecaudo = (SELECT MAX(CAST([numero_recaudo] AS BIGINT)) FROM [integracion_terceros].[dbo].[it_recaudo]);

            --- crea un nuevo numero de recaudo, sumando 1 al ultimo numero de recaudo obtenido
            SET @NuevoNumeroRecaudo = CAST(@UltimoNumeroRecaudo AS BIGINT) + 1;

            INSERT INTO [integracion_terceros].[dbo].[it_recaudo]
            (   
                fecha_creacion
                , usuario
                ,[codigo_organismo]
                ,[fecha_transaccion]
                ,[hora_transaccion]
                ,[numero_recaudo]
                ,[total_transferencia]
                ,[total_recaudo]
                ,[estado_lectura]
                ,[numero_obligacion]
                ,[valor_obligacion]
                ,[numero_cuota]
                ,[codigo_tipo_recaudo]
            )
            VALUES
            ( 
                GETDATE()
                , 'admin-c2'
                ,11001
                ,@fecha_transaccion 
                ,@hora_transaccion 
                ,@NuevoNumeroRecaudo
                ,@valor_cred_apl
                ,@valor_cred_apl
                ,1
                ,@id_factura_coactiva
                ,@valor_cred_apl
                ,0
                ,'02'
            );

            SET @id_recaudo = SCOPE_IDENTITY();

            SELECT 'EXITO'
            --COMMIT TRANSACTION
        END TRY  
        BEGIN CATCH
            IF @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;
            -- obtiene el mensaje de error
            SELECT @mensaje_error = 'Error en factura coactiva ' + CAST(@id_factura_coactiva AS VARCHAR) + 
            CHAR(13) + CHAR(10) + 
            'ErrorNumber: ' + CAST(ERROR_NUMBER() AS VARCHAR) + 
            ', ErrorSeverity: ' + CAST(ERROR_SEVERITY() AS VARCHAR) +
            ', ErrorState: ' + CAST(ERROR_STATE() AS VARCHAR) +
            ', ErrorProcedure: ' + ISNULL(ERROR_PROCEDURE(), '') +
            ', ErrorLine: ' + CAST(ERROR_LINE() AS VARCHAR) +
            ', ErrorMessage: ' + ERROR_MESSAGE();
            
            ---inserta registro que fallo en la tabla de errores
            INSERT INTO v_pagos_embargos_log_errores_insercion (
                id_creditos_embargos,
                id_coactivo,
                id_registro_pago_embargo,
                id_pago_embargo_axis,
                id_pago_embargo_axis_obligacion,
                id_recaudo,
                mensaje_error,
                fecha_registro
            )
            VALUES (
                @id_credito,
                @id_coactivo,
                @id_registro_pago_embargo,
                @id_pago_embargo_axis,
                @id_pago_embargo_axis_obligacion ,
                @id_recaudo,
                @mensaje_error,
                GETDATE() 
            );  
        END CATCH;  

        FETCH NEXT FROM cursor_pagos_embargos 
        INTO 
        @id_factura_coactiva,
        @id_factura_coactivada,
        @id_credito,
        @fecha_pago,
        @valor_cred_apl,
        @valor_capital_multa_vol,
        @valor_recargos_mora_vol,
        @valor_costa_procesal_multa_vol,
        @cred_aplicado_coactivo,
        @cred_aplicado_recargo_mora,
        @cred_aplicado_costa_procesal,
        @saldo_capital_multa,
        @saldo_recargos_mora,
        @saldo_costa_procesal_multa

    END--end while

CLOSE cursor_pagos_embargos
DEALLOCATE cursor_pagos_embargos

--select * from v_pagos_embargos_log_errores_insercion
/*
select * from integracion_terceros.dbo.it_recaudo where numero_obligacion= 13595931
select * from circulemos2.dbo.coactivo where numero_coactivo = '13630624'
select * from circulemos2.dbo.pago_embargo_axis where id_coactivo in (2253467,
2253468,
2253469)
select * from circulemos2.dbo.pago_embargo_axis_obligacion where numero_coactivo = '13630624'
select * from circulemos2.dbo.cartera where nombre  = 13464376

begin tran
update circulemos2.dbo.cartera
set saldo_interes = 0
,saldo_costas_procesales = 2.29
where id_cartera = 3906205
commit tran
*/