
begin tran

USE [gestor_docs]

INSERT INTO [dbo].[data_documento]

           ([descripcion]

           ,[nombre]

           ,[folder]

           ,[extension]

           ,[nombre_real]

           ,[Registro_BD])

     VALUES

           ('LogoATMEncabezadoVariable'

           ,'LogoATMEncabezadoVariable.png'

           ,null

           ,'.png'

           ,'LogoATMEncabezadoVariable.png'

           ,1)

begin tran

USE [gestor_docs]

INSERT INTO [dbo].[data_documento]

           ([descripcion]

           ,[nombre]

           ,[folder]

           ,[extension]

           ,[nombre_real]

           ,[Registro_BD])

     VALUES

           ('LogoATMPieVariable'

           ,'LogoATMPieVariable.png'

           ,null

           ,'.png'

           ,'LogoATMPieVariable.png'

           ,1)

commit tran

259187099


-------------------------------
259187105

---------------------------


USE [circulemos2]

begin tran

INSERT INTO [dbo].[imagen]

           ([fecha_inicio]

           ,[fecha_fin]

           ,[numero_imagen]

           ,[id_tipo_imagen])

     VALUES

           (GETDATE()

           ,null

           ,259187099

           ,4)

commit tran

USE [circulemos2]

begin tran

INSERT INTO [dbo].[imagen]

           ([fecha_inicio]

           ,[fecha_fin]

           ,[numero_imagen]

           ,[id_tipo_imagen])

     VALUES

           (GETDATE()

           ,null

           ,259187105

           ,5)

commit tran

-----------------
259187105
---------
259187099