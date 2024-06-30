--SOLIC_IMPUGNACION  OK 2237 10111
SET Language 'Spanish';    select  proceso.expediente,      proceso.nombre_infractor,      (select CONCAT('Ab. ', Upper(Concat (pf.nombre1, ' ', pf.nombre2, ' ', pf.apellido1, ' ', pf.apellido2)) )  as nombre   from funcionario f inner join firma_persona fp on fp.id_persona = f.id_persona  inner join persona pf on pf.id_persona= f.id_persona    WHERE f.id_cargo =11  and f.fecha_final_vigencia is null   ) as funcionario,      'DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO' as CARGO_DELEGADO,      delegado.nombre,      (select im.numero_imagen from imagen im where im.id_tipo_imagen = 1 and fecha_fin is null) logoATM,      delegado.firmaAgente,      CONVERT(VARCHAR,DAY(getdate())) + ' de ' +       CONVERT(VARCHAR,DATENAME(MONTH, GETDATE())) + ' de ' +       CONVERT(VARCHAR,YEAR(GETDATE())) + ', a las ' +       CONVERT(VARCHAR,DATEPART(hour, getdate())) + 'h' +       CONVERT(VARCHAR,DATEPART(minute, getdate())) as fechaSolicitud,        (SELECT top 1 mi.documento_faltante FROM trazabilidad_proceso trz INNER JOIN motivacion_impugnacion mi on mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso  WHERE trz.id_proceso= proceso.id_proceso order by fecha_inicio DESC) desc_motivacion    from   (      select pr.id_proceso,       convert(varchar,pr.numero_proceso) +' - '+ convert(varchar,year(pr.fecha_inicio)) as expediente,       CASE pe.id_tipo_identificacion WHEN '2' THEN pj.nombre_comercial ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ', pe.apellido1, ' ', pe.apellido2)) END as nombre_infractor    from  proceso pr (nolock) inner join      participante_proceso ppr (nolock) on ppr.id_proceso = pr.id_proceso left join      persona pe  (nolock) on pe.id_persona = ppr.id_persona left join      persona_juridica pj (nolock)                 ON pj.id_persona_juridica = pe.id_persona     where pr.id_proceso is not null  ) proceso ,    (SELECT     top 1 fa.numero_imagen firmaAgente,       Upper(Concat (nombre1, ' ', nombre2, ' ', apellido1, ' ', apellido2))  as nombre  FROM    PERSONA p LEFT JOIN   firma_persona fa on fa.id_persona = p.id_persona  WHERE p.ID_PERSONA IN (select  TOP 1 ID_PERSONA from funcionario where id_cargo = 6 and fecha_final_vigencia is null  ORDER BY NEWID() )  order by fa.fecha_registro desc  ) delegado
--NUMERO_EXPEDIENTE,NOMBRE_INFRACTOR,NOMBRE_ABOGADO_ASIG,CARGO_DELEGADO,DELEGADO_TITULONOMBRE_,LogoATM_variable,FIRMA_FUNCIONARIO_,FECHA_SOLICITUD,desc_motivacion


,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS


update documentos..xml_plantilla
--SOLIC_IMPUGNACION 2237 *    12
set contenido_xml_plantilla=
where id_xml_plantilla=2237

-------------------------------------------------------------------
--Variables de plantillas

select *from variable_plantilla
where id_variable='1448'

begin tran
delete variable_plantilla
where id_variable='1448' and id_plantilla='2237'
commit tran
rollback

INSERT INTO documentos..variable_plantilla
SELECT 2237, 1448

--el primero es el id_plantilla y el segundo es el id_variable


select *from variable_plantilla

select *from variable
--NUMERO_TRAMITE

select *from variable
where nombre_variable='NUMERO_TRAMITE'

select *from variable
where nombre_variable='TITULO_PLANTILLAS'

select *from documentos..variable_plantilla
where id_plantilla='2290'


select *from variable
where id_variable='1435'--1435
-------------------------------------------------------------------------------------
--Ver las variables
select nombre_variable
from documentos..variable_plantilla v
inner join documentos..variable va on va.id_variable=v.id_variable
where id_plantilla='2237'

----------------------------------

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'SOLIC_IMPUGNACION';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)


--NUMERO_EXPEDIENTE,NOMBRE_INFRACTOR,NOMBRE_ABOGADO_ASIG,CARGO_DELEGADO,DELEGADO_TITULONOMBRE_,LogoATM_variable,FIRMA_FUNCIONARIO_,FECHA_SOLICITUD,desc_motivacion,TITULO_PLANTILLAS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--SOLIC_IMPUGNACION 10111 2237

update documentos..xml_plantilla
--SOLIC_IMPUGNACION 2237 *    12
set contenido_xml_plantilla=0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C6A61737065725265706F727420786D6C6E733D22687474703A2F2F6A61737065727265706F7274732E736F75726365666F7267652E6E65742F6A61737065727265706F7274732220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E636522207873693A736368656D614C6F636174696F6E3D22687474703A2F2F6A61737065727265706F7274732E736F75726365666F7267652E6E65742F6A61737065727265706F72747320687474703A2F2F6A61737065727265706F7274732E736F75726365666F7267652E6E65742F7873642F6A61737065727265706F72742E78736422206E616D653D224F52445F434F49505F53494E5F494D50554722207061676557696474683D223631322220706167654865696768743D223739322220636F6C756D6E57696474683D2235373222206C6566744D617267696E3D223230222072696768744D617267696E3D2232302220746F704D617267696E3D2232302220626F74746F6D4D617267696E3D2232302220757569643D2239613462363535622D306636392D343064372D386563332D353630633361326336626439223E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E222076616C75653D22706978656C222F3E0A093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E646174612E64656661756C746461746161646170746572222076616C75653D224F6E6520456D707479205265636F7264222F3E0A093C70726F7065727479206E616D653D22697265706F72742E7A6F6F6D222076616C75653D22312E34363431303030303030303030303036222F3E0A093C70726F7065727479206E616D653D22697265706F72742E78222076616C75653D2230222F3E0A093C70726F7065727479206E616D653D22697265706F72742E79222076616C75653D2230222F3E0A093C706172616D65746572206E616D653D22494D4147455F4449525F4B45592220636C6173733D226A6176612E6C616E672E537472696E67223E0A09093C706172616D657465724465736372697074696F6E3E3C215B43444154415B5D5D3E3C2F706172616D657465724465736372697074696F6E3E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B22225D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C706172616D65746572206E616D653D225355425245504F52545F4449525F4B45592220636C6173733D226A6176612E6C616E672E537472696E67223E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B22225D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C706172616D65746572206E616D653D22505245564945575F4B45592220636C6173733D226A6176612E6C616E672E426F6F6C65616E223E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B66616C73655D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C706172616D65746572206E616D653D224E4F575F594541522220636C6173733D226A6176612E7574696C2E4461746522206973466F7250726F6D7074696E673D2266616C7365223E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B6E6577204461746528292E6765745965617228295D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C706172616D65746572206E616D653D224E4F575F4D4F4E54482220636C6173733D226A6176612E7574696C2E4461746522206973466F7250726F6D7074696E673D2266616C7365223E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B6E6577204461746528292E6765744D6F6E746828295D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C706172616D65746572206E616D653D224E4F575F4441592220636C6173733D226A6176612E7574696C2E4461746522206973466F7250726F6D7074696E673D2266616C7365223E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B6E6577204461746528292E67657444617928295D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C706172616D65746572206E616D653D224E4F575F484F55522220636C6173733D226A6176612E7574696C2E4461746522206973466F7250726F6D7074696E673D2266616C7365223E0A09093C64656661756C7456616C756545787072657373696F6E3E3C215B43444154415B6E6577204461746528292E676574486F7572732829202B22203A20222B206E6577204461746528292E6765744D696E7574657328292B22203A20222B6E6577204461746528292E6765745365636F6E647328295D5D3E3C2F64656661756C7456616C756545787072657373696F6E3E0A093C2F706172616D657465723E0A093C7175657279537472696E673E0A09093C215B43444154415B5D5D3E0A093C2F7175657279537472696E673E0A093C6669656C64206E616D653D2244454C454741444F5F544954554C4F4E4F4D4252455F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224E4F4D4252455F494E46524143544F522220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224E554D45524F5F455850454449454E54452220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224E4F4D4252455F41424F4741444F5F415349472220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224C6F676F41544D5F7661726961626C652220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D22434152474F5F44454C454741444F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D224649524D415F46554E43494F4E4152494F5F2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D2246454348415F534F4C4943495455442220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D22646573635F6D6F7469766163696F6E2220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6669656C64206E616D653D22544954554C4F5F504C414E54494C4C41532220636C6173733D226A6176612E6C616E672E537472696E67222F3E0A093C6261636B67726F756E643E0A09093C62616E64206865696768743D22373532222073706C6974547970653D2253747265746368223E0A0909093C7072696E745768656E45787072657373696F6E3E3C215B43444154415B24507B505245564945575F4B45597D2E626F6F6C65616E56616C756528295D5D3E3C2F7072696E745768656E45787072657373696F6E3E0A0909093C696D616765207363616C65496D6167653D2246696C6C4672616D65222069735573696E6743616368653D2266616C7365222069734C617A793D227472756522206F6E4572726F72547970653D22426C616E6B223E0A090909093C7265706F7274456C656D656E7420783D222D32382220793D2230222077696474683D2236313222206865696768743D22373336222069735072696E745768656E44657461696C4F766572666C6F77733D22747275652220757569643D2262383561393735342D323563392D343838302D386436632D303235646131356162643565223E0A09090909093C7072696E745768656E45787072657373696F6E3E3C215B43444154415B24507B505245564945575F4B45597D5D5D3E3C2F7072696E745768656E45787072657373696F6E3E0A090909093C2F7265706F7274456C656D656E743E0A090909093C696D61676545787072657373696F6E3E3C215B43444154415B24507B494D4147455F4449525F4B45597D202B20226D617263615F7072656C696D696E61722E706E67225D5D3E3C2F696D61676545787072657373696F6E3E0A0909093C2F696D6167653E0A09093C2F62616E643E0A093C2F6261636B67726F756E643E0A093C706167654865616465723E0A09093C62616E64206865696768743D223930222073706C6974547970653D2253747265746368222F3E0A093C2F706167654865616465723E0A093C64657461696C3E0A09093C62616E64206865696768743D22363134223E0A0909093C746578744669656C643E0A090909093C7265706F7274456C656D656E7420783D22312220793D22313138222077696474683D2235353822206865696768743D223135332220757569643D2262333163626532302D613932622D343766302D393164652D333139623664386633333838222F3E0A090909093C74657874456C656D656E742074657874416C69676E6D656E743D224A7573746966696564223E0A09090909093C666F6E7420666F6E744E616D653D22417269616C222073697A653D223131222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B22456E206D692063616C696461642064652044454C454741444F2064656C204469726563746F72206465204765737469C3B36E20646520496E6672616363696F6E6573207920536572766963696F73206465205472C3A16E7369746F2C22202B24467B4E4F4D4252455F41424F4741444F5F415349477D2B222C20736567C3BA6E20636F6E73746120656E20656C204D656D6F72616E646F204E726F2E2045504D544D472D47472D52522D323032312D393032392C2064652066656368612032372064652064696369656D62726520646520323032312C2070726576696F2061646D6974697220656C207472C3A16D6974652072657175657269646F20706F7220222B24467B4E4F4D4252455F494E46524143544F527D2B222C2073652065737461626C656365206C6F207369677569656E74653A20536520646973706F6E65207175652C207061726120636F6E74696E75617220636F6E20656C207472C3A16D6974652061646D696E69737472617469766F2C20646520636F6E666F726D6964616420636F6E20656C20617274C3AD63756C6F203134302064656C2043C3B36469676F204F7267C3A16E69636F2041646D696E69737472617469766F2C206573206E656365736172696F207175652073652061646A756E746520616C2070726F6365736F206C6F73207369677569656E74657320646F63756D656E746F7320686162696C6974616E7465733A20222B24467B646573635F6D6F7469766163696F6E7D2B222E205061726120656C6C6F207365206C65206F746F72676120656C2074C3A9726D696E6F206465206469657A2064C3AD617320612066696E206465207175652070726573656E7465206C6F20616E74657320736F6C6963697461646F20616C20636F7272656F20656C65637472C3B36E69636F2067657374696F6E2E6D756C7461734061746D2E676F622E65632C20696E646963616E646F20636C6172616D656E746520656C206E6F6D62726520636F6D706C65746F2C206EC3BA6D65726F2064652063C3A964756C6120792074656CC3A9666F6E6F2C206F206465206D616E6572612070726573656E6369616C2061206E756573747261206F666963696E61206465206174656E6369C3B36E20616C20636975646164616E6F20656E20656C20432E432E20416C62616E20426F726A61206C6F63616C2035362041207920422E20556E612076657A2063756D706C69646F20656C2074C3A9726D696E6F2C206C6120536563726574617269612041642D686F63206465626572C3A12073656E7461722072617AC3B36E20736F62726520656C2063756D706C696D69656E746F206465206C6F20736F6C6963697461646F20656E206573746520696D70756C736F2061646D696E69737472617469766F2C206361736F20636F6E74726172696F20736520646973706F6E6472C3A120656C206172636869766F2064656C2070726F6365736F2E2043C39A4D504C4153452C204F46C38D43494553452059204E4F544946C38D51554553452E225D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A0909093C746578744669656C643E0A090909093C7265706F7274456C656D656E7420783D22302220793D223537222077696474683D2235353822206865696768743D2231342220757569643D2238386137366232332D396338622D343564342D386131652D373063666431616335663536223E0A09090909093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E78222076616C75653D227078222F3E0A09090909093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E7769647468222076616C75653D227078222F3E0A09090909093C70726F7065727479206E616D653D22636F6D2E6A6173706572736F66742E73747564696F2E756E69742E686569676874222076616C75653D227078222F3E0A090909093C2F7265706F7274456C656D656E743E0A090909093C74657874456C656D656E743E0A09090909093C666F6E7420666F6E744E616D653D22417269616C222073697A653D22313122206973426F6C643D2266616C7365222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B22457870656469656E7465204E6F2E2022202B2024467B4E554D45524F5F455850454449454E54457D5D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A0909093C746578744669656C643E0A090909093C7265706F7274456C656D656E7420783D22312220793D223237222077696474683D2235333822206865696768743D2231342220757569643D2265356339383739652D386165302D343163352D613061372D343961643361373264663134222F3E0A090909093C74657874456C656D656E742074657874416C69676E6D656E743D2243656E746572223E0A09090909093C666F6E7420666F6E744E616D653D22417269616C222073697A653D22313122206973426F6C643D2274727565222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B2244495245434349C3934E204445204745535449C3934E20444520494E4652414343494F4E4553205920534552564943494F53204445205452C3814E5349544F225D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A0909093C746578744669656C643E0A090909093C7265706F7274456C656D656E7420783D22312220793D22343032222077696474683D2235353822206865696768743D2231372220757569643D2236643236626631372D363932352D343938342D393163632D366563313431316335303261222F3E0A090909093C74657874456C656D656E742074657874416C69676E6D656E743D2243656E746572223E0A09090909093C666F6E7420666F6E744E616D653D22417269616C222073697A653D22313122206973426F6C643D2274727565222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B24467B44454C454741444F5F544954554C4F4E4F4D4252455F7D5D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A0909093C746578744669656C643E0A090909093C7265706F7274456C656D656E7420783D22312220793D22343139222077696474683D2235353822206865696768743D2231372220757569643D2230656238306130622D383335622D343063362D626263662D353332623636653964333764222F3E0A090909093C74657874456C656D656E742074657874416C69676E6D656E743D2243656E746572223E0A09090909093C666F6E7420666F6E744E616D653D22417269616C222073697A653D22313122206973426F6C643D2274727565222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B24467B434152474F5F44454C454741444F7D5D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A0909093C696D6167652069734C617A793D227472756522206F6E4572726F72547970653D22426C616E6B223E0A090909093C7265706F7274456C656D656E7420783D223135382220793D22333235222077696474683D2231383022206865696768743D2236312220757569643D2238336232636332332D353731392D346636632D613837322D623565356532663430663761222F3E0A090909093C696D61676545787072657373696F6E3E3C215B43444154415B24467B4649524D415F46554E43494F4E4152494F5F7D5D5D3E3C2F696D61676545787072657373696F6E3E0A0909093C2F696D6167653E0A0909093C746578744669656C643E0A090909093C7265706F7274456C656D656E7420783D22302220793D223735222077696474683D2235353822206865696768743D2231372220757569643D2266633965666230312D613261312D343066372D396662632D653131356439333933393365222F3E0A090909093C74657874456C656D656E742074657874416C69676E6D656E743D224A7573746966696564223E0A09090909093C666F6E7420666F6E744E616D653D22417269616C222073697A653D22313122206973426F6C643D2266616C736522206973537472696B655468726F7567683D2266616C7365222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B2247756179617175696C2C20222B24467B46454348415F534F4C4943495455447D5D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A0909093C746578744669656C643E0A090909093C7265706F7274456C656D656E7420783D22302220793D2234222077696474683D2235333922206865696768743D2232332220757569643D2265346434376265372D383035372D343231622D383338632D643935313931633636633239222F3E0A090909093C74657874456C656D656E742074657874416C69676E6D656E743D2243656E746572223E0A09090909093C666F6E7420666F6E744E616D653D22417269616C222073697A653D22313122206973426F6C643D227472756522206973537472696B655468726F7567683D2266616C7365222F3E0A090909093C2F74657874456C656D656E743E0A090909093C746578744669656C6445787072657373696F6E3E3C215B43444154415B24467B544954554C4F5F504C414E54494C4C41537D5D5D3E3C2F746578744669656C6445787072657373696F6E3E0A0909093C2F746578744669656C643E0A09093C2F62616E643E0A093C2F64657461696C3E0A3C2F6A61737065725265706F72743E0A
where id_xml_plantilla=2237


----------------------------------------------------------------------------
begin tran
UPDATE documentos..plantilla_configuracion
SET    consulta=   'SET language ''Spanish'';

SELECT proceso.expediente,
       proceso.nombre_infractor,
       (SELECT Concat(''Ab. '', Upper(Concat (pf.nombre1, '' '', pf.nombre2, '' '',
                                    pf.apellido1, '' ''
                                            ,
                              pf.apellido2))) AS nombre
        FROM   funcionario f
               INNER JOIN persona pf
                       ON pf.id_persona = f.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_final_vigencia IS NULL)
       AS funcionario,
''DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO'' AS
CARGO_DELEGADO,
delegado.nombre,
(SELECT im.numero_imagen
 FROM   imagen im
 WHERE  im.id_tipo_imagen = 1
        AND fecha_fin IS NULL)
       logoATM,
delegado.firmaagente,
CONVERT(VARCHAR, Day(Getdate())) + '' de ''
+ CONVERT(VARCHAR, Datename(month, Getdate()))
+ '' de '' + CONVERT(VARCHAR, Year(Getdate()))
+ '', a las ''
+ CONVERT(VARCHAR, Datepart(hour, Getdate()))
+ ''h''
+ CONVERT(VARCHAR, Datepart(minute, Getdate()))                            AS
       fechaSolicitud,
(SELECT TOP 1 mi.documento_faltante
 FROM   trazabilidad_proceso trz
        INNER JOIN motivacion_impugnacion mi
                ON mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso
 WHERE  trz.id_proceso = proceso.id_proceso
 ORDER  BY fecha_inicio DESC)
       desc_motivacion
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + '' - ''
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN ''2'' THEN pj.nombre_comercial
                 ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '',
                            pe.apellido1, '' ''
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
        WHERE  pr.id_proceso = :idproceso) proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (fu.titulo_obtenido,'' '',nombre1, '' '', nombre2, '' '', apellido1, '' '',
                           apellido2)) AS nombre
        FROM   persona p
               LEFT JOIN firma_persona fa
                      ON fa.id_persona = p.id_persona
					  LEFT JOIN funcionario fu
					ON fu.id_persona=p.id_persona
        WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                                FROM   funcionario
                                WHERE  id_cargo = 6
                                       AND fecha_final_vigencia IS NULL
                                ORDER  BY Newid())
        ORDER  BY fa.fecha_registro DESC) delegado  '
		, orden_variables='NUMERO_EXPEDIENTE,NOMBRE_INFRACTOR,NOMBRE_ABOGADO_ASIG,CARGO_DELEGADO,DELEGADO_TITULONOMBRE_,LogoATM_variable,FIRMA_FUNCIONARIO_,FECHA_SOLICITUD,desc_motivacion,TITULO_PLANTILLAS,TITULO_PLANTILLAS'
WHERE  id_plantilla_config= 10111

commit tran

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'SOLIC_IMPUGNACION';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
--NUMERO_EXPEDIENTE,NOMBRE_INFRACTOR,NOMBRE_ABOGADO_ASIG,CARGO_DELEGADO,DELEGADO_TITULONOMBRE_,LogoATM_variable,FIRMA_FUNCIONARIO_,FECHA_SOLICITUD,desc_motivacion,TITULO_PLANTILLAS
-------------------------------------------------------------------------------------
--Modificada

SET language 'Spanish';

SELECT proceso.expediente,
       proceso.nombre_infractor,
       (SELECT Concat('Ab. ', Upper(Concat (pf.nombre1, ' ', pf.nombre2, ' ',
                                    pf.apellido1, ' '
                                            ,
                              pf.apellido2))) AS nombre
        FROM   funcionario f
               INNER JOIN persona pf
                       ON pf.id_persona = f.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_final_vigencia IS NULL)
       AS funcionario,
'DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO' AS
CARGO_DELEGADO,
delegado.nombre,
(SELECT im.numero_imagen
 FROM   imagen im
 WHERE  im.id_tipo_imagen = 1
        AND fecha_fin IS NULL)
       logoATM,
delegado.firmaagente,
CONVERT(VARCHAR, Day(Getdate())) + ' de '
+ CONVERT(VARCHAR, Datename(month, Getdate()))
+ ' de ' + CONVERT(VARCHAR, Year(Getdate()))
+ ', a las '
+ CONVERT(VARCHAR, Datepart(hour, Getdate()))
+ 'h'
+ CONVERT(VARCHAR, Datepart(minute, Getdate()))                            AS
       fechaSolicitud,
(SELECT TOP 1 mi.documento_faltante
 FROM   trazabilidad_proceso trz
        INNER JOIN motivacion_impugnacion mi
                ON mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso
 WHERE  trz.id_proceso = proceso.id_proceso
 ORDER  BY fecha_inicio DESC)
       desc_motivacion
	   ,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS
FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + ' - '
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN '2' THEN pj.nombre_comercial
                 ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                            pe.apellido1, ' '
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
        WHERE  pr.id_proceso = :idproceso) proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (fu.titulo_obtenido,' ',nombre1, ' ', nombre2, ' ', apellido1, ' ',
                           apellido2)) AS nombre
        FROM   persona p
               LEFT JOIN firma_persona fa
                      ON fa.id_persona = p.id_persona
					  LEFT JOIN funcionario fu
					ON fu.id_persona=p.id_persona
        WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                                FROM   funcionario
                                WHERE  id_cargo = 6
                                       AND fecha_final_vigencia IS NULL
                                ORDER  BY Newid())
        ORDER  BY fa.fecha_registro DESC) delegado 

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Original

SET language 'Spanish';

SELECT proceso.expediente,
       proceso.nombre_infractor,
       (SELECT Concat('Ab. ', Upper(Concat (pf.nombre1, ' ', pf.nombre2, ' ',
                                    pf.apellido1, ' '
                                            ,
                              pf.apellido2))) AS nombre
        FROM   funcionario f
               INNER JOIN firma_persona fp
                       ON fp.id_persona = f.id_persona
               INNER JOIN persona pf
                       ON pf.id_persona = f.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_final_vigencia IS NULL)
       AS funcionario,
'DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO' AS
CARGO_DELEGADO,
delegado.nombre,
(SELECT im.numero_imagen
 FROM   imagen im
 WHERE  im.id_tipo_imagen = 1
        AND fecha_fin IS NULL)
       logoATM,
delegado.firmaagente,
CONVERT(VARCHAR, Day(Getdate())) + ' de '
+ CONVERT(VARCHAR, Datename(month, Getdate()))
+ ' de ' + CONVERT(VARCHAR, Year(Getdate()))
+ ', a las '
+ CONVERT(VARCHAR, Datepart(hour, Getdate()))
+ 'h'
+ CONVERT(VARCHAR, Datepart(minute, Getdate()))                            AS
       fechaSolicitud,
(SELECT TOP 1 mi.documento_faltante
 FROM   trazabilidad_proceso trz
        INNER JOIN motivacion_impugnacion mi
                ON mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso
 WHERE  trz.id_proceso = proceso.id_proceso
 ORDER  BY fecha_inicio DESC)
       desc_motivacion
FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + ' - '
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN '2' THEN pj.nombre_comercial
                 ELSE Upper(Concat (pe.nombre1, ' ', pe.nombre2, ' ',
                            pe.apellido1, ' '
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
        WHERE  pr.id_proceso is not null) proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (nombre1, ' ', nombre2, ' ', apellido1, ' ',
                           apellido2)) AS nombre
        FROM   persona p
               LEFT JOIN firma_persona fa
                      ON fa.id_persona = p.id_persona
        WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                                FROM   funcionario
                                WHERE  id_cargo = 6
                                       AND fecha_final_vigencia IS NULL
                                ORDER  BY Newid())
        ORDER  BY fa.fecha_registro DESC) delegado 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--Update Alexander

begin tran
update documentos.dbo.plantilla_configuracion
set consulta =
'SET language ''Spanish'';
 
SELECT proceso.expediente,
       proceso.nombre_infractor,
       (SELECT Concat(''Ab. '', Upper(Concat (pf.nombre1, '' '', pf.nombre2, '' '',
                                    pf.apellido1, '' ''
                                            ,
                              pf.apellido2))) AS nombre
        FROM   funcionario f
               INNER JOIN persona pf
                       ON pf.id_persona = f.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_final_vigencia IS NULL)
       AS funcionario,
''DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO'' AS
CARGO_DELEGADO,
delegado.nombre,
(SELECT im.numero_imagen
FROM   imagen im
WHERE  im.id_tipo_imagen = 1
        AND fecha_fin IS NULL)
       logoATM,
delegado.firmaagente,
CONVERT(VARCHAR, Day(Getdate())) + '' de ''
+ CONVERT(VARCHAR, Datename(month, Getdate()))
+ '' de '' + CONVERT(VARCHAR, Year(Getdate()))
+ '', a las ''
+ CONVERT(VARCHAR, Datepart(hour, Getdate()))
+ ''h''
+ CONVERT(VARCHAR, Datepart(minute, Getdate()))                            AS
       fechaSolicitud,
(SELECT TOP 1 mi.documento_faltante
FROM   trazabilidad_proceso trz
        INNER JOIN motivacion_impugnacion mi
                ON mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso
WHERE  trz.id_proceso = proceso.id_proceso
ORDER  BY fecha_inicio DESC)
       desc_motivacion
FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + '' - ''
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN ''2'' THEN pj.nombre_comercial
                 ELSE Upper(Concat (pe.nombre1, '' '', pe.nombre2, '' '',
                            pe.apellido1, '' ''
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
        WHERE  pr.id_proceso is not null) proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (nombre1, '' '', nombre2, '' '', apellido1, '' '',
                           apellido2)) AS nombre
        FROM   persona p
               LEFT JOIN firma_persona fa
                      ON fa.id_persona = p.id_persona
        WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                                FROM   funcionario
                                WHERE  id_cargo = 6
                                       AND fecha_final_vigencia IS NULL
                                ORDER  BY Newid())
        ORDER  BY fa.fecha_registro DESC) delegado'
where id_plantilla_config = 10111	
commit tran
-------------------------------------------------------------------------------------
--Observaciones:
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--------------------------------------------------------
--Dato quemado
--Modificada
--------------------------------------------------------
--Dato quemado
--Modificada
SET language 'Spanish';

SELECT top 10
(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS,
proceso.expediente,
       proceso.nombre_infractor,
       (SELECT 
	   --Concat('Ab. ', 
	   Upper(Concat (f.titulo_obtenido,'FFFF ',pf.nombre1, ' ', pf.nombre2, ' ',
                                    pf.apellido1, ' '
                                            ,
                              pf.apellido2))
							  --) 
							  AS nombre
        FROM   funcionario f
               INNER JOIN persona pf
                       ON pf.id_persona = f.id_persona
        WHERE  f.id_cargo = 11
               AND f.fecha_final_vigencia IS NULL)
       AS funcionario,
'DELEGADO DEL DIRECTOR DE GESTION DE INFRACCIONES Y SERVICIOS DE TRANSITO' AS
CARGO_DELEGADO,
delegado.nombre,
(SELECT im.numero_imagen
 FROM   imagen im
 WHERE  im.id_tipo_imagen = 1
        AND fecha_fin IS NULL)
       logoATM,
delegado.firmaagente,
CONVERT(VARCHAR, Day(Getdate())) + ' de '
+ CONVERT(VARCHAR, Datename(month, Getdate()))
+ ' de ' + CONVERT(VARCHAR, Year(Getdate()))
+ ', a las '
+ CONVERT(VARCHAR, Datepart(hour, Getdate()))
+ 'h'
+ CONVERT(VARCHAR, Datepart(minute, Getdate()))                            AS
       fechaSolicitud,
(SELECT TOP 1 mi.documento_faltante
 FROM   trazabilidad_proceso trz
        INNER JOIN motivacion_impugnacion mi
                ON mi.id_trazabilidad_proceso = trz.id_trazabilidad_proceso
 WHERE  trz.id_proceso = proceso.id_proceso
 ORDER  BY fecha_inicio DESC)
       desc_motivacion

,(SELECT valor_parametro_defecto
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 439)AS TITULO_PLANTILLAS

FROM   (SELECT pr.id_proceso,
               CONVERT(VARCHAR, pr.numero_proceso) + ' - '
               + CONVERT(VARCHAR, Year(pr.fecha_inicio)) AS expediente,
               CASE pe.id_tipo_identificacion
                 WHEN '2' THEN pj.nombre_comercial
                 ELSE Upper(Concat ('HHHHHH',pe.nombre1, ' ', pe.nombre2, ' ',
                            pe.apellido1, ' '
                            ,
                      pe.apellido2))
               END                                       AS nombre_infractor
        FROM   proceso pr (nolock)
               INNER JOIN participante_proceso ppr (nolock)
                       ON ppr.id_proceso = pr.id_proceso
               LEFT JOIN persona pe (nolock)
                      ON pe.id_persona = ppr.id_persona
               LEFT JOIN persona_juridica pj (nolock)
                      ON pj.id_persona_juridica = pe.id_persona
        WHERE  pr.id_proceso is not null) as proceso,
       (SELECT TOP 1 fa.numero_imagen
                     firmaAgente,
                     Upper(Concat (fu.titulo_obtenido,' ',p.nombre1, ' ', nombre2, ' ', apellido1, ' ',
                           apellido2)) AS nombre
						   
       
	   FROM   persona p
               LEFT JOIN firma_persona fa
                      ON fa.id_persona = p.id_persona
			   LEFT JOIN funcionario fu
					ON fu.id_persona=p.id_persona
        WHERE  p.id_persona IN (SELECT TOP 1 id_persona
                                FROM   funcionario 
                                WHERE  id_cargo = 6
                                       AND fecha_final_vigencia IS NULL
                              --  ORDER  BY Newid()
								)
        --ORDER  BY fa.fecha_registro DESC
		) delegado 
----------------------------------------------------------------------
----------------------------------------------------------------------