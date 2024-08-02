drop schema if exists educamesta;
create schema if not exists EducamEsta;

use EducamEsta;


-- ====================================================================================================== funciones 
drop function if exists obtener_ID_Perfil;

DELIMITER //
create function obtener_ID_Perfil(numControl varchar(20))
returns int
deterministic
begin
    return (select id_Perfil from educamesta.perfil p where p.numeroControl=numControl);
end //

DELIMITER ;
/*=========================================================================================================tablas*/
create table nivelAcademico(
	idNivel int primary key auto_increment,
    nivel varchar(15)
);

insert into nivelAcademico(nivel) values('BACHILLERATO'),('UNIVERSIDAD');

/*
create table tipoEscuela(
	id_Tipo_Escuela int primary key,
    nombre varchar(30)
);

insert into tipoEscuela values
(1,'DEGETI'),
(2,'CETIS'),
(3,'CONALEP'),
(4,'OTRO');
*/;
create table escuela(
	id_escuela int primary key,
    nombre_escuela varchar(100)
	/*
    ,tipoEscuela int ,
    foreign key(tipoEscuela) references tipoEscuela(id_Tipo_Escuela)
    */
);

#insert into escuela values(1,'JOSEFA ORTIZ DE DOMINGUEZ',2);

create table departamento(
	idDepartamento int primary key auto_increment,
    nombre varchar(50)
);

insert into departamento(nombre) values
('depa 1'),('depa2');

create table perfil(
    numeroControl varchar(20) primary key,
    correoInstitucional varchar(150) unique,
    id_perfil int unique auto_increment,
    telefono varchar(10) unique
    
    #,nickName varchar(10) unique
);

insert into perfil(correoInstitucional,telefono,numeroControl) values
('22301061550038@cetis155.edu.mx','4491261629','22301061550038')
,('22301061550037@cetis155.edu.mx','4491121629','22301061550037')
,('22301061550036@cetis155.edu.mx','4491261822','22301061550036')
,('22301061550035@cetis155.edu.mx','4491236713','22301061550035')
;

create table alumno(
	idPerfil int primary key,
    foreign key (idPerfil) references perfil(id_perfil),
    nickName varchar(30) unique,
    grado int,
    grupo varchar(1)
    #escuela?
);

insert into alumno values
((select obtener_ID_Perfil('22301061550035')),'paquitoelpro87',3,'A'),
((select obtener_ID_Perfil('22301061550038')),'xxTentationXx',1,'B');

create table tutor(
	idPerfil int primary key ,
    foreign key (idPerfil) references perfil(id_perfil),
    nombres varchar(30),
    apellidos varchar(30),
    numTarjetaBienestar varchar(16) unique
    #escuela?
);

insert into tutor values
((select obtener_ID_Perfil('22301061550036')),'Nombre1 Nombre2','Apellido1 Apellido2','1231123133987888');

create table administrador(
	idPerfil int primary key ,
    foreign key (idPerfil) references perfil(id_perfil),
    departamento int,
    nombres varchar(30),
    apellidos varchar(30),
    
    claveAcceso varchar(10),
    #para acceder hay que ingresar numero de control, validando con la clave de acceso
    
    foreign key (departamento) references departamento(idDepartamento)
);

insert into administrador values ((select obtener_ID_Perfil('22301061550037')),1,'Nombre1 Nombre2','Apellido1 Apellido2','Acceso123');

create table asignatura (
	idAsignatura int primary key auto_increment,
    nombre varchar(20),
    descripcion varchar(200)
);
insert into asignatura(nombre,descripcion) values
('artimetica','Asignatura de las matematicas basada en las operaciones basicas como suma, resta, multiplicacion y division'),
('geometria','Asignatura de las matematicas centrada en el estudio de las figuras geometricas'),
('Calculo Diferencial','Ni idea');

create table tutorias(
	idTutoria int primary key auto_increment,
	enlaceVideollamada varchar(30),
    horario varchar(150),
    idTutor int,
    idAsignatura int,
    foreign key (idTutor) references perfil(id_perfil),
    foreign key (idAsignatura) references asignatura(idAsignatura)
);

insert into tutorias(enlaceVideollamada,horario,idTutor,idAsignatura) values
('https://zoom.edoaspk.com','jueves y sabado de 7-8 pm',(select obtener_ID_Perfil('22301061550036')),2);

create table tutoria_has_alumno(
	idRegistro int primary key auto_increment,
    idTutoria int,
    idAlumno int,
    fechaInicio date,
    fechaFin date,
    foreign key(idTutoria) references tutorias(idTutoria),
    foreign key(idAlumno) references perfil(id_perfil)
);

create table tutoria_has_mensajes(
	idMensaje int primary key auto_increment,
    idTutoria int,
    idPerfil int,
    fechaEnvio date,
    horaEnvio time,
    mensaje varchar(150),
    
    foreign key(idTutoria) references tutorias(idTutoria),
    foreign key(idPerfil) references perfil(id_perfil)
);

#insert into tutoria_has_mensajes(idTutoria,idPerfil,fechaEnvio,horaEnvio,mensaje) values(1,'hola que hacen');

create table documentos(
	#idea : guardar los documentos en drive y acceder por la url
	idDocumento int primary key auto_increment,
    url varchar(100)
);

create table tutorias_has_documentos(
	idRegistro int primary key auto_increment,
    idTutoria int,
    idDocumento int,
    foreign key(idTutoria) references tutorias(idTutoria),
    foreign key(idDocumento) references documentos(idDocumento)
);

