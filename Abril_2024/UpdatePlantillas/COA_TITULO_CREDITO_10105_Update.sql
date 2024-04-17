begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SELECT DISTINCT Concat (pp.numero_ingreso, ''-'', Year(Sysdatetime()), ''-'',
                                (SELECT Max(t.numero_proceso)
                                                                           FROM
                                titulo_credito t
                                                                           WHERE
                id_periodo_precoactivo = :proceso), ''-'', (SELECT Count(*)
                                                          FROM   titulo_credito
                                                          WHERE
                                id_periodo_precoactivo = :proceso))
                AS consecutivo,
                CASE p.id_tipo_identificacion
                  WHEN ''2'' THEN pj.nombre_comercial
                  ELSE Upper(Concat (p.nombre1, '' '', p.nombre2, '' '', p.apellido1
                             , '' ''
                             , p.apellido2))
                END
                AS nombreCompleto,
                Isnull(NULLIF(Isnull((SELECT TOP 1 Cast(u.direccion_de_entrega
                                                        AS VARCHAR(200))
                                      FROM
integracion_terceros..ubicabilidad_courier_validada
u
        WHERE  u.numero_identificacion =
               p.numero_identificacion
        ORDER  BY fecha_registro DESC),
       dbo.Direccionpersona(p.id_persona,
       DEFAULT)), ''''), ''GUAYAS, GUAYAQUIL'')
AS direccion,
Getdate()
AS hora,
Getdate()
AS fecha_actual,
pa.nombre_patio,
(SELECT di.complemento
FROM   direccion di
WHERE  pa.id_patio = di.id_direccion)
AS direccionPatio,
pre.placa_vehiculo,
p.numero_identificacion,
ti.nombre
AS motivoRetencion,
pre.numero_obligacion,
pp.fecha_ingreso,
pp.fecha_inicio_periodo,
pp.fecha_fin_periodo,
(SELECT Max(valor_tasa)
FROM   periodo_precoactivo
WHERE  id_periodo = :proceso)
AS valor,
pre.dias_patio,
Getdate()
AS fecha_actual2,
(SELECT [dbo].[Convertirnumeroletra]((SELECT Max(valor_tasa)
                        FROM   periodo_precoactivo
                        WHERE
id_periodo = :proceso), '''')) AS
valorTotal,
(SELECT Max(fp.numero_imagen)
FROM   firma_persona fp(nolock)
INNER JOIN funcionario fu(nolock)
  ON fu.id_persona = fp.id_persona
WHERE  fu.id_funcionario = (SELECT Max(t.funcionario2)
               FROM   titulo_credito t
               WHERE
t.id_periodo_precoactivo = :proceso)) AS
firmaFuncionario2,
(SELECT Max(fp.numero_imagen)
FROM   firma_persona fp(nolock)
INNER JOIN funcionario fu(nolock)
  ON fu.id_persona = fp.id_persona
WHERE  fu.id_funcionario = (SELECT TOP 1 id_funcionario
               FROM   funcionario fu1
               WHERE  fu1.id_cargo = 13
                      AND fu1.fecha_final_vigencia
                          IS NULL
               ORDER  BY fu1.fecha_inicio_vigencia
                         DESC))   AS
firmaFuncionario1,
(SELECT Max(fp.numero_imagen)
FROM   firma_persona fp(nolock)
INNER JOIN funcionario fu(nolock)
  ON fu.id_persona = fp.id_persona
WHERE  fu.id_funcionario = (SELECT TOP 1 id_funcionario
               FROM   funcionario fu1
               WHERE  fu1.id_cargo = 11
                      AND fu1.fecha_final_vigencia
                          IS NULL
               ORDER  BY fu1.fecha_inicio_vigencia
                         DESC))   AS
firmaFuncionario3,
(SELECT DISTINCT Concat (p.nombre1, '' '', p.nombre2, '' ''
   , p.apellido1, '' ''
   , p.apellido2) AS s
FROM   persona p
INNER JOIN funcionario fu
  ON fu.id_persona = p.id_persona
WHERE  fu.id_funcionario = (SELECT TOP 1 id_funcionario
               FROM   funcionario fu1
               WHERE  fu1.id_cargo = 13
                      AND fu1.fecha_final_vigencia
                          IS NULL
               ORDER  BY fu1.fecha_inicio_vigencia
                         DESC))   AS
nombreFuncionario1,
(SELECT DISTINCT Concat (p.nombre1, '' '', p.nombre2, '' ''
   , p.apellido1, '' ''
   , p.apellido2) AS s
FROM   persona p
INNER JOIN funcionario fu
  ON fu.id_persona = p.id_persona
INNER JOIN precoactivo pre
  ON (SELECT Max(t.funcionario2)
      FROM   titulo_credito t
      WHERE  t.id_periodo_precoactivo = :proceso)
     =
     fu.id_funcionario)
AS nombreFuncionario2,
(SELECT DISTINCT Concat (Isnull(fu.titulo_obtenido, ''''), '' '',
   p.nombre1, '' ''
   , p.nombre2, '' ''
                    , p.apellido1, '' ''
   , p.apellido2, '', Mgs'') AS s
FROM   persona p
INNER JOIN funcionario fu
  ON fu.id_persona = p.id_persona
WHERE  fu.id_funcionario = (SELECT TOP 1 id_funcionario
               FROM   funcionario fu1
               WHERE  fu1.id_cargo = 11
                      AND fu1.fecha_final_vigencia
                          IS NULL
               ORDER  BY fu1.fecha_inicio_vigencia
                         DESC))   AS
nombreFuncionario3,
Getdate()
AS fechaActual,
pp.fecha_ingreso
AS fechaIngreso,
CASE
WHEN ti.articulo IS NULL THEN ''''
WHEN ti.articulo <> '''' THEN Concat (ti.articulo, '' -'')
ELSE ''''
END
AS articulo,
pp.numero_periodo,
Concat (CONVERT(VARCHAR, pp.fecha_inicio_periodo, 103), '' - '',
CONVERT(VARCHAR, pp.fecha_fin_periodo, 103))
AS fechas_periodo,
CASE
WHEN pp.id_periodo IN (SELECT id_periodo
           FROM   periodo_precoactivo
           WHERE  id_periodo IN (
                  9335, 9387, 9403
                  , 10392,
                  10650, 10673, 10714, 10729,
                  10736, 10772, 10781, 10800,
                  10805, 10830, 10866, 10884,
                  10897, 10902, 10903, 10911,
                  10917, 10927, 10937, 10940,
                  10941, 10942, 10977, 10979,
                  10980, 10987, 10997, 11002,
                  11009, 11015, 11018, 11033,
                  11034, 11069, 11108, 11161,
                  11189, 11191, 11273, 11276,
                  11282, 11302, 11336, 11461,
                  11517, 11518, 11554, 11586,
                  11678, 11692, 11694, 11715,
                  11717, 11739, 11741, 11750,
                  11784, 11798, 11830, 11862,
                  11865, 11893, 11914, 11931,
                  11947, 11965, 11972, 11984,
                  11998, 11999, 12009, 12035,
                  12807, 12812, 12820, 12822,
                  12827, 12847, 12849, 12852,
                  12855, 12856, 12863, 12874,
                  12881, 12882, 12890, 12894,
                  12895, 12901, 12902, 12915,
                  12918, 12922, 12927, 12929,
                  12933, 12940, 12955, 12956,
                  12973, 12984, 12998, 13008,
                  13010, 13011, 13027, 13044,
                  13047, 13059, 13066, 13080,
                  13084, 13104, 13105, 13111,
                  13116, 13123, 13126, 13132,
                  13142, 13144, 13146, 13163,
                  13176, 13205, 13213, 13224,
                  13240, 13252, 13253, 13271,
                  13288, 13295, 13297, 13304,
                  13323, 13324, 13330, 13332,
                  13334, 13345, 13357, 13367,
                  13374, 13381, 13387, 13411,
                  13437, 13448, 13454, 13466,
                  13502, 13509, 13536, 13539,
                  13546, 13547, 13548, 13557,
                  13567, 13576, 13585, 13597,
                  13598, 13610, 13620, 13636,
                  13644, 13649, 13650, 13676,
                  13685, 13698, 13703, 13712,
                  13714, 13722, 13779, 13787,
                  13789, 13798, 13800, 13801,
                  13805, 13827, 13832, 13833,
                  13837, 13888, 13911, 13920,
                  13924, 13942, 13959, 13970,
                  13978, 13981, 13989, 13998,
                  14012, 14017, 14020, 14023,
                  14030, 14034, 14047, 14064,
                  14071, 14088, 14099, 14121,
                  14162, 14168, 14170, 14178,
                  14214, 14226, 14229, 14248,
                  14251, 14276, 14294, 14296,
                  14314, 14331, 14345, 14352,
                  14355, 14363, 14367, 14385,
                  14391, 14392, 14401, 14405,
                  14419, 14428, 14429, 14450,
                  14453, 14455, 14457, 14472,
                  14493, 14496, 14543, 14545,
                  14551, 14578, 14582, 14590,
                  14605, 14606, 14618, 14626,
                  14631, 14633, 14639, 14640,
                  14641, 14642, 14682, 14693,
                  14702, 14706, 14710, 14724,
                  14732, 14738, 14745, 14756,
                  14761, 14776, 14779, 14783,
                  14786, 14787, 14801, 14803,
                  14805, 14814, 14824, 14842,
                  14846, 14854, 14856, 14870,
                  14875, 14890, 14915, 14931,
                  14943, 14950, 14966, 15006,
                  15010, 15011, 15036, 15052,
                  15056, 15066, 15073, 15079,
                  15080, 15114, 15115, 15125,
                  15132, 15152, 15181, 15216,
                  15271, 15306, 15311, 15336,
                  15349, 15354, 15374, 15382,
                  15386, 15398, 15401, 15403,
                  15415, 15416, 15421, 15437,
                  15449, 15474, 15486, 15487,
                  15499, 15524, 15527, 15532,
                  15541, 15549, 15559, 15560,
                  15613, 15628, 15629, 15666,
                  15681, 15684, 15691, 15698,
                  15756, 15767, 15796, 15800,
                  15820, 15837, 15840, 15853,
                  15859, 15873, 15883, 15924,
                  15926, 15934, 15938, 15940,
                  15944, 15958, 15962, 15965,
                  15977, 15983, 15994, 16005,
                  16021, 16028, 16032, 16067,
                  16079, 16087, 16092, 16105,
                  16108, 16110, 16120, 16130,
                  16189, 16190, 16222, 16229,
                  16232, 16239, 16262, 16310,
                  16315, 16346, 16366, 16395,
                  16428, 16430, 16434, 16441,
                  16448, 16466, 16487, 16494,
                  16499, 16504, 16520, 16541,
                  16557, 16572, 16583, 16586,
                  16590, 16593, 16600, 16604,
                  16621, 16646, 16655, 16661,
                  16664, 16676, 16677, 16678,
                  16687, 16688, 16692, 16709,
                  16733, 16741, 16742, 16743,
                  16749, 16760, 16775, 16786,
                  16794, 16801, 16817, 16818,
                  16823, 16834, 16835, 16852,
                  16854, 16860, 16873, 16884,
                  16886, 16909, 16910, 16923,
                  16934, 16948, 16974, 16982,
                  17000, 17032, 17048, 17055,
                  17059, 17077, 17095, 17096,
                  17097, 17098, 17134, 17140,
                  17143, 17170, 17178, 17191,
                  17216, 17229, 17241, 17252,
                  17259, 17277, 17321, 17324,
                  17326, 17343, 17409, 17410,
                  17412, 17419, 17426, 17478,
                  17491, 17492, 17497, 17506,
                  17545, 17549, 17579, 17586,
                  17594, 17604, 17607, 17612,
                  17619, 17624, 17650, 17700,
                  17704, 17709, 17712, 17722,
                  17737, 17744, 17745, 17752,
                  17760, 17764, 17773, 17776,
                  17784, 17805, 17806, 17817,
                  17835, 17872, 17887, 17901,
                  17923, 17934, 17939, 17940,
                  17949, 17960, 17962, 17973,
                  17985, 17990, 18048, 18075,
                  18095, 18102, 18116, 18155,
                  18185, 18203, 18213, 18233,
                  18240, 18271, 18272, 18273,
                  18291, 18298, 18304, 18317,
                  18325, 18329, 18341, 18353,
                  18380, 18381, 18382, 18383,
                  18388, 18396, 18413, 18417,
                  18444, 18454, 18463, 18477,
                  18509, 18528, 18555, 18573,
                  18579, 18592, 18605, 18630,
                  18688, 18695, 18709, 18715,
                  18737, 18755, 18782, 18784,
                  18805, 18806, 18822, 18823,
                  18829, 18840, 18844, 18902,
                  18938, 18942, 18944, 18956,
                  18958, 18991, 19013, 19042,
                  19053, 19057, 19058, 19495,
                  27362, 27377, 27388, 27448,
                  66942, 67074 )
           UNION
           SELECT id_periodo
           FROM   periodo_precoactivo
           WHERE  id_periodo IN ( 167633, 167634,
                                  167795 )) THEN
''El presente documento sustituye cualquier otro emitido por el mismo concepto y hechos''
ELSE ''''
END                                                                       AS
textoMostrar,
(SELECT SUBSTRING(valor_parametro_defecto,18,62)
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 434) AS CARGO_DELEGADO 
FROM   precoactivo pre
INNER JOIN persona p
ON p.id_persona = pre.id_deudor
LEFT JOIN persona_juridica pj(nolock)
ON pj.id_persona_juridica = p.id_persona
INNER JOIN motivo_inmovilizacion_vehiculo ti
ON ti.id_motivo_inmovilizacion_vehiculo = pre.motivo_retencion
LEFT JOIN direccion_persona dp
ON dp.id_persona = p.id_persona
LEFT JOIN direccion di
ON di.id_direccion = dp.id_direccion
INNER JOIN patio pa
ON pa.id_patio = pre.id_patio
INNER JOIN periodo_precoactivo pp
ON pp.id_precoactivo = pre.id_precoactivo
LEFT JOIN titulo_credito titulo
ON titulo.id_periodo_precoactivo = pp.id_precoactivo
WHERE  pp.estado_periodo IN ( ''activo'', ''inactivo'' )
AND pp.estado_notificacion = :estadoNotificacion
AND pre.id_deudor = :deudor
AND id_periodo = :proceso 
'               
	   , orden_variables='NORMA,NOMBRE_INFRACTOR,DIRECCION_INFRACTOR,hora_actual,FECHA_CALIBRACION,NOMBRE_COMPLETO,DIRECCION_COACTIVA,placa,N_DOCUMENTO_INFRACTOR,TEXTO_NOTIFICACION,NUMERO_OBLIGACION,FECHA_INFRACCION,FECHA_SENTAR_RAZON_FALLO,FECHA_SOLICITUD,VALOR_INTERES,DIAS_COBRO,FECHA_INFRACCION3,VALOR_TOTAL_LETRAS,IMAGEN_FIRMA,IMAGEN_FIRMA_CINCO,IMAGEN_FIRMA_DOS,NOMBRE_ABOGADO,TEXTO_NOMBRE_1,NOMBRE_ABOGADO_PAT,FECHA_EVALUACION,FECHA_SENTAR_RAZON_FALLO,TIPO_BIEN,NUMERO_FACTURA,FECHA_TEXTO,PARRAFO_1,CARGO_DELEGADO'
WHERE  id_plantilla_config=10105


commit tran


--10105







