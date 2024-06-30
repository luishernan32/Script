--ORDENANZA_REQ_PAGO



declare @codigoPlantilla varchar(20);
set @codigoPlantilla = 'ORDENANZA_REQ_PAGO';--AUTO_PAGO_PATIO
select * from documentos..plantilla where codigo_plantilla=@codigoPlantilla
select * from documentos..plantilla_configuracion where id_plantilla in (select id_plantilla from documentos..plantilla where codigo_plantilla=@codigoPlantilla)
select * from documentos..proceso where id_proceso IN (select id_proceso from documentos..plantilla where codigo_plantilla=@codigoPlantilla)

--punto: 20  Jasper
--Presente error en el sistema
--ORDENANZA_REQ_PAGO	ORDENANZA_REQ_PAGO
--PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE PENDIENTE VPENDIENTE PENDIENTE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--Modificada
update documentos..xml_plantilla
--LEV_MED_CAUT  2258 *    8
set contenido_xml_plantilla=0x
where id_xml_plantilla=2229



--Original
update documentos..xml_plantilla
--LEV_MED_CAUT  2258 *    8
set contenido_xml_plantilla=0x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0d0a3c6a61737065725265706f727420786d6c6e733d22687474703a2f2f6a61737065727265706f7274732e736f75726365666f7267652e6e65742f6a61737065727265706f7274732220786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e636522207873693a736368656d614c6f636174696f6e3d22687474703a2f2f6a61737065727265706f7274732e736f75726365666f7267652e6e65742f6a61737065727265706f72747320687474703a2f2f6a61737065727265706f7274732e736f75726365666f7267652e6e65742f7873642f6a61737065727265706f72742e78736422206e616d653d224f52445f434f49505f53494e5f494d50554722207061676557696474683d223631322220706167654865696768743d223739322220636f6c756d6e57696474683d2235373222206c6566744d617267696e3d223230222072696768744d617267696e3d2232302220746f704d617267696e3d2232302220626f74746f6d4d617267696e3d2232302220757569643d2239613462363535622d306636392d343064372d386563332d353630633361326336626439223e0d0a093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e222076616c75653d22706978656c222f3e0d0a093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e646174612e64656661756c746461746161646170746572222076616c75653d224f6e6520456d707479205265636f7264222f3e0d0a093c70726f7065727479206e616d653d22697265706f72742e7a6f6f6d222076616c75653d22312e34363431303030303030303030303036222f3e0d0a093c70726f7065727479206e616d653d22697265706f72742e78222076616c75653d2230222f3e0d0a093c70726f7065727479206e616d653d22697265706f72742e79222076616c75653d2230222f3e0d0a093c706172616d65746572206e616d653d22494d4147455f4449525f4b45592220636c6173733d226a6176612e6c616e672e537472696e67223e0d0a09093c706172616d657465724465736372697074696f6e3e3c215b43444154415b5d5d3e3c2f706172616d657465724465736372697074696f6e3e0d0a09093c64656661756c7456616c756545787072657373696f6e3e3c215b43444154415b22225d5d3e3c2f64656661756c7456616c756545787072657373696f6e3e0d0a093c2f706172616d657465723e0d0a093c706172616d65746572206e616d653d225355425245504f52545f4449525f4b45592220636c6173733d226a6176612e6c616e672e537472696e67223e0d0a09093c64656661756c7456616c756545787072657373696f6e3e3c215b43444154415b22225d5d3e3c2f64656661756c7456616c756545787072657373696f6e3e0d0a093c2f706172616d657465723e0d0a093c706172616d65746572206e616d653d22505245564945575f4b45592220636c6173733d226a6176612e6c616e672e426f6f6c65616e223e0d0a09093c64656661756c7456616c756545787072657373696f6e3e3c215b43444154415b66616c73655d5d3e3c2f64656661756c7456616c756545787072657373696f6e3e0d0a093c2f706172616d657465723e0d0a093c706172616d65746572206e616d653d224e4f575f594541522220636c6173733d226a6176612e7574696c2e44617465223e0d0a09093c64656661756c7456616c756545787072657373696f6e3e3c215b43444154415b6e6577204461746528292e6765745965617228295d5d3e3c2f64656661756c7456616c756545787072657373696f6e3e0d0a093c2f706172616d657465723e0d0a093c706172616d65746572206e616d653d224e4f575f4d4f4e54482220636c6173733d226a6176612e7574696c2e44617465223e0d0a09093c64656661756c7456616c756545787072657373696f6e3e3c215b43444154415b6e6577204461746528292e6765744d6f6e746828295d5d3e3c2f64656661756c7456616c756545787072657373696f6e3e0d0a093c2f706172616d657465723e0d0a093c706172616d65746572206e616d653d224e4f575f4441592220636c6173733d226a6176612e7574696c2e44617465223e0d0a09093c64656661756c7456616c756545787072657373696f6e3e3c215b43444154415b6e6577204461746528292e67657444617928295d5d3e3c2f64656661756c7456616c756545787072657373696f6e3e0d0a093c2f706172616d657465723e0d0a093c706172616d65746572206e616d653d224e4f575f484f55522220636c6173733d226a6176612e7574696c2e44617465223e0d0a09093c64656661756c7456616c756545787072657373696f6e3e3c215b43444154415b6e6577204461746528292e676574486f7572732829202b22203a20222b206e6577204461746528292e6765744d696e7574657328292b22203a20222b6e6577204461746528292e6765745365636f6e647328295d5d3e3c2f64656661756c7456616c756545787072657373696f6e3e0d0a093c2f706172616d657465723e0d0a093c7175657279537472696e673e0d0a09093c215b43444154415b5d5d3e0d0a093c2f7175657279537472696e673e0d0a093c6669656c64206e616d653d2244454c454741444f5f544954554c4f4e4f4d4252455f2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d224e4f4d4252455f494e46524143544f522220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d22545f444f43554d454e544f5f494e46524143544f522220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d224e5f444f43554d454e544f5f494e46524143544f522220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d2256414c4f525f4d554c54412220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d224349554441445f494e4652414343494f4e2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d2246454348415f494e4652414343494f4e2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d226e756d65726f5f6369746163696f6e2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d224445534352495043494f4e5f494e4652414343494f4e2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d22504c4143415f5645484943554c4f2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d22444952454343494f4e5f494e4652414343494f4e2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d224e4f4d4252455f4147454e54452220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d22504c4143415f4147454e54452220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d224649524d415f4147454e54452220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d224649524d415f46554e43494f4e4152494f5f2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d2246454348415f534f4c4943495455442220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d224c6f676f41544d5f7661726961626c652220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d22554249434143494f4e5f494e46524143544f522220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d224445534352495043494f4e5f4d554c5441532220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d225041525241464f5f312220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d225041525241464f5f322220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d22434152474f5f44454c454741444f2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d22434f4449474f5f43414d4152412220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d2246454348415f43414c4942524143494f4e2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d2256454c4f43494441445f5045524d49544944412220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d2256454c4f43494441445f494e4652414343494f4e2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d2246454348415f47454e45524143494f4e2220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d22434f4449474f5f4147454e54452220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6669656c64206e616d653d224e554d45524f5f464143545552412220636c6173733d226a6176612e6c616e672e537472696e67222f3e0d0a093c6261636b67726f756e643e0d0a09093c62616e64206865696768743d22373532222073706c6974547970653d2253747265746368223e0d0a0909093c7072696e745768656e45787072657373696f6e3e3c215b43444154415b24507b505245564945575f4b45597d2e626f6f6c65616e56616c756528295d5d3e3c2f7072696e745768656e45787072657373696f6e3e0d0a0909093c696d616765207363616c65496d6167653d2246696c6c4672616d65222069735573696e6743616368653d2266616c7365222069734c617a793d227472756522206f6e4572726f72547970653d22426c616e6b223e0d0a090909093c7265706f7274456c656d656e7420783d222d32382220793d2230222077696474683d2236313222206865696768743d22373336222069735072696e745768656e44657461696c4f766572666c6f77733d22747275652220757569643d2262383561393735342d323563392d343838302d386436632d303235646131356162643565223e0d0a09090909093c7072696e745768656e45787072657373696f6e3e3c215b43444154415b24507b505245564945575f4b45597d5d5d3e3c2f7072696e745768656e45787072657373696f6e3e0d0a090909093c2f7265706f7274456c656d656e743e0d0a090909093c696d61676545787072657373696f6e3e3c215b43444154415b24507b494d4147455f4449525f4b45597d202b20226d617263615f7072656c696d696e61722e706e67225d5d3e3c2f696d61676545787072657373696f6e3e0d0a0909093c2f696d6167653e0d0a09093c2f62616e643e0d0a093c2f6261636b67726f756e643e0d0a093c706167654865616465723e0d0a09093c62616e64206865696768743d223731222073706c6974547970653d2253747265746368222f3e0d0a093c2f706167654865616465723e0d0a093c64657461696c3e0d0a09093c62616e64206865696768743d22363331223e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d22313539222077696474683d2235353822206865696768743d223233342220757569643d2262333163626532302d613932622d343766302d393164652d333139623664386633333838222f3e0d0a090909093c74657874456c656d656e742074657874416c69676e6d656e743d224a7573746966696564223e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d223131222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b24467b5041525241464f5f317d2b225c6e5c6e222b24467b5041525241464f5f327d5d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d2235222077696474683d2235333822206865696768743d2231342220757569643d2230366264663634612d313039642d346136322d386332362d333039383335383235323031222f3e0d0a090909093c74657874456c656d656e742074657874416c69676e6d656e743d2243656e746572223e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2274727565222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b22524551554552494d49454e544f204445205041474f20564f4c554e544152494f225d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d223330222077696474683d2235353822206865696768743d2231342220757569643d2238386137366232332d396338622d343564342d386131652d373063666431616335663536223e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e78222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e7769647468222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e686569676874222076616c75653d227078222f3e0d0a090909093c2f7265706f7274456c656d656e743e0d0a090909093c74657874456c656d656e743e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2266616c7365222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b2254c38d54554c4f204445204352c3894449544f204e6f2e3a20222b24467b6e756d65726f5f6369746163696f6e7d5d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c737461746963546578743e0d0a090909093c7265706f7274456c656d656e7420783d22322220793d22343732222077696474683d2235353922206865696768743d2231352220757569643d2261303034323037322d383235622d343532612d626133362d663035333837373566353139222f3e0d0a090909093c74657874456c656d656e743e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d223131222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578743e3c215b43444154415b4c6f2071756520636f6d756e69636f20612055737465642070617261206c6f732066696e65732070657274696e656e7465735d5d3e3c2f746578743e0d0a0909093c2f737461746963546578743e0d0a0909093c696d6167652069734c617a793d227472756522206f6e4572726f72547970653d22426c616e6b223e0d0a090909093c7265706f7274456c656d656e7420783d2232332220793d22353132222077696474683d2231383022206865696768743d2236312220757569643d2230346566313564632d316130622d346262662d393035662d356436633166333964383835222f3e0d0a090909093c696d61676545787072657373696f6e3e3c215b43444154415b24467b4649524d415f46554e43494f4e4152494f5f7d5d5d3e3c2f696d61676545787072657373696f6e3e0d0a0909093c2f696d6167653e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d223633222077696474683d2235353822206865696768743d2231342220757569643d2239623965323038382d303433392d343765302d396364642d313634626332393039373437223e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e78222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e7769647468222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e686569676874222076616c75653d227078222f3e0d0a090909093c2f7265706f7274456c656d656e743e0d0a090909093c74657874456c656d656e743e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2266616c7365222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b224ec3ba6d65726f206465206964656e7469666963616369c3b36e3a20222b24467b545f444f43554d454e544f5f494e46524143544f527d2b2220222b24467b4e5f444f43554d454e544f5f494e46524143544f527d5d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d223738222077696474683d2235353822206865696768743d2231342220757569643d2233323066613837332d313361662d343638382d616331382d663538306466616162333661223e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e78222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e7769647468222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e686569676874222076616c75653d227078222f3e0d0a090909093c2f7265706f7274456c656d656e743e0d0a090909093c74657874456c656d656e743e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2266616c7365222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b2244697265636369c3b36e3a20222b24467b554249434143494f4e5f494e46524143544f527d5d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d223933222077696474683d2235353822206865696768743d2231342220757569643d2262323263643936322d623839352d346466342d386263382d356236373535343766336335223e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e78222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e7769647468222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e686569676874222076616c75653d227078222f3e0d0a090909093c2f7265706f7274456c656d656e743e0d0a090909093c74657874456c656d656e743e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2266616c7365222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b2247756179617175696c2c2061206c6f7320222b24467b46454348415f47454e45524143494f4e7d2b222e225d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22312220793d22313132222077696474683d2235353822206865696768743d2234312220757569643d2234323634343536312d343735652d343731632d383738662d363865653630303231303666223e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e78222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e7769647468222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e686569676874222076616c75653d227078222f3e0d0a090909093c2f7265706f7274456c656d656e743e0d0a090909093c74657874456c656d656e743e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2266616c7365222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b2244656e74726f2064656c20657870656469656e746520646520436974616369c3b36e204ec2b03a20222b2024467b6e756d65726f5f6369746163696f6e7d202b20222c20756e612076657a2076656e6369646f20656c20706c617a6f2064652073757370656e7369c3b36e206465206c6f732070726f6365736f7320636f61637469766f732065737461626c656369646f20656e206c6120446973706f73696369c3b36e20566967c3a973696d612054657263657261206465206c61204c6579204f7267c3a16e6963612064652041706f796f2048756d616e69746172696f2c207365206c6520686163652073616265722061207573746564206c6f207369677569656e74653a225d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d22333933222077696474683d2235353822206865696768743d2237392220757569643d2264303538643035312d373435632d343561632d386166632d303330653036336537303766222f3e0d0a090909093c74657874456c656d656e742074657874416c69676e6d656e743d224a7573746966696564223e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d223131222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b22506f72206c6f20616e746573206d656e63696f6e61646f2c20726571756572696d6f7320646520757374656420656c207061676f206465206c61206d756c746120706f7220636f6e636570746f2064652027222b2024467b4445534352495043494f4e5f494e4652414343494f4e7d202b222720706f7220656c2076616c6f72206465202422202b2024467b56414c4f525f4d554c54417d202b22206dc3a173206c6f73207265636172676f73206465206c65792c20717565206465626572c3a12065666563747561726c6f2064656e74726f206465206c6f732031302064c3ad617320636f6e7461646f73206465736465206c61206665636861206465206c612070726573656e7465206e6f7469666963616369c3b36e2e225d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d22353639222077696474683d2235353822206865696768743d2231332220757569643d2261633837646562312d613962342d343031352d393630322d613538663539393238643538222f3e0d0a090909093c74657874456c656d656e742074657874416c69676e6d656e743d224a7573746966696564223e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2274727565222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b24467b44454c454741444f5f544954554c4f4e4f4d4252455f7d5d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c737461746963546578743e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d22353935222077696474683d2235353822206865696768743d2231362220757569643d2239363332626537302d376333632d343536392d613932352d616438323136393432356536222f3e0d0a090909093c74657874456c656d656e742074657874416c69676e6d656e743d224c656674223e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2274727565222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578743e3c215b43444154415b4147454e434941204445205452c3814e5349544f2059204d4f56494c494441445d5d3e3c2f746578743e0d0a0909093c2f737461746963546578743e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d22353832222077696474683d2235353822206865696768743d2231332220757569643d2264383962623231392d313262652d346165322d393230382d666437356538373462643439222f3e0d0a090909093c74657874456c656d656e742074657874416c69676e6d656e743d224a7573746966696564223e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2274727565222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b24467b434152474f5f44454c454741444f7d5d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d223437222077696474683d2235353822206865696768743d2231342220757569643d2266336535316138382d656534632d346461372d383033392d396638326462336130313665223e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e78222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e7769647468222076616c75653d227078222f3e0d0a09090909093c70726f7065727479206e616d653d22636f6d2e6a6173706572736f66742e73747564696f2e756e69742e686569676874222076616c75653d227078222f3e0d0a090909093c2f7265706f7274456c656d656e743e0d0a090909093c74657874456c656d656e743e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2266616c7365222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b224e6f6d62726520646520646575646f723a20222b2824467b4e4f4d4252455f494e46524143544f527d203d3d206e756c6c203f202222203a24467b4e4f4d4252455f494e46524143544f527d295d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a0909093c746578744669656c643e0d0a090909093c7265706f7274456c656d656e7420783d22302220793d22363130222077696474683d2235353822206865696768743d2231332220757569643d2236653736653432312d636462342d343462322d393963622d376630336661306137623764222f3e0d0a090909093c74657874456c656d656e742074657874416c69676e6d656e743d224a7573746966696564223e0d0a09090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313122206973426f6c643d2274727565222f3e0d0a090909093c2f74657874456c656d656e743e0d0a090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b24467b4e554d45524f5f464143545552417d3d3d6e756c6c3f22223a24467b4e554d45524f5f464143545552417d5d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a0909093c2f746578744669656c643e0d0a09093c2f62616e643e0d0a09093c62616e64206865696768743d22363031223e0d0a0909093c6672616d653e0d0a090909093c7265706f7274456c656d656e7420783d22322220793d223137222077696474683d2235353822206865696768743d223532302220757569643d2230643561663062362d623639322d346338652d613838342d323533383865616532306537222f3e0d0a090909093c626f783e0d0a09090909093c746f7050656e206c696e6557696474683d22302e3522206c696e655374796c653d22536f6c696422206c696e65436f6c6f723d2223303030303030222f3e0d0a09090909093c6c65667450656e206c696e6557696474683d22302e3522206c696e655374796c653d22536f6c696422206c696e65436f6c6f723d2223303030303030222f3e0d0a09090909093c626f74746f6d50656e206c696e6557696474683d22302e3522206c696e655374796c653d22536f6c696422206c696e65436f6c6f723d2223303030303030222f3e0d0a09090909093c726967687450656e206c696e6557696474683d22302e3522206c696e655374796c653d22536f6c696422206c696e65436f6c6f723d2223303030303030222f3e0d0a090909093c2f626f783e0d0a090909093c696d6167652069734c617a793d227472756522206f6e4572726f72547970653d22426c616e6b223e0d0a09090909093c7265706f7274456c656d656e7420783d2235312220793d2239222077696474683d22363922206865696768743d2236332220757569643d2265616162613737362d303435362d346165392d393462372d303463313866623237316539222f3e0d0a09090909093c696d61676545787072657373696f6e3e3c215b43444154415b24467b4c6f676f41544d5f7661726961626c657d5d5d3e3c2f696d61676545787072657373696f6e3e0d0a090909093c2f696d6167653e0d0a090909093c746578744669656c643e0d0a09090909093c7265706f7274456c656d656e7420783d2231312220793d223831222077696474683d2234373622206865696768743d2232362220757569643d2266626136633138342d653630302d343838332d616233322d643361643031616162613137222f3e0d0a09090909093c74657874456c656d656e742074657874416c69676e6d656e743d2243656e746572223e0d0a0909090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d22313022206973426f6c643d2274727565222f3e0d0a09090909093c2f74657874456c656d656e743e0d0a09090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b2254c3ad74756c6f206465206372c3a96469746f204e6f2e2022202b20225c6e22202b2024467b6e756d65726f5f6369746163696f6e7d5d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a090909093c2f746578744669656c643e0d0a090909093c746578744669656c6420697353747265746368576974684f766572666c6f773d227472756522206973426c616e6b5768656e4e756c6c3d2274727565223e0d0a09090909093c7265706f7274456c656d656e7420783d2231322220793d22313037222077696474683d2235323422206865696768743d223236342220757569643d2264353263623938652d373330652d343665362d616539352d303430666236666139663831222f3e0d0a09090909093c74657874456c656d656e742074657874416c69676e6d656e743d224a757374696669656422206d61726b75703d227374796c6564223e0d0a0909090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d2239222f3e0d0a09090909093c2f74657874456c656d656e743e0d0a09090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b223c7374796c65206973426f6c643d2774727565273e222b22312e2041444d494e49535452414349c3934e2050c39a424c494341204143524545444f52413a2022202b20223c2f7374796c653e22202b2022456d70726573612050c3ba626c696361206465205472c3a16e7369746f2079204d6f76696c696461642064652047756179617175696c204550222b225c6e222b0d0a223c7374796c65206973426f6c643d2774727565273e222b22322e20444555444f52202841293a202022202b20223c2f7374796c653e22202b202824467b4e4f4d4252455f494e46524143544f527d203d3d206e756c6c203f202222203a24467b4e4f4d4252455f494e46524143544f527d29202b225c6e222b0d0a223c7374796c65206973426f6c643d2774727565273e222b22332e204944454e5449464943414349c3934e3a204e4f2e20222b223c2f7374796c653e22202b202824467b4e5f444f43554d454e544f5f494e46524143544f527d203d3d206e756c6c203f2022223a2024467b4e5f444f43554d454e544f5f494e46524143544f527d29202b225c6e222b0d0a223c7374796c65206973426f6c643d2774727565273e222b22342e204645434841205920484f52413a2020222b223c2f7374796c653e222b2824467b46454348415f494e4652414343494f4e7d3d3d206e756c6c203f2022223a2024467b46454348415f494e4652414343494f4e7d292b222e205c6e222b0d0a223c7374796c65206973426f6c643d2774727565273e222b22352e205645484943554c4f20504c4143413a20222b223c2f7374796c653e22202b2824467b504c4143415f5645484943554c4f7d3d3d206e756c6c203f2022223a24467b504c4143415f5645484943554c4f7d292b225c6e222b0d0a223c7374796c65206973426f6c643d2774727565273e222b22362e204c554741523a2022202b20223c2f7374796c653e22202b2824467b444952454343494f4e5f494e4652414343494f4e7d3d3d206e756c6c203f2022223a24467b444952454343494f4e5f494e4652414343494f4e7d292b225c6e222b0d0a223c7374796c65206973426f6c643d2774727565273e222b22372e2056414c4f52204445204c41204d554c54413a2024222b223c2f7374796c653e22202b2824467b56414c4f525f4d554c54417d3d3d206e756c6c203f202230223a24467b56414c4f525f4d554c54417d292b225c6e222b0d0a223c7374796c65206973426f6c643d2774727565273e222b22382e20434f4e434550544f3a20222b20223c2f7374796c653e22202b2220436f6e74726176656e6369c3b36e206465205472c3a16e7369746f20222b202824467b4445534352495043494f4e5f494e4652414343494f4e7d3d3d206e756c6c203f2022223a2024467b4445534352495043494f4e5f494e4652414343494f4e7d29202b225c6e222b0d0a223c7374796c65206973426f6c643d2774727565273e392e203c2f7374796c653e536520726571756965726520717565206c61206f20656c20646575646f7220706167756520766f6c756e74617269616d656e7465206c61206f626c6967616369c3b36e20706f7220656c2076616c6f72206465202422202b202824467b56414c4f525f4d554c54417d3d3d206e756c6c203f202230223a24467b56414c4f525f4d554c54417d292b2022206dc3a173206c6f73207265636172676f73206465206c65792064656e74726f206465206c6f732031302064c3ad61732068c3a162696c65732c20636f6e7461646f73206465736465206c61206665636861206465206c612070726573656e7465206e6f7469666963616369c3b36e2e202056656e6369646f2065736520706c617a6f2c202073652067656e65726172c3a120656c207265636172676f207265737065637469766f2063616c63756c61646f20656e20626173652061206c61205461736120416374697661205265666572656e6369616c20706172612039302064c3ad61732065737461626c656369646120706f7220656c2042616e636f2043656e7472616c2064656c2045637561646f72206465736465206c6120666563686120646520737520657869676962696c69646164206861737461206c6120646520737520657874656e7369c3b36e2e20456e206361736f206465206e6f206573746172206465206163756572646f2c20706f6472c3a120696d7075676e61726c6f2064656e74726f206465206c6f7320332064c3ad61732068c3a162696c657320706f73746572696f7265732061207375206e6f7469666963616369c3b36e2e20456e206361736f20646520696e63756d706c696d69656e746f2c20736520646172c3a120696e6963696f20616c2070726f636564696d69656e746f20646520656a6563756369c3b36e20636f6163746976612e22202b225c6e222b0d0a2824467b434f4449474f5f43414d4152417d203d3d206e756c6c203f2022223a20223c7374796c65206973426f6c643d2774727565273e22202b202231302e2043c3934449474f2044452043c3814d4152413a2022202b20223c2f7374796c653e22202b2024467b434f4449474f5f43414d4152417d2b20225c6e2046454348412043414c494252414349c3934e3a222b2024467b46454348415f43414c4942524143494f4e7d2b22205c6e2056454c4f4349444144205045524d49544944413a20222b2024467b56454c4f43494441445f5045524d49544944417d202b22206b6d2f68205c6e2056454c4f43494441442047454e45524120494e465241434349c3934e3a222b2024467b56454c4f43494441445f494e4652414343494f4e7d2b22206b6d2f68205c6e22292b0d0a223c7374796c65206973426f6c643d2774727565273e22202b20224147454e544520434956494c204445205452c3814e5349544f2022202b20223c2f7374796c653e5c6e222b0d0a22204e4f4d4252453a2022202b202824467b4e4f4d4252455f4147454e54457d203d3d206e756c6c203f2022223a24467b4e4f4d4252455f4147454e54457d29202b20225c6e222b0d0a222043c3934449474f3a20222b2824467b434f4449474f5f4147454e54457d203d3d206e756c6c203f202222203a2024467b434f4449474f5f4147454e54457d292b22554e49464f524d41444f204e4f2e2022202b202824467b504c4143415f4147454e54457d203d3d206e756c6c203f2022223a24467b504c4143415f4147454e54457d292b225c6e225d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a090909093c2f746578744669656c643e0d0a090909093c696d6167652069734c617a793d227472756522206f6e4572726f72547970653d22426c616e6b223e0d0a09090909093c7265706f7274456c656d656e742073747265746368547970653d2252656c6174697665546f42616e644865696768742220783d2231322220793d22333435222077696474683d2231343822206865696768743d2233372220757569643d2237343431326133652d646630342d346562332d383435612d376137636631353638646665222f3e0d0a09090909093c696d61676545787072657373696f6e3e3c215b43444154415b24467b4649524d415f4147454e54457d5d5d3e3c2f696d61676545787072657373696f6e3e0d0a090909093c2f696d6167653e0d0a090909093c746578744669656c643e0d0a09090909093c7265706f7274456c656d656e7420783d2231312220793d22333832222077696474683d2235323522206865696768743d2232302220757569643d2232366137343330612d663737382d346330652d383062622d626336373733653531333330222f3e0d0a09090909093c74657874456c656d656e743e0d0a0909090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d223922206973426f6c643d2274727565222f3e0d0a09090909093c2f74657874456c656d656e743e0d0a09090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b224649524d41204147454e54452044495245434349c3934e20444520434f4e54524f4c204445205452c3814e5349544f225d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a090909093c2f746578744669656c643e0d0a090909093c746578744669656c643e0d0a09090909093c7265706f7274456c656d656e7420783d2231322220793d22343032222077696474683d2235323422206865696768743d2232342220757569643d2238346138643030332d613163352d343836332d623836302d356263373233633762623131222f3e0d0a09090909093c74657874456c656d656e743e0d0a0909090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d2239222f3e0d0a09090909093c2f74657874456c656d656e743e0d0a09090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b2241562e204341524c4f53204a554c494f2041524f53454d454e412c2047554159415155494c20e2809320475541594153204c4f43414c2036352054454c3a2028353933292028342920333930323239302047554159415155494c202d2045435541444f52225d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a090909093c2f746578744669656c643e0d0a090909093c746578744669656c643e0d0a09090909093c7265706f7274456c656d656e7420783d2231312220793d22343236222077696474683d2235323522206865696768743d2238372220757569643d2266633963363039342d326239642d343531612d613563642d326565373863323936336333222f3e0d0a09090909093c74657874456c656d656e743e0d0a0909090909093c666f6e7420666f6e744e616d653d22417269616c222073697a653d2239222f3e0d0a09090909093c2f74657874456c656d656e743e0d0a09090909093c746578744669656c6445787072657373696f6e3e3c215b43444154415b22454c205041474f204445204c41204d554c544120504f5220434f4e434550544f20222b2024467b4445534352495043494f4e5f494e4652414343494f4e7d2b2022504f5220454c2056414c4f522044452024222b24467b56414c4f525f4d554c54417d2b222c204445424552c3812045464543545541524c4f2044454e54524f204445204c4f532031302044c38d415320434f4e5441444f53204445534445204c412046454348412044452045535441204e4f5449464943414349c3934e2e20454c20494e46524143544f522044452053455220454c204341534f20504f4452c3812044454e54524f2044454c2054c389524d494e4f20444520332044c38d41532048c38142494c455320494d5055474e4152204553544120434954414349c3934e204445205452c3814e5349544f20414e5445204c41204155544f524944414420434f4d504554454e54452e225d5d3e3c2f746578744669656c6445787072657373696f6e3e0d0a090909093c2f746578744669656c643e0d0a0909093c2f6672616d653e0d0a09093c2f62616e643e0d0a093c2f64657461696c3e0d0a3c2f6a61737065725265706f72743e0d0a
where id_xml_plantilla=2229