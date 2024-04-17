SELECT p.numero_proceso,
       p.fecha_inicio
FROM   proceso p
WHERE  p.id_proceso = :idProceso 