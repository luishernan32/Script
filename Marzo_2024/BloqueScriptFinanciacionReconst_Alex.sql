


                -- Actualizar El estado del comparendo debe estar en estado 9 - Prefinanciada  
                UPDATE comparendo 
                SET    id_estado_comparendo = 9 
                WHERE  id_factura_axis IN (SELECT [of].numero_obligacion 
                                           FROM   obligacion_financiacion [of] 
                                           WHERE  [of].id_financiacion = 
                                                  (SELECT f.id_financiacion 
                                                   FROM   financiacion f 
                                                   WHERE 
                       f.numero_financiacion = @numFinanciacion 
                       ) 
                                          ); 
										  
			  -- Se Actualiza  la cartera de las obligaciones  
                DECLARE @idCartera AS BIGINT; 
                DECLARE @valorCapital AS DECIMAL(16, 2); 
                DECLARE @valorRecargos AS DECIMAL(16, 2); 
                DECLARE @valorCostosProcesales AS DECIMAL(16, 2); 
                DECLARE @BusinessCursor AS CURSOR; 

                SET @BusinessCursor = CURSOR 
                FOR SELECT cc.id_cartera, 
                           cc.valor_obligacion         AS costo_capital, 
                           cr.valor_interes_moratorios AS costo_recargos, 
                           cp.valor_costas_procesales  AS costos_procesales 
                    FROM   (SELECT c.id_cartera, 
                                   [of].valor_obligacion 
                            FROM   financiacion f 
                                   JOIN obligacion_financiacion [of] 
                                     ON f.id_financiacion = [of].id_financiacion 
                                   JOIN cartera c 
                                     ON c.nombre = [of].numero_obligacion 
                            WHERE  f.numero_financiacion = @numFinanciacion 
                                   AND [of].numero_obligacion = c.nombre) cc 
                           LEFT JOIN (SELECT c.id_cartera, 
                                             [of].valor_interes_moratorios 
                                      FROM   financiacion f 
                                             JOIN obligacion_financiacion [of] 
                                               ON f.id_financiacion = 
                                                  [of].id_financiacion 
                                             JOIN cartera c 
                                               ON 
                                     c.nombre = [of].numero_obligacion 
                                      WHERE  f.numero_financiacion = 
                                             @numFinanciacion 
                                             AND [of].numero_obligacion = 
                                                 c.nombre) 
                                     cr 
                                  ON cc.id_cartera = cr.id_cartera 
                           LEFT JOIN (SELECT c.id_cartera, 
                                             [of].valor_costas_procesales 
                                      FROM   financiacion f 
                                             JOIN obligacion_financiacion [of] 
                                               ON f.id_financiacion = 
                                                  [of].id_financiacion 
                                             JOIN cartera c 
                                               ON 
                                     c.nombre = [of].numero_obligacion 
                                      WHERE  f.numero_financiacion = 
                                             @numFinanciacion 
                                             AND [of].numero_obligacion = 
                                                 c.nombre) 
                                     cp 
                                  ON cr.id_cartera = cp.id_cartera 

                OPEN @BusinessCursor; 

                FETCH next FROM @BusinessCursor INTO @idCartera, @valorCapital, 
                @valorRecargos, @valorCostosProcesales; 

                WHILE @@FETCH_STATUS = 0 
                  BEGIN 
                      UPDATE cartera 
                      SET    saldo_capital = @valorCapital, 
                             saldo_interes = @valorRecargos, 
                             saldo_costas_procesales = @valorCostosProcesales, 
                             codigo_estado_obligacion = 4 
                      WHERE  id_cartera = @idCartera; 
					  -- movimiento recargo
					  UPDATE movimientos_cartera
					  set valor_movimiento = @valorRecargos
					  where id_cartera = @idCartera
					  and convert(date, fecha_creacion) = convert(date, @fecha_convenio)
					  and id_concepto = 153; 
					  
					  	-- movimiento rcosta
					  UPDATE movimientos_cartera
					  set valor_movimiento = @valorCostosProcesales
					  where id_cartera = @idCartera
					  and convert(date, fecha_creacion) = convert(date, @fecha_convenio)
					  and id_concepto = 156; 


					  -- saldos cartera
					  select top 1 @idmovcartera = id_movimiento_cartera 
					  from movimientos_cartera
					  where  id_cartera = @idCartera
					  order by id_movimiento_cartera desc

					   UPDATE saldo_cartera
					  set saldo = @valorCapital
					  where id_cartera = @idCartera
					  and id_movimiento_cartera =  @idmovcartera
					  and id_tipo_saldo = 1

					  UPDATE saldo_cartera
					  set saldo = @valorRecargos
					  where id_cartera = @idCartera
					  and id_movimiento_cartera =  @idmovcartera
					  and id_tipo_saldo =2

					  UPDATE saldo_cartera
					  set saldo = @valorCostosProcesales
					  where id_cartera = @idCartera
					  and id_movimiento_cartera =  @idmovcartera
					  and id_tipo_saldo =3

                      FETCH next FROM @BusinessCursor INTO @idCartera, 
                      @valorCapital 
                      , 
                      @valorRecargos, @valorCostosProcesales; 
                  END 
				  
				  
				  -- Genera el Acumulado Financiacion
				  
				  exec circulemos2.dbo.dba_distribucion_pagos_multas 195824 -- @id_financiacion
							  