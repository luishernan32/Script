begin tran

commit tran

INSERT INTO [dbo].[web_services]
           ([id_web_services]
           ,[id_tipo_web_service]
           ,[codigo]
           ,[nombre]
           ,[estado]
           ,[descripcion]
           ,[url_primaria]
           ,[url_secundaria])
     VALUES
           (142
           ,1
           ,142
           ,'Reverso Pago Embargo'
           ,1
           ,'Reverso Pago Embargo'
           ,'http://10.6.30.177:7001/WSPagosPorEmbargo/webresources/embargo/ReversoCredito'
           ,'http://10.6.30.177:7001/WSPagosPorEmbargo/webresources/embargo/ReversoCredito');



select *from web_services
where id_web_services=142



begin tran
update web_services set
url_primaria='http://axisweb-val.datatools.local:7001/WSPagosPorEmbargo/webresources/embargo/ReversoCredito',
url_secundaria='http://axisweb-val.datatools.local:7001/WSPagosPorEmbargo/webresources/embargo/ReversoCredito'
where id_web_services=142
commit tran
