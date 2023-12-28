SELECT top 500 -- se modifica para no tener overlaping en generaciones INC 18 nov 20222
        --'hernan.cortes@datatools.com.co' EMAIL,
        c.correo_electronico,
        a.archivo_path [path],
        m.multa,m.numero_documento,
        + (select valor from [dbo].[config_parametros] where variable='prefijo')
        + cast(FORMAT( CURRENT_TIMESTAMP, 'yyMMddhhmmss', 'en-US' ) as varchar(14))
        + rtrim(m.multa)
        + rtrim(cast(ROW_NUMBER() over (order by m.multa,c.correo_electronico) as varchar(20))) external_id
        ,cp.numero_citacion

 

 

--into #email_noti
FROM [dbo].[multa_estado_notificacion] m
    inner join circulemos2..persona p on m.numero_documento = p.numero_identificacion
    inner join circulemos2..correo_persona c on c.id_persona = p.id_persona
    inner join circulemos2..comparendo cp on cp.id_factura_axis = m.multa
    inner join (select t.* from 
            (select ag.id_archivo,ag.numero_factura, ag.fecha_creacion, ag.archivo_path, ROW_NUMBER() over (PARTITION BY ag.numero_factura, ag.archivo_path order by ag.id_archivo desc) linea
            from archivo_generado ag ) t
            where t.linea = 1
        ) a on a.numero_factura = m.multa
--        circulemos2..comparendo cp --adicion mfrc & mauricio julio 27 2021
  inner join integracion_terceros.dbo.v_all_infracciones vai on vai.NUMERO_FACTURA = cp.id_factura_axis
WHERE  m.estado_ultima_notificacion in (-1)
        and
        c.id_persona=p.id_persona
        and m.numero_documento = p.numero_identificacion
        and c.correo_electronico like '%@%'
        and m.multa = a.numero_factura
        and c.estado in (1)
--        and cp.fecha_notificacion IS NULL -- adicion MFRC & mauricio julio 27 2021
        --and m.multa not in (select multa from multa_circuitos where idcircuito = 'Correo en lista negra' and estado = -1)
        --and m.multa not in (select multa from multa_circuitos where observacion = 'Error al ejecutar el web services, validar el formato rest' and estado = -1)
       -- and not exists 
                    --(select numero_factura from [dbo].[config_control_job_enviar] ct
                    --where m.multa = ct.numero_factura)
        and m.multa in (12657021) 
        --NOT 11888384 11918259 11921951 11922536
        --NO NOT 11893685
        and len(vai.NUMERO_CITACION)>0
        and cp.id_estado_comparendo in (1,2)
        and vai.ESTADO_CITACION = 'PENDIENTE'
order by multa asc



--select *from multa_estado_notificacion
--where multa=12657021

--begin tran
--update multa_estado_notificacion
--set estado_ultima_notificacion=-1
--where multa=12657021
--commit tran


--select *from circulemos2..comparendo
--where id_factura_axis=12657021

--begin tran
--update circulemos2..comparendo
--set id_estado_comparendo=2
--where id_factura_axis=12657021
--commit tran


--select *from integracion_terceros.dbo.v_all_infracciones vai
--where vai.NUMERO_FACTURA = 12657021

--begin tran
--update integracion_terceros.dbo.v_all_infracciones 
--set ESTADO_CITACION='PENDIENTE'
--where NUMERO_FACTURA = 12657021

--commit tran