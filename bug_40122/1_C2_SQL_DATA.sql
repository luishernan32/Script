USE [circulemos2]
BEGIN TRANSACTION; 
  
BEGIN TRY

update configuracion_email
set cuerpo_email='<center><img style="margin-top: 5vh" src="https://gacetamultas.atm.gob.ec/imagenes/img/logoATM_Alcaldia.png"><br />      <div style="font-size: 12px;font-family: ''Times New Roman'', Times, serif;margin-top:2vh;color: #3DACE3"><b>EMPRESA              MUNICIPAL DE TR&Aacute;NSITO DE GUAYAQUIL</b></div><br /><br />  </center>  <div style="font-size: 19px;font-family: ''Times New Roman'', Times, serif; margin-left: 5vh;margin-right: 5vh;margin-top:5vh">      <center><b><u>NOTIFICACI&Oacute;N DE INCUMPLIMIENTO DE CONVENIO PAGO</u></b></center><br />      Lugar y Fecha: Guayaquil - ${fecha}316028<br />      A: ${nombreCompleto}<br />Doc. Identificación: ${cedula}<br />Convenio:      ${numeroConvenioPago}<br />No. trámite para pago de cuota en bancos: ${numeroTramite} <br />Correo: ${destinatario}            <div style="margin-top: 2vh">          </div>      <div style="margin-top: 2vh">          <P ALIGN="justify">Estimado ${nombreCompleto}, ${tipoDocumento} ${cedula}, ATM le informa que ha incumplido el convenio de pago celebrado el d&iacute;a ${fechaConvenio},               en su cuota # ${numeroCuota}, por un monto de $ ${montoPagar}, la cual debi&oacute; haberse efectuado su pago el d&iacute;a ${fechaPago}, con el No. Tramite ${numeroTramite}      </div>      <div style="margin-top: 3vh">          <P ALIGN="justify">De conformidad a lo estipulado en el convenio # ${numeroConvenioPago} y en virtud a lo enunciado en el Art. 278 del Código Orgánico             Administrativo numeral 2 inciso 4 ´Si la petici&oacute;n es admitida y la o el deudor infringe de cualquier modo los t&eacute;rminos, condiciones,               plazos o en general, las disposiciones de la administraci&oacute;n p&uacute;blica en relaci&oacute;n con la concesi&oacute;n de facilidades de pago,               el procedimiento de ejecuci&oacute;n coactiva continuar&aacute; desde la etapa en que se haya suspendido por efecto de la petici&oacute;n de                 facilidades de pago´.           </P>      </div>      <div style="margin-top: 3vh">          <P ALIGN="justify">Por lo expuesto se solicita el pago de la cuota vencida en un plazo m&aacute;ximo a 5 d&iacute;as contados desde la fecha de su notificaci&oacute;n,               caso contrario se tendr&aacute; por terminado el convenio realizado, d&aacute;ndose inicio al proceso coactivo o a la reanudaci&oacute;n de mismo seg&uacute;n sea el caso.          </P>      </div>   <div style="margin-top: 3vh">          <P ALIGN="justify">${infoCoactivo}                </P>      </div>   <div style="margin-top: 3vh">          <P ALIGN="justify">IMPORTANTE: Por favor no responda este correo ni escriba a esta direcci&oacute;n ya que no se encuentra habilitada para recibir mensajes.     Si requiere mayor informaci&oacute;n, puede comunicarse al tel&eacute;fono (04) 390-22-90, de lunes a viernes de 8:30 a 17:00.           </P>      </div>  </div>'
where codigo_tipo_email=48

END TRY  
BEGIN CATCH  
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;  
  
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO
