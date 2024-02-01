use circulemos2
 
CREATE TABLE [dbo].[acta_resorteo](
    "id_acta_resorteo" BIGINT IDENTITY(1,1) NOT NULL,
	"id_trazabilidad_proceso" BIGINT NOT NULL,
	"observacion" VARCHAR(max)  NULL,
	"id_funcionario" INT NOT NULL,
	"fecha_registro" DATE NULL DEFAULT NULL,
CONSTRAINT [PK_acta_resorteo] PRIMARY KEY CLUSTERED 
(
	[id_acta_resorteo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [UQ_acta_resorteo] UNIQUE NONCLUSTERED 
(
	[id_trazabilidad_proceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[acta_resorteo]  WITH CHECK ADD  CONSTRAINT [FK_acta_resorteo_funcionario] FOREIGN KEY([id_funcionario])
REFERENCES [dbo].[funcionario] ([id_funcionario])
GO
ALTER TABLE [dbo].[acta_resorteo] CHECK CONSTRAINT [FK_acta_resorteo_funcionario]
GO
ALTER TABLE [dbo].[acta_resorteo]  WITH CHECK ADD  CONSTRAINT [FK_acta_resorteo_proceso] FOREIGN KEY([id_trazabilidad_proceso])
REFERENCES [dbo].[trazabilidad_proceso] ([id_trazabilidad_proceso])
GO
ALTER TABLE [dbo].[acta_resorteo] CHECK CONSTRAINT [FK_acta_resorteo_proceso]
GO