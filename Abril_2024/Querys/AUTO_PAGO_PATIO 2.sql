DECLARE @FECHA DATE

SELECT TOP 1 @FECHA = tp.fecha_inicio
FROM   coactivo c(nolock)
       JOIN proceso p(nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp(nolock)
         ON tp.id_proceso = c.id_proceso
            AND tp.id_estado_proceso = 69
WHERE  c.id_coactivo = :idCoactivo
ORDER  BY c.id_coactivo DESC

SELECT c.numero_coactivo,
       CASE per.id_tipo_identificacion
         WHEN '2' THEN pj.nombre_comercial
         ELSE Upper(Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                    ' '
                           , per.apellido2))
       END                                                       AS
       nombreCompleto,
       Concat (p.numero_obligacion, '-', Year(Sysdatetime()), '-',
       (SELECT Max(t.numero_proceso)
        FROM
       titulo_credito t
                                                                    WHERE
       id_periodo_precoactivo = :periodo), '-', (SELECT Count(*)
                                                 FROM   titulo_credito
                                                 WHERE
       id_periodo_precoactivo = :periodo))                       AS consecutivo,
       per.numero_identificacion,
       Isnull(NULLIF(Isnull((SELECT TOP 1 Cast(u.direccion_de_entrega AS VARCHAR
                                               (200))
                             FROM
                     integracion_terceros..ubicabilidad_courier_validada
                     u
                             WHERE  u.numero_identificacion =
                                    per.numero_identificacion
                             ORDER  BY fecha_registro DESC),
                            dbo.Direccionpersona(per.id_persona,
                            DEFAULT)), ''), 'GUAYAS, GUAYAQUIL') AS
       direccionDuedor,
       tp.fecha_inicio                                           AS fechaActual,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1), Lower(
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido))),
               ' '
                       , per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' '
               , per.apellido2)
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))       AS
       nombrefuncionario,
       (SELECT Concat (per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' '
               , per.apellido2)
        FROM   funcionario f,
               persona per
        WHERE  per.id_persona = f.id_persona
               AND f.fecha_final_vigencia IS NULL
               AND f.id_cargo = 4
               AND f.id_subcargo = 3)                            AS
       nombrefuncionario2,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario_coactivo f(nolock)
                       ON f.id_persona = fp.id_persona
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))       AS firma,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp(nolock)
               INNER JOIN funcionario fu(nolock)
                       ON fu.id_persona = fp.id_persona
        WHERE  fu.fecha_final_vigencia IS NULL
               AND fu.id_cargo = 4
               AND fu.id_subcargo = 3)                           AS firma2,
       ti.codigo,
       (SELECT Sum(valor_tasa)
        FROM   periodo_precoactivo
        WHERE  id_precoactivo = p.id_precoactivo
               AND estado_periodo <> 'ANULADO')                  AS v,
       (SELECT [dbo].[Convertirnumeroletra]((SELECT Sum(valor_tasa)
                                             FROM   periodo_precoactivo
                                             WHERE
               id_precoactivo = p.id_precoactivo
               AND estado_periodo <> 'ANULADO'),
               ''))                                              AS
       valorTotalLetras,
       (SELECT f.memo_nombramiento
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))       AS memo,
       (SELECT f.fecha_nombramiento
        FROM   funcionario_coactivo f,
               persona per
        WHERE  f.id_cargo = 1
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))       AS fechaMemo,
       tp.fecha_inicio                                           AS fecha3,
       (SELECT Concat (Substring(f.titulo_obtenido, 1, 1),
                       Substring(f.titulo_obtenido, 2, Len(f.titulo_obtenido)),
               ' '
                       , per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' '
               , per.apellido2,
                       ', Mgs')
        FROM   funcionario f,
               persona per
        WHERE  f.id_cargo = 11
               AND per.id_persona = f.id_persona
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 11
                     AND per.id_persona = f.id_persona
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))       AS
       nombrefuncionario3,
       p.placa_vehiculo                                          AS placa,
       tim.nombre                                                AS
       motivoRetencion,
       CASE
         WHEN tim.articulo IS NULL THEN ''
         WHEN tim.articulo <> '' THEN Concat ('dispuesto en el ', tim.articulo,
                                      ', ')
         ELSE ''
       END                                                       AS articulo,
       peri.numero_periodo,
       peri.fecha_inicio_periodo,
       peri.fecha_fin_periodo,
       peri.valor_tasa,
       CASE
         WHEN c.id_coactivo IN ( 2187299, 2187300, 2187301, 2187302,
                                 2187303, 2187304, 2187306, 2187307,
                                 2187308, 2187309, 2187310, 2187311,
                                 2187313, 2187314, 2187315, 2187317,
                                 2187318, 2187319, 2187320, 2187321,
                                 2187323, 2187324, 2187325, 2187326,
                                 2187328, 2187329, 2187330, 2187331,
                                 2187332, 2187333, 2187334, 2187335,
                                 2187336, 2187337, 2187338, 2187339,
                                 2187340, 2187341, 2187342, 2187343,
                                 2187344, 2187345, 2187346, 2187347,
                                 2187348, 2187349, 2187350, 2187351,
                                 2187352, 2187353, 2187354, 2187355,
                                 2187356, 2187357, 2187358, 2187359,
                                 2187360, 2187361, 2187362, 2187363,
                                 2187364, 2187365, 2187366, 2187367,
                                 2187368, 2187369, 2187370, 2187371,
                                 2187372, 2187373, 2187374, 2187375,
                                 2187376, 2187377, 2187378, 2187379,
                                 2187380, 2187381, 2187382, 2187383,
                                 2187384, 2187385, 2187386, 2187387,
                                 2187388, 2187389, 2187390, 2187391,
                                 2187392, 2187393, 2187394, 2187395,
                                 2187396, 2187397, 2187398, 2187399,
                                 2187400, 2187401, 2187402, 2187403,
                                 2187404, 2187405, 2187406, 2187407,
                                 2187408, 2187409, 2187410, 2187411,
                                 2187412, 2187413, 2187414, 2187415,
                                 2187416, 2187417, 2187418, 2187419,
                                 2187420, 2187421, 2187422, 2187423,
                                 2187424, 2187425, 2187426, 2187427,
                                 2187428, 2187429, 2187430, 2187431,
                                 2187432, 2187433, 2187434, 2187435,
                                 2187436, 2187437, 2187438, 2187439,
                                 2187440, 2187441, 2187442, 2187443,
                                 2187444, 2187445, 2187446, 2187447,
                                 2187448, 2187449, 2187450, 2187451,
                                 2187452, 2187453, 2187454, 2187455,
                                 2187456, 2187457, 2187458, 2187459,
                                 2187460, 2187461, 2187462, 2187463,
                                 2187464, 2187465, 2187466, 2187467,
                                 2187468, 2187469, 2187470, 2187471,
                                 2187472, 2187473, 2187474, 2187475,
                                 2187476, 2187477, 2187478, 2187479,
                                 2187480, 2187481, 2187482, 2187483,
                                 2187484, 2187485, 2187486, 2187487,
                                 2187488, 2187489, 2187490, 2187491,
                                 2187492, 2187493, 2187494, 2187495,
                                 2187496, 2187497, 2187498, 2187499,
                                 2187500, 2187501, 2187502, 2187503,
                                 2187504, 2187505, 2187506, 2187507,
                                 2187508, 2187509, 2187510, 2187511,
                                 2187512, 2187513, 2187514, 2187515,
                                 2187516, 2187517, 2187518, 2187519,
                                 2187520, 2187521, 2187522, 2187523,
                                 2187524, 2187525, 2187526, 2187527,
                                 2187528, 2187529, 2187530, 2187531,
                                 2187532, 2187533, 2187534, 2187535,
                                 2187536, 2187537, 2187538, 2187539,
                                 2187540, 2187541, 2187542, 2187543,
                                 2187544, 2187545, 2187546, 2187547,
                                 2187548, 2187549, 2187550, 2187551,
                                 2187552, 2187553, 2187554, 2187555,
                                 2187556, 2187557, 2187558, 2187559,
                                 2187560, 2187561, 2187562, 2187563,
                                 2187564, 2187565, 2187566, 2187567,
                                 2187568, 2187569, 2187570, 2187571,
                                 2187572, 2187573, 2187574, 2187575,
                                 2187576, 2187577, 2187578, 2187579,
                                 2187580, 2187581, 2187582, 2187583,
                                 2187584, 2187585, 2187586, 2187587,
                                 2187588, 2187589, 2187590, 2187591,
                                 2187592, 2187593, 2187594, 2187595,
                                 2187596, 2187597, 2187598, 2187599,
                                 2187600, 2187601, 2187602, 2187603,
                                 2187604, 2187605, 2187606, 2187607,
                                 2187608, 2187609, 2187610, 2187611,
                                 2187612, 2187613, 2187614, 2187615,
                                 2187616, 2187617, 2187618, 2187619,
                                 2187620, 2187621, 2187622, 2187623,
                                 2187624, 2187625, 2187626, 2187627,
                                 2187628, 2187629, 2187630, 2187631,
                                 2187632, 2187633, 2187634, 2187635,
                                 2187636, 2187637, 2187638, 2187639,
                                 2187640, 2187641, 2187642, 2187643,
                                 2187644, 2187645, 2187646, 2187647,
                                 2187648, 2187649, 2187650, 2187651,
                                 2187652, 2187653, 2187654, 2187655,
                                 2187656, 2187657, 2187658, 2187659,
                                 2187660, 2187661, 2187662, 2187663,
                                 2187664, 2187665, 2187666, 2187667,
                                 2187668, 2187669, 2187670, 2187671,
                                 2187672, 2187673, 2187674, 2187675,
                                 2187676, 2187677, 2187678, 2187679,
                                 2187680, 2187681, 2187682, 2187683,
                                 2187684, 2187685, 2187686, 2187687,
                                 2187688, 2187689, 2187690, 2187691,
                                 2187692, 2187693, 2187694, 2187695,
                                 2187696, 2187697, 2187698, 2187699,
                                 2187700, 2187701, 2187702, 2187703,
                                 2187704, 2187705, 2187706, 2187707,
                                 2187708, 2187709, 2187710, 2187711,
                                 2187712, 2187713, 2187714, 2187715,
                                 2187716, 2187717, 2187718, 2187719,
                                 2187720, 2187721, 2187722, 2187723,
                                 2187724, 2187725, 2187726, 2187727,
                                 2187728, 2187729, 2187730, 2187731,
                                 2187732, 2187733, 2187734, 2187735,
                                 2187736, 2187737, 2187738, 2187739,
                                 2187740, 2187741, 2187742, 2187743,
                                 2187744, 2187745, 2187746, 2187747,
                                 2187748, 2187749, 2187750, 2187751,
                                 2187752, 2187753, 2187754, 2187755,
                                 2187756, 2187757, 2187758, 2187759,
                                 2187760, 2187761, 2187762, 2187763,
                                 2187764, 2187765, 2187766, 2187767,
                                 2187768, 2187769, 2187770, 2187771,
                                 2187772, 2187773, 2187774, 2187775,
                                 2187776, 2187777, 2187778, 2187779,
                                 2187780, 2187781, 2187782, 2187783,
                                 2187784, 2187785, 2187786, 2187787,
                                 2187788, 2187789, 2187790, 2187791,
                                 2187792, 2187793, 2187794, 2187795,
                                 2187796, 2187797, 2187798, 2187799,
                                 2187800, 2187801, 2187802, 2187803,
                                 2187804, 2187805, 2187806, 2187807,
                                 2187808, 2187809, 2187810, 2187811,
                                 2187812, 2187813, 2187814, 2187815,
                                 2187816, 2187817, 2187818, 2187819,
                                 2187820, 2187821, 2187822, 2187823,
                                 2187824, 2187825, 2187826, 2187827,
                                 2187828, 2187829, 2187830, 2187831,
                                 2187832, 2187833, 2187834, 2187835,
                                 2187836, 2187837, 2187838, 2187839,
                                 2187840, 2187841, 2187842, 2187843,
                                 2187844, 2187845, 2187846, 2187847,
                                 2187848, 2187849, 2187850, 2187851,
                                 2187852, 2187853, 2187854, 2187855,
                                 2187856, 2187857, 2187858, 2187859,
                                 2187860, 2187861, 2187862, 2187863,
                                 2187864, 2187865, 2187866, 2187867,
                                 2187868, 2187869, 2187870, 2187871,
                                 2187872, 2187873, 2187874, 2187875,
                                 2187876, 2187877, 2187878, 2187879,
                                 2187880, 2187881, 2187882, 2187883,
                                 2187884, 2187885, 2187886, 2187887,
                                 2189137, 2189138, 2189139, 2189140,
                                 2189142, 2189143, 2189144, 2189145,
                                 2189146, 2189148, 2189149, 2189150,
                                 2189151, 2189152, 2189154, 2189155,
                                 2189156, 2189157, 2189158, 2189159,
                                 2189160, 2189161, 2189162, 2189163,
                                 2189164, 2189165, 2189166, 2189167,
                                 2189168, 2189169, 2189170, 2189171,
                                 2189172, 2189173, 2189174, 2189175,
                                 2189176, 2189177, 2189178, 2189179,
                                 2189180, 2189181, 2189182, 2189183,
                                 2189184, 2189185, 2189186, 2189187,
                                 2189188, 2189189, 2189190, 2189191,
                                 2189192, 2189193, 2189194, 2189195,
                                 2189196, 2189197, 2189198, 2189199,
                                 2189200, 2189201, 2189202, 2189203,
                                 2189204, 2189205, 2189206, 2189207,
                                 2189208, 2189209, 2189210, 2189211,
                                 2189212, 2189213, 2189214, 2189215,
                                 2189216, 2189217, 2189218, 2189219,
                                 2189220, 2189221, 2189222, 2189223,
                                 2189224, 2189225, 2189226, 2189227,
                                 2189228, 2189229, 2189230, 2189231,
                                 2189232, 2189233, 2189234, 2189235,
                                 2189236, 2189237, 2189238, 2189239,
                                 2189240, 2189241, 2189242, 2189243,
                                 2189244, 2189245, 2189246, 2189247,
                                 2189248, 2189249, 2189250, 2189251,
                                 2189252, 2189253, 2189254, 2189255,
                                 2189257, 2189258, 2189259, 2189260,
                                 2189261, 2189262, 2189263, 2189264,
                                 2189265, 2189266, 2189267, 2189268,
                                 2189269, 2189270, 2189271, 2189272,
                                 2189273, 2189274, 2189275, 2189276,
                                 2189277, 2189278, 2189279, 2189280,
                                 2189281, 2189282, 2189283, 2189284,
                                 2189285, 2189286, 2189287, 2189288,
                                 2189289, 2189290, 2189291, 2189292,
                                 2189293, 2189294, 2189295, 2189296,
                                 2189297, 2189298, 2189299, 2189300,
                                 2189301, 2189302, 2189303, 2189304,
                                 2189305, 2189306, 2189307, 2189308,
                                 2189309, 2189310, 2189311, 2189312,
                                 2189313, 2189314, 2189315, 2189316,
                                 2189317, 2189318, 2189319, 2189320,
                                 2189321, 2189322, 2189323, 2189324,
                                 2189325, 2189326, 2189327, 2189328,
                                 2189329, 2189330, 2189331, 2189332,
                                 2189333, 2189334, 2189335, 2189336,
                                 2189337, 2189338, 2189339, 2189340,
                                 2189341, 2189342, 2189343, 2189344,
                                 2189345, 2189346, 2189347, 2189348,
                                 2189349, 2189350, 2189351, 2189352,
                                 2189353, 2189354, 2189355, 2189356,
                                 2189357, 2189358, 2189359, 2189360,
                                 2189361, 2189362, 2189363, 2189364,
                                 2189365, 2189366, 2189367, 2189368,
                                 2189369, 2189370, 2189371, 2189372,
                                 2189373, 2189374, 2189375, 2189376,
                                 2189377, 2189378, 2189379, 2189380,
                                 2189381, 2189382, 2189383, 2189384,
                                 2189385, 2189386, 2189387, 2189388,
                                 2189389, 2189390, 2189391, 2189392,
                                 2189393, 2189394, 2189395, 2189396,
                                 2189397, 2189398, 2189399, 2189400,
                                 2189401, 2189402, 2189403, 2189404,
                                 2189405, 2189406, 2189407, 2189408,
                                 2189409, 2189410, 2189411, 2189412,
                                 2189413, 2189414, 2189415, 2189416,
                                 2189417, 2189418, 2189419, 2189420,
                                 2189421, 2189422, 2189423, 2189424,
                                 2189425, 2189426, 2189427, 2189428,
                                 2189429, 2189430, 2189431, 2189432,
                                 2189433, 2189434, 2189435, 2189436,
                                 2189437, 2189438, 2189439, 2189440,
                                 2189441, 2189442, 2189443, 2189444,
                                 2189445, 2189446, 2189447, 2189448,
                                 2189449, 2189450, 2189451, 2189452,
                                 2189453, 2189454, 2189455, 2189456,
                                 2189457, 2189458, 2189459, 2189460,
                                 2189461, 2189462, 2189463, 2189464,
                                 2189465, 2189466, 2189467, 2189468,
                                 2189469, 2189470, 2189471, 2189472,
                                 2189473, 2189474, 2189475, 2189476,
                                 2189477, 2189479, 2189480, 2189481,
                                 2189482, 2189483, 2189484, 2189485,
                                 2189486, 2189487, 2189488, 2189489,
                                 2189490, 2189491, 2189492, 2189493,
                                 2189494, 2189495, 2189496, 2189497,
                                 2189498, 2189499, 2189500, 2189501,
                                 2189502, 2189503, 2189504, 2189505,
                                 2189506, 2189507, 2189508, 2189509,
                                 2189510, 2189511, 2189512, 2189513,
                                 2189514, 2189515, 2189516, 2189517,
                                 2189518, 2189519, 2189520, 2189521,
                                 2189522, 2189523, 2189524, 2189525,
                                 2189526, 2189527, 2189528, 2189529,
                                 2189530, 2189531, 2189532, 2189533,
                                 2189534, 2189535, 2189536, 2189537,
                                 2189538, 2189539, 2189540, 2189541,
                                 2189542, 2189543, 2189544, 2189545,
                                 2189546, 2189547, 2189548, 2189549,
                                 2189550, 2189551, 2189552, 2189553,
                                 2189554, 2189555, 2189556, 2189557,
                                 2189558, 2189559, 2189560, 2189561,
                                 2189562, 2189563, 2189564, 2189565,
                                 2189566, 2189567, 2189568, 2189569,
                                 2189570, 2189571, 2189572, 2189573,
                                 2189574, 2189575, 2189576, 2189577,
                                 2189578, 2189579, 2189580, 2189581,
                                 2189582, 2189583, 2189584, 2189585,
                                 2189586, 2189587, 2189588, 2189589,
                                 2189590, 2189591, 2189592, 2189593,
                                 2189594, 2189595, 2189596, 2189597,
                                 2189598, 2189599, 2189600, 2189601,
                                 2189602, 2189603, 2189604, 2189605,
                                 2189606, 2189607, 2189608, 2189609,
                                 2189610, 2189611, 2189612, 2189613,
                                 2189614, 2189615, 2189616, 2189617,
                                 2189618, 2189619, 2189620, 2189621,
                                 2189622, 2189623, 2189624, 2189625,
                                 2189626, 2189627 ) THEN
'El presente documento sustituye cualquier otro emitido por el mismo concepto y hechos'
  ELSE ''
END                                                       AS textoMostrar
FROM   precoactivo p
       INNER JOIN coactivo c
               ON c.id_deudor = p.id_deudor
       INNER JOIN trazabilidad_proceso tp(nolock)
               ON tp.id_proceso = c.id_proceso
       INNER JOIN periodo_precoactivo peri
               ON peri.id_precoactivo = p.id_precoactivo
       INNER JOIN persona per
               ON per.id_persona = p.id_deudor
       INNER JOIN tipo_identificacion_persona ti
               ON per.id_tipo_identificacion = ti.id_tipo_identificacion
       LEFT JOIN persona_juridica pj(nolock)
              ON pj.id_persona_juridica = per.id_persona
       INNER JOIN motivo_inmovilizacion_vehiculo tim
               ON tim.id_motivo_inmovilizacion_vehiculo = p.motivo_retencion
       INNER JOIN titulo_credito t
               ON t.id_periodo_precoactivo = peri.id_periodo
WHERE  peri.fecha_notificacion_titulo IS NOT NULL
       AND peri.estado_periodo IN ( 'activo', 'inactivo' )
       AND peri.estado_notificacion = 'enviado'
       AND p.id_deudor = :deudor
       AND c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 69
       AND peri.id_periodo = :periodo 





CONSECUTIVO_ORDEN_COBRO,NOMBRE_COMPLETO,NORMA,N_DOCUMENTO_INFRACTOR,DIRECCION_INFRACTOR,FECHA_GENERACION,NOMBRE_DELEGADO,NOMBRE_SECRETARIO,IMAGEN_FIRMA,IMAGEN_FIRMA_DOS,T_DOCUMENTO_INFRACTOR,VALOR_INTERES,VALOR_TOTAL_LETRAS,TEXTO_NOTIFICACION,FECHA_EVALUACION,hora_actual,ABOGADO_PROYECTADO,placa,TEXTO_NOMBRE_1,ARTICULO,NUMERO_FACTURA,FECHA_INFRACCION,FECHA_INFRACCION2,VALOR_INTERES2,PARRAFO_1