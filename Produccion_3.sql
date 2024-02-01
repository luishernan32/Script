select v.* from documentos..variable_plantilla vp
join documentos..variable v on v.id_variable=vp.id_variable
where vp.id_plantilla=2733