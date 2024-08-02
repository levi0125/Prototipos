drop function if exists obtener_ID_Perfil;

DELIMITER //
create function obtener_ID_Perfil(numControl varchar(20))
returns int
deterministic
begin
    return (select id_Perfil from educamesta.perfil p where p.numeroControl=numControl);
end //
/*
create function sumar(a int, b int)
returns int
deterministic
begin
	return a+b;
end //

*/
