use circulemos2
DECLARE @numFinanciacion VARCHAR(50);
SET @numFinanciacion = '529935';--8594587
	
select * from circulemos2.dbo.trazabilidad_error_financiacion_incumplida
where numero_de_convenio = @numFinanciacion

select * from circulemos2.dbo.trazabilidad_financiacion_incumplida
where numero_de_convenio = @numFinanciacion
order by 1


select 'v_financiaciones_axis'  vista_axis ,* from openquery (SRVBDATM, 'SELECT   A.ID_CONVENIO NUMERO_FINANCIACION,
       A.FECHA_INICIO_DEUDA,
	   A.ID_TIPO_CONVENIO,
       B.ID_IDENTIFICACION,
       B.IDENTIFICACION,
       B.NOMBRES,
       B.APELLIDO1,
       B.APELLIDO2,
       B.NOMBRE_COMERCIAL,
       A.VALOR_A_PAGAR VALOR_TOTAL_FINANCIADO,
       NVL(A.SALDO_CAPITAL, 0) + NVL(A.SALDO_INTERES, 0) + NVL(A.SALDO_MORA, 0) +
       NVL(A.SALDO_IMPUESTO, 0) + NVL(A.SALDO_OTROS, 0) SALDO_FINANCIACION,
       NVL(A.VALOR_CAPITAL, 0) VALOR_CAPITAL,
       NVL(A.VALOR_INTERES, 0) VALOR_INTERES,
       NVL(A.SALDO_CAPITAL, 0) SALDO_CAPITAL,
       NVL(A.SALDO_INTERES, 0) SALDO_INTERES,
       A.NRO_CUOTAS,
       A.FECHA_EMISION FECHA_REGISTRO,
       A.ESTADO,
	   A.ID_MOTIVO_ANULACION,
	   A.OBSERVACION
  FROM CP_CONVENIOS A, CL_PERSONAS B
 WHERE B.ID_PERSONA = A.ID_PERSONA
   --and a.id_tipo_convenio != ''RPO''
   AND a.id_convenio = 529935') 

select  'cl_personas' VISTA_AXIS,* from openquery 
(SRVBDATM, ' select * from cl_personas where id_persona in (select id_persona
from cp_convenios where id_convenio = 529935) ')

select 'v_detalles_pagos' vista_axis,* from integracion_terceros.dbo.v_all_detalles_pagos where numero_documento=@numFinanciacion;


select 'v_detalles_pagos_reversados' vista_axis,* from integracion_terceros.dbo.v_all_detalles_pagos_reversados where numero_documento=@numFinanciacion;

select 'v_financiacion' vista_axis, NUMERO_FINANCIACION,
FECHA_INICIO_DEUDA,
FECHA_REGISTRO,
VALOR_TOTAL_FINANCIADO,
SALDO_FINANCIACION,
VALOR_CAPITAL,
VALOR_INTERES,
ESTADO,
USUARIO
 from integracion_terceros.dbo.v_all_financiaciones where numero_financiacion=@numFinanciacion;
select 'v_detalle_financiacion' vista_axis,
NUMERO_FINANCIACION,
NRO_CUOTA,
INICIO_CUOTA,
VENCIMIENTO_CUOTA	,
CAST( VALOR_CUOTA AS float) valor_cuota	,
CAST(RECARGO_CUOTA	AS float) RECARGO_CUOTA,
CAST(SALDO_CUOTA	AS float) SALDO_CUOTA,
CAST(SALDO_INTERES AS float) SALDO_INTERES	,
USUARIO	,
ESTADO_LECTURA	,
FECHA_REGISTRO
from integracion_terceros.dbo.v_all_cuotasfinanciacion where numero_financiacion=@numFinanciacion;
select 'it_recaudo' intermedia,* from integracion_terceros.dbo.it_recaudo where numero_obligacion=@numFinanciacion
and estado_lectura in (1,2,3,11)
order by numero_cuota;

select 'it_recaudo_rechazo*****' INTERMEDIA,  rr.numero_recaudo, trr.* from integracion_terceros.dbo.it_recaudo  r
join circulemos2.dbo.recaudo_rechazo rr on rr.numero_recaudo = r.numero_recaudo
join circulemos2.dbo.detalle_recaudo_rechazo drr on drr.id_recaudo_rechazo = rr.id_recaudo_rechazo
join circulemos2.dbo.tipo_rechazo_recaudo trr on trr.id_tipo_rechazo_recaudo = drr.id_tipo_rechazo_recaudo
where r.numero_recaudo  in ( select ir.numero_recaudo from integracion_terceros.dbo.it_recaudo ir where ir.numero_obligacion=@numFinanciacion)

select 'detalle_pago' sogit,* from circulemos2.dbo.detalle_pago where numero_obligacion=@numFinanciacion;

--3125903   Aquí
select 'error_conciliacion_pago' sogit,*  from circulemos2.dbo.detalle_pago_conci_error dpc
inner join circulemos2.dbo.error_conciliacion_pago ecp 
on dpc.id_error_conciliacion_pago = ecp.id_error_conciliacion_pago
where dpc.id_detalle_pago in (
select dp.id_detalle_pago from circulemos2.dbo.detalle_pago dp where numero_obligacion=@numFinanciacion)


select 'financiacion' sogit,* from financiacion where numero_financiacion=@numFinanciacion;

select 'persona' sogit, * from persona where id_persona in(
select id_deudor from financiacion where numero_financiacion=@numFinanciacion);
select 'detalle_financiacion' sogit,* from detalle_financiacion where id_financiacion = (select id_financiacion from financiacion where numero_financiacion=@numFinanciacion);

select 'saldo_cuota_financiacion' sogit ,* from saldo_cuota_financiacion where id_detalle_financiacion in (select  id_detalle_financiacion from detalle_financiacion where id_financiacion = (select id_financiacion from financiacion where numero_financiacion=@numFinanciacion));


select 'cartera' sogit,* from cartera where nombre=@numFinanciacion;

select 'trazabilidad_cartera' sogit ,* from trazabilidad_cartera where id_cartera in ( select id_cartera from cartera where nombre=@numFinanciacion);
select 'movimientos_cartera' sogit,* from movimientos_cartera where id_cartera=(select id_cartera from cartera where nombre=@numFinanciacion and codigo_tipo_obligacion = 6) order by 1 desc;
select 'saldos_cartera' sogit,* from saldo_cartera where id_cartera=(select id_cartera from cartera where nombre=@numFinanciacion and codigo_tipo_obligacion = 6) order by 1 desc;



use circulemos2;
select f. numero_financiacion, e.descripcion, p.id_estado_proceso, f.id_tipo_financiacion, p.fecha_inicio, p.fecha_fin,p.id_estado_proceso
 from financiacion f, proceso p , estado_proceso e
where p.id_proceso = f.id_proceso
and e.id_estado_proceso = p.id_estado_proceso
and numero_financiacion=@numFinanciacion

select 'acumulado_financiacion' sogit, id_financiacion	,
numero_financiacion	,
numero_obligacion	,
numero_cuota	,
cast( valor_capital as float )  valor_capital	,
cast( valor_intereses as float )  valor_intereses	,
cast( valor_total as float )  valor_total	,
cast( valor_obligacion as float )  valor_obligacion	,
cast( valor_pago_capital as float )  valor_pago_capital	,
cast( valor_recargos as float )  valor_recargos	,
cast( valor_pago_recargos as float )  valor_pago_recargos	,
cast( valor_intereses_cuota as float )  valor_intereses_cuota	,
cast( valor_pago_intereses as float )  valor_pago_intereses	,
cast( valor_pago_capital_total as float )  valor_pago_capital_total	,
cast( valor_participacion_data as float )  valor_participacion_data	,
cast( valor_pago_data as float )  valor_pago_data	,
descripcion	,
cast( valor_recargos_costas_procesales as float )  valor_recargos_costas_procesales	,
cast( valor_pago_costa_procesal as float )  valor_pago_costa_procesal	,
id_facturacion_contrato	,
cast( participacion_capital_atm as float )  participacion_capital_atm	,
cast( pago_capital_atm as float )  pago_capital_atm	
 from acumulado_financiaciones where numero_financiacion=@numFinanciacion ;

select 'obligacion_financiacion' sogit,* from obligacion_financiacion where id_financiacion in (
select id_financiacion from financiacion where numero_financiacion=@numFinanciacion);


declare
@id_factura varchar(50); 
    DECLARE  @c_facturas_axis AS CURSOR; 
	DECLARE @TSQL varchar(8000),@TSQL2 varchar(8000),  @TSQL3 varchar(8000),@TSQL4 varchar(8000);
DROP TABLE IF EXISTS #tmp_factura_axis
CREATE TABLE #tmp_factura_axis
(
 id_factura bigint,
 pagada varchar(1),
 anulada varchar(1),
 convenio varchar(1),
 legal varchar(1),
 reclamo varchar(1),
 capital_factura float,
 saldo_capital float, 
 saldo_interes float,
 saldo_multas float
)	

  SET @c_facturas_axis = CURSOR 
  FOR select numero_obligacion from obligacion_financiacion where id_financiacion in (
select id_financiacion from financiacion where numero_financiacion=@numFinanciacion);

    OPEN  @c_facturas_axis; 

    FETCH next FROM  @c_facturas_axis INTO @id_factura; 

WHILE @@FETCH_STATUS = 0 
BEGIN
SET @TSQL = ''
SET @TSQL = 'select id_factura, pagada, anulada ,convenio,legal,reclamo, capital_factura
,saldo_capital, saldo_interes, saldo_multas from fa_facturas where id_factura = '
SET @TSQL2 = 'SELECT * FROM OPENQUERY(SRVBDATMJG, ''' + @TSQL +  CAST(@id_factura AS VARCHAR(25)) + ''')';
-- Convenios liquidados por incumplimiento en AXIS

	insert into #tmp_factura_axis
		EXEC (@TSQL2)

FETCH next FROM  @c_facturas_axis INTO @id_factura; 
 
 END -- END WHILE     
			
   	CLOSE @c_facturas_axis;
	DEALLOCATE @c_facturas_axis;

select 'fa_factura' axis, * from #tmp_factura_axis


/*** Inicio de Consulta de Coactivo**/

DROP TABLE IF EXISTS #tmp_factura_axis_coa
CREATE TABLE #tmp_factura_axis_coa
(
 id_factura bigint,
 pagada varchar(1),
 anulada varchar(1),
 convenio varchar(1),
 legal varchar(1),
 reclamo varchar(1),
 capital_factura float,
 saldo_capital float, 
 saldo_interes float,
 saldo_multas float
)	


SET @TSQL = ''
SET @TSQL = 'select id_factura, pagada, anulada ,convenio,legal,reclamo, capital_factura
,saldo_capital, saldo_interes, saldo_multas from fa_facturas where id_factura in ( '
SET @TSQL = @TSQL +' select id_documento from cp_documentos_convenios where id_convenio =  '
SET @TSQL2 = 'SELECT * FROM OPENQUERY(SRVBDATMJG, ''' + @TSQL +  CAST(@numFinanciacion AS VARCHAR(25)) + ')'')';
-- Convenios liquidados por incumplimiento en AXIS
--select @TSQL2
	insert into #tmp_factura_axis_coa
		EXEC (@TSQL2)



select 'fa_factura Coactiva' axis, * from #tmp_factura_axis_coa

select 'cartera comparendo' sogit,* from cartera where nombre in (
select numero_obligacion from circulemos2.dbo.financiacion f join circulemos2.dbo.obligacion_financiacion ofi on f.id_financiacion = ofi.id_financiacion
                                                                  where f.numero_financiacion = @numFinanciacion) ;

select 'trazabilidad_cartera_comparendo' sogit ,* from trazabilidad_cartera where id_cartera in ( 
select id_cartera from cartera where nombre in (
select numero_obligacion from circulemos2.dbo.financiacion f join circulemos2.dbo.obligacion_financiacion ofi on f.id_financiacion = ofi.id_financiacion
                                                                  where f.numero_financiacion = @numFinanciacion) 
)
order by id_trazabilidad_cartera;

select 'comparendo' sogit,* from circulemos2.dbo.comparendo where id_factura_axis in (
select numero_obligacion from obligacion_financiacion where id_financiacion in (
select id_financiacion from financiacion where numero_financiacion=@numFinanciacion));

select 'trazabilidad_comparendo' sogit,*  from trazabilidad_comparendo where cicomparendo in (select cicomparendo from circulemos2.dbo.comparendo where id_factura_axis in (
select numero_obligacion from obligacion_financiacion where id_financiacion in (
select id_financiacion from financiacion where numero_financiacion=@numFinanciacion))) 
order by id_trazabilidad_comparendo

select 'trazabilidad_proceso' sogit,* from trazabilidad_proceso  where id_proceso in (
select id_proceso from financiacion where numero_financiacion=@numFinanciacion);

select 'coactivo_proceso' sogit,* from circulemos2.dbo.coactivo_proceso cp where cp.numero_obligacion in (
select ofi.numero_obligacion from obligacion_financiacion ofi where id_financiacion in (
select id_financiacion from financiacion where numero_financiacion=@numFinanciacion));

select 'estado_proceso' financiaciones,* from circulemos2.dbo.estado_proceso where id_tipo_proceso = 2

select 'estado_obligacion' obligacion,* from circulemos2.dbo.estado_obligacion

select 'actividad_Cartera',* from circulemos2.dbo.actividad_cartera

select 'actividad',*  from circulemos2.dbo.actividad