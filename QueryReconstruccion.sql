/*select rp.*
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio=rp.numero_juicio
and rs.numero_juicio=rp.No_Oficio
where rs.procesado=1
and convert(date,rs.fecha_procesamiento)>=convert(date,'2024-08-01')
and rp.LOTE='Lote21_Retencion_Actualizacion_Medida'
and rs.documento_1='864800-5414-2017-1.pdf'*/

------------------------------------------------
--PDF_1
declare @lote varchar(100)
set @lote='Lote21_Retencion_Actualizacion_Medida'
select rp.*,rs.book, rs.id_consecutivo_reconstruccion
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio=rp.numero_juicio
and rs.numero_oficio=rp.no_Oficio
where rs.procesado=1
and convert(date,rs.fecha_procesamiento)>=convert(date,'2024-08-01')
and rp.LOTE='Lote21_Retencion_Actualizacion_Medida'
and rs.documento_1 in('864800-5414-2017-1.pdf',
'864800-58474-2017-1.pdf',
'864800-61930-2017-1.pdf',
'864562-407654-2022-1.pdf',
'864454-23443-2023-1.pdf',
'864454-23728-2023-1.pdf',
'864454-23764-2023-1.pdf',
'864454-24255-2023-1.pdf',
'864454-250-2023-1.pdf',
'864454-2532-2023-1.pdf',
'864454-25533-2023-1.pdf',
'864454-25571-2023-1.pdf',
'864454-25643-2023-1.pdf',
'864454-25655-2023-1.pdf',
'864454-25988-2023-1.pdf',
'864454-26002-2023-1.pdf',
'864448-19525-2023-1.pdf',
'864448-19565-2023-1.pdf',
'864448-19571-2023-1.pdf',
'864448-2027-2023-1.pdf',
'864448-2111-2023-1.pdf',
'864448-21421-2023-1.pdf',
'864448-21529-2023-1.pdf',
'864448-23060-2023-1.pdf',
'864448-23150-2023-1.pdf',
'864448-23227-2023-1.pdf',
'864600-422666-2022-1.pdf',
'864625-99960-2023-1.pdf',
'864626-103961-2019-1.pdf',
'864632-9653-2016-1.pdf',
'864456-100905-2023-1.pdf',
'864456-101577-2023-1.pdf',
'864632-46119-2016-1.pdf',
'864549-3998-2022-1.pdf',
'864452-14639-2017-1.pdf',
'864452-14706-2017-1.pdf',
'864452-14779-2017-1.pdf',
'864452-15049-2017-1.pdf',
'864452-15422-2017-1.pdf',
'864452-154757-2017-1.pdf',
'864452-15628-2017-1.pdf',
'864452-157693-2017-1.pdf',
'864450-310459-2022-1.pdf',
'864450-31076-2022-1.pdf',
'864450-311464-2022-1.pdf',
'864450-311947-2022-1.pdf',
'864450-312682-2022-1.pdf',
'864450-314810-2022-1.pdf',
'864450-315054-2022-1.pdf',
'864450-315197-2022-1.pdf',
'864450-315375-2022-1.pdf',
'864450-316335-2022-1.pdf',
'864454-245-2023-1.pdf',
'864454-23752-2023-1.pdf',
'864454-24079-2023-1.pdf',
'864454-24213-2023-1.pdf',
'864454-24333-2023-1.pdf',
'864454-2531-2023-1.pdf',
'864448-1958-2023-1.pdf',
'864448-1969-2023-1.pdf',
'864448-19817-2023-1.pdf',
'864448-2074-2023-1.pdf',
'864448-2098-2023-1.pdf',
'864448-21257-2023-1.pdf',
'864448-21448-2023-1.pdf',
'864448-2241-2023-1.pdf',
'864448-22725-2023-1.pdf',
'864448-22988-2023-1.pdf',
'864448-22996-2023-1.pdf',
'864448-23201-2023-1.pdf',
'864448-23305-2023-1.pdf',
'864452-18933-2017-1.pdf',
'864600-43204-2022-1.pdf',
'864574-411207-2022-1.pdf',
'864576-186019-2022-1.pdf',
'864452-15123-2017-1.pdf',
'864452-1519-2017-1.pdf',
'864452-15517-2017-1.pdf',
'864452-165286-2017-1.pdf',
'864452-174526-2017-1.pdf',
'864552-132547-2023-1.pdf',
'864580-13912-2023-1.pdf',
'864556-401950-2022-1.pdf',
'864557-176706-2022-1.pdf',
'864452-158808-2017-1.pdf',
'864452-16421-2017-1.pdf',
'864452-165230-2017-1.pdf',
'864452-16787-2017-1.pdf',
'864452-168052-2017-1.pdf',
'864452-17083-2017-1.pdf',
'864452-175336-2017-1.pdf',
'864452-18170-2017-1.pdf',
'864452-18214-2017-1.pdf',
'864452-18382-2017-1.pdf',
'864452-184105-2017-1.pdf',
'864579-418252-2022-1.pdf',
'864579-418739-2022-1.pdf',
'864455-316856-2022-1.pdf',
'864723-174935-2019-1.pdf',
'864640-182962-2018-1.pdf',
'864733-175679-2019-1.pdf',
'864710-30406-2023-1.pdf',
'864736-40599-2023-1.pdf',
'864736-41547-2023-1.pdf',
'864800-4786-2017-1.pdf',
'864800-483-2017-1.pdf',
'864800-4998-2017-1.pdf',
'864800-5381-2017-1.pdf',
'864800-53875-2017-1.pdf',
'864800-5705-2017-1.pdf',
'864800-60718-2017-1.pdf',
'864800-63524-2017-1.pdf',
'864468-194986-2019-1.pdf',
'864468-195031-2019-1.pdf',
'864468-195170-2019-1.pdf',
'864468-195189-2019-1.pdf',
'864744-226699-2022-1.pdf',
'864775-13457-2022-1.pdf',
'864468-195409-2019-1.pdf',
'864468-195465-2019-1.pdf',
'864468-195527-2019-1.pdf',
'864468-195709-2019-1.pdf',
'864468-195990-2019-1.pdf',
'864468-196078-2019-1.pdf',
'864468-196104-2019-1.pdf',
'864468-196203-2019-1.pdf',
'864468-196333-2019-1.pdf',
'864483-4969-2023-1.pdf',
'864450-310102-2022-1.pdf',
'864450-310349-2022-1.pdf',
'864450-311265-2022-1.pdf',
'864450-311306-2022-1.pdf',
'864450-311540-2022-1.pdf',
'864450-312805-2022-1.pdf',
'864450-313046-2022-1.pdf',
'864450-313103-2022-1.pdf',
'864450-313142-2022-1.pdf',
'864450-314933-2022-1.pdf',
'864450-315306-2022-1.pdf',
'864450-315451-2022-1.pdf',
'864450-31566-2022-1.pdf',
'864561-80306-2023-1.pdf',
'864454-23705-2023-1.pdf',
'864454-23720-2023-1.pdf',
'864454-25535-2023-1.pdf',
'864454-25569-2023-1.pdf',
'864454-25625-2023-1.pdf',
'864454-25920-2023-1.pdf',
'864454-25973-2023-1.pdf',
'864448-19676-2023-1.pdf',
'864448-19713-2023-1.pdf',
'864448-20063-2023-1.pdf',
'864448-20170-2023-1.pdf',
'864448-21348-2023-1.pdf',
'864450-3102-2022-1.pdf',
'864450-31064-2022-1.pdf',
'864450-311316-2022-1.pdf',
'864450-311480-2022-1.pdf',
'864450-313078-2022-1.pdf',
'864450-313131-2022-1.pdf',
'864450-315019-2022-1.pdf',
'864454-23954-2023-1.pdf',
'864454-24185-2023-1.pdf',
'864454-25315-2023-1.pdf',
'864454-25461-2023-1.pdf',
'864483-4990-2023-1.pdf',
'864485-337611-2022-1.pdf',
'864490-154860-2023-1.pdf',
'864490-16357-2023-1.pdf',
'864785-194480-2019-1.pdf',
'864529-360398-2022-1.pdf',
'864806-98906-2017-1.pdf',
'864785-194687-2019-1.pdf',
'864496-19370-2023-1.pdf',
'864477-200221-2019-1.pdf',
'864452-16539-2017-1.pdf',
'864448-22851-2023-1.pdf',
'864448-23040-2023-1.pdf',
'864448-23343-2023-1.pdf',
'864575-137734-2023-1.pdf',
'864632-48436-2016-1.pdf',
'864452-1506-2017-1.pdf',
'864452-18178-2017-1.pdf',
'864461-27870-2023-1.pdf',
'864800-49840-2017-1.pdf',
'864800-49934-2017-1.pdf',
'864800-5257-2017-1.pdf',
'864468-195296-2019-1.pdf',
'864468-195370-2019-1.pdf',
'864468-196113-2019-1.pdf',
'864468-196237-2019-1.pdf',
'864468-196246-2019-1.pdf',
'864800-59601-2017-1.pdf',
'864800-60476-2017-1.pdf',
'864800-62114-2017-1.pdf',
'864800-62258-2017-1.pdf',
'864800-6430-2017-1.pdf',
'864468-196236-2019-1.pdf',
'864801-269707-2022-1.pdf',
'864806-96919-2017-1.pdf',
'864806-97690-2017-1.pdf',
'864490-15861-2023-1.pdf',
'864495-11975-2023-1.pdf',
'864496-17320-2023-1.pdf',
'864508-58599-2023-1.pdf',
'864788-103525-2018-1.pdf',
'864528-6719-2023-1.pdf',
'864529-359837-2022-1.pdf',
'864452-188107-2017-1.pdf',
'864452-156621-2017-1.pdf',
'864452-17571-2017-1.pdf',
'864452-1797-2017-1.pdf',
'864452-18719-2017-1.pdf',
'864723-174963-2019-1.pdf',
'864724-35832-2023-1.pdf',
'864800-59563-2017-1.pdf',
'864468-195120-2019-1.pdf',
'864468-195132-2019-1.pdf',
'864468-195710-2019-1.pdf',
'864468-195892-2019-1.pdf',
'864724-38022-2023-1.pdf',
'864733-176703-2019-1.pdf',
'864465-150418-2023-1.pdf',
'864740-179480-2019-1.pdf',
'864800-48176-2017-1.pdf',
'864800-48685-2017-1.pdf',
'864800-5002-2017-1.pdf',
'864450-310048-2022-1.pdf',
'864450-310225-2022-1.pdf',
'864450-31032-2022-1.pdf',
'864450-311219-2022-1.pdf',
'864450-312867-2022-1.pdf',
'864450-313008-2022-1.pdf',
'864450-314822-2022-1.pdf',
'864450-315082-2022-1.pdf',
'864563-181163-2022-1.pdf',
'864454-2335-2023-1.pdf',
'864454-23962-2023-1.pdf',
'864454-25207-2023-1.pdf',
'864454-25511-2023-1.pdf',
'864454-25822-2023-1.pdf',
'864454-25842-2023-1.pdf',
'864454-2586-2023-1.pdf',
'864448-20125-2023-1.pdf',
'864448-21237-2023-1.pdf',
'864448-21593-2023-1.pdf',
'864448-23014-2023-1.pdf',
'864575-13815-2023-1.pdf',
'864456-10121-2023-1.pdf',
'864452-15212-2017-1.pdf',
'864452-179958-2017-1.pdf',
'864578-8622-2023-1.pdf',
'864551-175370-2022-1.pdf',
'864581-191592-2022-1.pdf',
'864616-283396-2019-1.pdf',
'864556-403100-2022-1.pdf',
'864461-28189-2023-1.pdf',
'864457-147906-2023-1.pdf',
'864749-231139-2022-1.pdf',
'864735-142186-2021-1.pdf',
'864465-150242-2023-1.pdf',
'864794-261553-2022-1.pdf',
'864800-49017-2017-1.pdf',
'864468-195936-2019-1.pdf',
'864468-195980-2019-1.pdf',
'864468-196151-2019-1.pdf',
'864468-196179-2019-1.pdf',
'864801-269762-2022-1.pdf',
'864777-91638-2022-1.pdf',
'864632-49236-2016-1.pdf',
'864452-155515-2017-1.pdf',
'864452-16871-2017-1.pdf',
'864452-17908-2017-1.pdf',
'864452-184531-2017-1.pdf',
'864579-417582-2022-1.pdf',
'864718-34969-2023-1.pdf',
'864558-134736-2023-1.pdf',
'864710-30461-2023-1.pdf',
'864733-177408-2019-1.pdf',
'864718-32430-2023-1.pdf',
'864792-133311-2018-1.pdf',
'864738-223046-2022-1.pdf',
'864800-4847-2017-1.pdf',
'864800-4987-2017-1.pdf',
'864800-5067-2017-1.pdf',
'864800-51-2017-1.pdf',
'864800-5133-2017-1.pdf',
'864800-65105-2017-1.pdf',
'864800-6554-2017-1.pdf',
'864468-194924-2019-1.pdf',
'864468-194941-2019-1.pdf',
'864468-195047-2019-1.pdf',
'864468-195048-2019-1.pdf',
'864468-195290-2019-1.pdf',
'864468-195542-2019-1.pdf',
'864468-195630-2019-1.pdf',
'864468-195915-2019-1.pdf',
'864800-5143-2017-1.pdf',
'864800-5192-2017-1.pdf',
'864800-52535-2017-1.pdf',
'864800-5276-2017-1.pdf',
'864800-53062-2017-1.pdf',
'864800-57197-2017-1.pdf',
'864800-5773-2017-1.pdf',
'864755-232447-2022-1.pdf'
)




--PDF_2
declare @lote varchar(100)
set @lote='Lote21_Retencion_Actualizacion_Medida'
select rp.*,rs.book, rs.id_consecutivo_reconstruccion
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio=rp.numero_juicio
and rs.numero_oficio=rp.no_Oficio
where rs.procesado=1
and convert(date,rs.fecha_procesamiento)>=convert(date,'2024-08-01')
and rp.LOTE='Lote21_Retencion_Actualizacion_Medida'
and rs.documento_2 in(
'864562-407654-2022-2.pdf',
'864454-23443-2023-2.pdf',
'864454-23728-2023-2.pdf',
'864454-23764-2023-2.pdf',
'864454-24255-2023-2.pdf',
'864454-250-2023-2.pdf',
'864454-2532-2023-2.pdf',
'864454-25533-2023-2.pdf',
'864454-25571-2023-2.pdf',
'864454-25643-2023-2.pdf',
'864454-25655-2023-2.pdf',
'864454-25988-2023-2.pdf',
'864454-26002-2023-2.pdf',
'864448-19525-2023-2.pdf',
'864448-19565-2023-2.pdf',
'864448-19571-2023-2.pdf',
'864448-2027-2023-2.pdf',
'864448-2111-2023-2.pdf',
'864448-21421-2023-2.pdf',
'864448-21529-2023-2.pdf',
'864448-23060-2023-2.pdf',
'864448-23150-2023-2.pdf',
'864448-23227-2023-2.pdf',
'864600-422666-2022-2.pdf',
'864625-99960-2023-2.pdf',
'864626-103961-2019-2.pdf',
'864632-9653-2016-2.pdf',
'864456-100905-2023-2.pdf',
'864456-101577-2023-2.pdf',
'864632-46119-2016-2.pdf',
'864549-3998-2022-2.pdf',
'864452-14639-2017-2.pdf',
'864452-14706-2017-2.pdf',
'864452-14779-2017-2.pdf',
'864452-15049-2017-2.pdf',
'864452-15422-2017-2.pdf',
'864452-154757-2017-2.pdf',
'864452-15628-2017-2.pdf',
'864452-157693-2017-2.pdf',
'864452-158808-2017-2.pdf',
'864452-16421-2017-2.pdf',
'864452-165230-2017-2.pdf',
'864452-16787-2017-2.pdf',
'864452-168052-2017-2.pdf',
'864452-17083-2017-2.pdf',
'864452-175336-2017-2.pdf',
'864452-18170-2017-2.pdf',
'864452-18214-2017-2.pdf',
'864452-18382-2017-2.pdf',
'864452-184105-2017-2.pdf',
'864579-418252-2022-2.pdf',
'864579-418739-2022-2.pdf',
'864455-316856-2022-2.pdf',
'864723-174935-2019-2.pdf',
'864640-182962-2018-2.pdf',
'864733-175679-2019-2.pdf',
'864710-30406-2023-2.pdf',
'864736-40599-2023-2.pdf',
'864736-41547-2023-2.pdf',
'864800-4786-2017-2.pdf',
'864800-483-2017-2.pdf',
'864800-4998-2017-2.pdf',
'864800-5381-2017-2.pdf',
'864800-53875-2017-2.pdf',
'864800-5705-2017-2.pdf',
'864800-60718-2017-2.pdf',
'864800-63524-2017-2.pdf',
'864468-194986-2019-2.pdf',
'864468-195031-2019-2.pdf',
'864468-195170-2019-2.pdf',
'864468-195189-2019-2.pdf',
'864744-226699-2022-2.pdf',
'864775-13457-2022-2.pdf',
'864468-195409-2019-2.pdf',
'864468-195465-2019-2.pdf',
'864468-195527-2019-2.pdf',
'864468-195709-2019-2.pdf',
'864468-195990-2019-2.pdf',
'864468-196078-2019-2.pdf',
'864468-196104-2019-2.pdf',
'864468-196203-2019-2.pdf',
'864468-196333-2019-2.pdf',
'864483-4969-2023-2.pdf',
'864450-3102-2022-2.pdf',
'864450-31064-2022-2.pdf',
'864450-311316-2022-2.pdf',
'864450-311480-2022-2.pdf',
'864450-313078-2022-2.pdf',
'864450-313131-2022-2.pdf',
'864450-315019-2022-2.pdf',
'864800-5414-2017-2.pdf',
'864800-58474-2017-2.pdf',
'864800-61930-2017-2.pdf',
'864450-310102-2022-2.pdf',
'864450-310349-2022-2.pdf',
'864450-311265-2022-2.pdf',
'864450-311306-2022-2.pdf',
'864450-311540-2022-2.pdf',
'864450-312805-2022-2.pdf',
'864450-313046-2022-2.pdf',
'864450-313103-2022-2.pdf',
'864450-313142-2022-2.pdf',
'864450-314933-2022-2.pdf',
'864450-315306-2022-2.pdf',
'864450-315451-2022-2.pdf',
'864450-31566-2022-2.pdf',
'864561-80306-2023-2.pdf',
'864454-23705-2023-2.pdf',
'864454-23720-2023-2.pdf',
'864454-25535-2023-2.pdf',
'864454-25569-2023-2.pdf',
'864454-25625-2023-2.pdf',
'864454-25920-2023-2.pdf',
'864454-25973-2023-2.pdf',
'864448-19676-2023-2.pdf',
'864448-19713-2023-2.pdf',
'864448-20063-2023-2.pdf',
'864448-20170-2023-2.pdf',
'864448-21348-2023-2.pdf',
'864454-23954-2023-2.pdf',
'864454-24185-2023-2.pdf',
'864454-25315-2023-2.pdf',
'864454-25461-2023-2.pdf',
'864483-4990-2023-2.pdf',
'864485-337611-2022-2.pdf',
'864490-154860-2023-2.pdf',
'864490-16357-2023-2.pdf',
'864785-194480-2019-2.pdf',
'864529-360398-2022-2.pdf',
'864806-98906-2017-2.pdf',
'864785-194687-2019-2.pdf',
'864496-19370-2023-2.pdf',
'864477-200221-2019-2.pdf',
'864452-16539-2017-2.pdf',
'864448-22851-2023-2.pdf',
'864448-23040-2023-2.pdf',
'864448-23343-2023-2.pdf',
'864575-137734-2023-2.pdf',
'864632-48436-2016-2.pdf',
'864452-1506-2017-2.pdf',
'864452-18178-2017-2.pdf',
'864461-27870-2023-2.pdf',
'864800-49840-2017-2.pdf',
'864800-49934-2017-2.pdf',
'864800-5257-2017-2.pdf',
'864468-195296-2019-2.pdf',
'864468-195370-2019-2.pdf',
'864468-196113-2019-2.pdf',
'864468-196237-2019-2.pdf',
'864468-196246-2019-2.pdf',
'864724-35832-2023-2.pdf',
'864800-59563-2017-2.pdf',
'864632-49236-2016-2.pdf',
'864452-155515-2017-2.pdf',
'864452-16871-2017-2.pdf',
'864452-17908-2017-2.pdf',
'864452-184531-2017-2.pdf',
'864579-417582-2022-2.pdf',
'864718-34969-2023-2.pdf',
'864558-134736-2023-2.pdf',
'864710-30461-2023-2.pdf',
'864733-177408-2019-2.pdf',
'864718-32430-2023-2.pdf',
'864792-133311-2018-2.pdf',
'864738-223046-2022-2.pdf',
'864800-4847-2017-2.pdf',
'864800-4987-2017-2.pdf',
'864800-5067-2017-2.pdf',
'864800-51-2017-2.pdf',
'864800-5133-2017-2.pdf',
'864800-65105-2017-2.pdf',
'864800-6554-2017-2.pdf',
'864468-194924-2019-2.pdf',
'864468-194941-2019-2.pdf',
'864468-195047-2019-2.pdf',
'864468-195048-2019-2.pdf',
'864468-195290-2019-2.pdf',
'864468-195542-2019-2.pdf',
'864468-195630-2019-2.pdf',
'864468-195915-2019-2.pdf',
'864800-5143-2017-2.pdf',
'864800-5192-2017-2.pdf',
'864800-52535-2017-2.pdf',
'864800-5276-2017-2.pdf',
'864800-53062-2017-2.pdf',
'864800-57197-2017-2.pdf',
'864800-5773-2017-2.pdf',
'864755-232447-2022-2.pdf',
'864800-59601-2017-2.pdf',
'864800-60476-2017-2.pdf',
'864800-62114-2017-2.pdf',
'864800-62258-2017-2.pdf',
'864800-6430-2017-2.pdf',
'864468-196236-2019-2.pdf',
'864801-269707-2022-2.pdf',
'864806-96919-2017-2.pdf',
'864806-97690-2017-2.pdf',
'864490-15861-2023-2.pdf',
'864495-11975-2023-2.pdf',
'864496-17320-2023-2.pdf',
'864508-58599-2023-2.pdf',
'864788-103525-2018-2.pdf',
'864528-6719-2023-2.pdf',
'864529-359837-2022-2.pdf',
'864468-195936-2019-2.pdf',
'864468-195980-2019-2.pdf',
'864468-196151-2019-2.pdf',
'864468-196179-2019-2.pdf',
'864801-269762-2022-2.pdf',
'864777-91638-2022-2.pdf',
'864452-188107-2017-2.pdf',
'864452-156621-2017-2.pdf',
'864452-17571-2017-2.pdf',
'864452-1797-2017-2.pdf',
'864452-18719-2017-2.pdf',
'864723-174963-2019-2.pdf',
'864468-195120-2019-2.pdf',
'864468-195132-2019-2.pdf',
'864468-195710-2019-2.pdf',
'864468-195892-2019-2.pdf',
'864450-310459-2022-2.pdf',
'864450-31076-2022-2.pdf',
'864450-311464-2022-2.pdf',
'864450-311947-2022-2.pdf',
'864450-312682-2022-2.pdf',
'864450-314810-2022-2.pdf',
'864450-315054-2022-2.pdf',
'864450-315197-2022-2.pdf',
'864450-315375-2022-2.pdf',
'864450-316335-2022-2.pdf',
'864454-245-2023-2.pdf',
'864454-23752-2023-2.pdf',
'864454-24079-2023-2.pdf',
'864454-24213-2023-2.pdf',
'864454-24333-2023-2.pdf',
'864454-2531-2023-2.pdf',
'864448-1958-2023-2.pdf',
'864448-1969-2023-2.pdf',
'864448-19817-2023-2.pdf',
'864448-2074-2023-2.pdf',
'864448-2098-2023-2.pdf',
'864448-21257-2023-2.pdf',
'864448-21448-2023-2.pdf',
'864448-2241-2023-2.pdf',
'864448-22725-2023-2.pdf',
'864448-22988-2023-2.pdf',
'864448-22996-2023-2.pdf',
'864448-23201-2023-2.pdf',
'864448-23305-2023-2.pdf',
'864452-18933-2017-2.pdf',
'864600-43204-2022-2.pdf',
'864574-411207-2022-2.pdf',
'864576-186019-2022-2.pdf',
'864452-15123-2017-2.pdf',
'864452-1519-2017-2.pdf',
'864452-15517-2017-2.pdf',
'864452-165286-2017-2.pdf',
'864452-174526-2017-2.pdf',
'864552-132547-2023-2.pdf',
'864580-13912-2023-2.pdf',
'864556-401950-2022-2.pdf',
'864557-176706-2022-2.pdf',
'864724-38022-2023-2.pdf',
'864733-176703-2019-2.pdf',
'864465-150418-2023-2.pdf',
'864740-179480-2019-2.pdf',
'864800-48176-2017-2.pdf',
'864800-48685-2017-2.pdf',
'864800-5002-2017-2.pdf',
'864450-310048-2022-2.pdf',
'864450-310225-2022-2.pdf',
'864450-31032-2022-2.pdf',
'864450-311219-2022-2.pdf',
'864450-312867-2022-2.pdf',
'864450-313008-2022-2.pdf',
'864450-314822-2022-2.pdf',
'864450-315082-2022-2.pdf',
'864563-181163-2022-2.pdf',
'864454-2335-2023-2.pdf',
'864454-23962-2023-2.pdf',
'864454-25207-2023-2.pdf',
'864454-25511-2023-2.pdf',
'864454-25822-2023-2.pdf',
'864454-25842-2023-2.pdf',
'864454-2586-2023-2.pdf',
'864448-20125-2023-2.pdf',
'864448-21237-2023-2.pdf',
'864448-21593-2023-2.pdf',
'864448-23014-2023-2.pdf',
'864575-13815-2023-2.pdf',
'864456-10121-2023-2.pdf',
'864452-15212-2017-2.pdf',
'864452-179958-2017-2.pdf',
'864578-8622-2023-2.pdf',
'864551-175370-2022-2.pdf',
'864581-191592-2022-2.pdf',
'864616-283396-2019-2.pdf',
'864556-403100-2022-2.pdf',
'864461-28189-2023-2.pdf',
'864457-147906-2023-2.pdf',
'864749-231139-2022-2.pdf',
'864735-142186-2021-2.pdf',
'864465-150242-2023-2.pdf',
'864794-261553-2022-2.pdf',
'864800-49017-2017-2.pdf')


--PDF_3
declare @lote varchar(100)
set @lote='Lote21_Retencion_Actualizacion_Medida'
select rp.*,rs.book, rs.id_consecutivo_reconstruccion
from circulemos2.dbo.reconstruccion_solicitud_busqueda_bienes rs
inner join integracion_terceros.dbo.reconstr_sol_bienes_pre rp on rs.numero_juicio=rp.numero_juicio
and rs.numero_oficio=rp.no_Oficio
where rs.procesado=1
and convert(date,rs.fecha_procesamiento)>=convert(date,'2024-08-01')
and rp.LOTE='Lote21_Retencion_Actualizacion_Medida'
and rs.documento_3 in(
'864454-23954-2023-3.pdf',
'864454-24185-2023-3.pdf',
'864454-25315-2023-3.pdf',
'864454-25461-2023-3.pdf',
'864483-4990-2023-3.pdf',
'864485-337611-2022-3.pdf',
'864490-154860-2023-3.pdf',
'864490-16357-2023-3.pdf',
'864785-194480-2019-3.pdf',
'864529-360398-2022-3.pdf',
'864806-98906-2017-3.pdf',
'864785-194687-2019-3.pdf',
'864496-19370-2023-3.pdf',
'864477-200221-2019-3.pdf',
'864452-16539-2017-3.pdf',
'864800-5414-2017-3.pdf',
'864800-58474-2017-3.pdf',
'864800-61930-2017-3.pdf',
'864450-3102-2022-3.pdf',
'864450-31064-2022-3.pdf',
'864450-311316-2022-3.pdf',
'864450-311480-2022-3.pdf',
'864450-313078-2022-3.pdf',
'864450-313131-2022-3.pdf',
'864450-315019-2022-3.pdf',
'864562-407654-2022-3.pdf',
'864454-23443-2023-3.pdf',
'864454-23728-2023-3.pdf',
'864454-23764-2023-3.pdf',
'864454-24255-2023-3.pdf',
'864454-250-2023-3.pdf',
'864454-2532-2023-3.pdf',
'864454-25533-2023-3.pdf',
'864454-25571-2023-3.pdf',
'864454-25643-2023-3.pdf',
'864454-25655-2023-3.pdf',
'864454-25988-2023-3.pdf',
'864454-26002-2023-3.pdf',
'864448-19525-2023-3.pdf',
'864448-19565-2023-3.pdf',
'864448-19571-2023-3.pdf',
'864448-2027-2023-3.pdf',
'864448-2111-2023-3.pdf',
'864448-21421-2023-3.pdf',
'864448-21529-2023-3.pdf',
'864448-23060-2023-3.pdf',
'864448-23150-2023-3.pdf',
'864448-23227-2023-3.pdf',
'864600-422666-2022-3.pdf',
'864625-99960-2023-3.pdf',
'864626-103961-2019-3.pdf',
'864632-9653-2016-3.pdf',
'864456-100905-2023-3.pdf',
'864456-101577-2023-3.pdf',
'864632-46119-2016-3.pdf',
'864549-3998-2022-3.pdf',
'864452-14639-2017-3.pdf',
'864452-14706-2017-3.pdf',
'864452-14779-2017-3.pdf',
'864452-15049-2017-3.pdf',
'864452-15422-2017-3.pdf',
'864452-154757-2017-3.pdf',
'864452-15628-2017-3.pdf',
'864452-157693-2017-3.pdf',
'864452-158808-2017-3.pdf',
'864452-16421-2017-3.pdf',
'864452-165230-2017-3.pdf',
'864452-16787-2017-3.pdf',
'864452-168052-2017-3.pdf',
'864452-17083-2017-3.pdf',
'864452-175336-2017-3.pdf',
'864452-18170-2017-3.pdf',
'864452-18214-2017-3.pdf',
'864452-18382-2017-3.pdf',
'864452-184105-2017-3.pdf',
'864579-418252-2022-3.pdf',
'864579-418739-2022-3.pdf',
'864455-316856-2022-3.pdf',
'864723-174935-2019-3.pdf',
'864640-182962-2018-3.pdf',
'864452-188107-2017-3.pdf',
'864452-156621-2017-3.pdf',
'864452-17571-2017-3.pdf',
'864452-1797-2017-3.pdf',
'864452-18719-2017-3.pdf',
'864723-174963-2019-3.pdf',
'864724-35832-2023-3.pdf',
'864800-59563-2017-3.pdf',
'864632-49236-2016-3.pdf',
'864452-155515-2017-3.pdf',
'864452-16871-2017-3.pdf',
'864452-17908-2017-3.pdf',
'864452-184531-2017-3.pdf',
'864579-417582-2022-3.pdf',
'864718-34969-2023-3.pdf',
'864558-134736-2023-3.pdf',
'864710-30461-2023-3.pdf',
'864733-177408-2019-3.pdf',
'864718-32430-2023-3.pdf',
'864792-133311-2018-3.pdf',
'864738-223046-2022-3.pdf',
'864800-4847-2017-3.pdf',
'864800-4987-2017-3.pdf',
'864800-5067-2017-3.pdf',
'864800-51-2017-3.pdf',
'864800-5133-2017-3.pdf',
'864800-65105-2017-3.pdf',
'864800-6554-2017-3.pdf',
'864468-194924-2019-3.pdf',
'864468-194941-2019-3.pdf',
'864468-195047-2019-3.pdf',
'864468-195048-2019-3.pdf',
'864468-195290-2019-3.pdf',
'864468-195542-2019-3.pdf',
'864468-195630-2019-3.pdf',
'864468-195915-2019-3.pdf',
'864800-5143-2017-3.pdf',
'864800-5192-2017-3.pdf',
'864800-52535-2017-3.pdf',
'864800-5276-2017-3.pdf',
'864800-53062-2017-3.pdf',
'864800-57197-2017-3.pdf',
'864800-5773-2017-3.pdf',
'864755-232447-2022-3.pdf',
'864800-59601-2017-3.pdf',
'864800-60476-2017-3.pdf',
'864800-62114-2017-3.pdf',
'864800-62258-2017-3.pdf',
'864800-6430-2017-3.pdf',
'864468-196236-2019-3.pdf',
'864801-269707-2022-3.pdf',
'864806-96919-2017-3.pdf',
'864806-97690-2017-3.pdf',
'864490-15861-2023-3.pdf',
'864495-11975-2023-3.pdf',
'864496-17320-2023-3.pdf',
'864508-58599-2023-3.pdf',
'864788-103525-2018-3.pdf',
'864528-6719-2023-3.pdf',
'864529-359837-2022-3.pdf',
'864468-195936-2019-3.pdf',
'864468-195980-2019-3.pdf',
'864468-196151-2019-3.pdf',
'864468-196179-2019-3.pdf',
'864801-269762-2022-3.pdf',
'864777-91638-2022-3.pdf',
'864468-195120-2019-3.pdf',
'864468-195132-2019-3.pdf',
'864468-195710-2019-3.pdf',
'864468-195892-2019-3.pdf',
'864450-310459-2022-3.pdf',
'864450-31076-2022-3.pdf',
'864450-311464-2022-3.pdf',
'864450-311947-2022-3.pdf',
'864450-312682-2022-3.pdf',
'864450-314810-2022-3.pdf',
'864450-315054-2022-3.pdf',
'864450-315197-2022-3.pdf',
'864450-315375-2022-3.pdf',
'864450-316335-2022-3.pdf',
'864454-245-2023-3.pdf',
'864454-23752-2023-3.pdf',
'864454-24079-2023-3.pdf',
'864454-24213-2023-3.pdf',
'864454-24333-2023-3.pdf',
'864454-2531-2023-3.pdf',
'864448-1958-2023-3.pdf',
'864448-1969-2023-3.pdf',
'864448-19817-2023-3.pdf',
'864448-2074-2023-3.pdf',
'864448-2098-2023-3.pdf',
'864448-21257-2023-3.pdf',
'864448-21448-2023-3.pdf',
'864448-2241-2023-3.pdf',
'864448-22725-2023-3.pdf',
'864448-22988-2023-3.pdf',
'864448-22996-2023-3.pdf',
'864448-23201-2023-3.pdf',
'864448-23305-2023-3.pdf',
'864452-18933-2017-3.pdf',
'864600-43204-2022-3.pdf',
'864574-411207-2022-3.pdf',
'864576-186019-2022-3.pdf',
'864452-15123-2017-3.pdf',
'864452-1519-2017-3.pdf',
'864452-15517-2017-3.pdf',
'864452-165286-2017-3.pdf',
'864452-174526-2017-3.pdf',
'864552-132547-2023-3.pdf',
'864580-13912-2023-3.pdf',
'864556-401950-2022-3.pdf',
'864557-176706-2022-3.pdf',
'864724-38022-2023-3.pdf',
'864733-176703-2019-3.pdf',
'864465-150418-2023-3.pdf',
'864740-179480-2019-3.pdf',
'864800-48176-2017-3.pdf',
'864800-48685-2017-3.pdf',
'864800-5002-2017-3.pdf',
'864450-310048-2022-3.pdf',
'864450-310225-2022-3.pdf',
'864450-31032-2022-3.pdf',
'864450-311219-2022-3.pdf',
'864450-312867-2022-3.pdf',
'864450-313008-2022-3.pdf',
'864450-314822-2022-3.pdf',
'864450-315082-2022-3.pdf',
'864563-181163-2022-3.pdf',
'864454-2335-2023-3.pdf',
'864454-23962-2023-3.pdf',
'864454-25207-2023-3.pdf',
'864454-25511-2023-3.pdf',
'864454-25822-2023-3.pdf',
'864454-25842-2023-3.pdf',
'864454-2586-2023-3.pdf',
'864448-20125-2023-3.pdf',
'864448-21237-2023-3.pdf',
'864448-21593-2023-3.pdf',
'864448-23014-2023-3.pdf',
'864575-13815-2023-3.pdf',
'864456-10121-2023-3.pdf',
'864452-15212-2017-3.pdf',
'864452-179958-2017-3.pdf',
'864578-8622-2023-3.pdf',
'864551-175370-2022-3.pdf',
'864581-191592-2022-3.pdf',
'864616-283396-2019-3.pdf',
'864556-403100-2022-3.pdf',
'864461-28189-2023-3.pdf',
'864457-147906-2023-3.pdf',
'864749-231139-2022-3.pdf',
'864735-142186-2021-3.pdf',
'864465-150242-2023-3.pdf',
'864794-261553-2022-3.pdf',
'864800-49017-2017-3.pdf',
'864733-175679-2019-3.pdf',
'864710-30406-2023-3.pdf',
'864736-40599-2023-3.pdf',
'864736-41547-2023-3.pdf',
'864800-4786-2017-3.pdf',
'864800-483-2017-3.pdf',
'864800-4998-2017-3.pdf',
'864800-5381-2017-3.pdf',
'864800-53875-2017-3.pdf',
'864800-5705-2017-3.pdf',
'864800-60718-2017-3.pdf',
'864800-63524-2017-3.pdf',
'864468-194986-2019-3.pdf',
'864468-195031-2019-3.pdf',
'864468-195170-2019-3.pdf',
'864468-195189-2019-3.pdf',
'864744-226699-2022-3.pdf',
'864775-13457-2022-3.pdf',
'864468-195409-2019-3.pdf',
'864468-195465-2019-3.pdf',
'864468-195527-2019-3.pdf',
'864468-195709-2019-3.pdf',
'864468-195990-2019-3.pdf',
'864468-196078-2019-3.pdf',
'864468-196104-2019-3.pdf',
'864468-196203-2019-3.pdf',
'864468-196333-2019-3.pdf',
'864483-4969-2023-3.pdf',
'864450-310102-2022-3.pdf',
'864450-310349-2022-3.pdf',
'864450-311265-2022-3.pdf',
'864450-311306-2022-3.pdf',
'864450-311540-2022-3.pdf',
'864450-312805-2022-3.pdf',
'864450-313046-2022-3.pdf',
'864450-313103-2022-3.pdf',
'864450-313142-2022-3.pdf',
'864450-314933-2022-3.pdf',
'864450-315306-2022-3.pdf',
'864450-315451-2022-3.pdf',
'864450-31566-2022-3.pdf',
'864561-80306-2023-3.pdf',
'864454-23705-2023-3.pdf',
'864454-23720-2023-3.pdf',
'864454-25535-2023-3.pdf',
'864454-25569-2023-3.pdf',
'864454-25625-2023-3.pdf',
'864454-25920-2023-3.pdf',
'864454-25973-2023-3.pdf',
'864448-19676-2023-3.pdf',
'864448-19713-2023-3.pdf',
'864448-20063-2023-3.pdf',
'864448-20170-2023-3.pdf',
'864448-21348-2023-3.pdf',
'864448-22851-2023-3.pdf',
'864448-23040-2023-3.pdf',
'864448-23343-2023-3.pdf',
'864575-137734-2023-3.pdf',
'864632-48436-2016-3.pdf',
'864452-1506-2017-3.pdf',
'864452-18178-2017-3.pdf',
'864461-27870-2023-3.pdf',
'864800-49840-2017-3.pdf',
'864800-49934-2017-3.pdf',
'864800-5257-2017-3.pdf',
'864468-195296-2019-3.pdf',
'864468-195370-2019-3.pdf',
'864468-196113-2019-3.pdf',
'864468-196237-2019-3.pdf',
'864468-196246-2019-3.pdf')




