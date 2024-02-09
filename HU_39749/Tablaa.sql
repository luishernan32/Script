select *from proceso
where numero_proceso='67'
and year(fecha_inicio)='2024'
and id_tipo_proceso='1'


select *from trazabilidad_proceso
where id_proceso='17902336'

select *from trazabilidad_proceso
where id_trazabilidad_proceso='17902336'

------------------------------------------------
--De aquí se toma el ejemplo
select *from evaluar_impugnacion
where id_trazabilidad_proceso='17900523'





-------------------------------------------------
-----------Depuración----------------------------
-------------------------------------------------
select *from evaluar_impugnacion
where id_evaluar_impugnacion='268632'

select *from funcionario
where id_funcionario='3'

select *from persona
where id_persona='187252'

--268632
-------------------------------------------------



select *from acta_resorteo_impugnacion

------------------------------------------------

select ei.id_evaluar_impugnacion
from proceso p
inner join trazabilidad_proceso tp on p.id_proceso=tp.id_proceso
inner join evaluar_impugnacion ei on ei.id_trazabilidad_proceso=tp.id_trazabilidad_proceso
where ei.id_trazabilidad_proceso='17900523'



select *from estado_proceso   --Aquí se tiene que crear



select *from funcionario


USE [circulemos2]
GO










----------------------------------------------------------------------


----------------------------------------------------------------------acta_resorteo_impugnacion 




----------------------------------------------------------------------
--25/01/0224
USE circulemos2;
GO

CREATE TABLE acta_resorteo_impugnacion( 
	" id_acta_resorteo" BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	"id_trazabilidad_proceso" INT NOT NULL,
	"id_funcionario" INT NOT NULL,
	"codigo_plantilla" VARCHAR(50) NOT NULL,
	"fecha_registro" DATE NULL DEFAULT NULL,
	"observacion" VARCHAR(250) NOT NULL
);


--ActaResorteoImpugnacionDTO
--ActaResorteoImpugnacion
--ActaResorteoImpugnacionHelper 

select *from acta_resorteo_impugnacion

select *from funcionario



USE [circulemos2]
GO

/****** Object:  Table [dbo].[evaluar_impugnacion]    Script Date: 25/01/2024 5:52:35 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[evaluar_impugnacion](
	[id_evaluar_impugnacion] [bigint] IDENTITY(1,1) NOT NULL,
	[id_trazabilidad_proceso] [bigint] NOT NULL,
	[solucion_inmediata] [smallint] NOT NULL,
	[id_justificacion_impugnacion] [int] NULL,
	[consideracion_juridica] [varchar](max) NULL,
	[id_funcionario] [int] NULL,
	[codigo_plantilla] [varchar](50) NULL,
 CONSTRAINT [PK_evaluar_impugnacion] PRIMARY KEY CLUSTERED 
(
	[id_evaluar_impugnacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_evaluar_trazabilidad] UNIQUE NONCLUSTERED 
(
	[id_trazabilidad_proceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[evaluar_impugnacion]  WITH CHECK ADD  CONSTRAINT [FK_evaluar_impugnacion_funcionario] FOREIGN KEY([id_funcionario])
REFERENCES [dbo].[funcionario] ([id_funcionario])
GO

ALTER TABLE [dbo].[evaluar_impugnacion] CHECK CONSTRAINT [FK_evaluar_impugnacion_funcionario]
GO

ALTER TABLE [dbo].[evaluar_impugnacion]  WITH CHECK ADD  CONSTRAINT [FK_evaluar_trazabilidad_proceso] FOREIGN KEY([id_trazabilidad_proceso])
REFERENCES [dbo].[trazabilidad_proceso] ([id_trazabilidad_proceso])
GO

ALTER TABLE [dbo].[evaluar_impugnacion] CHECK CONSTRAINT [FK_evaluar_trazabilidad_proceso]
GO

ALTER TABLE [dbo].[evaluar_impugnacion]  WITH CHECK ADD  CONSTRAINT [FK_justificacion_impugnacion] FOREIGN KEY([id_justificacion_impugnacion])
REFERENCES [dbo].[justificacion_impugnacion] ([id_justificacion_impugnacion])
GO

ALTER TABLE [dbo].[evaluar_impugnacion] CHECK CONSTRAINT [FK_justificacion_impugnacion]
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


USE circulemos2;
GO
 
CREATE TABLE acta_resorteo_impugnacion( 
	" id_acta_resorteo" BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	"id_trazabilidad_proceso" INT NOT NULL,
	"id_funcionario" INT NOT NULL,
	"codigo_plantilla" VARCHAR(50) NOT NULL,
	"fecha_registro" DATE NULL DEFAULT NULL,
	"observacion" VARCHAR(250) NOT NULL
);


select *from acta_resorteo


