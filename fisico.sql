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
