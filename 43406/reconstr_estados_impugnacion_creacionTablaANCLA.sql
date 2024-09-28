select *from circulemos2.dbo.tipo_fallo

select *from circulemos2.dbo.usuario_persona
where login like '%NEIMY%'

select *from circulemos2.dbo.estado_proceso
where id_tipo_proceso=1
and nombre like '%FALLO%'


--id_reconstr,expediente,",Tipo Fallo,",Motivación_fallo,",Usuario Sogit Fallo,",Fecha Fallo,",Plantilla Fallo,",Documento Fallo,",Estado Fallo,",Usuario Sogit Resolucion(Estado_Cerrado),",Fecha_resolucion(Estado_Cerrado),",documento resolucion,",Estado SOGIT resolucion,",fecha_procesamiento,",procesado,",error,",path_documento,
--=A2&","&B2&","","&C2&","","&D2&","","&E2&","","&F2&","","&G2&","","&H2&","","&I2&","","&J2&","","&K2&","","&L2&","","&M2&","","&N2&","","&O2&","","&P2&","","&Q2&","


--[id_reconstr],	[expediente],	[Tipo Fallo],	[Motivación_fallo],	[Usuario Sogit Fallo],	[Fecha Fallo],	[Plantilla Fallo],	[Documento Fallo],	[Estado Fallo],	[Usuario Sogit Resolucion(Estado_Cerrado)],	[Fecha_resolucion(Estado_Cerrado)],	[documento resolucion],	[Estado SOGIT resolucion],	[fecha_procesamiento],	[procesado],	[error],	[path_documento]


-----------------------------------
--Creación de una tabla

CREATE TABLE integracion_terceros.[dbo].[reconstr_estados_impugnacion](
 [id_reconstr][bigint] IDENTITY(1,1) NOT NULL,
 [expediente] [varchar](20),	
 [Tipo Fallo] [varchar](50), --Es un valor grandeeeee	
 [Motivación_fallo] [varchar](max),	
 [Usuario Sogit Fallo] [varchar](20),
 [Fecha Fallo] [datetime],--GETDATE() AÑO, MES , DIA
 [Plantilla Fallo] [varchar](50),	
 [Documento Fallo] [varchar](255) NULL,	
 [Estado Fallo] [varchar](50),	
 [Usuario Sogit Resolucion(Estado_Cerrado)][varchar](20),
 [Fecha_resolucion(Estado_Cerrado)][datetime],	
 [documento resolucion][varchar](50),	
 [Estado SOGIT resolucion][varchar](50),
 [fecha_procesamiento] [datetime],	--Parece que esté es el final datetime
 [procesado][smallint] NOT NULL,	
 [error] [varchar](250) NULL,	
 [path_documento][varchar](255) NULL --varchar grande
 );

----------------------------------------------------------------------
--begin tran
--drop TABLE integracion_terceros.[dbo].[reconstr_estados_impugnacion]
--commit tran


/*delete integracion_terceros.[dbo].[reconstr_estados_impugnacion]
where id_reconstr=10*/
----------------------------------------------------------------------
 SELECT *FROM integracion_terceros.[dbo].[reconstr_estados_impugnacion]

  SELECT 
  --[Estado SOGIT resolucion]
  *FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Estado SOGIT resolucion]='CERRADO'

   SELECT *FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Estado SOGIT resolucion] like '%CERRADO%'

---********************************************************************
--, , ,

  @Usuario_Sogit_Resolucion_Estado_Cerrado= SELECT *FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Usuario Sogit Resolucion(Estado_Cerrado)]

  @Fecha_resolucion_Estado_Cerrado=SELECT *FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Fecha_resolucion(Estado_Cerrado)]

  @Estado_SOGIT_resolucion=SELECT *FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Estado SOGIT resolucion]
---********************************************************************
--  Estado SOGIT resolucion
--CERRADO
-----------------------------------------------------------------------------------------
 @Estado_SOGIT_resolucion=SELECT *FROM integracion_terceros.dbo.reconstr_estados_impugnacion
  where [Tipo Fallo]




---------------------------------------------------------------------
--El insert







 --------------------------------------
 --Ejemplo solicitud busqueda de bienes

 USE [circulemos2]
GO

/****** Object:  Table [dbo].[reconstruccion_solicitud_busqueda_bienes]    Script Date: 11/09/2024 1:35:08 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[reconstruccion_solicitud_busqueda_bienes](
	[id_consecutivo_reconstruccion] [bigint] IDENTITY(1,1) NOT NULL,
	[numero_juicio] [varchar](20) NOT NULL,
	[valor_proyectado] [varchar](20) NOT NULL,
	[numero_oficio] [varchar](20) NOT NULL,
	[fecha_creacion_oficio] [varchar](80) NOT NULL,
	[documento_1] [varchar](100) NOT NULL,
	[documento_2] [varchar](100) NOT NULL,
	[documento_3] [varchar](100) NOT NULL,
	[procesado] [smallint] NOT NULL,
	[error] [varchar](250) NULL,
	[path_documento_1] [varchar](255) NULL,
	[path_documento_2] [varchar](255) NULL,
	[path_documento_3] [varchar](255) NULL
) ON [PRIMARY]
GO




 -----------------------------------
--Creación de una tabla

USE [circulemos2]
 GO
 
CREATE TABLE [dbo].[funcionario_financiacion](
   [id_funcionario_fin] [int] IDENTITY(1,1) NOT NULL,
   [id_funcionario] [int] NOT NULL,
   [id_cargo] [int] NOT NULL,
   [fecha_inicio_vigencia] [date] NOT NULL,
   [fecha_final_vigencia] [date] NULL,
   [memo_nombramiento] [varchar](150) NULL,
   [fecha_nombramiento] [date] NULL,
   [motivo] [varchar](11) NULL,
   [estado] [varchar](11) NULL,
   [id_subcargo] [int] NULL,
   [titulo_obtenido] [varchar](10) NULL,
   [id_persona] [bigint] NOT NULL,
 PRIMARY KEY CLUSTERED 
 (
   [id_funcionario_fin] ASC
 ) ON [PRIMARY]
 )
 GO
 
ALTER TABLE [dbo].[funcionario_financiacion]  WITH CHECK ADD  CONSTRAINT [FK_funci_fin_01] FOREIGN KEY([id_cargo])
 REFERENCES [dbo].[cargo] ([id_cargo])
 GO
 
ALTER TABLE [dbo].[funcionario_financiacion] CHECK CONSTRAINT [FK_funci_fin_01]
 GO
 
ALTER TABLE [dbo].[funcionario_financiacion]  WITH CHECK ADD  CONSTRAINT [FK_funci_fin_02] FOREIGN KEY([id_funcionario])
 REFERENCES [dbo].[funcionario] ([id_funcionario])
 GO
 
ALTER TABLE [dbo].[funcionario_financiacion] CHECK CONSTRAINT [FK_funci_fin_02]
 GO
 
ALTER TABLE [dbo].[funcionario_financiacion]  WITH CHECK ADD  CONSTRAINT [FK_funci_fin_03] FOREIGN KEY([id_subcargo])
 REFERENCES [dbo].[subcargo] ([id_subcargo])
 GO
 
ALTER TABLE [dbo].[funcionario_financiacion] CHECK CONSTRAINT [FK_funci_fin_03]
 GO
 
ALTER TABLE [dbo].[funcionario_financiacion]  WITH CHECK ADD  CONSTRAINT [FK_funci_fin_04] FOREIGN KEY([id_persona])
 REFERENCES [dbo].[persona] ([id_persona])
 GO
 
ALTER TABLE [dbo].[funcionario_financiacion] CHECK CONSTRAINT [FK_funci_fin_04]
 GO


 ----------------------------------------------

 --El insert de la tabla creada
 USE [integracion_terceros]
GO

INSERT INTO [dbo].[reconstr_estados_impugnacion]
           ([expediente]
           ,[Tipo Fallo]
           ,[Motivación_fallo]
           ,[Usuario Sogit Fallo]
           ,[Fecha Fallo]
           ,[Plantilla Fallo]
           ,[Documento Fallo]
           ,[Estado Fallo]
           ,[Usuario Sogit Resolucion(Estado_Cerrado)]
           ,[Fecha_resolucion(Estado_Cerrado)]
           ,[documento resolucion]
           ,[Estado SOGIT resolucion]
           ,[fecha_procesamiento]
           ,[procesado]
           ,[error]
           ,[path_documento])
     VALUES
           (<expediente, varchar(20),>
           ,<Tipo Fallo, varchar(5000),>
           ,<Motivación_fallo, varchar(50),>
           ,<Usuario Sogit Fallo, varchar(20),>
           ,<Fecha Fallo, datetime,>
           ,<Plantilla Fallo, varchar(20),>
           ,<Documento Fallo, varchar(255),>
           ,<Estado Fallo, varchar(20),>
           ,<Usuario Sogit Resolucion(Estado_Cerrado), varchar(20),>
           ,<Fecha_resolucion(Estado_Cerrado), datetime,>
           ,<documento resolucion, varchar(20),>
           ,<Estado SOGIT resolucion, varchar(20),>
           ,<fecha_procesamiento, datetime,>
           ,<procesado, smallint,>
           ,<error, varchar(250),>
           ,<path_documento, varchar(255),>)
GO

-------------------------------------------------------

--lo siguiente sería actualizar el estado del proceso a 4, y fecha_fin, igual fecha_reoslucion, en observacion tambien debe colocarle cerrado
select top 2 *from circulemos2.[dbo].[trazabilidad_proceso]
where id_estado_proceso=4

select top 2 *from circulemos2.[dbo].proceso
where id_estado_proceso=23

select *from circulemos2.[dbo].[estado_proceso]

/*select * from circulemos2.dbo.estado_proceso
where nombre like '%cerrado%' --4*/

--id_trazabilidad_proceso


select id_trazabilidad_proceso 
from circulemos2.[dbo].[trazabilidad_proceso]
where id_estado_proceso=4

select top 20 *from circulemos2.[dbo].fallo_impugnacion


--------------------------------------------------------
--Insert fallo impugnacion
USE [circulemos2]


INSERT INTO [circulemos2].[dbo].[fallo_impugnacion]
           ([id_trazabilidad_proceso]
           ,[id_tipo_fallo]
           ,[motivo]
           ,[porcentaje]
           ,[codigo_plantilla]
           ,[valor_obligacion]
           ,[valor_descuento]
           ,[puntos]
           ,[id_infraccion]
           ,[id_memo_fallo]
           ,[id_funcionario]
           ,[valor_total_devolucion])
     VALUES
           (<id_trazabilidad_proceso, bigint,>
           ,<id_tipo_fallo, int,>
           ,<motivo, varchar(max),>
           ,<porcentaje, decimal(5,2),>
           ,<codigo_plantilla, varchar(20),>
           ,<valor_obligacion, decimal(16,2),>
           ,<valor_descuento, decimal(16,2),>
           ,<puntos, decimal(5,2),>
           ,<id_infraccion, int,>
           ,<id_memo_fallo, bigint,>
           ,<id_funcionario, int,>
           ,<valor_total_devolucion, numeric(10,2),>)


-------------------------------------------------------------------

select co.id_coactivo
from coactivo co
inner join proceso po on po.id_proceso=co.id_proceso
inner join obligacion_coactivo oc on co.id_coactivo=oc.id_coactivo
inner join comparendo com on com.id_factura_axis=oc.numero_obligacion
inner join comparendo_proceso cp on cp.cicomparendo=com.cicomparendo 
inner join proceso pe on pe.id_proceso=cp.id_proceso and pe.id_tipo_proceso = 1
where po.nu in('276972','269279','274477','281588','284544','284591','287643','287470','290353')
and year(po.fecha_inicio)='2023'
--and  po.id_proceso=cp.id_proceso
--and  po.id_tipo_proceso = 1

select top 2 *from proceso
select top 2 *from obligacion_coactivo
select top 2 *from comparendo
select top 2 *from comparendo_proceso
------------------------------------------------------------------
USE [circulemos2]
GO

INSERT INTO [dbo].[fallo_impugnacion]
           ([id_trazabilidad_proceso]
           ,[id_tipo_fallo]
           ,[motivo]
           ,[porcentaje]
           ,[codigo_plantilla]
           ,[valor_obligacion]
           ,[valor_descuento]
           ,[puntos]
           ,[id_infraccion]
           ,[id_memo_fallo]
           ,[id_funcionario]
           ,[valor_total_devolucion])
     VALUES
           (<id_trazabilidad_proceso, bigint,>
           ,<id_tipo_fallo, int,>
           ,<motivo, varchar(max),>
           ,<porcentaje, decimal(5,2),>
           ,<codigo_plantilla, varchar(20),>
           ,<valor_obligacion, decimal(16,2),>
           ,<valor_descuento, decimal(16,2),>
           ,<puntos, decimal(5,2),>
           ,<id_infraccion, int,>
           ,<id_memo_fallo, bigint,>
           ,<id_funcionario, int,>
           ,<valor_total_devolucion, numeric(10,2),>)
GO

------------------------------------------------------------




















-----------------------------------------------------------------------

--ANEXOS

------------------------------------------------------------------------


USE [integracion_terceros]
GO

INSERT INTO [dbo].[reconstr_estados_impugnacion]
           ([expediente]
           ,[Tipo Fallo]
           ,[Motivación_fallo]
           ,[Usuario Sogit Fallo]
           ,[Fecha Fallo]
           ,[Plantilla Fallo]
           ,[Documento Fallo]
           ,[Estado Fallo]
           ,[Usuario Sogit Resolucion(Estado_Cerrado)]
           ,[Fecha_resolucion(Estado_Cerrado)]
           ,[documento resolucion]
           ,[Estado SOGIT resolucion]
           ,[fecha_procesamiento]
           ,[procesado]
           ,[error]
           ,[path_documento])
     VALUES

--	  ('14807-2023','Fallo condenatorio - total','avoco conocimiento del presente expediente de contravención de tránsito, que se inició
--mediante la Impugnación No. 15977 - 2023 presentada por ALEJANDRO MAURICIO RODRIGUEZ VALAREZO con
--identificación No. 0923764914 , quien impugna en los siguientes términos: “ Solicito la impugnación por motivo me
--estacione en mi lugar de trabajo ya que soy trabajador del ministerio de salud publica estuve buscando la llave del
--garaje sin darme cuenta que había sido multado por medio de foto de un agente de transito y no me entrego la citación
--y no me dejo junto al vehículo la citación No. 5003000169 y declaro bajo juramento que no he presentado impugnación
--por la referida infracción ante la Función Judicial y que, en caso de hacerlo, daré aviso inmediato dentro de este trámite
--a la ATM ”. De conformidad con lo consagrado en el artículo 173 de la Constitución de la República del Ecuador, y
--según lo estipulado en el artículo 147 de la Ley Orgánica de Transporte Terrestre, Tránsito y Seguridad Vial y en los
--artículos 98, 99 y 100 del Código Orgánico Administrativo , y siendo el estado actual del expediente el de resolver, para
--hacerlo se considera: PRIMERO.- El artículo 130 del Código Orgánico de Organización Territorial, Autonomía y
--Descentralización establece en su segundo inciso que a los Gobiernos Autónomos Descentralizados Municipales les
--corresponde de forma exclusiva planificar, regular y controlar el tránsito, el transporte y la seguridad vial, dentro de su
--territorio cantonal, y en Guayaquil se lo ejerce a través de la Empresa Pública Municipal de Tránsito de Guayaquil, Ep.,
--conforme consta en el artículo 2 de la Ordenanza que regula su Creación y Funcionamiento, publicada en la Gaceta
--Oficial Municipal No. 38, del lunes 30 de julio de 2012,que textualmente expresa: “La entidad municipal “EMPRESA
--PÚBLICA MUNICIPAL DE TRÁNSITO, EP” tiene por objeto ejercer la competencia de rectoría local, planificación,
--regulación, control y gestión del tránsito, transporte terrestre y seguridad vial en el cantón Guayaquil de acuerdo con la
--Constitución de la República y el Código Orgánico de Organización Territorial, Autonomía y Descentralización,
--fundamentalmente. El artículo 1 de la Segunda Reforma a la Ordenanza que regula la Creación y Funcionamiento de la
--EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO DE GUAYAQUIL, EP publicada en la Gaceta Oficial Municipal No.
--29, el jueves 17 de Diciembre de 2020, que textualmente expresa: “Modifíquese a lo largo de toda la Ordenanza
--vigente donde se nombre a la ORDENANZA QUE REGULA LA CREACIÓN Y FUNCIONAMIENTO DE LA EMPRESA
--PÚBLICA MUNICIPAL DE TRÁNSITO DE GUAYAQUIL EP., y de sus reformas la denominación por “EMPRESA
--PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL, EP”. De conformidad con los artículos 49 y 71
--del Código Orgánico Administrativo el infrascrito delegado es competente para conocer y resolver la presente
--impugnación. SEGUNDO. - No existe omisión de solemnidad sustancial que vicie de nulidad el procedimiento, de
--acuerdo ¿con lo dispuesto en los artículos 14, 42,43, 65, 134 y 183 del Código Orgánico Administrativo, y 76 (1) de la
--Constitución de la Republica de Ecuador, que regulan los reclamos y recursos a los actos administrativos emitidos por
--los Gobiernos Autónomos Descentralizados, y por las empresas públicas, por lo que se declara la validez de todo lo
--actuado y en todas sus partes. TERCERO.- La impugnación se refiere a la citación de tránsito 5003000169 del 09 de
--noviembre de 2023, impuesta de conformidad con el Artículo 6, numeral 1 - REFORMA A LA ORDENANZA PARA LA
--FACILITACIÓN DE LA CIRCULACIÓN VEHICULAR EN LA CIUDAD DE GUAYAQUIL - ESTACIONAR VEHICULOS
--EN SITIOS PROHIBIDOS DETERMINADOS POR LA ATM, O EN DOBLE COLUMNA FUERA DE LA ZONA CENTRAL
--CUARTO.- En el detalle de citación el agente civil de tránsito en su observación indica lo siguiente; “ESTACIONADO
--SOBRE LAS ACERA PANAMÁ Y JOSE AGUIRRE”, y la referida citación es por el Artículo 6, numeral 1 - REFORMA A
--LA ORDENANZA PARA LA FACILITACIÓN DE LA CIRCULACIÓN VEHICULAR EN LA CIUDAD DE GUAYAQUIL -
--ESTACIONAR VEHICULOS EN SITIOS PROHIBIDOS DETERMINADOS POR LA ATM, O EN DOBLE COLUMNA
--FUERA DE LA ZONA CENTRAL QUINTO. – Consta dentro del expediente el detalle de citación de tránsito
--5003000169 del 09 de noviembre de 2023, la infracción está dirigida a la placa vehicular No. GSI2065. SEXTO. –
--Consta dentro del expediente los siguientes documentos: Documentos habilitantes. SÉPTIMO. - El artículo 11 de la
--Constitución que establece “...El Estado será responsable por detención arbitraria, error judicial, retardo injustificado o
--inadecuada administración de justicia, violación del derecho a la tutela judicial efectiva, y por las violaciones de los
--principios y reglas del debido proceso...” OCTAVO.- El Código Orgánico Administrativo en su artículo 14, establece “La
--actuación administrativa se somete a la Constitución, a los instrumentos internacionales, a la ley, a los principios, a la                                                     
--jurisprudencia aplicable y al presente Código”. NOVENO.- El Código Orgánico Administrativo en su artículo 18,
--establece “Los organismos que conforman el sector público, deberán emitir sus actos conforme a los principios de
--juridicidad e igualdad y no podrán realizar interpretaciones arbitrarias” . DÉCIMO.- El Código Orgánico Administrativo,
--en su artículo 194, establece” La prueba será aportada por la persona interesada en su primera comparecencia al
--procedimiento administrativo. La prueba, a la que sea imposible tener acceso, deberá ser anunciada y aquella que no
--se anuncie no podrá introducirse en el período de prueba previsto en la norma de la materia o en su defecto, cuando
--las administraciones públicas lo fijen. Todo documento, información o pericia que no esté en poder de la persona
--interesada, que para ser obtenida requiera del auxilio de la administración pública, facultará para solicitar al órgano
--administrativo que ordene a quien corresponda que la entregue o facilite de acuerdo con las normas de este Código.
--Se podrá solicitar prueba no anunciada en la primera comparecencia, hasta antes de la resolución, siempre que se
--acredite que no fue de conocimiento de la persona interesada o que, habiéndola conocido, no pudo disponer de la
--misma. La administración pública podrá aceptar o no esta solicitud. Si la acepta, el órgano dispondrá que se la
--practique en un término de cinco días y no se podrá solicitar más pruebas. En el procedimiento administrativo donde no
--se haya previsto un período de prueba, la administración pública de oficio o a petición de la persona interesada, abrirá
--un período específico de no más de treinta días”. DÉCIMO PRIMERO.- El Código Orgánico Administrativo, en su
--artículo 198, establece” Las administraciones públicas podrán disponer la práctica de cualquier prueba que juzguen
--necesaria para el esclarecimiento de los hechos controvertidos”. DÉCIMO SEGUNDO.- El artículo 18 del Código
--Orgánico Administrativo dispone: “Principio de interdicción de la arbitrariedad. Los organismos que conforman el sector
--público, deberán emitir sus actos conforme a los principios de juridicidad e igualdad y no podrán realizar
--interpretaciones arbitrarias. El ejercicio de las potestades discrecionales, observará los derechos individuales, el deber
--de motivación y la debida razonabilidad”. Por las consideraciones que anteceden habiendo ALEJANDRO MAURICIO
--RODRIGUEZ VALAREZO con identificación No. 0923764914, deducido una impugnación respecto de una
--contravención de tránsito determinada en Artículo 6, numeral 1 - REFORMA A LA ORDENANZA PARA LA
--FACILITACIÓN DE LA CIRCULACIÓN VEHICULAR EN LA CIUDAD DE GUAYAQUIL - ESTACIONAR VEHICULOS
--EN SITIOS PROHIBIDOS DETERMINADOS POR LA ATM, O EN DOBLE COLUMNA FUERA DE LA ZONA CENTRAL
--, y habiéndose comprobado que el articulo por el cual se impuso la infracción de tránsito, es incorrecto ya que el
--agente civil de tránsito en su observación del detalle de citación indica “ESTACIONADO SOBRE LAS ACERA
--PANAMÁ Y JOSE AGUIRRE”, en este sentido resulta evidente que la imagen aportada en el detalle de citación No.
--5003000169 no aporta prueba suficiente para determinar el cometimiento de la infracción, por lo tanto, resulta
--ineludible para esta administración considerar una duda razonable a favor del administrado, en tal sentido a, a efectos
--de prevalecer el derecho que posee el administrado de presumir su inocencia, de conformidad a lo establecido en el
--artículo 3 numeral 6 de la Ley para la Optimización y Eficiencia de Trámites Administrativos el cual prescribe: “En caso
--de duda, las normas serán interpretadas a favor de la o el administrado. Los derechos sustanciales de las y los
--administrados prevalecerán sobre los aspectos meramente formales, siempre y cuando estos puedan ser subsanados
--y no afecten derechos de terceros o el interés público, según lo determinado en la Constitución de la República”. En
--virtud de los antecedentes expuestos, las pruebas aportadas en el expediente y de la normativa invocada aplicable al
--caso, RESUELVO DECLARAR CON LUGAR Y ACEPTAR LA IMPUGNACIÓN PRESENTADA por ALEJANDRO
--MAURICIO RODRIGUEZ VALAREZO con identificación No. 0923764914 y SE RATIFICA EL ESTADO DE
--INOCENCIA respecto a la contravención/multa de tránsito número 5003000169 del 09 de noviembre de 2023,
--impuesta de conformidad con el Artículo 6, numeral 1 - REFORMA A LA ORDENANZA PARA LA FACILITACIÓN DE
--LA CIRCULACIÓN VEHICULAR EN LA CIUDAD DE GUAYAQUIL - ESTACIONAR VEHICULOS EN SITIOS
--PROHIBIDOS DETERMINADOS POR LA ATM, O EN DOBLE COLUMNA FUERA DE LA ZONA CENTRAL, debiendo
--realizarse el cambio de estado de la multa en el sistema AXIS de la Autoridad de Tránsito Municipal de “impugnado” a
--“anulado”. Actúe Diacny Alcívar Matute como secretario(a) ad – hoc.- NOTIFIQUESE CÚMPLASE'	




--	 ,'diacny.alcivar',
--	  '18-12-2024','Registro Fallo','RESOLUCION ADMINISTRATIVA 15977-2023.pdf','FALLO PROYECTADO',
--	  'felipe.larreategui','18-12-2024','RESOLUCION ADMINISTRATIVA 14807-2023.pdf','CERRADO',null,1,null,null),

           /*(<expediente, varchar(20),>
           ,<Tipo Fallo, varchar(5000),>
           ,<Motivación_fallo, varchar(50),>
           ,<Usuario Sogit Fallo, varchar(20),>
           ,<Fecha Fallo, datetime,>
           ,<Plantilla Fallo, varchar(20),>
           ,<Documento Fallo, varchar(255),>
           ,<Estado Fallo, varchar(20),>
           ,<Usuario Sogit Resolucion(Estado_Cerrado), varchar(20),>
           ,<Fecha_resolucion(Estado_Cerrado), datetime,>
           ,<documento resolucion, varchar(20),>
           ,<Estado SOGIT resolucion, varchar(20),>
           ,<fecha_procesamiento, datetime,>
           ,<procesado, smallint,>
           ,<error, varchar(250),>
           ,<path_documento, varchar(255),>)*/





('14807-2023','Condenatorio',
'avoco conocimiento delpresente expediente de contravención de tránsito, que se inició mediante la Impugnación No. 14807 - 2023 presentadapor JUAN CARLOS OCHOA ALVARADO con identificación No. 0913273835 , quien impugna en los siguientes términos:“ Solicito la impugnación porque nunca fui notificado de la misma por ningún medio, solo me llegó la notificación del juiciode coactiva. Adjunto escrito y documentos habilitantes. “Por lo expuesto anteriormente solicito la impugnación de la multagenerada por la citación de tránsito No. 3316000464 y declaro bajo juramento que no he presentado impugnación por lareferida infracción ante la Función Judicial y que, en caso de hacerlo, daré aviso inmediato dentro de este trámite a laATM.” ”. De conformidad con lo consagrado en el artículo 173 de la Constitución de la República del Ecuador, y según loestipulado en el artículo 147 de la Ley Orgánica de Transporte Terrestre, Tránsito y Seguridad Vial y en los artículos 98,99 y 100 del Código Orgánico Administrativo , y siendo el estado actual del expediente el de resolver, para hacerlo seconsidera: PRIMERO. – El artículo 130 del Código Orgánico de Organización Territorial, Autonomía y Descentralización establece en su segundo inciso que a los Gobiernos Autónomos Descentralizados Municipales les corresponde de forma exclusiva planificar, regular y controlar el tránsito, el transporte y la seguridad vial, dentro de su territorio cantonal, y en Guayaquil se lo ejerce a través de la Empresa Pública Municipal de Tránsito de Guayaquil, E., conforme consta en el artículo 2 de la Ordenanza que regula su Creación y Funcionamiento, publicada en la Gaceta Oficial Municipal No. 38, del lunes 30 de julio de 2012, que textualmente expresa: “La entidad municipal “EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO, EP” tiene por objeto ejercer la competencia de rectoría local, planificación, regulación, control y gestión del tránsito, transporte terrestre y seguridad vial en el cantón Guayaquil de acuerdo con la Constitución de la República y el Código Orgánico de Organización Territorial, Autonomía y Descentralización, fundamentalmente. El artículo 1 de la Segunda Reforma a la Ordenanza que regula la Creación y Funcionamiento de la EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO DE GUAYAQUIL, EP publicada en la Gaceta Oficial Municipal No. 29, el jueves 17 de Diciembre de 2020, que textualmente expresa: “Modifíquese a lo largo de toda la Ordenanza vigente donde se nombre a la ORDENANZA QUE REGULA LA CREACION Y FUNCIONAMIENTO DE LA EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO DE GUAYAQUIL EP., y de sus reformas la denominación por “EMPRESA PÚBLICA MUNICIPAL DE TRÁNSITO Y MOVILIDAD DE GUAYAQUIL, EP”. De conformidad con los artículos 49 y 71 del Código Orgánico Administrativo el infrascrito Delegado es competente para conocer y resolver la presente impugnación. SEGUNDO. – No existe omisión de solemnidad sustancial que vicie de nulidad el procedimiento, de acuerdo con lo dispuesto en los artículos 14, 42, 43, 65, 134 y 183 del Código Orgánico Administrativo, y 76 (1) de la Constitución ecuatoriana, que regulan los reclamos y recursos a los actos administrativos emitidos por los Gobiernos Autónomos Descentralizados, y por las empresas públicas, por lo que se declara la validez de todo lo actuado y en todas sus partes. TERCERO. – La impugnación se refiere a la citación de tránsito número 3316000464 , del 04 de octubre de 2023 , por Contravención de Tránsito impuesta de conformidad con el Artículo 2 de la Reforma a la Ordenanza para la Facilitación de la Circulación Vehicular en la ciudad de Guayaquil - ESTACIONAR EN SITIOS PROHIB. O EN DOBLE COLUMNA. FUERA DE LA ZONA CENTRAL, el cual establece: “Fuera de la zona que señala el artículo anterior, los conductores y solidariamente el propietario del vehículo que estacionen sus vehículos en sitios prohibidos determinados por la Autoridad de Tránsito Municipal, o que estacionen sus vehículos en doble columna impidiendo así el buen uso del espacio público, serán sancionados con una multa equivalente al 15% de un Salario Básico Unificado; dicha sanción será puesta a conocimiento del conductor y/o propietario del automotor al momento de cometer la falta o será notificada a través de los medios electrónicos, o mediante avisos en los diarios de mayor circulación o al realizar el proceso de Matriculación y Revisión Técnica Vehicular, según el orden aquí descrito”. CUARTO. – Consta agregado al expediente el detalle de la citación No. 3316000464 , del 04 de octubre de 2023 , impuesta de conformidad con el Artículo 2 de la Reforma a la Ordenanza para la Facilitación de la Circulación Vehicular en la ciudad de Guayaquil - ESTACIONAR EN SITIOS PROHIB. O EN DOBLE COLUMNA. FUERA DE LA ZONA CENTRAL, donde se puede apreciar la imagen captada por el agente civil de tránsito al momento de generar la citación. QUINTO.- Que de lo indicado en la ORDENANZA DE DISMINUCIÓN Y ELIMINACIÓN DE VALORES DE MULTAS DE TRÁNSITO ESTABLECIDAS EN ORDENANZA                                                       
MUNICIPALES, publicada en el registro oficial No. 982 de fecha 01 de agosto de 2023 en su parte pertinente establece “(…) Art. 6.- Sustitúyase el Art. 6 de la Ordenanza para la Facilitación de la Circulación Vehicular en la Ciudad de Guayaquil, por el siguiente texto: “Los conductores y solidariamente el propietario del vehículo que estacionen sus
vehículos en sitios prohibidos determinados por la Empresa Pública Municipal de Tránsito y Movilidad de Guayaquil, EP., o que estacionen sus vehículos en doble columna impidiendo así el buen uso de espacio público, serán sancionados con una multa equivalente al 10% de un salario básico unificado; dicha sanción será puesta a
conocimiento del conductor y/o propietario del automotor al momento de cometer la falta o será notificada a través de los medios electrónicos, o mediante avisos en los diarios de mayor circulación o al realizar el proceso de Matriculación y Revisión Técnica Vehicular, según el orden aquí descrito.…” SEXTO.- Consta adjunto por el administrado a su
reclamo inicial lo siguiente: 6.1 Documentos habilitantes ; 6.2 Un escrito en el que indica “….a) Con fecha 07 de noviembre de 2023, tengo conocimiento de un proceso coactivo con numero 274477-2023, enviado a mi correa personal por una supuesta la citación de tránsito, multa inconstitucionalmente impuesta a mi licencia y al vehículo de
mi propiedad de placas EBA1131, puesto que no he sido notificado con copia del detalle de la citacfón, en legat y debida forma por parte de la ATM de la Ciudad de Guayaquil, lo cual me deja en estado absoluto de indefensión y vulneración directa de derechos Constitucionales, de conformidad con lo que establecen las siguientes normas legales;
Corte Constitucional en su Sentencia 71-14-CN-19 señala: ""La finalidad de la notificación es poner en conocimiento del particular afectado el inicio de una actuación en su contra, de tal forma que pueda participar integralmente en cada etapa del procedimiento administrativo y, de ser pertinente, ejercer su derecho de defensa y contradicción. Si el
presunto infractor no ha tenido la oportunidad de demostrar su inocencia atentan contra el derecho fundamental al debido proceso"". Ley Orgánica de transporte Terrestre y Seguridad Vial, Art. 179.- En las contravenciones, los agentes de tránsito entregarán personalmente al responsable de la comisión de la contravención, copia de la boleta
correspondiente, en ta cual se señalará la contravenclón, el nombre y número de cédula del conductor del vehículo, o de no poder establecerse la identidad del conductor el número de placas del vehículo. En caso de que no se pueda entregar la boleta personalmente, ésta de ser posible se remitirá al domicilio del propietario del vehículo en un plazo no
mayor de setenta y dos horas contados desde la fecha en que fue cometida la infracción. Dicha boleta llevará impreso el detalle de la contravención y la advertencia de las sanciones correspondientes que para ella prevé la Ley. En el Artículo 19 del Reglamento de Homologación, Uso y Validación de Sistemas, Dispositivos y Equipos Tecnológicos para
Detección y Notificación de Infracciones de Tránsito se detalla a su vez; ""...Art. 19.- Notificación: En caso de que no se pueda entregar la boleta personalmente, esta de ser posible se remitirá al domicilio del propietario del vehículo en un plazo no mayor de setenta y dos horas contadas desde la fecha en que fue cometida la infracción. Dicha Boleta llevara
impresa el detalle de la contravención y la advertencia de las sanciones correspondientes que para ella prevé la ley. Reglamento General para la Aplicación de la Ley Orgánica de Transporte Terrestre, Tránsito y Seguridad Vial...Art. 238. Inc. 4. -Para efectos de la notificación de contravenciones, se tomará en cuenta el domicilio civil, correos
electrónicos, y demás información que se encuentre registrada en la base de datos de las instituciones que realizan el control de tránsito a nivel nacional o local.…” SÉPTIMO. – Mediante auto inicial de fecha 08 de noviembre de 2023, se dio apertura al período probatorio, en el que se suscitó lo siguiente: De conformidad con los artículos 193 al 199 del
Código Orgánico Administrativo,se da apertura al período probatorio por el término de diez días, a fin de que se evacúen las siguientes pruebas: 2.1.Que el/la secretario(a) ad-hoc extraiga del sistema AXIS el detalle de la citación de tránsito impugnada por JUANCARLOS OCHOA ALVARADO con identificación No. 0913273835 y se lo agregue al
expediente. 2.2. Que elimpugnante presente las pruebas que considere pertinentes que demuestren lo alegado en el escrito de impugnación,estas podrán ser ingresadas por medio de la página web www.atm.gob.ec en la opción de Impugnación de Multas o demanera presencial en los Centros de Atención Ciudadana de la Empresa Pública de
Tránsito y Movilidad de GuayaquilE.P. 2.3. De conformidad al art. 196 del Código Orgánico Administrativo, todas las pruebas ordenadas dentro delprocedimiento estarán a disposición del impugnante, quien podrá acercarse al Centro de Atención Ciudadana de laEmpresa Pública de Tránsito y Movilidad, ubicado en el Centro Comercial Albán Borja, local 56 A y B, puerta 1, ysolicitar las copias certificadas de los documentos agregados al expediente por esta administración. 2.4. Que se envíeatento memorando a la Dirección de Control de Tránsito de la Autoridad de Tránsito Municipal a fin de que notifique alagente civil de tránsito GAMBOA GURUMENDI HUGO ENRIQUEZ con código 0377, el día 15 de noviembre del 2023,a las 10H00, para que comparezca a este despacho, ubicado en el Centro Comercial Albán Borja, local 56 A y B,puerta 1, a rendir su versión libre y voluntaria en torno a los hechos de la citación de tránsito No. 3316000464 del 04de octubre de 2023. De conformidad con el artículo 76, numeral 7, letra h de la Constitución de la República delEcuador, el impugnante podrá comparecer con el objeto de hacer prevalecer su derecho a la defensa. Cabe mencionar, que el requisito principal para presentarse e intervenir dentro de la versión libre y voluntaria es presentar ala secretaria del despacho la identificación o cédula de ciudadanía.…” OCTAVO. – Consta dentro del expediente lo siguiente: 7.1 Consta el acta de la versión libre y voluntaria del agente civil de tránsito GAMBOA GURUMENDI HUGO ENRIQUEZ con código 0377, en la que manifiesta: “(…) en las dependencias de la Autoridad de Tránsito Municipal, ante el DELEGADO del director de Gestión de Infracciones y Servicios de Tránsito, avoca conocimiento la AB. ARIANA ALEJANDRA AVILES MORA, según consta en el memorando No. EPMTMG-DGISTSACK-2023-0005, de fecha 26 de septiembre del 2023, comparece el agente GAMBOA GURUMENDI HUGO ENRIQUEZ con código 0377 con identificación no. 0951012954 a rendir su versión libre y voluntaria sobre los hechos en relación con la citación de tránsito No. 3316000464 , de fecha 04 de octubre de 2023, del expediente 14807 -2023. No se encuentra presente el impugnante JUAN CARLOS OCHOA ALVARADO con identificación No. 0913273835. Actúa como secretario(a) ad-hoc JENNIFFER ALEXANDRA ZAMBRANO VALENZUELA. En este estado se da inicio a la versión, disponiendo que el agente civil de tránsito GAMBOA GURUMENDI HUGO ENRIQUEZ, de contestación a las preguntas que realiza el Ab. ARIANA ALEJANDRA AVILES MORA en el siguiente orden: 1P.- GENERALES DE LEY: GAMBOA GURUMENDI HUGO ENRIQUEZ de estado civil casado de 28 años, con domicilio en la ciudad de Guayaquil, de ocupación ACT. 2P.- ¿Diga el declarante, si usted realizo la citación de tránsito a la licencia de conducir
o a la placa vehicular? 2R. yo realice la citación de tránsito No. 3316000464 , de fecha 04 de octubre de 2023 a la placa No. EBA1131. 3P.- Relaté el declarante los hechos en torno a la citación que reconoció usted en la pregunta anterior. – 3R. Me encontraba de servicio motorizado en la unidad No. 145 realizando rondas de control en la AV JUAN
TANCA MARENGO FUERA DEL IESS MARTHA DE ROLDÓS. Me percaté que el vehículo de placas EBA1131 se encontraba mal estacionado sobre la acera obstaculizando la libre circulación peatonal así mismo consta una señala reglamentaria que indica “prohibido estacionar”, me bajé de mi unidad, me acerqué al vehículo y visualicé que el
conductor no se encontraba en el interior, espere por el lapso de 10 minutos para que llegue el conductor al lugar, pero no llego, acto seguido procedí a confeccionar la citación de tránsito a la placa vehicular de conformidad con la ordenanza municipal por vehículo mal estacionado sobre la acera, dejando la boleta de citación debidamente firmada
adherida al parabrisas del vehículo. De lo alegado por el impugnante en su formulario de impugnación, es de mencionar que deje la boleta de citación debidamente firmada en el parabrisas del vehículo, por lo tanto, me ratifico en la sanción impuesta (…)”. Habiéndole notificado al impugnante que podría comparecer con el objeto de hacer
prevalecer su derecho a la defensa como consta en el auto inicial, este no asistió el día y hora antes mencionados NOVENO. – Consta dentro del expediente una razón sentada por parte del secretario AD-HOC en la cual se indica que el impugnante no ha presentado pruebas dentro del término procesal oportuno. DÉCIMO. – El artículo 14 del Código
Orgánico Administrativo, señala lo siguiente: “Art. 14.- Principio de juridicidad. - La actuación administrativa se somete a la Constitución, a los instrumentos internacionales, a la ley, a los principios, a la jurisprudencia aplicable y al presente Código”. DÉCIMO PRIMERO. – El artículo 18 del Código Orgánico Administrativo detalla “Los organismos que
conforman el sector público, deberán emitir sus actos conforme a los principios de juridicidad e igualdad y no podrán realizar interpretaciones arbitrarias. El ejercicio de las potestades discrecionales observará los derechos individuales, el deber de motivación y la debida razonabilidad.” DÉCIMO SEGUNDO. – El Código Orgánico Administrativo, en su
artículo 194, establece” La prueba será aportada por la persona interesada en su primera comparecencia al procedimiento administrativo. La prueba, a la que sea imposible tener acceso, deberá ser anunciada y aquella que no se anuncie no podrá introducirse en el período de prueba previsto en la norma de la materia o en su defecto, cuando
las administraciones públicas lo fijen. Todo documento, información o pericia que no esté en poder de la persona interesada, que para ser obtenida requiera del auxilio de la administración pública, facultará para solicitar al órgano administrativo que ordene a quien corresponda que la entregue o facilite de acuerdo con las normas de este Código.
Se podrá solicitar prueba no anunciada en la primera comparecencia, hasta antes de la resolución, siempre que se acredite que no fue de conocimiento de la persona interesada o que, habiéndola conocido, no pudo disponer de la misma. La administración pública podrá aceptar o no esta solicitud. Si la acepta, el órgano dispondrá que se la
practique en un término de cinco días y no se podrá solicitar más pruebas. En el procedimiento administrativo donde no se haya previsto un período de prueba, la administración pública de oficio o a petición de la persona interesada, abrirá un período específico de no más de treinta días”. DÉCIMO TERCERO. – El Código Orgánico Administrativo, en su
artículo 198, establece: “Las administraciones públicas podrán disponer la práctica de cualquier prueba que juzguen necesaria para el esclarecimiento de los hechos controvertidos”. DÉCIMO CUARTO. – La Ley Orgánica De Transporte Terrestre, Tránsito y Seguridad Vial en el artículo 183 dispone: “Los usuarios de las vías están obligados a obedecer las normativas, reglamentaciones viales, indicaciones del agente de tránsito y señales de tránsito que establezcan una obligación o prohibición, salvo circunstancias especiales que lo justifiquen.”. DÉCIMO QUINTO . – El Reglamento a la Ley Orgánica de Transporte Terrestre, Tránsito y Seguridad Vial en su artículo 179, numeral 2 prescribe: “Está
prohibido a los conductores estacionar su vehículo: Sobre las aceras y rampas destinadas a la circulación de peatones.” Por las consideraciones que anteceden, habiendo JUAN CARLOS OCHOA ALVARADO con identificación No. 0913273835 ,, deducido una impugnación respecto a la citación de tránsito número 3316000464 , del 04 de octubre de 2023 , impuesta de conformidad con el Artículo 2 de la Reforma a la Ordenanza para la Facilitación de la Circulación Vehicular en la ciudad de Guayaquil, corresponde efectuar un análisis de las alegaciones planteadas por el impugnante a efectos de determinar si existe o no el cometimiento de la contravención contemplada en el detalle de citación No. 3480001742 sistema AXIS . 1.- De las alegaciones realizadas por el impugnante se le indica que el agente civil de tránsito GAMBOA GURUMENDI HUGO ENRIQUEZ con código 0377, en su versión libre y voluntaria manifestó : “(…) Me encontraba de servicio motorizado en la unidad No. 145 realizando rondas de control en la AV JUAN TANCA MARENGO FUERA DEL IESS MARTHA DE ROLDÓS. Me percaté que el vehículo de placas EBA1131 se encontraba mal estacionado sobre la acera obstaculizando la libre circulación peatonal así mismo consta una señala reglamentaria que indica “prohibido estacionar”, me bajé de mi unidad, me acerqué al vehículo y visualicé que el conductor no se encontraba en el interior, espere por el lapso de 10 minutos para que llegue el conductor al lugar, pero no llego, acto seguido procedí a confeccionar la citación de tránsito a la placa vehicular de conformidad con la ordenanza municipal por vehículo mal estacionado sobre la acera, dejando la boleta de citación debidamente firmada adherida al parabrisas
del vehículo. De lo alegado por el impugnante en su formulario de impugnación, es de mencionar que deje la boleta de citación debidamente firmada en el parabrisas del vehículo, por lo tanto, me ratifico en la sanción impuesta. (…)”; prueba testimonial que se considera pertinente y conducente, dentro de la presente impugnación, puesto que la
versión del agente civil de tránsito se encuentra envestida de legalidad y fé pública. Es importante destacar que cuando un Agente Civil de Tránsito emite una versión libre y voluntaria, se espera que lo haga de buena fe y dentro de los parámetros establecidos por la ley. En este sentido, se aplica la doctrina de los actos propios, que generalmente se
utiliza para los actos realizados por la Administración Pública en el ámbito del Derecho público. Esta doctrina reconoce la importancia de la buena fe y la equidad, en concordancia con el artículo 17 del Código Orgánico Administrativo que indica: “Principio de buena fe. Se presume que los servidores públicos y las personas mantienen un comportamiento legal y adecuado en el ejercicio de sus competencias, derechos y deberes.”. La fe pública es esencial para el funcionamiento adecuado del sistema jurídico y administrativo, ya que proporciona seguridad y certeza en las actuaciones de los servidores públicos. Cuando un acto o documento cuenta con fe pública, se le confiere una
presunción de veracidad y exactitud, lo que implica que se le otorga credibilidad y se le considera válido y vinculante para las partes involucradas. 2.- Respecto a la falta de notificación alegada por el impugnante se le hace conocer que consta del expediente la versión libre y voluntaria del agente civil de transito en la que menciono “…es de mencionar
que deje la boleta de citación debidamente firmada en el parabrisas del vehículo, por lo tanto, me ratifico en la sanción impuesta …” así mismo esta autoridad respetando el derecho a la defensa le indico mediante auto inicial de fecha 08 de noviembre de 2023 que podría comparecer a la versión del agente civil de transito sin embargo se ha podido
verificar que el impugnante no compareció a la diligencia de versión libre y voluntaria del agente civil de tránsito, con el objeto de hacer prevalecer su derecho a la defensa, aun habiendo sido notificado en debida y legal forma, siendo responsabilidad del impugnante. 3.- por lo que en este sentido, y no habiendo el impugnante presentado prueba alguna
que logre desvirtuar el cometimiento de la contravención, y habiendo el agente civil de tránsito GAMBOA GURUMENDI HUGO ENRIQUEZ con código 0377, comparecido a rendir su versión libre y voluntaria, donde ratificó el cometimiento de la contravención de tránsito realizada por el impugnante, con el cual se encuentra probada la existencia de la
contravención imputada, dado que ha logrado esclarecer el cometimiento de la infracción, convirtiéndolo en elemento probatorio que conduce al convencimiento pleno de los hechos y circunstancias de la infracción, se concluye que el impugnante es responsable del cometimiento de la contravención/multa de tránsito de conformidad al Artículo 2 de la
Reforma a la Ordenanza para la Facilitación de la Circulación Vehicular en la ciudad de Guayaquil. En virtud de los antecedentes expuestos, las pruebas aportadas en el expediente y de la normativa invocada aplicable al caso, RESUELVO DECLARAR NEGADA LA IMPUGNACIÓN PRESENTADA por JUAN CARLOS OCHOA ALVARADO con identificación No. 0913273835 , y SE RATIFICA LA SANCIÓN PECUNIARIA, de la citación de tránsito No. 3316000464 , del 04 de octubre de 2023 , impuesta de conformidad con el Artículo 2 de la REFORMA A LA ORDENANZA PARA LA FACILITACIÓN DE LA CIRCULACIÓN VEHICULAR EN LA CIUDAD DE GUAYAQUIL – ESTACIONAR EN SITIOS PROHIB. O EN DOBLE COLUMNA. FUERA DE LA ZONA CENTRAL , esto es la suma de USD$45,00 ( CUARENTA Y CINCO CON 00/100 DÓLARES DE LOS ESTADO UNIDOS DE AMÉRICA ), debiendo realizarse en el sistema AXIS
de la Autoridad de Tránsito Municipal el cambio de estado de la multa de “impugnado” a “pendiente”. De conformidad con lo dispuesto en el artículo 205 y 224 del Código Orgánico Administrativo se hace conocer al impugnante que tiene el término de 10 días, contados a partir de la notificación de la presente resolución, para presentar el correspondiente
recurso de apelación ante la máxima autoridad de esta entidad. Actúe Cristina Magallanes como secretario(a) ad-hoc.- NOTIFÍQUESE Y CÚMPLASE. –
'



,'darling.magallanes','7-12-2023','Registro Fallo',
'RESOLUCION ADMINISTRATIVA 14807-2023.pdf','FALLO PROYECTADO','felipe.larreategui','07-12-2023','RESOLUCION ADMINISTRATIVA 14807-2023.pdf','CERRADO',null,1,null,null)


