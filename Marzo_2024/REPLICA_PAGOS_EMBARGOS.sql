use integracion_terceros
DECLARE
@id_factura_coactiva varchar(20),
@id_credito varchar(20),
@id_registro_pago_embargo bigint,
@id_pago_embargo_axis  bigint

DECLARE c_pagos_embargos CURSOR FOR
select 
id_factura_coactiva
, id_credito
from v_pagos_embargos_pre
where CONVERT(date, fecha_pago)>=CONVERT(date, '2023-12-01')
and id_credito = 1617607
order by fecha_pago desc;

open c_pagos_embargos
fetch next from c_pagos_embargos into @id_factura_coactiva, @id_credito


WHILE @@FETCH_STATUS = 0
begin
BEGIN TRY 
BEGIN TRANSACTION;


--1 insert registro_pago_embargo (....) values (...)
set @id_registro_pago_embargo = SCOPE_IDENTITY(); 

-- 2 insert pago_embargo_axis ( ... id_registro_pago_embargo ) values (.... @id_registro_pago_embargo)
set @id_pago_embargo_axis =SCOPE_IDENTITY(); 

-- 3 insert pago_embargo_axis_obligacion ( ... id_pago_embargo_axis) values ( ....  @id_pago_embargo_axis)

-- 4 insert it_Recaudo


COMMIT TRANSACTION
END TRY  
BEGIN CATCH  
    SELECT   'Error en factura coactiva '+ @id_factura_coactiva,
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;  
fetch next
from c1 into @idConvenio;
end--end while


close c1
deallocate c1



select * from integracion_terceros.dbo.it_multa where id_factura_axis = 13952307