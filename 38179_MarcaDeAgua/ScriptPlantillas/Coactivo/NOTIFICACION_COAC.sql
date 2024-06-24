--NOTIFICACION_COAC 2621 40




		
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'DECLARE @FECHA DATETIME2

SELECT TOP 1 @FECHA = CASE c.id_tipo_coactivo
                        WHEN 3 THEN tp.fecha_inicio
                        ELSE p.fecha_inicio
                      END
FROM   coactivo c
       JOIN proceso p (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = p.id_proceso
WHERE  c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 24
ORDER  BY tp.fecha_inicio DESC

SELECT c.id_coactivo,
       Concat(p.numero_proceso, ''-'', Year(p.fecha_inicio))            AS
       ''numeroJuicio'',
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, '' '', pe.nombre2, '' '', pe.apellido1, '' '',
                    pe.apellido2))
       END                                                            AS
       nombreCompleto,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Direccionpersona(pe.id_persona, DEFAULT)                   AS
       Direccion,
       @FECHA,
       (SELECT Count(id_documento_proceso)
        FROM   documento_proceso
        WHERE  id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               AND id_tipo_documento_proceso = 10)
       + 1                                                            AS
       cantidadDocs,
       Cast((SELECT DISTINCT Substring((SELECT ( Concat(''-'', c1.numero_citacion)
                                               ) AS
                                                    [text()]
                                        FROM   obligacion_coactivo cp1 (nolock)
                                               JOIN comparendo c1 (nolock)
                                                 ON cp1.numero_obligacion =
                                                    c1.id_factura_axis
                                        WHERE  cp1.id_coactivo = cp2.id_coactivo
                                        ORDER  BY cp1.id_coactivo
                                        FOR xml path ('''')), 1, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max)) citacion,
       Cast((SELECT DISTINCT Substring((SELECT '',''
                                               + Concat(c.numero_citacion,
                                               '' de fecha ''
                                               ,
            Format(c.fecha_infraccion,
            ''dd \de MMMM \de yyyy''),
            '', tipificada y sancionada en el artículo '',
            ci.articulo, '', numeral '', i.numeral_infraccion, '' - '',
            nm.nombre) AS
                      [text()]
            FROM   obligacion_coactivo cp1 (nolock)
            INNER JOIN comparendo c (nolock)
            ON cp1.numero_obligacion = c.id_factura_axis
            INNER JOIN infraccion i (nolock)
            ON c.id_infraccion = i.id_infraccion
            INNER JOIN configuracion_infraccion ci (nolock)
            ON i.id_infraccion = ci.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
            INNER JOIN normatividad nm (nolock)
            ON nm.id_normatividad = ci.id_normatividad
            WHERE  cp1.id_coactivo = cp2.id_coactivo
            ORDER  BY cp1.id_coactivo
            FOR xml path ('''')), 2, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max))
       descripcion,
       Upper(Concat(per.nombre1, '' '', per.nombre2, '' '', per.apellido1, '' '',
             per.apellido2))                                          AS
       nombreAbogado,
       Day(@FECHA)                                                    AS Dia,
       @FECHA                                                         AS
       horaSolicitud,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
        WHERE  fp.id_persona = per.id_persona)                        AS firma,
       CASE
         WHEN c.id_tramite < 0 THEN ''0''
         ELSE c.id_tramite
       END                                                            AS
       numeroPago,
       Cast((SELECT DISTINCT Substring((SELECT ( Concat(''-'', c1.id_factura_axis)
                                               ) AS
                                                    [text()]
                                        FROM   obligacion_coactivo cp1 (nolock)
                                               JOIN comparendo c1 (nolock)
                                                 ON cp1.numero_obligacion =
                                                    c1.id_factura_axis
                                        WHERE  cp1.id_coactivo = cp2.id_coactivo
                                        ORDER  BY cp1.id_coactivo
                                        FOR xml path ('''')), 1, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max)) facturas,
       (SELECT Concat(f.memo_nombramiento, '', de fecha '', Cast(
                       Format(f.fecha_nombramiento, ''dd \de MMMM \de yyyy'') AS
                       VARCHAR(
                       50)))
        FROM   funcionario_coactivo f (nolock)
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       datosNombramiento,
       (SELECT Concat(f.titulo_obtenido, ''. '', Upper(
                       Concat(per.nombre1, '' '', per.nombre2, '' '', per.apellido1,
                       '' '',
                                                       per.apellido2)))
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
               INNER JOIN coactivo_funcionario cf (nolock)
                       ON f.id_funcionario = cf.id_funcionario
        WHERE  cf.id_coactivo = c.id_coactivo)                        AS
       titulo_nombreFuncionario,
       (SELECT o.norma
        FROM   organismo_normatividad o (nolock)
        WHERE  ( o.estado = 1
                 AND o.codigo_organismo = 11001
                 AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                 AND o.fecha_final_vigencia >= CONVERT(DATE, @FECHA) )
                OR ( o.estado = 1
                     AND o.codigo_organismo = 11001
                     AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND o.fecha_final_vigencia IS NULL ))            AS norma,
       (SELECT Concat(Isnull(f.titulo_obtenido, ''''), '' '', per.nombre1, '' '',
               per.nombre2, '' '',
                       per.apellido1, '' '', per.apellido2, '', Mgs'')
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 11
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       director_gestion_infracciones,
       CASE
         WHEN c.id_coactivo IN ( 2182235, 2182238, 2182242, 2182246,
                                 2182252, 2182257, 2182258, 2182259,
                                 2182264, 2182271, 2182272, 2182276,
                                 2182295, 2182298, 2182312, 2182317,
                                 2182323, 2182329, 2182332, 2182339,
                                 2182349, 2182353, 2182354, 2183060,
                                 2183148, 2183498, 2183500, 2183504,
                                 2183510, 2183512, 2183517, 2183518,
                                 2183533, 2183537, 2183538, 2183551,
                                 2183555, 2183559, 2183561, 2183566,
                                 2183572, 2183577, 2183578, 2183583,
                                 2183588, 2183590, 2183591, 2183597,
                                 2183602, 2183603, 2183607, 2183608,
                                 2183609, 2183610, 2183616, 2183619,
                                 2183620, 2183621, 2183622, 2183624,
                                 2183643, 2183646, 2183650, 2183654,
                                 2183656, 2183657, 2183665, 2183671,
                                 2183672, 2183673, 2183674, 2183679,
                                 2183696, 2183697, 2183701, 2183708,
                                 2183714, 2183720, 2183725, 2183728,
                                 2183733, 2183742, 2186755, 2186790,
                                 2186791, 2186792, 2186793, 2186794,
                                 2186796, 2186797, 2186798, 2186799,
                                 2186800, 2186801, 2186802, 2186803,
                                 2186805, 2186806, 2186807, 2186808,
                                 2186809, 2186812, 2186813, 2186814,
                                 2186815, 2186816, 2186817, 2186818,
                                 2186819, 2186820, 2186821, 2186822,
                                 2186823, 2186824, 2186825, 2186826,
                                 2186827, 2186828, 2186829, 2186830,
                                 2186831, 2186832, 2186833, 2186834,
                                 2186835, 2186836, 2186837, 2186838,
                                 2186839, 2186840, 2186841, 2186842,
                                 2186843, 2186844, 2186845, 2186846,
                                 2186847, 2186848, 2186849, 2186850,
                                 2186851, 2186852, 2186853, 2186854,
                                 2186855, 2186856, 2186857, 2186859,
                                 2186860, 2186861, 2186862, 2186863,
                                 2186864, 2186865, 2186866, 2186867,
                                 2186868, 2186869, 2186870, 2186871,
                                 2186872, 2186873, 2186874, 2186875,
                                 2186876, 2186877, 2186878, 2186879,
                                 2186880, 2186881, 2186882, 2186883,
                                 2186884, 2186885, 2186886, 2186887,
                                 2186888, 2186889, 2186890, 2186891,
                                 2186892, 2186893, 2186894, 2186895,
                                 2186896, 2186897, 2186898, 2186899,
                                 2186900, 2186901, 2186902, 2186904,
                                 2186905, 2186906, 2186907, 2186908,
                                 2186909, 2186910, 2186911, 2186912,
                                 2186913, 2186914, 2186915, 2186916,
                                 2186917, 2186918, 2186919, 2186920,
                                 2186921, 2186923, 2186924, 2186925,
                                 2186926, 2186927, 2186928, 2186930,
                                 2186931, 2186932, 2186933, 2186934,
                                 2186935, 2186937, 2186938, 2186939,
                                 2186940, 2186941, 2186942, 2186943,
                                 2186944, 2186945, 2186946, 2186947,
                                 2186948, 2186949, 2186950, 2186951,
                                 2186952, 2186953, 2186954, 2186955,
                                 2186956, 2186957, 2186958, 2186959,
                                 2186960, 2186961, 2186962, 2186963,
                                 2186964, 2186965, 2186966, 2186967,
                                 2186968, 2186969, 2186970, 2186971,
                                 2186972, 2186973, 2186974, 2186976,
                                 2186977, 2186978, 2186979, 2186980,
                                 2186981, 2186982, 2186983, 2186984,
                                 2186985, 2186986, 2186987, 2186988,
                                 2186989, 2186990, 2186991, 2186992,
                                 2186993, 2186994, 2186995, 2186996,
                                 2186997, 2186998, 2186999, 2187000,
                                 2187001, 2187002, 2187003, 2187004,
                                 2187005, 2187006, 2187007, 2187008,
                                 2187009, 2187010, 2187011, 2187012,
                                 2187013, 2187014, 2187015, 2187016,
                                 2187017, 2187019, 2187020, 2187021,
                                 2187022, 2187023, 2187024, 2187025,
                                 2187026, 2187027, 2187028, 2187029,
                                 2187030, 2187031, 2187032, 2187033,
                                 2187034, 2187035, 2187036, 2187037,
                                 2187038, 2187039, 2187040, 2187041,
                                 2187042, 2187043, 2187044, 2187045,
                                 2187046, 2187047, 2187048, 2187049,
                                 2187050, 2187051, 2187052, 2187053,
                                 2187054, 2187055, 2187056, 2187057,
                                 2187058, 2187059, 2187060, 2187061,
                                 2187062, 2187063, 2187064, 2187065,
                                 2187066, 2187067, 2187068, 2187069,
                                 2187071, 2187072, 2187073, 2187074,
                                 2187075, 2187077, 2187078, 2187079,
                                 2187080, 2187081, 2187082, 2187083,
                                 2187084, 2187085, 2187086, 2187087,
                                 2187088, 2187089, 2187090, 2187091,
                                 2187092, 2187093, 2187094, 2187095,
                                 2187096, 2187097, 2187100, 2187102,
                                 2187103, 2187104, 2187105, 2187106,
                                 2187107, 2187108, 2187110, 2187114,
                                 2187115, 2187116, 2187117, 2187118,
                                 2187119, 2187120, 2187121, 2187122,
                                 2187123, 2187124, 2187125, 2187126,
                                 2187127, 2187129, 2187130, 2187131,
                                 2187132, 2187133, 2187134, 2187135,
                                 2187136, 2187139, 2187140, 2187141,
                                 2187142, 2187144, 2187145, 2187146,
                                 2187147, 2187148, 2187150, 2187153,
                                 2187154, 2187156, 2187157, 2187159,
                                 2187163, 2187166, 2187167, 2187171,
                                 2187172, 2187173, 2187174, 2187175,
                                 2187177, 2187178, 2187179, 2187180,
                                 2187181, 2187182, 2187183, 2187187,
                                 2187188, 2187190, 2187191, 2187194,
                                 2187195, 2187196, 2187197, 2187198,
                                 2187199, 2187200, 2187202, 2187203,
                                 2187205, 2187206, 2187207, 2187208,
                                 2187214, 2187216, 2187219, 2187222,
                                 2187223, 2187224, 2187225, 2187229,
                                 2187230, 2187231, 2187233, 2187234,
                                 2187235, 2187238, 2187240, 2187242,
                                 2187243, 2187244, 2187246, 2187247,
                                 2187248, 2187249, 2187250, 2187251,
                                 2187255, 2187256, 2187257, 2187260,
                                 2187262, 2187264, 2187267, 2187269,
                                 2187271, 2187272, 2187273, 2187274,
                                 2187276, 2187277, 2187278, 2187279,
                                 2187280, 2187281, 2187282, 2187283,
                                 2187285, 2187287, 2187288, 2187289,
                                 2187290, 2187291, 2187292, 2187295,
                                 2187296, 2187305, 2187312, 2187316,
                                 2187322, 2187327, 2187931, 2188011,
                                 2188016, 2188033, 2188034, 2188035,
                                 2188036, 2188037, 2188038, 2188039,
                                 2188040, 2188041, 2188042, 2188043,
                                 2188044, 2188045, 2188046, 2188047,
                                 2188048, 2188049, 2188050, 2188051,
                                 2188055, 2188075, 2188076, 2188077,
                                 2188078, 2188079, 2188080, 2188081,
                                 2188082, 2188083, 2188084, 2188086,
                                 2188087, 2188088, 2188089, 2188090,
                                 2188091, 2188092, 2188093, 2188094,
                                 2188095, 2188096, 2188097, 2188099,
                                 2188100, 2188101, 2188102, 2188103,
                                 2188104, 2188105, 2188106, 2188107,
                                 2188108, 2188109, 2188110, 2188111,
                                 2188112, 2188113, 2188114, 2188115,
                                 2188116, 2188117, 2188118, 2188119,
                                 2188120, 2188121, 2188122, 2188123,
                                 2188125, 2188126, 2188127, 2188128,
                                 2188129, 2188130, 2188131, 2188132,
                                 2188133, 2188134, 2188135, 2188136,
                                 2188137, 2188138, 2188139, 2188140,
                                 2188141, 2188142, 2188143, 2188144,
                                 2188145, 2188146, 2188147, 2188148,
                                 2188149, 2188150, 2188152, 2188153,
                                 2188154, 2188155, 2188156, 2188157,
                                 2188158, 2188159, 2188160, 2188161,
                                 2188162, 2188163, 2188164, 2188165,
                                 2188166, 2188167, 2188168, 2188169,
                                 2188170, 2188171, 2188172, 2188173,
                                 2188174, 2188175, 2188176, 2188177,
                                 2188178, 2188179, 2188180, 2188181,
                                 2188182, 2188183, 2188184, 2188185,
                                 2188186, 2188187, 2188188, 2188189,
                                 2188191, 2188193, 2188194, 2188195,
                                 2188196, 2188197, 2188198, 2188199,
                                 2188200, 2188201, 2188202, 2188203,
                                 2188204, 2188205, 2188206, 2188207,
                                 2188208, 2188209, 2188210, 2188211,
                                 2188212, 2188213, 2188214, 2188215,
                                 2188216, 2188217, 2188218, 2188219,
                                 2188220, 2188221, 2188222, 2188223,
                                 2188224, 2188225, 2188226, 2188227,
                                 2188228, 2188229, 2188230, 2188231,
                                 2188232, 2188234, 2188235, 2188236,
                                 2188237, 2188238, 2188239, 2188240,
                                 2188241, 2188242, 2188243, 2188244,
                                 2188245, 2188246, 2188247, 2188248,
                                 2188249, 2188250, 2188251, 2188252,
                                 2188253, 2188254, 2188255, 2188256,
                                 2188257, 2188258, 2188259, 2188260,
                                 2188261, 2188262, 2188263, 2188264,
                                 2188265, 2188266, 2188267, 2188268,
                                 2188269, 2188270, 2188271, 2188272,
                                 2188273, 2188274, 2188275, 2188276,
                                 2188277, 2188278, 2188279, 2188280,
                                 2188281, 2188282, 2188283, 2188284,
                                 2188285, 2188286, 2188287, 2188288,
                                 2188289, 2188290, 2188292, 2188293,
                                 2188294, 2188295, 2188296, 2188297,
                                 2188298, 2188299, 2188300, 2188301,
                                 2188302, 2188303, 2188304, 2188305,
                                 2188306, 2188307, 2188308, 2188309,
                                 2188310, 2188311, 2188312, 2188313,
                                 2188314, 2188315, 2188316, 2188317,
                                 2188318, 2188319, 2188320, 2188321,
                                 2188322, 2188323, 2188324, 2188325,
                                 2188326, 2188327, 2188328, 2188329,
                                 2188330, 2188331, 2188332, 2188333,
                                 2188334, 2188335, 2188336, 2188337,
                                 2188339, 2188340, 2188341, 2188342,
                                 2188343, 2188344, 2188345, 2188346,
                                 2188348, 2188349, 2188350, 2188351,
                                 2188352, 2188353, 2188354, 2188355,
                                 2188356, 2188357, 2188361, 2188362,
                                 2188363, 2188364, 2188365, 2188366,
                                 2188367, 2188368, 2188369, 2188370,
                                 2188371, 2188372, 2188373, 2188374,
                                 2188375, 2188376, 2188377, 2188378,
                                 2188379, 2188380, 2188381, 2188382,
                                 2188383, 2188385, 2188386, 2188387,
                                 2188388, 2188389, 2188390, 2188392,
                                 2188393, 2188394, 2188399, 2188400,
                                 2188401, 2188402, 2188403, 2188404,
                                 2188405, 2188406, 2188408, 2188409,
                                 2188410, 2188411, 2188412, 2188413,
                                 2188414, 2188415, 2188416, 2188418,
                                 2188419, 2188420, 2188421, 2188422,
                                 2188424, 2188425, 2188426, 2188427,
                                 2188428, 2188429, 2188430, 2188431,
                                 2188432, 2188433, 2188434, 2188435,
                                 2188436, 2188437, 2188439, 2188440,
                                 2188441, 2188442, 2188443, 2188444,
                                 2188445, 2188446, 2188447, 2188448,
                                 2188449, 2188450, 2188451, 2188452,
                                 2188453, 2188454, 2188455, 2188456,
                                 2188457, 2188459, 2188460, 2188461,
                                 2188462, 2188463, 2188464, 2188465,
                                 2188466, 2188467, 2188468, 2188469,
                                 2188471, 2188472, 2188473, 2188474,
                                 2188475, 2188476, 2188478, 2188479,
                                 2188480, 2188481, 2188482, 2188483,
                                 2188484, 2188485, 2188486, 2188487,
                                 2188489, 2188491, 2188492, 2188493,
                                 2188494, 2188495, 2188496, 2188497,
                                 2188498, 2188500, 2188502, 2188503,
                                 2188504, 2188505, 2188506, 2188507,
                                 2188508, 2188509, 2188510, 2188511,
                                 2188512, 2188513, 2188514, 2188515,
                                 2188516, 2188518, 2188519, 2188520,
                                 2188522, 2188523, 2188525, 2188526,
                                 2188527, 2188528, 2188529, 2188530,
                                 2188531, 2188532, 2188533, 2188534,
                                 2188536, 2188537, 2188538, 2188539,
                                 2188540, 2188541, 2188542, 2188543,
                                 2188544, 2188545, 2188547, 2188548,
                                 2188549, 2188550, 2188551, 2188552,
                                 2188553, 2188555, 2188556, 2188558,
                                 2188559, 2188561, 2188562, 2188563,
                                 2188564, 2188565, 2188566, 2188567,
                                 2188568, 2188569, 2188570, 2188571,
                                 2188572, 2188573, 2188574, 2188575,
                                 2188576, 2188577, 2188578, 2188579,
                                 2188580, 2188581, 2188582, 2188583,
                                 2188584, 2188585, 2188586, 2188587,
                                 2188588, 2188589, 2188591, 2188592,
                                 2188593, 2188594, 2188595, 2188596,
                                 2188597, 2188598, 2188599, 2188600,
                                 2188601, 2188602, 2188603, 2188604,
                                 2188606, 2188607, 2188608, 2188609,
                                 2188610, 2188611, 2188612, 2188613,
                                 2188614, 2188615, 2188616, 2188617,
                                 2188618, 2188619, 2188620, 2188621,
                                 2188622, 2188623, 2188624, 2188625,
                                 2188626, 2188627, 2188628, 2188629,
                                 2188630, 2188631, 2188632, 2188633,
                                 2188634, 2188635, 2188636, 2188637,
                                 2188638, 2188639, 2188641, 2188644,
                                 2188645, 2188646, 2188647, 2188648,
                                 2188649, 2188650, 2188651, 2188652,
                                 2188653, 2188654, 2188656, 2188658,
                                 2188660, 2188661, 2188664, 2188665,
                                 2188666, 2188667, 2188668, 2188669,
                                 2188670, 2188671, 2188672, 2188673,
                                 2188674, 2188675, 2188676, 2188679,
                                 2188680, 2188681, 2188682, 2188683,
                                 2188684, 2188685, 2188686, 2188687,
                                 2188688, 2188689, 2188690, 2188691,
                                 2188692, 2188693, 2188694, 2188695,
                                 2188696, 2188698, 2188699, 2188702,
                                 2188704, 2188705, 2188706, 2188708,
                                 2188709, 2188710, 2188711, 2188712,
                                 2188713, 2188714, 2188715, 2188717,
                                 2188718, 2188719, 2188720, 2188722,
                                 2188723, 2188724, 2188725, 2188726,
                                 2188727, 2188728, 2188729, 2188730,
                                 2188731, 2188732, 2188733, 2188734,
                                 2188735, 2188736, 2188737, 2188738,
                                 2188739, 2188740, 2188741, 2188742,
                                 2188743, 2188744, 2188745, 2188746,
                                 2188747, 2188748, 2188749, 2188750,
                                 2188751, 2188752, 2188753, 2188754,
                                 2188755, 2188756, 2188757, 2188758,
                                 2188759, 2188760, 2188761, 2188762,
                                 2188763, 2188764, 2188765, 2188766,
                                 2188767, 2188768, 2188769, 2188770,
                                 2188771, 2188772, 2188773, 2188774,
                                 2188775, 2188776, 2188777, 2188778,
                                 2188779, 2188780, 2188781, 2188782,
                                 2188783, 2188784, 2188785, 2188786,
                                 2188788, 2188789, 2188790, 2188791,
                                 2188792, 2188793, 2188794, 2188795,
                                 2188796, 2188797, 2188798, 2188799,
                                 2188800, 2188801, 2188802, 2188803,
                                 2188804, 2188805, 2188806, 2188807,
                                 2188808, 2188809, 2188810, 2188811,
                                 2188812, 2188813, 2188814, 2188815,
                                 2188816, 2188817, 2188818, 2188819,
                                 2188820, 2188821, 2188822, 2188823,
                                 2188824, 2188825, 2188826, 2188827,
                                 2188828, 2188829, 2188830, 2188831,
                                 2188832, 2188833, 2188834, 2188835,
                                 2188836, 2188837, 2188838, 2188839,
                                 2188840, 2188841, 2188842, 2188843,
                                 2188844, 2188845, 2188846, 2188847,
                                 2188848, 2188849, 2188850, 2188851,
                                 2188852, 2188854, 2188855, 2188856,
                                 2188857, 2188858, 2188859, 2188860,
                                 2188861, 2188862, 2188863, 2188864,
                                 2188865, 2188866, 2188868, 2188869,
                                 2188872, 2188873, 2188874, 2188877,
                                 2188878, 2188879, 2188881, 2188882,
                                 2188883, 2188884, 2188885, 2188886,
                                 2188888, 2188890, 2188891, 2188892,
                                 2188893, 2188897, 2188898, 2188899,
                                 2188901, 2188902, 2188905, 2188906,
                                 2188907, 2188908, 2188909, 2188911,
                                 2188912, 2188913, 2188921, 2188922,
                                 2188924, 2188927, 2188928, 2188929,
                                 2188930, 2188931, 2188932, 2188933,
                                 2188934, 2188935, 2188939, 2188941,
                                 2188942, 2188943, 2188944, 2188945,
                                 2188947, 2188949, 2188951, 2188952,
                                 2188954, 2188955, 2188956, 2188957,
                                 2188958, 2188959, 2188960, 2188961,
                                 2188962, 2188965, 2188966, 2188967,
                                 2188969, 2188971, 2188972, 2188973,
                                 2188974, 2188976, 2188977, 2188978,
                                 2188979, 2188980, 2188982, 2188985,
                                 2188986, 2188988, 2188989, 2188990,
                                 2188991, 2188994, 2188995, 2188998,
                                 2188999, 2189000, 2189003, 2189004,
                                 2189005, 2189006, 2189007, 2189008,
                                 2189011, 2189012, 2189014, 2189015,
                                 2189018, 2189019, 2189021, 2189029,
                                 2189030, 2189031, 2189032, 2189036,
                                 2189037, 2189038, 2189039, 2189040,
                                 2189041, 2189043, 2189044, 2189046,
                                 2189049, 2189051, 2189052, 2189054,
                                 2189055, 2189057, 2189058, 2189060,
                                 2189061, 2189062, 2189065, 2189066,
                                 2189067, 2189068, 2189069, 2189071,
                                 2189073, 2189074, 2189078, 2189081,
                                 2189082, 2189083, 2189084, 2189085,
                                 2189088, 2189089, 2189090, 2189092,
                                 2189093, 2189094, 2189097, 2189100,
                                 2189102, 2189103, 2189104, 2189107,
                                 2189111, 2189112, 2189113, 2189121,
                                 2189124, 2189125, 2189126, 2189131,
                                 2189133, 2189134, 2189135, 2189136,
                                 2189141, 2189147, 2189153, 2180816,
                                 2182126, 2182132, 2182220, 2182225 ) THEN
''El presente documento sustituye cualquier otro emitido por el mismo concepto y hechos''
  ELSE ''''
END                                                            AS textoMostrar,
(SELECT valor_parametro_defecto
 FROM   parametro(nolock)
 WHERE  codigo_parametro = 434)                                AS cargo_delegado
       ,
( Upper((SELECT valor_parametro_defecto
         FROM   parametro(nolock)
         WHERE  codigo_parametro = 434)) )                     AS
       cargo_delegado_mayusculas
,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS

FROM   coactivo c (nolock)
       JOIN proceso p (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       JOIN funcionario fu (nolock)
         ON fu.id_funcionario = c.id_funcionario
       JOIN persona per (nolock)
         ON per.id_persona = fu.id_persona
WHERE  c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 24 '               
	   , orden_variables='ID_COACTIVO,NUMERO_PROCESO,NOMBRE_COMPLETO,T_DOCUMENTO_INFRACTOR,DOCUMENTO_INFRACTOR,DIRECCION_INFRACTOR,FECHA_SOLICITUD,NUMERO_GENERACION_DOCUMENTO,numero_citacion,DESCRIPCION_MULTAS,NOMBRE_ABOGADO,DIA_FECHA,HORA_SOLICITUD,IMAGEN_FIRMA,NUMERO_PAGO,NUMERO_COMPARENDO,DELEGADO_NOMBRAMIENTO_,DELEGADO_TITULONOMBRE_,NORMA,TEXTO_NOMBRE_1,PARRAFO_1,PROFESION,CARGO_DELEGADO,TITULO_PLANTILLAS'
WHERE  id_plantilla_config=40

commit tran


declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'NOTIFICACION_COAC';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS


--Modificada
------------------------------------------------------------
DECLARE @FECHA DATETIME2

SELECT TOP 1 @FECHA = CASE c.id_tipo_coactivo
                        WHEN 3 THEN tp.fecha_inicio
                        ELSE p.fecha_inicio
                      END
FROM   coactivo c
       JOIN proceso p (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = p.id_proceso
WHERE  c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 24
ORDER  BY tp.fecha_inicio DESC

SELECT c.id_coactivo,
       Concat(p.numero_proceso, '-', Year(p.fecha_inicio))            AS
       'numeroJuicio',
       CASE pe.id_tipo_identificacion
         WHEN 2 THEN Upper(pj.nombre_comercial)
         ELSE Upper(Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',
                    pe.apellido2))
       END                                                            AS
       nombreCompleto,
       tip.codigo,
       pe.numero_identificacion,
       dbo.Direccionpersona(pe.id_persona, DEFAULT)                   AS
       Direccion,
       @FECHA,
       (SELECT Count(id_documento_proceso)
        FROM   documento_proceso
        WHERE  id_trazabilidad_proceso = tp.id_trazabilidad_proceso
               AND id_tipo_documento_proceso = 10)
       + 1                                                            AS
       cantidadDocs,
       Cast((SELECT DISTINCT Substring((SELECT ( Concat('-', c1.numero_citacion)
                                               ) AS
                                                    [text()]
                                        FROM   obligacion_coactivo cp1 (nolock)
                                               JOIN comparendo c1 (nolock)
                                                 ON cp1.numero_obligacion =
                                                    c1.id_factura_axis
                                        WHERE  cp1.id_coactivo = cp2.id_coactivo
                                        ORDER  BY cp1.id_coactivo
                                        FOR xml path ('')), 1, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max)) citacion,
       Cast((SELECT DISTINCT Substring((SELECT ','
                                               + Concat(c.numero_citacion,
                                               ' de fecha '
                                               ,
            Format(c.fecha_infraccion,
            'dd \de MMMM \de yyyy'),
            ', tipificada y sancionada en el artículo ',
            ci.articulo, ', numeral ', i.numeral_infraccion, ' - ',
            nm.nombre) AS
                      [text()]
            FROM   obligacion_coactivo cp1 (nolock)
            INNER JOIN comparendo c (nolock)
            ON cp1.numero_obligacion = c.id_factura_axis
            INNER JOIN infraccion i (nolock)
            ON c.id_infraccion = i.id_infraccion
            INNER JOIN configuracion_infraccion ci (nolock)
            ON i.id_infraccion = ci.id_infraccion
            AND ci.fecha_fin_vigencia IS NULL
            INNER JOIN normatividad nm (nolock)
            ON nm.id_normatividad = ci.id_normatividad
            WHERE  cp1.id_coactivo = cp2.id_coactivo
            ORDER  BY cp1.id_coactivo
            FOR xml path ('')), 2, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max))
       descripcion,
       Upper(Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',
             per.apellido2))                                          AS
       nombreAbogado,
       Day(@FECHA)                                                    AS Dia,
       @FECHA                                                         AS
       horaSolicitud,
       (SELECT Max(fp.numero_imagen)
        FROM   firma_persona fp (nolock)
        WHERE  fp.id_persona = per.id_persona)                        AS firma,
       CASE
         WHEN c.id_tramite < 0 THEN '0'
         ELSE c.id_tramite
       END                                                            AS
       numeroPago,
       Cast((SELECT DISTINCT Substring((SELECT ( Concat('-', c1.id_factura_axis)
                                               ) AS
                                                    [text()]
                                        FROM   obligacion_coactivo cp1 (nolock)
                                               JOIN comparendo c1 (nolock)
                                                 ON cp1.numero_obligacion =
                                                    c1.id_factura_axis
                                        WHERE  cp1.id_coactivo = cp2.id_coactivo
                                        ORDER  BY cp1.id_coactivo
                                        FOR xml path ('')), 1, 5000) comparendos
             FROM   obligacion_coactivo cp2 (nolock)
             WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max)) facturas,
       (SELECT Concat(f.memo_nombramiento, ', de fecha ', Cast(
                       Format(f.fecha_nombramiento, 'dd \de MMMM \de yyyy') AS
                       VARCHAR(
                       50)))
        FROM   funcionario_coactivo f (nolock)
        WHERE  f.id_cargo = 1
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 1
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       datosNombramiento,
       (SELECT Concat(f.titulo_obtenido, '. ', Upper(
                       Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1,
                       ' ',
                                                       per.apellido2)))
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
               INNER JOIN coactivo_funcionario cf (nolock)
                       ON f.id_funcionario = cf.id_funcionario
        WHERE  cf.id_coactivo = c.id_coactivo)                        AS
       titulo_nombreFuncionario,
       (SELECT o.norma
        FROM   organismo_normatividad o (nolock)
        WHERE  ( o.estado = 1
                 AND o.codigo_organismo = 11001
                 AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                 AND o.fecha_final_vigencia >= CONVERT(DATE, @FECHA) )
                OR ( o.estado = 1
                     AND o.codigo_organismo = 11001
                     AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND o.fecha_final_vigencia IS NULL ))            AS norma,
       (SELECT Concat(Isnull(f.titulo_obtenido, ''), ' ', per.nombre1, ' ',
               per.nombre2, ' ',
                       per.apellido1, ' ', per.apellido2, ', Mgs')
        FROM   funcionario f (nolock)
               INNER JOIN persona per (nolock)
                       ON f.id_persona = per.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
               AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)
                OR ( f.id_cargo = 11
                     AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)
                     AND f.fecha_final_vigencia IS NULL ))            AS
       director_gestion_infracciones,
       CASE
         WHEN c.id_coactivo IN ( 2182235, 2182238, 2182242, 2182246,
                                 2182252, 2182257, 2182258, 2182259,
                                 2182264, 2182271, 2182272, 2182276,
                                 2182295, 2182298, 2182312, 2182317,
                                 2182323, 2182329, 2182332, 2182339,
                                 2182349, 2182353, 2182354, 2183060,
                                 2183148, 2183498, 2183500, 2183504,
                                 2183510, 2183512, 2183517, 2183518,
                                 2183533, 2183537, 2183538, 2183551,
                                 2183555, 2183559, 2183561, 2183566,
                                 2183572, 2183577, 2183578, 2183583,
                                 2183588, 2183590, 2183591, 2183597,
                                 2183602, 2183603, 2183607, 2183608,
                                 2183609, 2183610, 2183616, 2183619,
                                 2183620, 2183621, 2183622, 2183624,
                                 2183643, 2183646, 2183650, 2183654,
                                 2183656, 2183657, 2183665, 2183671,
                                 2183672, 2183673, 2183674, 2183679,
                                 2183696, 2183697, 2183701, 2183708,
                                 2183714, 2183720, 2183725, 2183728,
                                 2183733, 2183742, 2186755, 2186790,
                                 2186791, 2186792, 2186793, 2186794,
                                 2186796, 2186797, 2186798, 2186799,
                                 2186800, 2186801, 2186802, 2186803,
                                 2186805, 2186806, 2186807, 2186808,
                                 2186809, 2186812, 2186813, 2186814,
                                 2186815, 2186816, 2186817, 2186818,
                                 2186819, 2186820, 2186821, 2186822,
                                 2186823, 2186824, 2186825, 2186826,
                                 2186827, 2186828, 2186829, 2186830,
                                 2186831, 2186832, 2186833, 2186834,
                                 2186835, 2186836, 2186837, 2186838,
                                 2186839, 2186840, 2186841, 2186842,
                                 2186843, 2186844, 2186845, 2186846,
                                 2186847, 2186848, 2186849, 2186850,
                                 2186851, 2186852, 2186853, 2186854,
                                 2186855, 2186856, 2186857, 2186859,
                                 2186860, 2186861, 2186862, 2186863,
                                 2186864, 2186865, 2186866, 2186867,
                                 2186868, 2186869, 2186870, 2186871,
                                 2186872, 2186873, 2186874, 2186875,
                                 2186876, 2186877, 2186878, 2186879,
                                 2186880, 2186881, 2186882, 2186883,
                                 2186884, 2186885, 2186886, 2186887,
                                 2186888, 2186889, 2186890, 2186891,
                                 2186892, 2186893, 2186894, 2186895,
                                 2186896, 2186897, 2186898, 2186899,
                                 2186900, 2186901, 2186902, 2186904,
                                 2186905, 2186906, 2186907, 2186908,
                                 2186909, 2186910, 2186911, 2186912,
                                 2186913, 2186914, 2186915, 2186916,
                                 2186917, 2186918, 2186919, 2186920,
                                 2186921, 2186923, 2186924, 2186925,
                                 2186926, 2186927, 2186928, 2186930,
                                 2186931, 2186932, 2186933, 2186934,
                                 2186935, 2186937, 2186938, 2186939,
                                 2186940, 2186941, 2186942, 2186943,
                                 2186944, 2186945, 2186946, 2186947,
                                 2186948, 2186949, 2186950, 2186951,
                                 2186952, 2186953, 2186954, 2186955,
                                 2186956, 2186957, 2186958, 2186959,
                                 2186960, 2186961, 2186962, 2186963,
                                 2186964, 2186965, 2186966, 2186967,
                                 2186968, 2186969, 2186970, 2186971,
                                 2186972, 2186973, 2186974, 2186976,
                                 2186977, 2186978, 2186979, 2186980,
                                 2186981, 2186982, 2186983, 2186984,
                                 2186985, 2186986, 2186987, 2186988,
                                 2186989, 2186990, 2186991, 2186992,
                                 2186993, 2186994, 2186995, 2186996,
                                 2186997, 2186998, 2186999, 2187000,
                                 2187001, 2187002, 2187003, 2187004,
                                 2187005, 2187006, 2187007, 2187008,
                                 2187009, 2187010, 2187011, 2187012,
                                 2187013, 2187014, 2187015, 2187016,
                                 2187017, 2187019, 2187020, 2187021,
                                 2187022, 2187023, 2187024, 2187025,
                                 2187026, 2187027, 2187028, 2187029,
                                 2187030, 2187031, 2187032, 2187033,
                                 2187034, 2187035, 2187036, 2187037,
                                 2187038, 2187039, 2187040, 2187041,
                                 2187042, 2187043, 2187044, 2187045,
                                 2187046, 2187047, 2187048, 2187049,
                                 2187050, 2187051, 2187052, 2187053,
                                 2187054, 2187055, 2187056, 2187057,
                                 2187058, 2187059, 2187060, 2187061,
                                 2187062, 2187063, 2187064, 2187065,
                                 2187066, 2187067, 2187068, 2187069,
                                 2187071, 2187072, 2187073, 2187074,
                                 2187075, 2187077, 2187078, 2187079,
                                 2187080, 2187081, 2187082, 2187083,
                                 2187084, 2187085, 2187086, 2187087,
                                 2187088, 2187089, 2187090, 2187091,
                                 2187092, 2187093, 2187094, 2187095,
                                 2187096, 2187097, 2187100, 2187102,
                                 2187103, 2187104, 2187105, 2187106,
                                 2187107, 2187108, 2187110, 2187114,
                                 2187115, 2187116, 2187117, 2187118,
                                 2187119, 2187120, 2187121, 2187122,
                                 2187123, 2187124, 2187125, 2187126,
                                 2187127, 2187129, 2187130, 2187131,
                                 2187132, 2187133, 2187134, 2187135,
                                 2187136, 2187139, 2187140, 2187141,
                                 2187142, 2187144, 2187145, 2187146,
                                 2187147, 2187148, 2187150, 2187153,
                                 2187154, 2187156, 2187157, 2187159,
                                 2187163, 2187166, 2187167, 2187171,
                                 2187172, 2187173, 2187174, 2187175,
                                 2187177, 2187178, 2187179, 2187180,
                                 2187181, 2187182, 2187183, 2187187,
                                 2187188, 2187190, 2187191, 2187194,
                                 2187195, 2187196, 2187197, 2187198,
                                 2187199, 2187200, 2187202, 2187203,
                                 2187205, 2187206, 2187207, 2187208,
                                 2187214, 2187216, 2187219, 2187222,
                                 2187223, 2187224, 2187225, 2187229,
                                 2187230, 2187231, 2187233, 2187234,
                                 2187235, 2187238, 2187240, 2187242,
                                 2187243, 2187244, 2187246, 2187247,
                                 2187248, 2187249, 2187250, 2187251,
                                 2187255, 2187256, 2187257, 2187260,
                                 2187262, 2187264, 2187267, 2187269,
                                 2187271, 2187272, 2187273, 2187274,
                                 2187276, 2187277, 2187278, 2187279,
                                 2187280, 2187281, 2187282, 2187283,
                                 2187285, 2187287, 2187288, 2187289,
                                 2187290, 2187291, 2187292, 2187295,
                                 2187296, 2187305, 2187312, 2187316,
                                 2187322, 2187327, 2187931, 2188011,
                                 2188016, 2188033, 2188034, 2188035,
                                 2188036, 2188037, 2188038, 2188039,
                                 2188040, 2188041, 2188042, 2188043,
                                 2188044, 2188045, 2188046, 2188047,
                                 2188048, 2188049, 2188050, 2188051,
                                 2188055, 2188075, 2188076, 2188077,
                                 2188078, 2188079, 2188080, 2188081,
                                 2188082, 2188083, 2188084, 2188086,
                                 2188087, 2188088, 2188089, 2188090,
                                 2188091, 2188092, 2188093, 2188094,
                                 2188095, 2188096, 2188097, 2188099,
                                 2188100, 2188101, 2188102, 2188103,
                                 2188104, 2188105, 2188106, 2188107,
                                 2188108, 2188109, 2188110, 2188111,
                                 2188112, 2188113, 2188114, 2188115,
                                 2188116, 2188117, 2188118, 2188119,
                                 2188120, 2188121, 2188122, 2188123,
                                 2188125, 2188126, 2188127, 2188128,
                                 2188129, 2188130, 2188131, 2188132,
                                 2188133, 2188134, 2188135, 2188136,
                                 2188137, 2188138, 2188139, 2188140,
                                 2188141, 2188142, 2188143, 2188144,
                                 2188145, 2188146, 2188147, 2188148,
                                 2188149, 2188150, 2188152, 2188153,
                                 2188154, 2188155, 2188156, 2188157,
                                 2188158, 2188159, 2188160, 2188161,
                                 2188162, 2188163, 2188164, 2188165,
                                 2188166, 2188167, 2188168, 2188169,
                                 2188170, 2188171, 2188172, 2188173,
                                 2188174, 2188175, 2188176, 2188177,
                                 2188178, 2188179, 2188180, 2188181,
                                 2188182, 2188183, 2188184, 2188185,
                                 2188186, 2188187, 2188188, 2188189,
                                 2188191, 2188193, 2188194, 2188195,
                                 2188196, 2188197, 2188198, 2188199,
                                 2188200, 2188201, 2188202, 2188203,
                                 2188204, 2188205, 2188206, 2188207,
                                 2188208, 2188209, 2188210, 2188211,
                                 2188212, 2188213, 2188214, 2188215,
                                 2188216, 2188217, 2188218, 2188219,
                                 2188220, 2188221, 2188222, 2188223,
                                 2188224, 2188225, 2188226, 2188227,
                                 2188228, 2188229, 2188230, 2188231,
                                 2188232, 2188234, 2188235, 2188236,
                                 2188237, 2188238, 2188239, 2188240,
                                 2188241, 2188242, 2188243, 2188244,
                                 2188245, 2188246, 2188247, 2188248,
                                 2188249, 2188250, 2188251, 2188252,
                                 2188253, 2188254, 2188255, 2188256,
                                 2188257, 2188258, 2188259, 2188260,
                                 2188261, 2188262, 2188263, 2188264,
                                 2188265, 2188266, 2188267, 2188268,
                                 2188269, 2188270, 2188271, 2188272,
                                 2188273, 2188274, 2188275, 2188276,
                                 2188277, 2188278, 2188279, 2188280,
                                 2188281, 2188282, 2188283, 2188284,
                                 2188285, 2188286, 2188287, 2188288,
                                 2188289, 2188290, 2188292, 2188293,
                                 2188294, 2188295, 2188296, 2188297,
                                 2188298, 2188299, 2188300, 2188301,
                                 2188302, 2188303, 2188304, 2188305,
                                 2188306, 2188307, 2188308, 2188309,
                                 2188310, 2188311, 2188312, 2188313,
                                 2188314, 2188315, 2188316, 2188317,
                                 2188318, 2188319, 2188320, 2188321,
                                 2188322, 2188323, 2188324, 2188325,
                                 2188326, 2188327, 2188328, 2188329,
                                 2188330, 2188331, 2188332, 2188333,
                                 2188334, 2188335, 2188336, 2188337,
                                 2188339, 2188340, 2188341, 2188342,
                                 2188343, 2188344, 2188345, 2188346,
                                 2188348, 2188349, 2188350, 2188351,
                                 2188352, 2188353, 2188354, 2188355,
                                 2188356, 2188357, 2188361, 2188362,
                                 2188363, 2188364, 2188365, 2188366,
                                 2188367, 2188368, 2188369, 2188370,
                                 2188371, 2188372, 2188373, 2188374,
                                 2188375, 2188376, 2188377, 2188378,
                                 2188379, 2188380, 2188381, 2188382,
                                 2188383, 2188385, 2188386, 2188387,
                                 2188388, 2188389, 2188390, 2188392,
                                 2188393, 2188394, 2188399, 2188400,
                                 2188401, 2188402, 2188403, 2188404,
                                 2188405, 2188406, 2188408, 2188409,
                                 2188410, 2188411, 2188412, 2188413,
                                 2188414, 2188415, 2188416, 2188418,
                                 2188419, 2188420, 2188421, 2188422,
                                 2188424, 2188425, 2188426, 2188427,
                                 2188428, 2188429, 2188430, 2188431,
                                 2188432, 2188433, 2188434, 2188435,
                                 2188436, 2188437, 2188439, 2188440,
                                 2188441, 2188442, 2188443, 2188444,
                                 2188445, 2188446, 2188447, 2188448,
                                 2188449, 2188450, 2188451, 2188452,
                                 2188453, 2188454, 2188455, 2188456,
                                 2188457, 2188459, 2188460, 2188461,
                                 2188462, 2188463, 2188464, 2188465,
                                 2188466, 2188467, 2188468, 2188469,
                                 2188471, 2188472, 2188473, 2188474,
                                 2188475, 2188476, 2188478, 2188479,
                                 2188480, 2188481, 2188482, 2188483,
                                 2188484, 2188485, 2188486, 2188487,
                                 2188489, 2188491, 2188492, 2188493,
                                 2188494, 2188495, 2188496, 2188497,
                                 2188498, 2188500, 2188502, 2188503,
                                 2188504, 2188505, 2188506, 2188507,
                                 2188508, 2188509, 2188510, 2188511,
                                 2188512, 2188513, 2188514, 2188515,
                                 2188516, 2188518, 2188519, 2188520,
                                 2188522, 2188523, 2188525, 2188526,
                                 2188527, 2188528, 2188529, 2188530,
                                 2188531, 2188532, 2188533, 2188534,
                                 2188536, 2188537, 2188538, 2188539,
                                 2188540, 2188541, 2188542, 2188543,
                                 2188544, 2188545, 2188547, 2188548,
                                 2188549, 2188550, 2188551, 2188552,
                                 2188553, 2188555, 2188556, 2188558,
                                 2188559, 2188561, 2188562, 2188563,
                                 2188564, 2188565, 2188566, 2188567,
                                 2188568, 2188569, 2188570, 2188571,
                                 2188572, 2188573, 2188574, 2188575,
                                 2188576, 2188577, 2188578, 2188579,
                                 2188580, 2188581, 2188582, 2188583,
                                 2188584, 2188585, 2188586, 2188587,
                                 2188588, 2188589, 2188591, 2188592,
                                 2188593, 2188594, 2188595, 2188596,
                                 2188597, 2188598, 2188599, 2188600,
                                 2188601, 2188602, 2188603, 2188604,
                                 2188606, 2188607, 2188608, 2188609,
                                 2188610, 2188611, 2188612, 2188613,
                                 2188614, 2188615, 2188616, 2188617,
                                 2188618, 2188619, 2188620, 2188621,
                                 2188622, 2188623, 2188624, 2188625,
                                 2188626, 2188627, 2188628, 2188629,
                                 2188630, 2188631, 2188632, 2188633,
                                 2188634, 2188635, 2188636, 2188637,
                                 2188638, 2188639, 2188641, 2188644,
                                 2188645, 2188646, 2188647, 2188648,
                                 2188649, 2188650, 2188651, 2188652,
                                 2188653, 2188654, 2188656, 2188658,
                                 2188660, 2188661, 2188664, 2188665,
                                 2188666, 2188667, 2188668, 2188669,
                                 2188670, 2188671, 2188672, 2188673,
                                 2188674, 2188675, 2188676, 2188679,
                                 2188680, 2188681, 2188682, 2188683,
                                 2188684, 2188685, 2188686, 2188687,
                                 2188688, 2188689, 2188690, 2188691,
                                 2188692, 2188693, 2188694, 2188695,
                                 2188696, 2188698, 2188699, 2188702,
                                 2188704, 2188705, 2188706, 2188708,
                                 2188709, 2188710, 2188711, 2188712,
                                 2188713, 2188714, 2188715, 2188717,
                                 2188718, 2188719, 2188720, 2188722,
                                 2188723, 2188724, 2188725, 2188726,
                                 2188727, 2188728, 2188729, 2188730,
                                 2188731, 2188732, 2188733, 2188734,
                                 2188735, 2188736, 2188737, 2188738,
                                 2188739, 2188740, 2188741, 2188742,
                                 2188743, 2188744, 2188745, 2188746,
                                 2188747, 2188748, 2188749, 2188750,
                                 2188751, 2188752, 2188753, 2188754,
                                 2188755, 2188756, 2188757, 2188758,
                                 2188759, 2188760, 2188761, 2188762,
                                 2188763, 2188764, 2188765, 2188766,
                                 2188767, 2188768, 2188769, 2188770,
                                 2188771, 2188772, 2188773, 2188774,
                                 2188775, 2188776, 2188777, 2188778,
                                 2188779, 2188780, 2188781, 2188782,
                                 2188783, 2188784, 2188785, 2188786,
                                 2188788, 2188789, 2188790, 2188791,
                                 2188792, 2188793, 2188794, 2188795,
                                 2188796, 2188797, 2188798, 2188799,
                                 2188800, 2188801, 2188802, 2188803,
                                 2188804, 2188805, 2188806, 2188807,
                                 2188808, 2188809, 2188810, 2188811,
                                 2188812, 2188813, 2188814, 2188815,
                                 2188816, 2188817, 2188818, 2188819,
                                 2188820, 2188821, 2188822, 2188823,
                                 2188824, 2188825, 2188826, 2188827,
                                 2188828, 2188829, 2188830, 2188831,
                                 2188832, 2188833, 2188834, 2188835,
                                 2188836, 2188837, 2188838, 2188839,
                                 2188840, 2188841, 2188842, 2188843,
                                 2188844, 2188845, 2188846, 2188847,
                                 2188848, 2188849, 2188850, 2188851,
                                 2188852, 2188854, 2188855, 2188856,
                                 2188857, 2188858, 2188859, 2188860,
                                 2188861, 2188862, 2188863, 2188864,
                                 2188865, 2188866, 2188868, 2188869,
                                 2188872, 2188873, 2188874, 2188877,
                                 2188878, 2188879, 2188881, 2188882,
                                 2188883, 2188884, 2188885, 2188886,
                                 2188888, 2188890, 2188891, 2188892,
                                 2188893, 2188897, 2188898, 2188899,
                                 2188901, 2188902, 2188905, 2188906,
                                 2188907, 2188908, 2188909, 2188911,
                                 2188912, 2188913, 2188921, 2188922,
                                 2188924, 2188927, 2188928, 2188929,
                                 2188930, 2188931, 2188932, 2188933,
                                 2188934, 2188935, 2188939, 2188941,
                                 2188942, 2188943, 2188944, 2188945,
                                 2188947, 2188949, 2188951, 2188952,
                                 2188954, 2188955, 2188956, 2188957,
                                 2188958, 2188959, 2188960, 2188961,
                                 2188962, 2188965, 2188966, 2188967,
                                 2188969, 2188971, 2188972, 2188973,
                                 2188974, 2188976, 2188977, 2188978,
                                 2188979, 2188980, 2188982, 2188985,
                                 2188986, 2188988, 2188989, 2188990,
                                 2188991, 2188994, 2188995, 2188998,
                                 2188999, 2189000, 2189003, 2189004,
                                 2189005, 2189006, 2189007, 2189008,
                                 2189011, 2189012, 2189014, 2189015,
                                 2189018, 2189019, 2189021, 2189029,
                                 2189030, 2189031, 2189032, 2189036,
                                 2189037, 2189038, 2189039, 2189040,
                                 2189041, 2189043, 2189044, 2189046,
                                 2189049, 2189051, 2189052, 2189054,
                                 2189055, 2189057, 2189058, 2189060,
                                 2189061, 2189062, 2189065, 2189066,
                                 2189067, 2189068, 2189069, 2189071,
                                 2189073, 2189074, 2189078, 2189081,
                                 2189082, 2189083, 2189084, 2189085,
                                 2189088, 2189089, 2189090, 2189092,
                                 2189093, 2189094, 2189097, 2189100,
                                 2189102, 2189103, 2189104, 2189107,
                                 2189111, 2189112, 2189113, 2189121,
                                 2189124, 2189125, 2189126, 2189131,
                                 2189133, 2189134, 2189135, 2189136,
                                 2189141, 2189147, 2189153, 2180816,
                                 2182126, 2182132, 2182220, 2182225 ) THEN
'El presente documento sustituye cualquier otro emitido por el mismo concepto y hechos'
  ELSE ''
END                                                            AS textoMostrar,
(SELECT valor_parametro_defecto
 FROM   parametro(nolock)
 WHERE  codigo_parametro = 434)                                AS cargo_delegado
       ,
( Upper((SELECT valor_parametro_defecto
         FROM   parametro(nolock)
         WHERE  codigo_parametro = 434)) )                     AS
       cargo_delegado_mayusculas
,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS

FROM   coactivo c (nolock)
       JOIN proceso p (nolock)
         ON p.id_proceso = c.id_proceso
       JOIN trazabilidad_proceso tp (nolock)
         ON tp.id_proceso = p.id_proceso
       JOIN persona pe (nolock)
         ON pe.id_persona = c.id_deudor
       LEFT JOIN persona_juridica pj (nolock)
              ON pj.id_persona_juridica = pe.id_persona
       JOIN tipo_identificacion_persona tip (nolock)
         ON tip.id_tipo_identificacion = pe.id_tipo_identificacion
       JOIN funcionario fu (nolock)
         ON fu.id_funcionario = c.id_funcionario
       JOIN persona per (nolock)
         ON per.id_persona = fu.id_persona
WHERE  c.id_coactivo = :idCoactivo
       AND tp.id_estado_proceso = 24 


-------------------------------------------------



--Original
-------------------------------------------------------------------------------------
DECLARE @FECHA DATETIME2    SELECT TOP 1 @FECHA = CASE c.id_tipo_coactivo                          WHEN 3 THEN tp.fecha_inicio                          ELSE p.fecha_inicio                        END  FROM   coactivo c         JOIN proceso p (nolock)           ON p.id_proceso = c.id_proceso         JOIN trazabilidad_proceso tp (nolock)           ON tp.id_proceso = p.id_proceso  WHERE  c.id_coactivo = :idCoactivo         AND tp.id_estado_proceso = 24  ORDER  BY tp.fecha_inicio DESC    SELECT c.id_coactivo,         Concat(p.numero_proceso, '-', Year(p.fecha_inicio))            AS         'numeroJuicio',         CASE pe.id_tipo_identificacion           WHEN 2 THEN Upper(pj.nombre_comercial)           ELSE Upper(Concat(pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ',                      pe.apellido2))         END                                                            AS         nombreCompleto,         tip.codigo,         pe.numero_identificacion,         dbo.Direccionpersona(pe.id_persona, DEFAULT)                   AS         Direccion,         @FECHA,         (SELECT Count(id_documento_proceso)          FROM   documento_proceso          WHERE  id_trazabilidad_proceso = tp.id_trazabilidad_proceso                 AND id_tipo_documento_proceso = 10)         + 1                                                            AS         cantidadDocs,         Cast((SELECT DISTINCT Substring((SELECT ( Concat('-', c1.numero_citacion)                                                 ) AS                                                      [text()]                                          FROM   obligacion_coactivo cp1 (nolock)                                                 JOIN comparendo c1 (nolock)                                                   ON cp1.numero_obligacion =                                                      c1.id_factura_axis                                          WHERE  cp1.id_coactivo = cp2.id_coactivo                                          ORDER  BY cp1.id_coactivo                                          FOR xml path ('')), 1, 5000) comparendos               FROM   obligacion_coactivo cp2 (nolock)               WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max)) citacion,         Cast((SELECT DISTINCT Substring((SELECT ','                                                 + Concat(c.numero_citacion,                                                 ' de fecha '                                                 ,              Format(c.fecha_infraccion,              'dd \de MMMM \de yyyy'),              ', tipificada y sancionada en el artículo ',              ci.articulo, ', numeral ', i.numeral_infraccion, ' - ',              nm.nombre) AS                        [text()]              FROM   obligacion_coactivo cp1 (nolock)              INNER JOIN comparendo c (nolock)              ON cp1.numero_obligacion = c.id_factura_axis              INNER JOIN infraccion i (nolock)              ON c.id_infraccion = i.id_infraccion              INNER JOIN configuracion_infraccion ci (nolock)              ON i.id_infraccion = ci.id_infraccion              AND ci.fecha_fin_vigencia IS NULL              INNER JOIN normatividad nm (nolock)              ON nm.id_normatividad = ci.id_normatividad              WHERE  cp1.id_coactivo = cp2.id_coactivo              ORDER  BY cp1.id_coactivo              FOR xml path ('')), 2, 5000) comparendos               FROM   obligacion_coactivo cp2 (nolock)               WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max))         descripcion,         Upper(Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ',               per.apellido2))                                          AS         nombreAbogado,         Day(@FECHA)                                                    AS Dia,         @FECHA                                                         AS         horaSolicitud,         (SELECT Max(fp.numero_imagen)          FROM   firma_persona fp (nolock)          WHERE  fp.id_persona = per.id_persona)                        AS firma,         CASE           WHEN c.id_tramite < 0 THEN '0'           ELSE c.id_tramite         END                                                            AS         numeroPago,         Cast((SELECT DISTINCT Substring((SELECT ( Concat('-', c1.id_factura_axis)                                                 ) AS                                                      [text()]                                          FROM   obligacion_coactivo cp1 (nolock)                                                 JOIN comparendo c1 (nolock)                                                   ON cp1.numero_obligacion =                                                      c1.id_factura_axis                                          WHERE  cp1.id_coactivo = cp2.id_coactivo                                          ORDER  BY cp1.id_coactivo                                          FOR xml path ('')), 1, 5000) comparendos               FROM   obligacion_coactivo cp2 (nolock)               WHERE  cp2.id_coactivo = c.id_coactivo) AS VARCHAR(max)) facturas,         (SELECT Concat(f.memo_nombramiento, ', de fecha ', Cast(                         Format(f.fecha_nombramiento, 'dd \de MMMM \de yyyy') AS                         VARCHAR(                         50)))          FROM   funcionario_coactivo f (nolock)          WHERE  f.id_cargo = 1                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                  OR ( f.id_cargo = 1                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND f.fecha_final_vigencia IS NULL ))            AS         datosNombramiento,         (SELECT Concat(f.titulo_obtenido, '. ', Upper(                         Concat(per.nombre1, ' ', per.nombre2, ' ', per.apellido1,                         ' ',                                                         per.apellido2)))          FROM   funcionario f (nolock)                 INNER JOIN persona per (nolock)                         ON f.id_persona = per.id_persona                 INNER JOIN coactivo_funcionario cf (nolock)                         ON f.id_funcionario = cf.id_funcionario          WHERE  cf.id_coactivo = c.id_coactivo)                        AS         titulo_nombreFuncionario,         (SELECT o.norma          FROM   organismo_normatividad o (nolock)          WHERE  ( o.estado = 1                   AND o.codigo_organismo = 11001                   AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                   AND o.fecha_final_vigencia >= CONVERT(DATE, @FECHA) )                  OR ( o.estado = 1                       AND o.codigo_organismo = 11001                       AND o.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND o.fecha_final_vigencia IS NULL ))            AS norma,         (SELECT Concat(ISNULL(f.titulo_obtenido, ''), ' ', per.nombre1, ' ', per.nombre2, ' ', per.apellido1, ' ', per.apellido2, ', Mgs')          FROM   funcionario f (nolock)                 INNER JOIN persona per (nolock)                         ON f.id_persona = per.id_persona          WHERE  f.id_cargo = 11                 AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                 AND f.fecha_final_vigencia >= CONVERT(DATE, @FECHA)                  OR ( f.id_cargo = 11                       AND f.fecha_inicio_vigencia <= CONVERT(DATE, @FECHA)                       AND f.fecha_final_vigencia IS NULL ))            AS         director_gestion_infracciones      ,CASE WHEN c.id_coactivo IN (2182235,2182238,2182242,2182246,2182252,2182257,2182258,2182259,2182264,2182271,2182272,2182276,2182295,2182298,2182312,2182317,2182323,2182329,2182332,2182339,2182349,2182353,2182354,2183060,2183148,2183498,2183500,2183504,2183510,2183512,2183517,2183518,2183533,2183537,2183538,2183551,2183555,2183559,2183561,2183566,2183572,2183577,2183578,2183583,2183588,2183590,2183591,2183597,2183602,2183603,2183607,2183608,2183609,2183610,2183616,2183619,2183620,2183621,2183622,2183624,2183643,2183646,2183650,2183654,2183656,2183657,2183665,2183671,2183672,2183673,2183674,2183679,2183696,2183697,2183701,2183708,2183714,2183720,2183725,2183728,2183733,2183742,2186755,2186790,2186791,2186792,2186793,2186794,2186796,2186797,2186798,2186799,2186800,2186801,2186802,2186803,2186805,2186806,2186807,2186808,2186809,2186812,2186813,2186814,2186815,2186816,2186817,2186818,2186819,2186820,2186821,2186822,2186823,2186824,2186825,2186826,2186827,2186828,2186829,2186830,2186831,2186832,2186833,2186834,2186835,2186836,2186837,2186838,2186839,2186840,2186841,2186842,2186843,2186844,2186845,2186846,2186847,2186848,2186849,2186850,2186851,2186852,2186853,2186854,2186855,2186856,2186857,2186859,2186860,2186861,2186862,2186863,2186864,2186865,2186866,2186867,2186868,2186869,2186870,2186871,2186872,2186873,2186874,2186875,2186876,2186877,2186878,2186879,2186880,2186881,2186882,2186883,2186884,2186885,2186886,2186887,2186888,2186889,2186890,2186891,2186892,2186893,2186894,2186895,2186896,2186897,2186898,2186899,2186900,2186901,2186902,2186904,2186905,2186906,2186907,2186908,2186909,2186910,2186911,2186912,2186913,2186914,2186915,2186916,2186917,2186918,2186919,2186920,2186921,2186923,2186924,2186925,2186926,2186927,2186928,2186930,2186931,2186932,2186933,2186934,2186935,2186937,2186938,2186939,2186940,2186941,2186942,2186943,2186944,2186945,2186946,2186947,2186948,2186949,2186950,2186951,2186952,2186953,2186954,2186955,2186956,2186957,2186958,2186959,2186960,2186961,2186962,2186963,2186964,2186965,2186966,2186967,2186968,2186969,2186970,2186971,2186972,2186973,2186974,2186976,2186977,2186978,2186979,2186980,2186981,2186982,2186983,2186984,2186985,2186986,2186987,2186988,2186989,2186990,2186991,2186992,2186993,2186994,2186995,2186996,2186997,2186998,2186999,2187000,2187001,2187002,2187003,2187004,2187005,2187006,2187007,2187008,2187009,2187010,2187011,2187012,2187013,2187014,2187015,2187016,2187017,2187019,2187020,2187021,2187022,2187023,2187024,2187025,2187026,2187027,2187028,2187029,2187030,2187031,2187032,2187033,2187034,2187035,2187036,2187037,2187038,2187039,2187040,2187041,2187042,2187043,2187044,2187045,2187046,2187047,2187048,2187049,2187050,2187051,2187052,2187053,2187054,2187055,2187056,2187057,2187058,2187059,2187060,2187061,2187062,2187063,2187064,2187065,2187066,2187067,2187068,2187069,2187071,2187072,2187073,2187074,2187075,2187077,2187078,2187079,2187080,2187081,2187082,2187083,2187084,2187085,2187086,2187087,2187088,2187089,2187090,2187091,2187092,2187093,2187094,2187095,2187096,2187097,2187100,2187102,2187103,2187104,2187105,2187106,2187107,2187108,2187110,2187114,2187115,2187116,2187117,2187118,2187119,2187120,2187121,2187122,2187123,2187124,2187125,2187126,2187127,2187129,2187130,2187131,2187132,2187133,2187134,2187135,2187136,2187139,2187140,2187141,2187142,2187144,2187145,2187146,2187147,2187148,2187150,2187153,2187154,2187156,2187157,2187159,2187163,2187166,2187167,2187171,2187172,2187173,2187174,2187175,2187177,2187178,2187179,2187180,2187181,2187182,2187183,2187187,2187188,2187190,2187191,2187194,2187195,2187196,2187197,2187198,2187199,2187200,2187202,2187203,2187205,2187206,2187207,2187208,2187214,2187216,2187219,2187222,2187223,2187224,2187225,2187229,2187230,2187231,2187233,2187234,2187235,2187238,2187240,2187242,2187243,2187244,2187246,2187247,2187248,2187249,2187250,2187251,2187255,2187256,2187257,2187260,2187262,2187264,2187267,2187269,2187271,2187272,2187273,2187274,2187276,2187277,2187278,2187279,2187280,2187281,2187282,2187283,2187285,2187287,2187288,2187289,2187290,2187291,2187292,2187295,2187296,2187305,2187312,2187316,2187322,2187327,2187931,2188011,2188016,2188033,2188034,2188035,2188036,2188037,2188038,2188039,2188040,2188041,2188042,2188043,2188044,2188045,2188046,2188047,2188048,2188049,2188050,2188051,2188055,2188075,2188076,2188077,2188078,2188079,2188080,2188081,2188082,2188083,2188084,2188086,2188087,2188088,2188089,2188090,2188091,2188092,2188093,2188094,2188095,2188096,2188097,2188099,2188100,2188101,2188102,2188103,2188104,2188105,2188106,2188107,2188108,2188109,2188110,2188111,2188112,2188113,2188114,2188115,2188116,2188117,2188118,2188119,2188120,2188121,2188122,2188123,2188125,2188126,2188127,2188128,2188129,2188130,2188131,2188132,2188133,2188134,2188135,2188136,2188137,2188138,2188139,2188140,2188141,2188142,2188143,2188144,2188145,2188146,2188147,2188148,2188149,2188150,2188152,2188153,2188154,2188155,2188156,2188157,2188158,2188159,2188160,2188161,2188162,2188163,2188164,2188165,2188166,2188167,2188168,2188169,2188170,2188171,2188172,2188173,2188174,2188175,2188176,2188177,2188178,2188179,2188180,2188181,2188182,2188183,2188184,2188185,2188186,2188187,2188188,2188189,2188191,2188193,2188194,2188195,2188196,2188197,2188198,2188199,2188200,2188201,2188202,2188203,2188204,2188205,2188206,2188207,2188208,2188209,2188210,2188211,2188212,2188213,2188214,2188215,2188216,2188217,2188218,2188219,2188220,2188221,2188222,2188223,2188224,2188225,2188226,2188227,2188228,2188229,2188230,2188231,2188232,2188234,2188235,2188236,2188237,2188238,2188239,2188240,2188241,2188242,2188243,2188244,2188245,2188246,2188247,2188248,2188249,2188250,2188251,2188252,2188253,2188254,2188255,2188256,2188257,2188258,2188259,2188260,2188261,2188262,2188263,2188264,2188265,2188266,2188267,2188268,2188269,2188270,2188271,2188272,2188273,2188274,2188275,2188276,2188277,2188278,2188279,2188280,2188281,2188282,2188283,2188284,2188285,2188286,2188287,2188288,2188289,2188290,2188292,2188293,2188294,2188295,2188296,2188297,2188298,2188299,2188300,2188301,2188302,2188303,2188304,2188305,2188306,2188307,2188308,2188309,2188310,2188311,2188312,2188313,2188314,2188315,2188316,2188317,2188318,2188319,2188320,2188321,2188322,2188323,2188324,2188325,2188326,2188327,2188328,2188329,2188330,2188331,2188332,2188333,2188334,2188335,2188336,2188337,2188339,2188340,2188341,2188342,2188343,2188344,2188345,2188346,2188348,2188349,2188350,2188351,2188352,2188353,2188354,2188355,2188356,2188357,2188361,2188362,2188363,2188364,2188365,2188366,2188367,2188368,2188369,2188370,2188371,2188372,2188373,2188374,2188375,2188376,2188377,2188378,2188379,2188380,2188381,2188382,2188383,2188385,2188386,2188387,2188388,2188389,2188390,2188392,2188393,2188394,2188399,2188400,2188401,2188402,2188403,2188404,2188405,2188406,2188408,2188409,2188410,2188411,2188412,2188413,2188414,2188415,2188416,2188418,2188419,2188420,2188421,2188422,2188424,2188425,2188426,2188427,2188428,2188429,2188430,2188431,2188432,2188433,2188434,2188435,2188436,2188437,2188439,2188440,2188441,2188442,2188443,2188444,2188445,2188446,2188447,2188448,2188449,2188450,2188451,2188452,2188453,2188454,2188455,2188456,2188457,2188459,2188460,2188461,2188462,2188463,2188464,2188465,2188466,2188467,2188468,2188469,2188471,2188472,2188473,2188474,2188475,2188476,2188478,2188479,2188480,2188481,2188482,2188483,2188484,2188485,2188486,2188487,2188489,2188491,2188492,2188493,2188494,2188495,2188496,2188497,2188498,2188500,2188502,2188503,2188504,2188505,2188506,2188507,2188508,2188509,2188510,2188511,2188512,2188513,2188514,2188515,2188516,2188518,2188519,2188520,2188522,2188523,2188525,2188526,2188527,2188528,2188529,2188530,2188531,2188532,2188533,2188534,2188536,2188537,2188538,2188539,2188540,2188541,2188542,2188543,2188544,2188545,2188547,2188548,2188549,2188550,2188551,2188552,2188553,2188555,2188556,2188558,2188559,2188561,2188562,2188563,2188564,2188565,2188566,2188567,2188568,2188569,2188570,2188571,2188572,2188573,2188574,2188575,2188576,2188577,2188578,2188579,2188580,2188581,2188582,2188583,2188584,2188585,2188586,2188587,2188588,2188589,2188591,2188592,2188593,2188594,2188595,2188596,2188597,2188598,2188599,2188600,2188601,2188602,2188603,2188604,2188606,2188607,2188608,2188609,2188610,2188611,2188612,2188613,2188614,2188615,2188616,2188617,2188618,2188619,2188620,2188621,2188622,2188623,2188624,2188625,2188626,2188627,2188628,2188629,2188630,2188631,2188632,2188633,2188634,2188635,2188636,2188637,2188638,2188639,2188641,2188644,2188645,2188646,2188647,2188648,2188649,2188650,2188651,2188652,2188653,2188654,2188656,2188658,2188660,2188661,2188664,2188665,2188666,2188667,2188668,2188669,2188670,2188671,2188672,2188673,2188674,2188675,2188676,2188679,2188680,2188681,2188682,2188683,2188684,2188685,2188686,2188687,2188688,2188689,2188690,2188691,2188692,2188693,2188694,2188695,2188696,2188698,2188699,2188702,2188704,2188705,2188706,2188708,2188709,2188710,2188711,2188712,2188713,2188714,2188715,2188717,2188718,2188719,2188720,2188722,2188723,2188724,2188725,2188726,2188727,2188728,2188729,2188730,2188731,2188732,2188733,2188734,2188735,2188736,2188737,2188738,2188739,2188740,2188741,2188742,2188743,2188744,2188745,2188746,2188747,2188748,2188749,2188750,2188751,2188752,2188753,2188754,2188755,2188756,2188757,2188758,2188759,2188760,2188761,2188762,2188763,2188764,2188765,2188766,2188767,2188768,2188769,2188770,2188771,2188772,2188773,2188774,2188775,2188776,2188777,2188778,2188779,2188780,2188781,2188782,2188783,2188784,2188785,2188786,2188788,2188789,2188790,2188791,2188792,2188793,2188794,2188795,2188796,2188797,2188798,2188799,2188800,2188801,2188802,2188803,2188804,2188805,2188806,2188807,2188808,2188809,2188810,2188811,2188812,2188813,2188814,2188815,2188816,2188817,2188818,2188819,2188820,2188821,2188822,2188823,2188824,2188825,2188826,2188827,2188828,2188829,2188830,2188831,2188832,2188833,2188834,2188835,2188836,2188837,2188838,2188839,2188840,2188841,2188842,2188843,2188844,2188845,2188846,2188847,2188848,2188849,2188850,2188851,2188852,2188854,2188855,2188856,2188857,2188858,2188859,2188860,2188861,2188862,2188863,2188864,2188865,2188866,2188868,2188869,2188872,2188873,2188874,2188877,2188878,2188879,2188881,2188882,2188883,2188884,2188885,2188886,2188888,2188890,2188891,2188892,2188893,2188897,2188898,2188899,2188901,2188902,2188905,2188906,2188907,2188908,2188909,2188911,2188912,2188913,2188921,2188922,2188924,2188927,2188928,2188929,2188930,2188931,2188932,2188933,2188934,2188935,2188939,2188941,2188942,2188943,2188944,2188945,2188947,2188949,2188951,2188952,2188954,2188955,2188956,2188957,2188958,2188959,2188960,2188961,2188962,2188965,2188966,2188967,2188969,2188971,2188972,2188973,2188974,2188976,2188977,2188978,2188979,2188980,2188982,2188985,2188986,2188988,2188989,2188990,2188991,2188994,2188995,2188998,2188999,2189000,2189003,2189004,2189005,2189006,2189007,2189008,2189011,2189012,2189014,2189015,2189018,2189019,2189021,2189029,2189030,2189031,2189032,2189036,2189037,2189038,2189039,2189040,2189041,2189043,2189044,2189046,2189049,2189051,2189052,2189054,2189055,2189057,2189058,2189060,2189061,2189062,2189065,2189066,2189067,2189068,2189069,2189071,2189073,2189074,2189078,2189081,2189082,2189083,2189084,2189085,2189088,2189089,2189090,2189092,2189093,2189094,2189097,2189100,2189102,2189103,2189104,2189107,2189111,2189112,2189113,2189121,2189124,2189125,2189126,2189131,2189133,2189134,2189135,2189136,2189141,2189147,2189153,2180816,2182126,2182132,2182220,2182225)     THEN 'El presente documento sustituye cualquier otro emitido por el mismo concepto y hechos'    ELSE ''    END AS textoMostrar,    (select valor_parametro_defecto from parametro(NOLOCK) where codigo_parametro=434) as cargo_delegado,    (UPPER((select valor_parametro_defecto from parametro(NOLOCK) where codigo_parametro=434))) as cargo_delegado_mayusculas  FROM   coactivo c (nolock)         JOIN proceso p (nolock)           ON p.id_proceso = c.id_proceso         JOIN trazabilidad_proceso tp (nolock)           ON tp.id_proceso = p.id_proceso         JOIN persona pe (nolock)           ON pe.id_persona = c.id_deudor         LEFT JOIN persona_juridica pj (nolock)                ON pj.id_persona_juridica = pe.id_persona         JOIN tipo_identificacion_persona tip (nolock)           ON tip.id_tipo_identificacion = pe.id_tipo_identificacion         JOIN funcionario fu (nolock)           ON fu.id_funcionario = c.id_funcionario         JOIN persona per (nolock)           ON per.id_persona = fu.id_persona  WHERE  c.id_coactivo = :idCoactivo         AND tp.id_estado_proceso = 24
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------