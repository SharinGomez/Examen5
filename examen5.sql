

/* CREACION TABLA SOCIO
   Se registra una única dirección y teléfono para cada socio.*/

create table socio (
	RUT varchar(25),
	nombre_socio varchar(25),
	apellido_socio varchar(25),
	direccion varchar(25),
	telefono varchar(25),
	primary key (RUT)
);

select * from socio;

/* CREACION TABLA LIBRO
 * 
 * El ISBN (International Standard Book Number), 
 * es un número de 13 cifras que identifica de una manera única a cada 
 * libro o producto de editorial publicado. */

create table libro (
	ISBN varchar(15),
	titulo varchar(40),
	paginas int,
	codigo_autor int,
	nombre_autor varchar(25),
	apellido_autor varchar(25),
	fecha_nacimiento date,
	fecha_muerte date,n
	tipo_autor varchar(10),
	dias_prestamo int,
	primary key (codigo_autor)
);

select * from libro;
delete  from libro;
drop table libro cascade;



create table prestamo (
	fecha_prestamo date,
	fecha_devolucion_real date,
	fecha_devolucion_esperada date,
	rut_socio varchar(25) references socio(RUT),
	nombre_socio varchar (20),
	codigo_autor int references libro (codigo_autor),
	titulo varchar (40)
,	primary key (rut_socio, codigo_autor)
);

select * from prestamo;c
drop table prestamo cascade;



-- insertando registro de tabla socio

insert into socio (rut, nombre_socio, apellido_socio, direccion, telefono) 
values
('17222435-1', 'PEDRO', 'CASTRO', 'LOS AROMOS 1, CALDERA', '933445566'),
('20514234-2', 'ANDRES', 'SOLIS', 'PUYEHUE 2, CALDERA', '988776655'),
('9365221-3', 'ELIZABETH', 'SUAREZ', 'LOS ALAMOS 3, CALDERA', '922556699'),
('16299876-4', 'MARIA ', 'CARMONA', 'LAS ANANUCAS 4, CALDERA','977445511'),
('11672986-5', 'ELIANA', 'ROJAS', 'ACASIAS 5, CALDERA', '966778811');

-- insertando registro libros

insert into libro (isbn, titulo, paginas, codigo_autor, nombre_autor,
apellido_autor, fecha_nacimiento, fecha_muerte, tipo_autor, dias_prestamo) 
values 
('000-222222-001','CUENTOS DE CIENCIA FICCION', 214, 3, 'PEDRO', 'CASTRO', '01-01-1949', '01-01-2020', 'PRINCIPAL', 5),
('444-333333-002','CUENTOS DE TERROR', 510, 4, 'ANDRES', 'SOLIS', '01-01-1972', NULL, 'COAUTOR', 5),
('888-555555-003', 'GRANDES POETAS CHILENOS', 357, 1, 'ELIZABETH', 'SUAREZ','01-01-1968', null, 'PRINCIPAL', 10),
('777-444444-004', 'LEYENDAS NACIONALES', 511, 2, 'MARIA','CARMONA','01-01-1950', '01-01-2012', 'PRINCIPAL', 10),
('666-999999-005', 'MANUAL DE PROGRAMACION', 298, 5, 'ELIANA','ROJAS','01-01-1956', NULL, 'PRINCIPAL', 10);

select * from LIBRO;

--- REGISTRO DE HISTORIAL PRÉSTAMO

insert into prestamo values
('2020-01-10', '2020-01-18','2020-01-27' , '17222435-1', 'PEDRO CASTRO', 3, 'CUENTOS DE CIENCIA FICCION'),
('2020-01-17', '2020-01-25','2020-01-27' , '11672986-5', 'ELIANA ROJAS', 1, 'GRANDES POETAS CHILENOS'),
('2020-01-14', '2020-01-20','2020-02-05' , '16299876-4', 'MARIA CARMONA', 2, 'LEYENDAS NACIONALES'),
('2020-01-20', '2020-01-28','2020-02-06' , '9365221-3', 'ELIZABETH SUAREZ', 5, 'MANUAL DE PROGRAMACION' ),
('2020-01-26', '2020-02-30','2020-02-03' , '20514234-2', 'ANDRES SOLIS', 3, 'CUENTOS DE CIENCIA FICCION'),
('2020-01-23', '2020-02-26','2020-02-14' , '9365221-3', 'ELIZABETH SUAREZ', 5, 'MANUAL DE PROGRAMACION' ),
('2020-01-18', '2020-02-24','2020-02-07' , '11672986-5', 'ELIANA ROJAS', 1,'GRANDES POETAS CHILENOS');

select * from PRESTAMO;



-- MOSTRAR TODOS LOS LIBROS QUE SEAN MENOS DE 300 PAGINAS
select * from LIBRO where PAGINAS < 300;


-- MOSTRAR TODOS LOS AUTORES NACIDOS DESPUES DE 01-01-1970
select NOMBRE_AUTOR, APELLIDO_AUTOR from LIBRO where FECHA_NACIMIENTO > '01-01-1970';


-- MOSTRAR LIBRO MÁS SOLICITADO
-- opcion 1
select TITULO, 
(select COUNT(TITULO)>1 as MAS_SOLICITADO)
from PRESTAMO 
group by TITULO
order by MAS_SOLICITADO desc;

-- opcion 2
select TITULO, 
(select COUNT(TITULO) as MAS_SOLICITADO)
from PRESTAMO 
group by TITULO
order by MAS_SOLICITADO desc;



-- MOSTRAR MORA DE SOCIO
select NOMBRE_SOCIO,
(select fecha_devolucion_real - Fecha_devolucion_esperada)>0 as MOROSO,
(select fecha_devolucion_real- Fecha_devolucion_esperada)*100 as MULTA,
(select fecha_devolucion_real- Fecha_devolucion_esperada) as DIAS
	from PRESTAMO
	where fecha_devolucion_real - Fecha_devolucion_esperada > 0;
	
select * from PRESTAMO;







