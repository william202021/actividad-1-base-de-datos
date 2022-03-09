CREATE TABLE COLEGIO ( 
ruc character varying(9) NOT NULL, 
nombre character varying(50) NOT NULL, 
direccion character varying(50) NOT NULL, 
CONSTRAINT cp_colegio_carlosarango PRIMARY KEY (ruc) 
 
);

CREATE TABLE CIUDAD_NACIMIENTO(
id_ciudad SERIAL NOT NULL,
nombre character varying(50) NOT NULL,
CONSTRAINT cp_id_ciudad PRIMARY KEY(id_ciudad)
);

CREATE TABLE CARGO(
id_cargo serial NOT NULL,
nombre character varying(20) NOT NULL,
salario integer NOT NULL,
CONSTRAINT cp_id_cargo PRIMARY KEY(id_cargo)
);

CREATE TABLE SEDE( 
id_sede serial NOT NULL, 
nombre character varying(50) NOT NULL, 
ruc character varying(9) NOT NULL, 
CONSTRAINT cp_sede PRIMARY KEY (id_sede), 
CONSTRAINT caj_colegio_sede FOREIGN KEY (ruc) 
REFERENCES COLEGIO(ruc) 
ON DELETE RESTRICT 
ON UPDATE CASCADE 
);

CREATE TABLE PERIODO ( 
id_periodo serial NOT NULL, 
nombre character varying(50) NOT NULL, 
ruc character varying(9) NOT NULL, 
CONSTRAINT cp_periodo PRIMARY KEY (id_periodo), 
CONSTRAINT caj_colegio_periodo FOREIGN KEY (ruc) 
REFERENCES COLEGIO(ruc) 
ON DELETE RESTRICT 
ON UPDATE CASCADE 
 );


CREATE TABLE NIVEL( 
id_nivel serial NOT NULL, 
cano character varying(50) NOT NULL, 
nombre character varying(50) NOT NULL, 
id_sede integer NOT NULL, 
CONSTRAINT cp_nivel PRIMARY KEY (id_nivel), 
CONSTRAINT caj_sede FOREIGN KEY (id_sede) 
REFERENCES SEDE(id_sede) 
ON DELETE RESTRICT 
ON UPDATE CASCADE 
 
);

CREATE TABLE GRADO( 
 
id_grado serial NOT NULL, 
 
nombre character varying(50) NOT NULL, 
 
id_nivel integer NOT NULL, 
 
CONSTRAINT cp_grado PRIMARY KEY (id_grado), 
 
CONSTRAINT caj_nivel FOREIGN KEY (id_nivel) 
 
REFERENCES NIVEL(id_nivel) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE 
 
);


CREATE TABLE AREA( 
 
id_area serial NOT NULL, 
 
nombre character varying(50) NOT NULL, 
 
CONSTRAINT cp_area PRIMARY KEY (id_area) 
 
);

CREATE DOMAIN estado_profesor AS character varying(15) 
 
CHECK (VALUE IN ('retirado', 'activo', 'deshabilitado'));


CREATE TABLE PROFESOR( 
 
dni_profesor integer NOT NULL, 
 
nombre character varying(50) NOT NULL, 
 
ape_mat character varying(50) NOT NULL, 
 
ape_pat character varying(50) NOT NULL, 
 
id_cargo integer NOT NULL, 
 
sexo character varying(10) NOT NULL, 
 
id_ciudad integer NOT NULL, 
 
direccion character varying(50) NOT NULL, 
 
nivel_estudios character varying(15) NOT NULL, 
 
celular character varying(15) NOT NULL, 
 
email character varying(30) NOT NULL, 
 
fijo character varying(10) NOT NULL, 
 
estado estado_profesor NOT NULL, 
 
id_area integer NOT NULL, 
 
 
CONSTRAINT cp_profesor PRIMARY KEY (dni_profesor), 
 
CONSTRAINT caj_area FOREIGN KEY (id_area) 
 
REFERENCES AREA(id_area) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE,
 
CONSTRAINT caj_salario_prof FOREIGN KEY (id_cargo) 
 
REFERENCES CARGO(id_cargo) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE,

CONSTRAINT caj_lugar_prof FOREIGN KEY (id_ciudad) 
 
REFERENCES CIUDAD_NACIMIENTO(id_ciudad) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE
 
);

CREATE TABLE ASIGNATURA( 
 
id_asignatura serial NOT NULL, 
 
nombre character varying(50) NOT NULL, 
 
id_grado integer NOT NULL, 
 
id_area integer NOT NULL, 
 
dni_profesor integer NOT NULL, 
 
CONSTRAINT cp_asignatura PRIMARY KEY (id_asignatura), 
 
CONSTRAINT caj_grado FOREIGN KEY (id_grado) 
 
REFERENCES GRADO(id_grado) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE, 
 
CONSTRAINT caj_area FOREIGN KEY (id_area) 
 
REFERENCES AREA(id_area) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE, 
 
CONSTRAINT caj_profesor FOREIGN KEY (dni_profesor) 
 
REFERENCES PROFESOR(dni_profesor) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE 
 
);

CREATE TABLE SECCION( 
 
id_seccion serial NOT NULL, 
 
nombre character varying(50) NOT NULL, 
 
id_grado integer NOT NULL, 
 
CONSTRAINT cp_seccion PRIMARY KEY (id_seccion), 
 
CONSTRAINT caj_grado FOREIGN KEY (id_grado) 
 
REFERENCES GRADO(id_grado) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE 
 
  
 
);

CREATE DOMAIN estado_alumno AS character varying(15) 
 
CHECK (VALUE IN ('activo', 'suspendido', 'retirado', 'trasladado', 'graduado'));


CREATE TABLE ESTUDIANTE( 
 
dni_alumno integer NOT NULL, 
 
ape_mat character varying(50) NOT NULL, 
 
ape_pat character varying(50) NOT NULL,  
 
nombres character varying(50) NOT NULL, 
 
sexo character varying(10) NOT NULL, 
 
reso_direct character varying(20) NOT NULL, 
 
observacion character varying(100) NOT NULL, 
 
num_matri character varying(20) NOT NULL, 
 
lengua_mat character varying(30) NOT NULL, 
 
estado estado_alumno NOT NULL,  
 
fijo character varying(10) NOT NULL, 
 
id_ciudad integer NOT NULL, 
 
fecha_nac Date NOT NULL,  
 
sit_matric character varying(20) NOT NULL, 
 
celular character varying(20) NOT NULL, 
 
direccion character varying(50) NOT NULL, 
 
usuario character varying(10) NOT NULL, 
 
clave character varying(12) NOT NULL, 
 
CONSTRAINT cp_estudiante PRIMARY KEY (dni_alumno),
CONSTRAINT cp_lugar_estudiante FOREIGN KEY (id_ciudad)

REFERENCES CIUDAD_NACIMIENTO(id_ciudad) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE 
 
 
  
 
);


CREATE DOMAIN estado_matricula AS character varying(15) 
 
CHECK (VALUE IN ('activa', 'suspendida'));


CREATE TABLE MATRICULA( 
 
id_matricula serial NOT NULL, 
 
observacion character varying(100) NOT NULL, 
 
estado estado_matricula NOT NULL, 
 
nro_orden character varying(20) NOT NULL, 
 
turno character varying(10) NOT NULL, 
 
fecha_inicio date NOT NULL, 
 
fecha_final date NOT NULL, 
 
inst_proc character varying(20) NOT NULL, 
 
edad integer NOT NULL, 
 
id_seccion integer NOT NULL, 
 
dni_alumno integer NOT NULL, 
 
CONSTRAINT cp_matricula PRIMARY KEY (id_matricula), 
 
CONSTRAINT caj_seccion FOREIGN KEY (id_seccion) 
 
REFERENCES SECCION(id_seccion) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE, 
 
CONSTRAINT caj_estudiante FOREIGN KEY (dni_alumno) 
 
REFERENCES ESTUDIANTE(dni_alumno) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE 
 
  
 
);


CREATE TABLE NOTA( 
 
id_nota serial NOT NULL, 
 
fecha Date NOT NULL, 
 
nota integer NOT NULL, 
 
id_periodo integer NOT NULL, 
 
dni_profesor integer NOT NULL, 
 
dni_alumno integer NOT NULL, 
 
id_asignatura integer NOT NULL, 
 
  
 
CONSTRAINT cp_nota PRIMARY KEY(id_nota), 
 
CONSTRAINT caj_periodo FOREIGN KEY(id_periodo) 
 
REFERENCES PERIODO(id_periodo) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE, 
 
CONSTRAINT caj_dni_profesor FOREIGN KEY(dni_profesor) 
 
REFERENCES PROFESOR(dni_profesor) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE, 
 
CONSTRAINT caj_dni_alumno FOREIGN KEY(dni_alumno) 
 
REFERENCES ESTUDIANTE(dni_alumno) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE, 
 
CONSTRAINT caj_id_asignatura FOREIGN KEY(id_asignatura) 
 
REFERENCES ASIGNATURA(id_asignatura) 
 
ON DELETE RESTRICT 
 
ON UPDATE CASCADE 
 
 
 
);


CREATE TABLE PARIENTE( 
 
dni_pariente integer NOT NULL, 
 
ocupacion character varying(50) NOT NULL, 
 
ape_pat character varying(50) NOT NULL, 
 
ape_mat character varying(50) NOT NULL, 
 
nombres character varying(50) NOT NULL, 
 
tipo_pariente character varying(15) NOT NULL, 
 
escolaridad character varying(15) NOT NULL, 
 
vive_con character varying(50) NOT NULL, 
 
fecha_nac Date NOT NULL, 
 
celular character varying(10) NOT NULL, 
 
fijo character varying(10) NOT NULL, 
 
usuario character varying(10) NOT NULL, 
 
clave character varying(10) NOT NULL, 
 
CONSTRAINT cp_dni_pariente PRIMARY KEY(dni_pariente) 
 
  
 
);


CREATE TABLE DIRECTIVO(
id_directivo SERIAL NOT NULL,
Identificacion character varying(12) NOT NULL,
nombres character varying(50) NOT NULL,
ape_mat character varying(50) NOT NULL,
ape_pat character varying(50) NOT NULL,
direccion character varying(50) NOT NULL,
fecha_nac Date NOT NULL,
id_ciudad integer NOT NULL,
estado estado_profesor NOT NULL, 
sexo character varying(10) NOT NULL,
usuario character varying(10) NOT NULL,
clave character varying(12) NOT NULL, 
id_sede integer NOT NULL,
id_cargo integer NOT NULL,
CONSTRAINT cp_id_directivo PRIMARY KEY(id_directivo),
CONSTRAINT caj_id_ciudad FOREIGN KEY(id_ciudad)
REFERENCES CIUDAD_NACIMIENTO(id_ciudad)
ON DELETE RESTRICT
ON UPDATE CASCADE,
CONSTRAINT caj_id_sede FOREIGN KEY(id_sede)
REFERENCES SEDE(id_sede)
ON DELETE RESTRICT
ON UPDATE CASCADE,
CONSTRAINT caj_id_cargo FOREIGN KEY(id_cargo)
REFERENCES CARGO(id_cargo)
ON DELETE RESTRICT
ON UPDATE CASCADE
 
);

CREATE TABLE AULA(
id_aula SERIAL NOT NULL,
nombre character varying(50) NOT NULL,
capacidad integer NOT NULL,
CONSTRAINT cp_id_aula PRIMARY KEY(id_aula)
 
);


CREATE DOMAIN estado_acudiente AS character varying(15)  
 
CHECK (VALUE IN ('Si', 'No')); 
 
 
CREATE TABLE RECONOCE( 
 
id_matricula integer NOT NULL,  
 
dni_pariente integer NOT NULL,  
 
acudiente estado_acudiente NOT NULL, 
 
CONSTRAINT cp_id_matricula PRIMARY KEY(id_matricula, dni_pariente), 
 
CONSTRAINT caj_id_matricula FOREIGN KEY(id_matricula)

REFERENCES MATRICULA(id_matricula)
ON DELETE RESTRICT
ON UPDATE CASCADE,

CONSTRAINT caj_dni_pariente FOREIGN KEY(dni_pariente)
REFERENCES PARIENTE(dni_pariente)
ON DELETE RESTRICT
ON UPDATE CASCADE
 
);


CREATE TABLE IMPARTE (
dni_profesor integer NOT NULL,
id_asignatura integer NOT NULL,
id_seccion integer NOT NULL,
CONSTRAINT cp_id_combinado PRIMARY KEY(dni_profesor, id_asignatura, id_seccion),
CONSTRAINT caj_imparte FOREIGN KEY(dni_profesor)
REFERENCES PROFESOR(dni_profesor)
ON DELETE RESTRICT
ON UPDATE CASCADE,
CONSTRAINT caj_imparte_asignatura FOREIGN KEY(id_asignatura)
REFERENCES ASIGNATURA(id_asignatura)
ON DELETE RESTRICT
ON UPDATE CASCADE,
CONSTRAINT caj_imparte_seccion FOREIGN KEY(id_seccion)	
REFERENCES SECCION(id_seccion)
ON DELETE RESTRICT
ON UPDATE CASCADE
 
);



insert into cargo (id_cargo, nombre, salario) VALUES (1 , 'PROFESOR_1', 2500000) 

 insert into cargo (id_cargo, nombre, salario) VALUES (2 , 'PROFESOR_2', 3000000) 

 insert into cargo (id_cargo, nombre, salario) VALUES (3 , 'PROFESOR_3', 4000000) 

 insert into cargo (id_cargo, nombre, salario) VALUES (4 , 'directivo_1', 4500000) 

 insert into cargo (id_cargo, nombre, salario) VALUES (5 , 'directivo_2', 5500000) 

 

insert into aula (id_aula, nombre, capacidad) VALUES (1 , 'AULA1', 30) 

insert into aula (id_aula, nombre, capacidad) VALUES (2 , 'AULA2', 20) 

insert into aula (id_aula, nombre, capacidad) VALUES (3 , 'AULA3', 19) 

insert into aula (id_aula, nombre, capacidad) VALUES (4 , 'AULA4', 28) 

insert into aula (id_aula, nombre, capacidad) VALUES (5 , 'AULA5', 25) 

 

insert into area (id_area, nombre) VALUES (1 , 'HUMANIDADES') 

insert into area (id_area, nombre) VALUES (2, 'LENGUAS EXTRANJERAS') 

insert into area (id_area, nombre) VALUES (3, 'MATEMATICAS') 

insert into area (id_area, nombre) VALUES (4, 'INFORMATICA') 

insert into area (id_area, nombre) VALUES (5, 'ETICA Y VALORES') 

 

insert into CIUDAD_NACIMIENTO (id_ciudad, nombre) VALUES (1 , 'BOGOTA') 

insert into CIUDAD_NACIMIENTO (id_ciudad, nombre) VALUES (2 , 'MEDELLIN') 

insert into CIUDAD_NACIMIENTO (id_ciudad, nombre) VALUES (3 , 'CALI') 

insert into CIUDAD_NACIMIENTO (id_ciudad, nombre) VALUES (4 , 'CARTAGENA') 

insert into CIUDAD_NACIMIENTO (id_ciudad, nombre) VALUES (5 , 'SANTA MARTA') 

 

insert into COLEGIO (ruc, nombre, direccion) VALUES (123456789 , 'CARLOS ARANGO VELEZ', 'CRA 21 No 38-50') 

 

insert into SEDE (id_sede, nombre, ruc) VALUES (1 , 'CARLOS ARANGO VELEZ SEDE PRINCIPAL', '123456789') 

 

insert into NIVEL (id_nivel, cano, nombre, id_sede) VALUES (1 , 'CANO', 'PRIMARIA', 1) 

insert into NIVEL (id_nivel, cano, nombre, id_sede) VALUES (2 , 'CANO', 'SECUNDARIA', 1) 

 

 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (1 , 'PREESCOLAR', 1) 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (2 , 'PRIMERO', 1) 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (3 , 'SEGUNDO', 1) 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (4 , 'TERCERO', 1) 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (5 , 'CUARTO', 1) 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (6 , 'QUINTO', 1) 

 

 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (7 , 'SEXTO', 2) 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (8 , 'SEPTIMO', 2) 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (9 , 'OCTAVO', 2) 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (10 , 'NOVENO', 2) 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (11 , 'DECIMO', 2) 

insert into GRADO (id_grado,nombre, id_nivel) VALUES (12 , 'ONCE', 2) 

 

 

 

insert into DIRECTIVO (id_directivo,nombres, ape_mat, direccion, fecha_nac, id_ciudad, estado, sexo, usuario, clave, id_sede, id_cargo, identificacion, ape_pat)  

VALUES (1 , 'CARLOS', 'RODRIGUEZ', 'CRA 80 NO 29-52', '1980/02/22', 1, 'activo', 'M', 'CRODRIGUEZ', 'XXXXX', 1, 4, '102548963', 'LIZARAZO' ) 

  

insert into DIRECTIVO (id_directivo,nombres, ape_mat, direccion, fecha_nac, id_ciudad, estado, sexo, usuario, clave, id_sede, id_cargo, identificacion, ape_pat)  

VALUES (2 , 'MIGUEL', 'SALAMANCA', 'CRA 85 NO 89-20', '1978/07/28', 1, 'activo', 'M', 'MSALAMANCA', 'XXXXX', 1, 4, '25879912', 'GIRALDO' ) 

  

insert into DIRECTIVO (id_directivo,nombres, ape_mat, direccion, fecha_nac, id_ciudad, estado, sexo, usuario, clave, id_sede, id_cargo, identificacion, ape_pat)  

VALUES (3 , 'CARMENZA', 'ESTRADA', 'CRA 25 NO 119-55', '1998/08/31', 1, 'activo', 'F', 'CESTRADA', 'XXXXX', 1, 5, '8596723', 'PARDO' ) 

  

insert into DIRECTIVO (id_directivo,nombres, ape_mat, direccion, fecha_nac, id_ciudad, estado, sexo, usuario, clave, id_sede, id_cargo, identificacion, ape_pat)  

VALUES (4 , 'ALEJANDRO', 'FORERO', 'CRA 55 NO 48-20', '1958/12/31', 1, 'activo', 'M', 'AFORERO', 'XXXXX', 1, 5, '89753065', 'TAPIA' ) 

  

insert into DIRECTIVO (id_directivo,nombres, ape_mat, direccion, fecha_nac, id_ciudad, estado, sexo, usuario, clave, id_sede, id_cargo, identificacion, ape_pat)  

VALUES (5 , 'ALEJANDRA', 'MARTINEZ', 'CRA 25 NO 18-15', '1979/01/15', 1, 'activo', 'F', 'AMARTINEZ', 'XXXXX', 1, 4, '85203945', 'HERNANDEZ' ) 

 

 

 

insert into PROFESOR (dni_profesor, nombre, ape_mat, ape_pat, id_cargo, sexo, id_ciudad, direccion, nivel_estudios, celular, email, fijo, estado, id_area)  

VALUES (10357894 , 'ARTURO', 'ASCENCIO', 'RODRIGUEZ', 1, 'M', 1, 'CRA 85-98-25', 'POSTGRADO', '30578948', 'aascencio@educacion.com', '7568941', 'activo', 1)  

  

  

insert into PROFESOR (dni_profesor, nombre, ape_mat, ape_pat, id_cargo, sexo, id_ciudad, direccion, nivel_estudios, celular, email, fijo, estado, id_area)  

VALUES (2598744 , '	CAMILA', 'GARCIA', 'CASTELLANOS', 2, 'F', 2, 'CRA 95-97-35', 'PROFESIONAL', '3158967845', 'cgarcia@educacion.com', '6558975', 'activo', 2)  

  

insert into PROFESOR (dni_profesor, nombre, ape_mat, ape_pat, id_cargo, sexo, id_ciudad, direccion, nivel_estudios, celular, email, fijo, estado, id_area)  

VALUES (8597485 , 'NORBERTO', 'RODRIGUEZ', 'LIZARAZO', 3, 'M', 3, 'CRA 105-107-45', 'POSTGRADO', '305897456', 'nrodriguez@educacion.com', '6558975', 'activo', 3)  

  

insert into PROFESOR (dni_profesor, nombre, ape_mat, ape_pat, id_cargo, sexo, id_ciudad, direccion, nivel_estudios, celular, email, fijo, estado, id_area)  

VALUES (7954865 , '	ANTONIO', 'MELO', 'CASAS', 1, 'M', 4, 'CRA 150-20-95', 'PROFESIONAL', '3054789650', 'amelo@educacion.com', '7808595', 'activo', 4)  

  

  

insert into PROFESOR (dni_profesor, nombre, ape_mat, ape_pat, id_cargo, sexo, id_ciudad, direccion, nivel_estudios, celular, email, fijo, estado, id_area)  

VALUES (687894 , 'ROBERTA', 'CASTELBLANCO', 'MADERO', 2, 'F', 5, 'CRA 155-35-59', 'POSTGRADO', '3115478952', 'rcatelblanco@educacion.com', '2789966', 'activo', 5) 

 

 

 

insert into seccion (id_seccion, nombre, id_grado)  

values (1, '001', 1) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (2, '002', 1) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (3, '003', 1) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (4, '101', 2) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (5, '102', 2) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (6, '103', 2) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (7, '201', 3) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (8, '202', 3) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (9, '203', 3) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (10, '301', 4) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (11, '302', 4) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (12, '303', 4) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (13, '401', 5) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (14, '402', 5) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (15, '403', 5) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (16, '501', 6) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (17, '502', 6) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (18, '503', 6) 

 

 

insert into seccion (id_seccion, nombre, id_grado)  

values (19, '601', 7) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (20, '602', 7) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (21, '603', 7) 

  

  

insert into seccion (id_seccion, nombre, id_grado)  

values (22, '701', 8) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (23, '702', 8) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (24, '703', 8) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (25, '801', 9) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (26, '802', 9) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (27, '803', 9) 

  

  

insert into seccion (id_seccion, nombre, id_grado)  

values (28, '901', 10) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (29, '902', 10) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (30, '903', 10) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (31, '1001', 11) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (32, '1002', 11) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (33, '1003', 11) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (34, '1101', 12) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (35, '1102', 12) 

  

insert into seccion (id_seccion, nombre, id_grado)  

values (36, '1103', 12) 

 

 

 

 

 

insert into asignatura (id_asignatura, nombre, id_grado, id_area, dni_profesor)  

values (1, 'Matemáticas I', 1, 3, 10357894) 

  

insert into asignatura (id_asignatura, nombre, id_grado, id_area, dni_profesor)  

values (2, 'Ingles I', 1, 2, 2598744) 

  

insert into asignatura (id_asignatura, nombre, id_grado, id_area, dni_profesor)  

values (3, 'Ciencias Sociales I', 1, 1, 8597485) 

  

insert into asignatura (id_asignatura, nombre, id_grado, id_area, dni_profesor)  

values (4, 'Informatica I', 1, 4, 7954865) 

  

insert into asignatura (id_asignatura, nombre, id_grado, id_area, dni_profesor)  

values (5, 'Etica I', 1, 5, 687894) 

 

 

insert into estudiante(dni_alumno, ape_mat, ape_pat, nombres, sexo, reso_direct, observacion, num_matri, lengua_mat, estado, fijo, id_ciudad, fecha_nac, sit_matric, celular, direccion, usuario, clave) 

values (10354789, 'RODRIGUEZ', 'SALAMANCA', 'ANTONIO', 'M', 'RESPDIRECT', 'OK', 'MAT-123456', 'ESPANOL', 'activo', '3015478', 1, '2016/06/20', 'OK', '301547893', 'CRA 50 NO 87-20', '10354789', 'xxxx') 

  

insert into estudiante(dni_alumno, ape_mat, ape_pat, nombres, sexo, reso_direct, observacion, num_matri, lengua_mat, estado, fijo, id_ciudad, fecha_nac, sit_matric, celular, direccion, usuario, clave) 

values (10354788, 'CALVO', 'GRISALES', 'MIGUEL', 'M', 'RESPDIRECT', 'OK', 'MAT-123457', 'ESPANOL', 'activo', '5478951', 1, '2015/08/22', 'OK', '358945512', 'CRA 30 NO 97-50', '10354788', 'xxxx') 

  

  

insert into estudiante(dni_alumno, ape_mat, ape_pat, nombres, sexo, reso_direct, observacion, num_matri, lengua_mat, estado, fijo, id_ciudad, fecha_nac, sit_matric, celular, direccion, usuario, clave) 

values (10354548, 'GUTIERREZ', 'RODRIGUEZ', 'AMPARO', 'F', 'RESPDIRECT', 'OK', 'MAT-123988', 'ESPANOL', 'activo', '7989552', 1, '2015/12/25', 'OK', '359744529', 'CRA 20 NO 77-44', '10354548', 'xxxx') 

  

  

insert into estudiante(dni_alumno, ape_mat, ape_pat, nombres, sexo, reso_direct, observacion, num_matri, lengua_mat, estado, fijo, id_ciudad, fecha_nac, sit_matric, celular, direccion, usuario, clave) 

values (1035892, 'FORERO', 'RODRIGUEZ', 'EDILBERTO', 'M', 'RESPDIRECT', 'OK', 'MAT-1292565', 'ESPANOL', 'activo', '7985263', 1, '2016/12/31', 'OK', '312657', 'CRA 80 NO 27-84', '1035892', 'xxxx') 

  

  

insert into estudiante(dni_alumno, ape_mat, ape_pat, nombres, sexo, reso_direct, observacion, num_matri, lengua_mat, estado, fijo, id_ciudad, fecha_nac, sit_matric, celular, direccion, usuario, clave) 

values (2597889, 'MARTINEZ', 'RODRIGUEZ', 'CARLOS', 'M', 'RESPDIRECT', 'OK', 'MAT-12135', 'ESPANOL', 'activo', '798899', 1, '2016/11/29', 'OK', '312657', 'CRA 80 NO 27-84', '2597889', 'xxxx') 

  

  

insert into estudiante(dni_alumno, ape_mat, ape_pat, nombres, sexo, reso_direct, observacion, num_matri, lengua_mat, estado, fijo, id_ciudad, fecha_nac, sit_matric, celular, direccion, usuario, clave) 

values (5897445, 'ACEVEDO', 'SALAMANCA', 'MILENA', 'F', 'RESPDIRECT', 'OK', 'MAT-459879', 'ESPANOL', 'activo', '798899', 2, '2015/11/29', 'OK', '312657', 'CRA 80 NO 27-84', '5897445', 'xxxx') 

  

insert into estudiante(dni_alumno, ape_mat, ape_pat, nombres, sexo, reso_direct, observacion, num_matri, lengua_mat, estado, fijo, id_ciudad, fecha_nac, sit_matric, celular, direccion, usuario, clave) 

values (4897726, 'GARZON', 'PARDO', 'CLARA', 'F', 'RESPDIRECT', 'OK', 'MAT-13546', 'ESPANOL', 'activo', '798899', 2, '2017/02/25', 'OK', '312657', 'CRA 80 NO 27-84', '4897726', 'xxxx') 

  

  

insert into estudiante(dni_alumno, ape_mat, ape_pat, nombres, sexo, reso_direct, observacion, num_matri, lengua_mat, estado, fijo, id_ciudad, fecha_nac, sit_matric, celular, direccion, usuario, clave) 

values (2569897, 'GIRALDO', 'PATINO', 'CLEMENCIA', 'F', 'RESPDIRECT', 'OK', 'MAT-16567', 'ESPANOL', 'activo', '798899', 3, '2015/01/31', 'OK', '312657', 'CRA 80 NO 27-84', '2569897', 'xxxx') 

 

 

 

insert into matricula(id_matricula, observacion, estado, nro_orden, turno, fecha_inicio, fecha_final, inst_proc, edad, id_seccion, dni_alumno) 

values (1, 'ok', 'activa', '1', '1', '2022/02/01', '2022/11/30', 'inst', 6, 1, 10354789) 

  

insert into matricula(id_matricula, observacion, estado, nro_orden, turno, fecha_inicio, fecha_final, inst_proc, edad, id_seccion, dni_alumno) 

values (2, 'ok', 'activa', '1', '1', '2022/02/01', '2022/11/30', 'inst', 5, 2, 10354788) 

  

insert into matricula(id_matricula, observacion, estado, nro_orden, turno, fecha_inicio, fecha_final, inst_proc, edad, id_seccion, dni_alumno) 

values (3, 'ok', 'activa', '1', '1', '2022/02/01', '2022/11/30', 'inst', 5, 3, 10354548) 

  

insert into matricula(id_matricula, observacion, estado, nro_orden, turno, fecha_inicio, fecha_final, inst_proc, edad, id_seccion, dni_alumno) 

values (4, 'ok', 'activa', '1', '1', '2022/02/01', '2022/11/30', 'inst', 6, 1, 1035892) 

  

insert into matricula(id_matricula, observacion, estado, nro_orden, turno, fecha_inicio, fecha_final, inst_proc, edad, id_seccion, dni_alumno) 

values (5, 'ok', 'activa', '1', '1', '2022/02/01', '2022/11/30', 'inst', 5, 1, 2597889) 

  

insert into matricula(id_matricula, observacion, estado, nro_orden, turno, fecha_inicio, fecha_final, inst_proc, edad, id_seccion, dni_alumno) 

values (6, 'ok', 'activa', '1', '1', '2022/02/01', '2022/11/30', 'inst', 6, 2, 5897445) 

  

insert into matricula(id_matricula, observacion, estado, nro_orden, turno, fecha_inicio, fecha_final, inst_proc, edad, id_seccion, dni_alumno) 

values (7, 'ok', 'activa', '1', '1', '2022/02/01', '2022/11/30', 'inst', 5, 2, 4897726) 

  

  

insert into matricula(id_matricula, observacion, estado, nro_orden, turno, fecha_inicio, fecha_final, inst_proc, edad, id_seccion, dni_alumno) 

values (8, 'ok', 'activa', '1', '1', '2022/02/01', '2022/11/30', 'inst', 5, 3, 2569897) 

 

 

 

insert into imparte(dni_profesor, id_asignatura, id_seccion) 

values (10357894, 1, 1) 

  

insert into imparte(dni_profesor, id_asignatura, id_seccion) 

values (2598744, 2, 2) 

  

insert into imparte(dni_profesor, id_asignatura, id_seccion) 

values (8597485, 3, 3) 

  

insert into imparte(dni_profesor, id_asignatura, id_seccion) 

values (7954865, 4, 1) 

  

insert into imparte(dni_profesor, id_asignatura, id_seccion) 

values (687894, 5, 2) 

 

 

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (1, '2022/02/25', 8, 1, 10357894, 10354789, 1) 

  

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (2, '2022/02/25', 6, 1, 10357894, 1035892, 1) 

  

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (3, '2022/02/25', 9, 1, 10357894, 2597889, 1) 

  

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (4, '2022/02/25', 6, 1, 2598744, 10354788, 2) 

  

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (5, '2022/02/25', 7, 1, 2598744, 5897445, 2) 

  

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (6, '2022/02/25', 9, 1, 2598744, 4897726, 2) 

  

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (7, '2022/02/25', 9, 1, 8597485, 10354548, 3) 

  

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (8, '2022/02/25', 5, 1, 8597485, 2569897, 3) 

  

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (9, '2022/02/25', 6, 1, 7954865, 10354789, 4) 

  

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (10, '2022/02/25', 6, 1, 7954865, 1035892, 4) 

  

insert into nota(id_nota, fecha, nota, id_periodo, dni_profesor, dni_alumno, id_asignatura) 

values (11, '2022/02/25', 6, 1, 7954865, 2597889, 4) 

 

 

insert into pariente(dni_pariente, ocupacion, ape_pat, ape_mat, nombres, tipo_pariente, escolaridad, vive_con, fecha_nac, celular, fijo, usuario, clave) 

values(123587, 'Empleado', 'LOPEZ', 'FERREIRA', 'MATEO', 'PADRE', 'PRIMARIA', 'ESPOSA', '1985/02/25', '301547895', '7859632', '123587', 'XXXX') 

  

insert into pariente(dni_pariente, ocupacion, ape_pat, ape_mat, nombres, tipo_pariente, escolaridad, vive_con, fecha_nac, celular, fijo, usuario, clave) 

values(5897465, 'Empleado', 'GILBERTO', 'GAMARRA', 'EDWIN', 'HERMANO', 'SECUNDARIA', 'HERMANO', '1995/02/25', '301547895', '7859632', '5897465', 'XXXX') 

  

insert into pariente(dni_pariente, ocupacion, ape_pat, ape_mat, nombres, tipo_pariente, escolaridad, vive_con, fecha_nac, celular, fijo, usuario, clave) 

values(458795, 'Independiente', 'PARDO', 'FORERO', 'OSCAR', 'PADRE', 'UNIVERSITARIO', 'ESPOSA', '1995/02/25', '301547895', '7859632', '458795', 'XXXX') 

  

insert into pariente(dni_pariente, ocupacion, ape_pat, ape_mat, nombres, tipo_pariente, escolaridad, vive_con, fecha_nac, celular, fijo, usuario, clave) 

values(748963, 'Independiente', 'GARZON', 'NAVAS', 'WILLIAM', 'PADRE', 'PRIMARIA', 'ESPOSA', '1995/02/25', '301547895', '7859632', '748963', 'XXXX') 

  

insert into pariente(dni_pariente, ocupacion, ape_pat, ape_mat, nombres, tipo_pariente, escolaridad, vive_con, fecha_nac, celular, fijo, usuario, clave) 

values(895566, 'EMPLEADO', 'GARZON', 'MANRIQUE', 'AURA', 'MADRE', 'PRIMARIA', 'HIJOS', '1995/02/25', '301547895', '7859632', '895566', 'XXXX') 

  

insert into pariente(dni_pariente, ocupacion, ape_pat, ape_mat, nombres, tipo_pariente, escolaridad, vive_con, fecha_nac, celular, fijo, usuario, clave) 

values(2015487, 'EMPLEADO', 'PERDOMO', 'ORTUZ', 'CLEMENCIA', 'MADRE', 'PRIMARIA', 'HIJOS', '1995/02/25', '301547895', '7859632', '2015487', 'XXXX') 

  

  

insert into pariente(dni_pariente, ocupacion, ape_pat, ape_mat, nombres, tipo_pariente, escolaridad, vive_con, fecha_nac, celular, fijo, usuario, clave) 

values(1024896, 'EMPLEADO', 'NAVARRETE', 'ORTUZ', 'ANGELA', 'MADRE', 'UNIVERSITARIO', 'HIJOS', '1995/02/25', '301547895', '7859632', '1024896', 'XXXX') 

 

 

insert into reconoce(id_matricula, dni_pariente, acudiente) 

values (1, 123587, 'Si') 

  

insert into reconoce(id_matricula, dni_pariente, acudiente) 

values (2, 5897465, 'Si') 

  

insert into reconoce(id_matricula, dni_pariente, acudiente) 

values (3, 458795, 'Si') 

  

insert into reconoce(id_matricula, dni_pariente, acudiente) 

values (4, 748963, 'Si') 

  

insert into reconoce(id_matricula, dni_pariente, acudiente) 

values (5, 895566, 'Si') 

  

insert into reconoce(id_matricula, dni_pariente, acudiente) 

values (6, 2015487, 'Si') 

  

insert into reconoce(id_matricula, dni_pariente, acudiente) 

values (7, 1024896, 'Si') 

 