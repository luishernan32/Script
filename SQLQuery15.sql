 sb.append(" SELECT DISTINCT(fd) FROM FuncionarioDia fd");
        sb.append(" JOIN FETCH fd.funcionario f");
        sb.append(" WHERE fd.fecha = :fecha");
        params.put("fecha", fechaBusqueda);



SELECT DISTINCT(fd) FROM FuncionarioDia fd
JOIN fd.funcionario f
WHERE fd.fecha = 
     


select top 10 * from funcionario_dia where fecha ='2023-08-23' order by 1 desc

--------------------------------------------------------------------------------------------------------------------
-- insert manual faltaba un registro en funcionario_dia hacia falta el registro para la fecha del 23 "Produccion"
begin tran
insert into funcionario_dia (id_funcionario, fecha) values (24,'2023-08-23')

-------------------------------------------------------------------------------------------------------------------