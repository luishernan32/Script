SELECT SUBSTRING(valor, 1, CHARINDEX('DIRECTOR(A)', valor) + LEN('DIRECTOR(A)') - 1) AS valor_parametro_defecto
FROM (
SELECT valor_parametro_defecto AS valor
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436
) AS X





SELECT REPLACE(valor_parametro_defecto,'DIRECTOR(A)','DIRECTOR(A)\n') AS parte1,'parte2' as parte2, 'parte3' as parte3
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436







SELECT valor_parametro_defecto AS valor
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436




SELECT valor_parametro_defecto= SUBSTRING(valor_parametro_defecto, 1, CHARINDEX('DIRECTOR(A)', valor_parametro_defecto) + LEN('DIRECTOR(A)') - 1)
FROM (
SELECT valor_parametro_defecto 
        FROM   parametro(nolock)
        WHERE  codigo_parametro = 436
) AS valor_parametro_defecto

SELECT SUBSTRING('Hola Mundo', 1, 4) AS Resultado;