 select top 20 *from circulemos2.dbo.log_ejecucion_ws
 where convert(date,fecha_envio)=convert(date,GETDATE())
 order by 1 desc