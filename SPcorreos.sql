USE [notificaciones]
GO
/****** Object:  StoredProcedure [dbo].[dba_ws_sendDoc]    Script Date: 13/07/2023 9:44:48 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[dba_ws_sendDoc] @extranlId varchar (120),
					@email varchar(120),@pdf xml,
					@multa int, @numerodocumento varchar(50),@citacion varchar(30),
					@Status varchar(8000) out AS


DECLARE @obj int,
        @url VarChar(8000),
        @requestHeader VarChar(8000),
        @requestBody VarChar(max),
		@lenth int,
		@response varchar(8000)

--set @idEnvio = @id_external

select 'LP 1'
SET @url = 'https://q7mgkqt1r8.execute-api.us-east-1.amazonaws.com/Stage/ws/rest/sendEmail'
/** HU-GEN-NOT-MUL Generar notificaci�n de multa **/
-- Se obtiene el cuerpo del correo
declare @html varChar(max)
, @plantilla varchar(max)

set @html = dbo.dba_obtener_cuerpo_correo(@multa)
select 'LP 2'
IF ISNULL(@html,'')=''
	set @plantilla = ',"templateId": 1553296812384611'
else
	set @plantilla = ',"bodyContent": '+ @html

/*************************************************/
-- Para produccion
-- "certification" : true, 
SET @requestBody = '{
  "fromName" : "Autoridad de Transito Municipal Guayaquil",
  "fromAddress" : "alexander.aguilar@datatools.com.co",
  "certification" : false,
  "signAttachments": true,
  "recipients" :
    [
    "'+rtrim(@email)+'"
    ],
  "subject" : "NOTIFICACIÓN DE INFRACCIÓN '+rtrim(@multa)+' - CITACIÓN '+rtrim(@citacion)+' ",
  "metadata": [
    {"tag": "cedula", "value":"'+rtrim(@numerodocumento)+'"},
    {"tag": "multa", "value":"'+rtrim(@multa)+'"},
	{"tag": "correo", "value":"'+rtrim(@email)+'"},
	{"tag": "extranlid", "value":"'+rtrim(@extranlId)+'"}
    ],
  "attachments": [
    {"name": "'+rtrim(@multa)+'.pdf", "data":"'+cast(@pdf as varchar(max))+'"}
    ]' +
	@plantilla
+'}'

--select @requestBody
select @lenth=LEN(@requestBody)
select 'LP 3'

EXEC sp_OACreate 'MSXML2.ServerXMLHttp', @obj OUT
select 'LP 3.1'
EXEC sp_OAMethod @obj, 'Open', NULL, 'POST', @url, false
EXEC sp_OAMethod @obj, 'setRequestHeader', NULL, 'Content-Type', 'application/json'
EXEC sp_OAMethod @obj, 'setRequestHeader', NULL, 'X-SCKEY-TOKEN', '+qOl+xeENhMaqI/DJZro8wlgIpWNdtO0fnzNXSl0D9305yrw8RsfnPTkWw+el5xzcO0dQDMubORGQ9VAnTHxhE0RELp3O8NdUF1si0LKuJM='
EXEC sp_OAMethod @obj, 'send', NULL, @requestBody
EXEC sp_OAGetProperty @obj, 'responseText', @response OUTPUT
select 'LP 4'
EXEC sp_OADestroy @obj
select @requestBody
INSERT INTO circulemos2.dbo."log_ejecucion_ws" ( "id_respuesta_web_services", "mensaje_enviado", "fecha_envio", "ruta_envio", "mensaje_recibido", "fecha_recepcion", "observacion") 
VALUES ( NULL
, @requestBody 
, getDATE(), 'https://q7mgkqt1r8.execute-api.us-east-1.amazonaws.com/Stage/ws/rest/sendEmail',@response , getDATE(), 'https://q7mgkqt1r8.execute-api.us-east-1.amazonaws.com/Stage/ws/rest/sendEmail');
select @response
select 'LP 5'
--select @response
select @Status=@response

--select notificaciones.dbo.dba_read_response_rest(@response,'messageId')