--
-- PostgreSQL database dump
--

-- Dumped from database version 17.7
-- Dumped by pg_dump version 17.0

-- Started on 2026-02-03 08:58:39

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: asistencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asistencia (
    id integer NOT NULL,
    id_seccion integer NOT NULL,
    id_estudiante integer NOT NULL,
    fecha date NOT NULL,
    presente integer NOT NULL
);


ALTER TABLE public.asistencia OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16392)
-- Name: asistencia_estudiantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asistencia_estudiantes (
    id integer NOT NULL,
    seccion_id integer NOT NULL,
    nombre_completo character varying(200),
    codigo character varying(50),
    orden integer,
    activo integer,
    fecha_registro timestamp without time zone
);


ALTER TABLE public.asistencia_estudiantes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16395)
-- Name: asistencia_horarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asistencia_horarios (
    id integer NOT NULL,
    seccion_id integer NOT NULL,
    dia_semana character varying(20)
);


ALTER TABLE public.asistencia_horarios OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16398)
-- Name: asistencia_registros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asistencia_registros (
    id integer NOT NULL,
    estudiante_id integer NOT NULL,
    semana_id integer NOT NULL,
    fecha_clase date NOT NULL,
    presente integer,
    observaciones text,
    fecha_registro timestamp without time zone,
    usuario_registro character varying(100),
    estado character varying(20)
);


ALTER TABLE public.asistencia_registros OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16401)
-- Name: asistencia_secciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asistencia_secciones (
    id integer NOT NULL,
    nombre character varying(100),
    descripcion character varying(255),
    orden integer,
    activo integer
);


ALTER TABLE public.asistencia_secciones OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16404)
-- Name: asistencia_semanas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asistencia_semanas (
    id integer NOT NULL,
    numero_semana integer NOT NULL,
    nombre character varying(50),
    fecha_inicio date,
    fecha_fin date,
    activa integer,
    fecha_creacion timestamp without time zone
);


ALTER TABLE public.asistencia_semanas OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16407)
-- Name: curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curso (
    id integer NOT NULL,
    nombre character varying(150),
    carrera character varying(10)
);


ALTER TABLE public.curso OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16410)
-- Name: curso_docente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curso_docente (
    id integer NOT NULL,
    id_curso integer NOT NULL,
    id_docente integer NOT NULL
);


ALTER TABLE public.curso_docente OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16413)
-- Name: grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupo (
    id integer NOT NULL,
    nombre character varying(100),
    carrera character varying(10),
    fecha_creacion timestamp without time zone
);


ALTER TABLE public.grupo OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16416)
-- Name: grupo_estudiante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupo_estudiante (
    id integer NOT NULL,
    id_grupo integer NOT NULL,
    id_usuario integer NOT NULL,
    id_seccion integer
);


ALTER TABLE public.grupo_estudiante OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16419)
-- Name: grupos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupos (
    id integer NOT NULL,
    nombre character varying(50),
    carrera character varying(10),
    numero_grupo integer NOT NULL,
    fecha_creacion timestamp without time zone
);


ALTER TABLE public.grupos OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16422)
-- Name: horario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.horario (
    id integer NOT NULL,
    id_curso_docente integer NOT NULL,
    dia character varying(9),
    hora_inicio time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL
);


ALTER TABLE public.horario OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16425)
-- Name: material_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material_curso (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    id_curso integer,
    id_seccion integer,
    titulo character varying(200),
    descripcion text,
    archivo character varying(255),
    tipo character varying(5),
    fecha_subida timestamp without time zone
);


ALTER TABLE public.material_curso OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16428)
-- Name: nota; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota (
    id integer NOT NULL,
    id_seccion integer NOT NULL,
    id_estudiante integer NOT NULL,
    nota1 numeric(5,2),
    nota2 numeric(5,2),
    nota3 numeric(5,2),
    nota_final numeric(5,2),
    promedio numeric(5,2)
);


ALTER TABLE public.nota OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16431)
-- Name: pagos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagos (
    id integer NOT NULL,
    id_preinscripcion integer NOT NULL,
    numero_cuota integer NOT NULL,
    monto numeric(10,2),
    metodo_pago character varying(50),
    referencia_pago character varying(100),
    comprobante_pago character varying(255),
    fecha_pago timestamp without time zone,
    registrado_por character varying(100),
    notas text
);


ALTER TABLE public.pagos OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16434)
-- Name: preinscripcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preinscripcion (
    id integer NOT NULL,
    fecha_registro timestamp without time zone,
    nombre character varying(100),
    apellido character varying(100),
    dni character varying(20),
    email character varying(100),
    direccion character varying(200),
    colegio character varying(150),
    nombre_apoderado character varying(100),
    apellido_apoderado character varying(100),
    dni_apoderado character varying(8),
    email_apoderado character varying(100),
    telefono_apoderado character varying(15),
    telefono2_apoderado character varying(15),
    metodo_pago character varying(13),
    modalidad_pago character varying(7),
    monto_total numeric(10,2),
    monto_pagado numeric(10,2),
    saldo_pendiente numeric(10,2),
    estado_pago character varying(9),
    fecha_limite_2da_cuota date,
    referencia_pago character varying(50),
    comprobante_pago character varying(255),
    boleta_sunat character varying(255),
    grado character varying(50),
    estado character varying(9),
    origen character varying(6),
    intentos integer NOT NULL,
    seccion_id integer,
    intereses character varying(255),
    escaneo_id integer
);


ALTER TABLE public.preinscripcion OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16437)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    id integer NOT NULL,
    nombre character varying(20)
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16440)
-- Name: seccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seccion (
    id integer NOT NULL,
    id_horario integer,
    nombre character varying(1),
    id_grupo integer NOT NULL
);


ALTER TABLE public.seccion OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16443)
-- Name: secciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.secciones (
    id integer NOT NULL,
    nombre character varying(50),
    grado_grupo character varying(20),
    capacidad_maxima integer,
    "año_academico" character varying(10),
    fecha_creacion timestamp without time zone
);


ALTER TABLE public.secciones OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16446)
-- Name: telefono; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefono (
    id integer NOT NULL,
    id_preinscripcion integer NOT NULL,
    numero character varying(15)
);


ALTER TABLE public.telefono OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16449)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    correo character varying(50),
    password character varying(100),
    nombre character varying(50),
    apellido character varying(50),
    carrera character varying(10),
    grupo character varying(5),
    id_rol integer NOT NULL,
    estado integer
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 4966 (class 0 OID 16389)
-- Dependencies: 217
-- Data for Name: asistencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asistencia (id, id_seccion, id_estudiante, fecha, presente) FROM stdin;
\.


--
-- TOC entry 4967 (class 0 OID 16392)
-- Dependencies: 218
-- Data for Name: asistencia_estudiantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asistencia_estudiantes (id, seccion_id, nombre_completo, codigo, orden, activo, fecha_registro) FROM stdin;
1	1	Zurita Cespedes AdriÃ¡n Leopoldo	\N	0	0	2026-01-05 03:57:58
2	1	Zurita Cespedes Daniel Eduardo	\N	0	0	2026-01-05 04:03:19
3	5	Alban Saavedra Luis Alessandro	\N	0	1	2026-01-06 03:21:37
4	5	Bárcena Herrera Valeria		0	1	2026-01-06 03:21:47
5	5	Barrios Gálvez Fabiana		0	1	2026-01-06 03:22:13
6	5	Ayosa Silupu Andre Atzel	\N	0	1	2026-01-06 03:22:15
7	5	Caceres Cordova Alonso	\N	0	1	2026-01-06 03:22:34
8	5	Chunga Távara Alberto Nicolás		0	1	2026-01-06 03:22:36
9	6	Cornejo Osorio Nicolás		0	1	2026-01-06 03:22:59
10	5	Calle Lezama Albert Estefano	\N	0	1	2026-01-06 03:23:00
11	6	Coveña Henckell Daniel	\N	0	1	2026-01-06 03:23:19
12	5	Chong Goytizolo Camila	\N	0	1	2026-01-06 03:23:21
13	6	Galecio Santos Eduardo Rafael	\N	0	0	2026-01-06 03:23:38
14	5	Chuquimarca Abadie Luis Gabriel	\N	0	1	2026-01-06 03:23:43
15	6	Gil Melendez Adriana Jazmin	\N	0	1	2026-01-06 03:23:55
16	6	Cruz Nole Alessandro		0	1	2026-01-06 03:24:13
17	5	Ginocchio Torres Olenka Jazmin		0	1	2026-01-06 03:24:19
18	6	Diaz Garcia Marco		0	1	2026-01-06 03:24:30
19	6	Lozada Gallo Alexa Azucena	\N	0	1	2026-01-06 03:24:49
20	6	Flores Alzamora Juan Pablo		0	1	2026-01-06 03:24:51
21	6	Mondragón Juarez Daniella Ivanna	\N	0	1	2026-01-06 03:25:10
22	5	Guerra Flores Letizia Isabel	\N	0	1	2026-01-06 03:25:14
23	5	Otero Chero Omar Junior		0	1	2026-01-06 03:25:24
24	5	Herrera Rambla Reyes Rafael	\N	0	1	2026-01-06 03:25:40
25	6	Palacios Tong Mateo Jaciel		0	1	2026-01-06 03:25:57
26	5	Hurtado Carrillo Naomi Brigitte	\N	0	1	2026-01-06 03:26:04
27	6	Ruiz Dioses Santiago Alonso	\N	0	1	2026-01-06 03:26:14
28	5	Izu Infante Angela Valentina		0	1	2026-01-06 03:26:30
29	5	Villacorta Mogollón Angel		0	1	2026-01-06 03:26:35
30	5	Vega Pacherres Karolay Guadalupe		0	1	2026-01-06 03:27:09
31	5	Jimenez Villigua Christopher Matias	\N	0	1	2026-01-06 03:27:15
32	5	Lama Seminario Jose Carlos	\N	0	1	2026-01-06 03:27:28
33	5	Vega Pacherres Yomira Guadalupe		0	1	2026-01-06 03:27:31
34	5	Yamunaque Yamunaque Jesús Fabian		0	1	2026-01-06 03:27:57
35	6	Litano Yahuana Luciana Valeria		0	1	2026-01-06 03:28:04
36	5	Zapata Zeta Luis Rodolfo		0	1	2026-01-06 03:28:18
37	6	Galecio Santos Eduardo Rafael	\N	0	1	2026-01-06 03:28:34
38	6	Llacsahuanga Lachira Carlos Eduardo		0	1	2026-01-06 03:28:37
39	6	Acosta García Deysi Miluska	\N	0	1	2026-01-06 03:28:53
40	5	Luque Fassio Juan Luis	\N	0	1	2026-01-06 03:28:54
41	5	Neira Chumacero Joaquin	\N	0	1	2026-01-06 03:29:10
42	6	Rodriguez Montero Hardy Nicolas	\N	0	1	2026-01-06 03:29:19
43	6	Neira Rosales Adriana		0	1	2026-01-06 03:29:27
44	6	Ojeda Medina Juan Diego		0	1	2026-01-06 03:30:03
45	5	Pacheco Cordova Carlos		0	1	2026-01-06 03:30:21
46	6	Echeandia Vega Ray Antonio	\N	0	1	2026-01-06 03:30:26
47	6	Pissani Quesñay Mariana		0	1	2026-01-06 03:30:37
48	6	García Yaipen Alexandra Vanesa	\N	0	1	2026-01-06 03:30:46
49	6	Ramirez Manzanares Mariano		0	1	2026-01-06 03:31:01
50	5	Guevara Chunga Alanna Sofia		0	1	2026-01-06 03:31:06
51	5	Ramirez Rivera Ivanna Valentina	\N	0	1	2026-01-06 03:31:14
52	6	Raymundo Zevallos Bruno Rolando	\N	0	1	2026-01-06 03:31:29
53	6	Requena Rivera Raul Alejandro		0	1	2026-01-06 03:31:39
54	6	Riofrio Carmen Miguel Horacio		0	1	2026-01-06 03:33:05
55	5	Roman Rojas Eiki Alexander		0	1	2026-01-06 03:34:31
56	5	Ruidias Navarro Andrea Isabel	\N	0	1	2026-01-06 03:34:52
57	6	Ruiz Rosillo Piero Rodrigo		0	1	2026-01-06 03:35:19
58	5	Saavedra Oliva Daniel Alonso	\N	0	1	2026-01-06 03:35:50
59	6	Saavedra Velasquez Mateo Gabriel		0	1	2026-01-06 03:36:05
60	6	Talledo Rodriguez Josemaria		0	1	2026-01-06 03:36:24
61	5	Ubillus Castillo Fernando Gabriel		0	1	2026-01-06 03:37:19
62	6	Yajahuanca Ticliahuanca Marianela		0	1	2026-01-06 03:37:37
63	1	Abad Farfan Maria Azucena	\N	0	1	2026-01-06 16:27:29
64	1	Abad Farfan Maria Alejandra	\N	0	1	2026-01-06 16:27:44
65	1	Abanto De la Cruz Braulio	\N	0	0	2026-01-06 16:28:01
66	1	Aguilar Zapata Angelo Grabriel	\N	0	1	2026-01-06 16:28:19
67	1	Barrientos Carrion Rosita	\N	0	0	2026-01-06 16:28:31
68	1	Cruz Nole Sayri Natalie	\N	0	1	2026-01-06 16:28:49
69	1	Diaz Salaverry Siu	\N	0	1	2026-01-06 16:29:19
70	1	Henckell Yarlaque Jesus Nicolas	\N	0	1	2026-01-06 16:29:39
71	1	Herrera Rambla Reyes Josemaria	\N	0	0	2026-01-06 16:29:58
72	1	Miranda Gonzales Brianna	\N	0	0	2026-01-06 16:30:45
73	1	Quezada Pulache Alanna Guadalupe	\N	0	0	2026-01-06 16:35:03
74	1	Zapata Navarro Anghelo Sebastian	\N	0	0	2026-01-06 16:35:32
75	1	Zurita Cespedes Daniel Eduardo	\N	0	0	2026-01-06 16:36:08
76	1	Zurita Cespedes Adrián Leopoldo	\N	0	0	2026-01-06 16:36:33
77	1	Jara Calopiño Oscar Mathias	\N	0	1	2026-01-06 16:36:53
78	1	Arroyo Whacheng Enzo	\N	0	1	2026-01-06 16:37:12
79	1	García Sedán Jose Marcelo		0	1	2026-01-06 16:37:38
80	3	García Cruz Sergio Luis		0	0	2026-01-06 16:38:05
81	1	Guerra Flores Renato Augusto	\N	0	0	2026-01-06 16:39:55
82	1	Vilchez Farfan Dayana Zuleika	\N	0	1	2026-01-06 16:40:16
83	6	Rodriguez Montero Hardy	\N	0	0	2026-01-06 17:09:31
84	6	Palacios Villafuertes Victor Alejandro	\N	0	1	2026-01-06 17:10:46
85	6	Ancajima Moran Samuel Arturo	\N	0	1	2026-01-06 17:11:09
86	5	Asabache Fernandez Carlos Antoni		0	1	2026-01-06 17:11:43
87	5	Alban Vargas Briseidy Camila		0	1	2026-01-06 17:12:20
88	6	Chávez Benites Luis Mateo		0	1	2026-01-06 17:13:27
89	1	Abad Farfán María Azucena	\N	0	0	2026-01-07 13:41:31
90	1	Abad Farfán María Alejandra	\N	0	0	2026-01-07 13:42:13
91	1	Abanto de la Cruz Braulio Eduardo	\N	0	1	2026-01-07 13:44:04
92	1	Aguilar Zapata Angelo Gabriel	\N	0	0	2026-01-07 13:45:05
93	2	Agapito Llauce Gustavo Leonel	\N	0	1	2026-01-07 13:45:54
94	2	Alamo Bancayan Sebastian Samir	\N	0	1	2026-01-07 13:46:19
95	1	Barrientos Carrión Rosita	\N	0	1	2026-01-07 13:46:26
96	1	Cruz Nole Sayri Natalie	\N	0	0	2026-01-07 13:46:50
97	2	Alban Sandoval Sol Jazmin	\N	0	1	2026-01-07 13:46:53
98	1	Diaz Salaverry Siu	\N	0	0	2026-01-07 13:47:08
99	2	Amaya More Diego Leonel	\N	0	1	2026-01-07 13:47:08
100	2	Barrientos Carrion Javier Manuel	\N	0	1	2026-01-07 13:47:26
101	2	Carrasco Enriquez Danna Stella	\N	0	1	2026-01-07 13:47:41
102	2	Castro Salinas Barbara	\N	0	1	2026-01-07 13:47:59
103	1	Henckell Yarleque Jesús Nicolas	\N	0	0	2026-01-07 13:48:12
104	2	Cervante Luna Daniela Mildred	\N	0	1	2026-01-07 13:48:21
105	2	Chavez Gallardo Lia Haziel	\N	0	1	2026-01-07 13:48:42
106	1	Herrera Rambla Reyes Josemaría	\N	0	1	2026-01-07 13:49:05
107	2	Chavez More Juan Pablo	\N	0	1	2026-01-07 13:49:19
108	1	Miranda Gonzales Brianna Abigail	\N	0	1	2026-01-07 13:49:26
109	2	Chunga Tavara Cesar Mathias	\N	0	1	2026-01-07 13:49:48
110	2	Cordova Nunura Sebastian Isaias	\N	0	1	2026-01-07 13:50:10
111	2	Coveña Henckell Mariajose	\N	0	1	2026-01-07 13:50:36
112	2	De lama Ancajima Jose Salvador	\N	0	1	2026-01-07 13:50:54
113	1	Quezada Pulache Alanna Guadalupe	\N	0	1	2026-01-07 13:51:00
114	2	Diaz Salaverry Fernando	\N	0	1	2026-01-07 13:51:09
115	1	Zapata Navarro Anghelo Sebastian	\N	0	1	2026-01-07 13:51:18
116	1	Zurita Cespedes Daniel Eduardo	\N	0	1	2026-01-07 13:51:40
117	2	Espinoza Cordova Joaquin	\N	0	1	2026-01-07 13:51:55
118	1	Zurita Cespedes Adrián Leopoldo	\N	0	1	2026-01-07 13:52:08
119	1	Jara Calopiño Oscar Mathias	\N	0	0	2026-01-07 13:52:34
120	2	Flores Rivera Rodrigo Alejandro	\N	0	1	2026-01-07 13:52:41
121	2	Florez Alvarado Carmen Brenda	\N	0	1	2026-01-07 13:52:59
122	2	Gallo Nuñez Thiago Saul	\N	0	1	2026-01-07 13:53:15
123	1	Arroyo Whacheng Enzo	\N	0	0	2026-01-07 13:53:35
124	2	Garcia Marcelo Alexa	\N	0	1	2026-01-07 13:53:37
125	2	Gil Melendez Alejandro Uriel	\N	0	1	2026-01-07 13:54:00
126	1	García Sedán Jose Miguel	\N	0	0	2026-01-07 13:54:22
127	2	Guerrero Puente Bastian Gael	\N	0	1	2026-01-07 13:54:30
128	1	García Cruz Sergio Luis	\N	0	0	2026-01-07 13:54:48
129	2	Guerrero Timana Joaquin Renato		0	1	2026-01-07 13:55:00
130	1	Guerra Flores Renato Augusto	\N	0	1	2026-01-07 13:55:19
131	1	Vilchez Farfan Dayana Zuleika	\N	0	0	2026-01-07 13:55:36
132	2	Guevara Espinoza Dante	\N	0	1	2026-01-07 13:56:14
133	2	Hernandez Moscol Angelo Gabriel	\N	0	1	2026-01-07 13:56:33
134	2	Laureano Mera Juan Luis	\N	0	1	2026-01-07 13:57:16
135	4	Campos Terrones Rodrigo Mateo		0	1	2026-01-07 13:57:34
136	3	Cardoza Camino Christhopher	\N	0	1	2026-01-07 13:57:53
137	2	Machuca Ruesta Dariel Rodrigo	\N	0	1	2026-01-07 13:58:00
138	2	Marroquin Viera Cielo	\N	0	1	2026-01-07 13:58:13
139	2	Martinez Mendoza Fabiano Alexander	\N	0	1	2026-01-07 13:58:30
140	2	Medina Benites Andrea Fabiana	\N	0	1	2026-01-07 13:58:52
141	2	Mendoza Duarte Kiara Guadalupe	\N	0	1	2026-01-07 13:59:22
142	2	Palacios Tong Cesar Gabriel	\N	0	1	2026-01-07 14:00:00
143	2	Paz Mechato Santiago Leonel	\N	0	1	2026-01-07 14:00:21
144	1	Carrasco Perales Guadalupe	\N	0	0	2026-01-07 14:00:25
145	2	Pulache Atarama Luhana Guadalupe	\N	0	1	2026-01-07 14:00:37
146	2	Quispe Chinchay Luis Gustavo	\N	0	1	2026-01-07 14:00:54
147	2	Rubio Bardales Mariana Valeria	\N	0	1	2026-01-07 14:01:18
148	2	Samatelo Cruz Alessandra Victoria	\N	0	1	2026-01-07 14:01:33
149	3	Castro Nizama Liang Arturo	\N	0	1	2026-01-07 14:01:46
150	2	Valverde Chunga Camila Yamileth	\N	0	1	2026-01-07 14:01:55
151	3	Céspedes Jimenez Miluska Antuané		0	1	2026-01-07 14:02:21
152	2	Valverde Encalada Thiago Nicolas	\N	0	1	2026-01-07 14:02:27
153	3	Durand Abadie Franco		0	1	2026-01-07 14:02:40
154	2	Ventura Rivas Cielito Fernanda	\N	0	1	2026-01-07 14:02:47
155	3	García Nima Camila Nicole		0	1	2026-01-07 14:02:56
156	2	Zapata Navarr Andre Manuel	\N	0	0	2026-01-07 14:03:06
157	2	Reyes Adrianzen Aaron	\N	0	1	2026-01-07 14:03:21
158	2	Suarez Diaz Angelo Emilio	\N	0	1	2026-01-07 14:03:39
159	3	Garcia Nima Camila Belén	\N	0	1	2026-01-07 14:03:41
160	2	Vereche Jara Lharims Antonela	\N	0	1	2026-01-07 14:04:15
161	3	Gomez Mena Ariana Jazmin	\N	0	1	2026-01-07 14:04:36
162	2	Mendoza Maldonado Fabiana Valeria	\N	0	1	2026-01-07 14:04:39
163	4	Guerra Palacios Macarena		0	1	2026-01-07 14:04:50
164	2	Jara Cordova Allyson Ximena	\N	0	1	2026-01-07 14:04:52
165	2	Guardado Sandoval Luciana Abigail	\N	0	1	2026-01-07 14:05:14
166	4	Guevara Cardoza Franco Sebastian		0	1	2026-01-07 14:05:31
167	4	Gutierrez Cordova Kamila Victoria		0	1	2026-01-07 14:06:23
168	4	Henckell Yarleque Oswaldo Sebastian		0	1	2026-01-07 14:07:01
169	2	Benites Pacherres Luciana Nadin	\N	0	1	2026-01-07 14:07:40
170	4	Jaramillo Bustamante Ana Paula		0	1	2026-01-07 14:07:45
171	3	La Madrid Rosales Mariana Lucía		0	1	2026-01-07 14:08:42
172	3	Lalupu Carrión Valentino		0	1	2026-01-07 14:09:13
173	3	Nunura Reyyes Andrea de los Milagros		0	1	2026-01-07 14:09:36
174	4	Palacios Campas Ashly Del Carmen		0	1	2026-01-07 14:10:10
175	4	Palacios Campas Diego Fernando		0	1	2026-01-07 14:11:01
176	3	Yovera Ayosa Luis Angel		0	1	2026-01-07 14:11:13
177	4	Paz Mechato Nathaniel Abigail		0	1	2026-01-07 14:11:24
178	3	Torres Morales Aaron Rodrigo		0	1	2026-01-07 14:11:31
179	4	Peña Chuman Shesly Valentina		0	1	2026-01-07 14:11:52
180	3	Pingo Vega Daniela Cristina		0	1	2026-01-07 14:12:12
181	4	Calero Arrunategui Adriana Nicolle		0	1	2026-01-07 14:12:39
182	4	Pintado Román Patrick Leonel		0	1	2026-01-07 14:12:45
183	3	Prado Moscoso Diego José Ricardo	\N	0	1	2026-01-07 14:13:26
184	4	Araujo Castillo Adriano Lionel	\N	0	1	2026-01-07 14:13:32
185	3	Pulache Rivas Diane de los ANgeles	\N	0	1	2026-01-07 14:13:49
186	3	Ramos Alvarado Camila Gabriel	\N	0	1	2026-01-07 14:14:07
187	4	Ruiz Moreno Kamila Nataniel		0	1	2026-01-07 14:14:18
188	3	Saucedo Quinde Valentina		0	1	2026-01-07 14:14:33
189	4	Torres Ricalde Brunella Jimena	\N	0	1	2026-01-07 14:14:40
190	3	Soto Guerra Cesar Ernesto		0	1	2026-01-07 14:14:50
191	3	Timana Ramos Ariana Alexandra	\N	0	1	2026-01-07 14:15:31
192	4	Retamozo Suarez Camila Vanessa		0	1	2026-01-07 14:15:43
193	3	Cienfuegos Lertua Carlos Arturo		0	1	2026-01-07 14:16:09
194	4	Troncos Escobar Leonardo Fabri		0	1	2026-01-07 14:16:15
195	3	Correa Solano Dayanne Nicle		0	1	2026-01-07 14:16:42
196	3	Vegas Bejarano Vannia Aleyda		0	1	2026-01-07 14:16:44
197	4	Yovera Farfán Maria Jimena		0	1	2026-01-07 14:17:37
198	3	Le Stunff Atoche Gael		0	1	2026-01-07 14:17:46
199	4	Viera Yacila Genesis	\N	0	1	2026-01-07 14:18:09
200	3	Garcia Cruz Jenner Matias		0	1	2026-01-07 14:18:49
201	3	Zurita Cespedes Moises Alejandro	\N	0	1	2026-01-07 14:18:51
202	3	Ponce Zavaleta Juan Alonso		0	1	2026-01-07 14:19:13
203	3	Rumiche Calle Karla Renata		0	1	2026-01-07 14:19:32
204	3	Leon Guillen Lia Macarena		0	1	2026-01-07 14:19:53
205	4	Tafur Ancajima Luciana Jazmin		0	1	2026-01-07 14:21:10
206	3	Vargas Guerrero Mayte		0	1	2026-01-07 14:21:26
207	3	Castro Perez Ricardo Alejandro		0	1	2026-01-07 14:22:18
208	3	Chirito Ramirez Shanella Dayana		0	1	2026-01-07 14:22:50
209	3	Aparicio Gonzales Stephanie Dayana		0	1	2026-01-07 14:23:17
210	4	Palomino Vilela Thiago Nicolas	\N	0	1	2026-01-07 14:24:15
211	4	Rubio Guillen Valentina		0	1	2026-01-07 14:24:37
212	4	Rumiche Farfan Carlo Mateo	\N	0	1	2026-01-07 14:25:00
213	4	Olivares Chiroque Isabela Liscet	\N	0	1	2026-01-07 14:25:43
214	3	Garcia Sandoval Emmy		0	1	2026-01-07 14:25:58
215	3	Roman Lopez Yeason Aldair		0	1	2026-01-07 14:26:32
216	4	Camacho Cruz Pierina Lorena	\N	0	0	2026-01-07 14:27:03
217	4	Ocaña Adrianzen Miguel Adrian		0	1	2026-01-07 14:27:52
218	4	Moreno Morocho Crisnhy Loreni	\N	0	1	2026-01-07 14:28:23
219	4	Del Valle Inca Juan Ricardo		0	1	2026-01-07 14:29:44
220	3	Abad Espinoza Romina		0	1	2026-01-07 14:29:58
221	4	Garcia Sedan Jose Miguel		0	1	2026-01-07 14:30:22
222	3	Atarama Maza Camila Alessandra		0	1	2026-01-07 14:30:45
223	4	Otero Velasco Bianca Isabel		0	1	2026-01-07 14:30:59
224	4	Ponce Briceño Angel		0	1	2026-01-07 14:31:33
225	4	Guerrero Castillo Nurit Fernanda	\N	0	1	2026-01-07 14:31:54
226	6	Pozo Pinday Alma Valeria	\N	0	1	2026-01-07 14:36:24
227	6	Monroy Pasapera Jaime Eduardo	\N	0	1	2026-01-07 14:37:13
228	5	Condori Olmedo Angie		0	1	2026-01-07 14:37:30
229	6	Abarca Navarro Ricardo Sebastian	\N	0	1	2026-01-07 14:37:51
230	6	Tamariz Gomez Mateo André	\N	0	1	2026-01-07 14:38:14
231	3	Carrasco Perales Guadalupe	\N	0	1	2026-01-07 17:39:32
232	6	Cienfuegos Ruiz Daniela Mia	\N	0	1	2026-01-07 17:41:25
233	3	Moscol Vasquez Maria Jose	\N	0	0	2026-01-07 17:42:21
234	6	Raul Perez	\N	0	0	2026-01-08 15:22:32
235	5	Cantoral Quispe Mateo André		0	1	2026-01-08 15:23:21
236	5	Perez Carmen Raul Ricardo		0	1	2026-01-08 15:23:31
237	6	Chumacero Cisneros Jefry	\N	0	1	2026-01-08 15:23:51
238	5	Fernandez Salazar Mia Yamile		0	1	2026-01-08 15:24:51
239	5	Chiroque Gamboa Leandro Matias		0	1	2026-01-08 15:25:16
240	3	Bayona Juarez Mathias Nicolas	\N	0	1	2026-01-08 15:30:42
241	1	Bruno Estrada Maria Fatima	\N	0	1	2026-01-08 15:31:33
242	1	Chunga Silupu Thiago Alejandro	\N	0	1	2026-01-08 15:32:07
243	6	Falla León Gabriela Katherine	\N	0	0	2026-01-09 13:57:30
244	6	Rodriguez Cardenas Luhana Elizabeth	\N	0	1	2026-01-09 14:01:09
245	2	Coveñas Cruz Leonardo Nicolas	\N	0	1	2026-01-09 14:01:48
246	2	Moscol Vasquez Maria Jose	\N	0	1	2026-01-09 15:36:09
247	2	Camacho Cruz Pierina	\N	0	1	2026-01-10 16:42:08
248	5	Falla León Gabriela Katherinne		0	1	2026-01-12 12:56:04
249	4	Moscol Vasquez Maria Jose		0	1	2026-01-12 14:09:18
250	4	Camacho Cruz Pierina Lorena	\N	0	1	2026-01-12 14:15:59
251	3	More Mogollon Byrne Harumy		0	1	2026-01-12 14:17:40
252	4	Obregon Zapata Roberto	\N	0	1	2026-01-12 14:18:27
253	5	Calixtro Gómez Maximiliano Stefano		0	1	2026-01-12 14:45:04
254	5	Ramirez Paiva Henry Emanuel Isaias		0	1	2026-01-12 14:45:44
255	6	Sanchez Martell Mateo Zaid	\N	0	1	2026-01-12 14:46:18
256	6	Valdiviezo García Sergio Eduardo	\N	0	1	2026-01-12 14:46:46
257	1	Ibañez Villegas Andres Josue	\N	0	1	2026-01-13 13:55:56
258	1	Saldarriaga Herrera Juan Manuel	\N	0	1	2026-01-13 13:57:08
259	1	Ramirez Paiva Carlos Jose	\N	0	1	2026-01-13 13:57:29
260	1	Calixtro Gómez Fernando Alonso	\N	0	1	2026-01-13 13:59:08
261	1	Sánchez Lozada Fernando Sebastian	\N	0	1	2026-01-13 13:59:49
262	1	Fiestas Cruz Emma Patricia	\N	0	1	2026-01-13 14:00:24
263	1	Herrera Rambla Leyton Sandra Valeria	\N	0	1	2026-01-13 14:00:46
264	1	Tirado Reyes Catalina	\N	0	1	2026-01-13 14:01:11
265	2	Sánchez Lozada Manuel Alejandro	\N	0	1	2026-01-13 14:19:09
266	6	Calitro Gómez Maximiliano	\N	0	0	2026-01-13 14:39:47
267	5	Zavala Lozada Mario Jorge		0	1	2026-01-13 14:41:03
268	6	Sandoval Valdiviezo Luciana Alessandra	\N	0	1	2026-01-13 14:41:50
269	5	Valdiviezo Polo Jesús Alberto		0	1	2026-01-13 14:44:23
270	2	Zapata Navarro Andre Manuel	\N	0	1	2026-01-15 16:34:32
271	1	García Cruz Sergio Luis	\N	0	1	2026-01-15 16:39:21
1	1	Zurita Cespedes AdriÃ¡n Leopoldo	\N	0	0	2026-01-05 03:57:58
2	1	Zurita Cespedes Daniel Eduardo	\N	0	0	2026-01-05 04:03:19
3	5	Alban Saavedra Luis Alessandro	\N	0	1	2026-01-06 03:21:37
4	5	Bárcena Herrera Valeria		0	1	2026-01-06 03:21:47
5	5	Barrios Gálvez Fabiana		0	1	2026-01-06 03:22:13
6	5	Ayosa Silupu Andre Atzel	\N	0	1	2026-01-06 03:22:15
7	5	Caceres Cordova Alonso	\N	0	1	2026-01-06 03:22:34
8	5	Chunga Távara Alberto Nicolás		0	1	2026-01-06 03:22:36
9	6	Cornejo Osorio Nicolás		0	1	2026-01-06 03:22:59
10	5	Calle Lezama Albert Estefano	\N	0	1	2026-01-06 03:23:00
11	6	Coveña Henckell Daniel	\N	0	1	2026-01-06 03:23:19
12	5	Chong Goytizolo Camila	\N	0	1	2026-01-06 03:23:21
13	6	Galecio Santos Eduardo Rafael	\N	0	0	2026-01-06 03:23:38
14	5	Chuquimarca Abadie Luis Gabriel	\N	0	1	2026-01-06 03:23:43
15	6	Gil Melendez Adriana Jazmin	\N	0	1	2026-01-06 03:23:55
16	6	Cruz Nole Alessandro		0	1	2026-01-06 03:24:13
17	5	Ginocchio Torres Olenka Jazmin		0	1	2026-01-06 03:24:19
18	6	Diaz Garcia Marco		0	1	2026-01-06 03:24:30
19	6	Lozada Gallo Alexa Azucena	\N	0	1	2026-01-06 03:24:49
20	6	Flores Alzamora Juan Pablo		0	1	2026-01-06 03:24:51
21	6	Mondragón Juarez Daniella Ivanna	\N	0	1	2026-01-06 03:25:10
22	5	Guerra Flores Letizia Isabel	\N	0	1	2026-01-06 03:25:14
23	5	Otero Chero Omar Junior		0	1	2026-01-06 03:25:24
24	5	Herrera Rambla Reyes Rafael	\N	0	1	2026-01-06 03:25:40
25	6	Palacios Tong Mateo Jaciel		0	1	2026-01-06 03:25:57
26	5	Hurtado Carrillo Naomi Brigitte	\N	0	1	2026-01-06 03:26:04
27	6	Ruiz Dioses Santiago Alonso	\N	0	1	2026-01-06 03:26:14
28	5	Izu Infante Angela Valentina		0	1	2026-01-06 03:26:30
29	5	Villacorta Mogollón Angel		0	1	2026-01-06 03:26:35
30	5	Vega Pacherres Karolay Guadalupe		0	1	2026-01-06 03:27:09
31	5	Jimenez Villigua Christopher Matias	\N	0	1	2026-01-06 03:27:15
32	5	Lama Seminario Jose Carlos	\N	0	1	2026-01-06 03:27:28
33	5	Vega Pacherres Yomira Guadalupe		0	1	2026-01-06 03:27:31
34	5	Yamunaque Yamunaque Jesús Fabian		0	1	2026-01-06 03:27:57
35	6	Litano Yahuana Luciana Valeria		0	1	2026-01-06 03:28:04
36	5	Zapata Zeta Luis Rodolfo		0	1	2026-01-06 03:28:18
37	6	Galecio Santos Eduardo Rafael	\N	0	1	2026-01-06 03:28:34
38	6	Llacsahuanga Lachira Carlos Eduardo		0	1	2026-01-06 03:28:37
39	6	Acosta García Deysi Miluska	\N	0	1	2026-01-06 03:28:53
40	5	Luque Fassio Juan Luis	\N	0	1	2026-01-06 03:28:54
41	5	Neira Chumacero Joaquin	\N	0	1	2026-01-06 03:29:10
42	6	Rodriguez Montero Hardy Nicolas	\N	0	1	2026-01-06 03:29:19
43	6	Neira Rosales Adriana		0	1	2026-01-06 03:29:27
44	6	Ojeda Medina Juan Diego		0	1	2026-01-06 03:30:03
45	5	Pacheco Cordova Carlos		0	1	2026-01-06 03:30:21
46	6	Echeandia Vega Ray Antonio	\N	0	1	2026-01-06 03:30:26
47	6	Pissani Quesñay Mariana		0	1	2026-01-06 03:30:37
48	6	García Yaipen Alexandra Vanesa	\N	0	1	2026-01-06 03:30:46
49	6	Ramirez Manzanares Mariano		0	1	2026-01-06 03:31:01
50	5	Guevara Chunga Alanna Sofia		0	1	2026-01-06 03:31:06
51	5	Ramirez Rivera Ivanna Valentina	\N	0	1	2026-01-06 03:31:14
52	6	Raymundo Zevallos Bruno Rolando	\N	0	1	2026-01-06 03:31:29
53	6	Requena Rivera Raul Alejandro		0	1	2026-01-06 03:31:39
54	6	Riofrio Carmen Miguel Horacio		0	1	2026-01-06 03:33:05
55	5	Roman Rojas Eiki Alexander		0	1	2026-01-06 03:34:31
56	5	Ruidias Navarro Andrea Isabel	\N	0	1	2026-01-06 03:34:52
57	6	Ruiz Rosillo Piero Rodrigo		0	1	2026-01-06 03:35:19
58	5	Saavedra Oliva Daniel Alonso	\N	0	1	2026-01-06 03:35:50
59	6	Saavedra Velasquez Mateo Gabriel		0	1	2026-01-06 03:36:05
60	6	Talledo Rodriguez Josemaria		0	1	2026-01-06 03:36:24
61	5	Ubillus Castillo Fernando Gabriel		0	1	2026-01-06 03:37:19
62	6	Yajahuanca Ticliahuanca Marianela		0	1	2026-01-06 03:37:37
63	1	Abad Farfan Maria Azucena	\N	0	1	2026-01-06 16:27:29
64	1	Abad Farfan Maria Alejandra	\N	0	1	2026-01-06 16:27:44
65	1	Abanto De la Cruz Braulio	\N	0	0	2026-01-06 16:28:01
66	1	Aguilar Zapata Angelo Grabriel	\N	0	1	2026-01-06 16:28:19
67	1	Barrientos Carrion Rosita	\N	0	0	2026-01-06 16:28:31
68	1	Cruz Nole Sayri Natalie	\N	0	1	2026-01-06 16:28:49
69	1	Diaz Salaverry Siu	\N	0	1	2026-01-06 16:29:19
70	1	Henckell Yarlaque Jesus Nicolas	\N	0	1	2026-01-06 16:29:39
71	1	Herrera Rambla Reyes Josemaria	\N	0	0	2026-01-06 16:29:58
72	1	Miranda Gonzales Brianna	\N	0	0	2026-01-06 16:30:45
73	1	Quezada Pulache Alanna Guadalupe	\N	0	0	2026-01-06 16:35:03
74	1	Zapata Navarro Anghelo Sebastian	\N	0	0	2026-01-06 16:35:32
75	1	Zurita Cespedes Daniel Eduardo	\N	0	0	2026-01-06 16:36:08
76	1	Zurita Cespedes Adrián Leopoldo	\N	0	0	2026-01-06 16:36:33
77	1	Jara Calopiño Oscar Mathias	\N	0	1	2026-01-06 16:36:53
78	1	Arroyo Whacheng Enzo	\N	0	1	2026-01-06 16:37:12
79	1	García Sedán Jose Marcelo		0	1	2026-01-06 16:37:38
80	3	García Cruz Sergio Luis		0	0	2026-01-06 16:38:05
81	1	Guerra Flores Renato Augusto	\N	0	0	2026-01-06 16:39:55
82	1	Vilchez Farfan Dayana Zuleika	\N	0	1	2026-01-06 16:40:16
83	6	Rodriguez Montero Hardy	\N	0	0	2026-01-06 17:09:31
84	6	Palacios Villafuertes Victor Alejandro	\N	0	1	2026-01-06 17:10:46
85	6	Ancajima Moran Samuel Arturo	\N	0	1	2026-01-06 17:11:09
86	5	Asabache Fernandez Carlos Antoni		0	1	2026-01-06 17:11:43
87	5	Alban Vargas Briseidy Camila		0	1	2026-01-06 17:12:20
88	6	Chávez Benites Luis Mateo		0	1	2026-01-06 17:13:27
89	1	Abad Farfán María Azucena	\N	0	0	2026-01-07 13:41:31
90	1	Abad Farfán María Alejandra	\N	0	0	2026-01-07 13:42:13
91	1	Abanto de la Cruz Braulio Eduardo	\N	0	1	2026-01-07 13:44:04
92	1	Aguilar Zapata Angelo Gabriel	\N	0	0	2026-01-07 13:45:05
93	2	Agapito Llauce Gustavo Leonel	\N	0	1	2026-01-07 13:45:54
94	2	Alamo Bancayan Sebastian Samir	\N	0	1	2026-01-07 13:46:19
95	1	Barrientos Carrión Rosita	\N	0	1	2026-01-07 13:46:26
96	1	Cruz Nole Sayri Natalie	\N	0	0	2026-01-07 13:46:50
97	2	Alban Sandoval Sol Jazmin	\N	0	1	2026-01-07 13:46:53
98	1	Diaz Salaverry Siu	\N	0	0	2026-01-07 13:47:08
99	2	Amaya More Diego Leonel	\N	0	1	2026-01-07 13:47:08
100	2	Barrientos Carrion Javier Manuel	\N	0	1	2026-01-07 13:47:26
101	2	Carrasco Enriquez Danna Stella	\N	0	1	2026-01-07 13:47:41
102	2	Castro Salinas Barbara	\N	0	1	2026-01-07 13:47:59
103	1	Henckell Yarleque Jesús Nicolas	\N	0	0	2026-01-07 13:48:12
104	2	Cervante Luna Daniela Mildred	\N	0	1	2026-01-07 13:48:21
105	2	Chavez Gallardo Lia Haziel	\N	0	1	2026-01-07 13:48:42
106	1	Herrera Rambla Reyes Josemaría	\N	0	1	2026-01-07 13:49:05
107	2	Chavez More Juan Pablo	\N	0	1	2026-01-07 13:49:19
108	1	Miranda Gonzales Brianna Abigail	\N	0	1	2026-01-07 13:49:26
109	2	Chunga Tavara Cesar Mathias	\N	0	1	2026-01-07 13:49:48
110	2	Cordova Nunura Sebastian Isaias	\N	0	1	2026-01-07 13:50:10
111	2	Coveña Henckell Mariajose	\N	0	1	2026-01-07 13:50:36
112	2	De lama Ancajima Jose Salvador	\N	0	1	2026-01-07 13:50:54
113	1	Quezada Pulache Alanna Guadalupe	\N	0	1	2026-01-07 13:51:00
114	2	Diaz Salaverry Fernando	\N	0	1	2026-01-07 13:51:09
115	1	Zapata Navarro Anghelo Sebastian	\N	0	1	2026-01-07 13:51:18
116	1	Zurita Cespedes Daniel Eduardo	\N	0	1	2026-01-07 13:51:40
117	2	Espinoza Cordova Joaquin	\N	0	1	2026-01-07 13:51:55
118	1	Zurita Cespedes Adrián Leopoldo	\N	0	1	2026-01-07 13:52:08
119	1	Jara Calopiño Oscar Mathias	\N	0	0	2026-01-07 13:52:34
120	2	Flores Rivera Rodrigo Alejandro	\N	0	1	2026-01-07 13:52:41
121	2	Florez Alvarado Carmen Brenda	\N	0	1	2026-01-07 13:52:59
122	2	Gallo Nuñez Thiago Saul	\N	0	1	2026-01-07 13:53:15
123	1	Arroyo Whacheng Enzo	\N	0	0	2026-01-07 13:53:35
124	2	Garcia Marcelo Alexa	\N	0	1	2026-01-07 13:53:37
125	2	Gil Melendez Alejandro Uriel	\N	0	1	2026-01-07 13:54:00
126	1	García Sedán Jose Miguel	\N	0	0	2026-01-07 13:54:22
127	2	Guerrero Puente Bastian Gael	\N	0	1	2026-01-07 13:54:30
128	1	García Cruz Sergio Luis	\N	0	0	2026-01-07 13:54:48
129	2	Guerrero Timana Joaquin Renato		0	1	2026-01-07 13:55:00
130	1	Guerra Flores Renato Augusto	\N	0	1	2026-01-07 13:55:19
131	1	Vilchez Farfan Dayana Zuleika	\N	0	0	2026-01-07 13:55:36
132	2	Guevara Espinoza Dante	\N	0	1	2026-01-07 13:56:14
133	2	Hernandez Moscol Angelo Gabriel	\N	0	1	2026-01-07 13:56:33
134	2	Laureano Mera Juan Luis	\N	0	1	2026-01-07 13:57:16
135	4	Campos Terrones Rodrigo Mateo		0	1	2026-01-07 13:57:34
136	3	Cardoza Camino Christhopher	\N	0	1	2026-01-07 13:57:53
137	2	Machuca Ruesta Dariel Rodrigo	\N	0	1	2026-01-07 13:58:00
138	2	Marroquin Viera Cielo	\N	0	1	2026-01-07 13:58:13
139	2	Martinez Mendoza Fabiano Alexander	\N	0	1	2026-01-07 13:58:30
140	2	Medina Benites Andrea Fabiana	\N	0	1	2026-01-07 13:58:52
141	2	Mendoza Duarte Kiara Guadalupe	\N	0	1	2026-01-07 13:59:22
142	2	Palacios Tong Cesar Gabriel	\N	0	1	2026-01-07 14:00:00
143	2	Paz Mechato Santiago Leonel	\N	0	1	2026-01-07 14:00:21
144	1	Carrasco Perales Guadalupe	\N	0	0	2026-01-07 14:00:25
145	2	Pulache Atarama Luhana Guadalupe	\N	0	1	2026-01-07 14:00:37
146	2	Quispe Chinchay Luis Gustavo	\N	0	1	2026-01-07 14:00:54
147	2	Rubio Bardales Mariana Valeria	\N	0	1	2026-01-07 14:01:18
148	2	Samatelo Cruz Alessandra Victoria	\N	0	1	2026-01-07 14:01:33
149	3	Castro Nizama Liang Arturo	\N	0	1	2026-01-07 14:01:46
150	2	Valverde Chunga Camila Yamileth	\N	0	1	2026-01-07 14:01:55
151	3	Céspedes Jimenez Miluska Antuané		0	1	2026-01-07 14:02:21
152	2	Valverde Encalada Thiago Nicolas	\N	0	1	2026-01-07 14:02:27
153	3	Durand Abadie Franco		0	1	2026-01-07 14:02:40
154	2	Ventura Rivas Cielito Fernanda	\N	0	1	2026-01-07 14:02:47
155	3	García Nima Camila Nicole		0	1	2026-01-07 14:02:56
156	2	Zapata Navarr Andre Manuel	\N	0	0	2026-01-07 14:03:06
157	2	Reyes Adrianzen Aaron	\N	0	1	2026-01-07 14:03:21
158	2	Suarez Diaz Angelo Emilio	\N	0	1	2026-01-07 14:03:39
159	3	Garcia Nima Camila Belén	\N	0	1	2026-01-07 14:03:41
160	2	Vereche Jara Lharims Antonela	\N	0	1	2026-01-07 14:04:15
161	3	Gomez Mena Ariana Jazmin	\N	0	1	2026-01-07 14:04:36
162	2	Mendoza Maldonado Fabiana Valeria	\N	0	1	2026-01-07 14:04:39
163	4	Guerra Palacios Macarena		0	1	2026-01-07 14:04:50
164	2	Jara Cordova Allyson Ximena	\N	0	1	2026-01-07 14:04:52
165	2	Guardado Sandoval Luciana Abigail	\N	0	1	2026-01-07 14:05:14
166	4	Guevara Cardoza Franco Sebastian		0	1	2026-01-07 14:05:31
167	4	Gutierrez Cordova Kamila Victoria		0	1	2026-01-07 14:06:23
168	4	Henckell Yarleque Oswaldo Sebastian		0	1	2026-01-07 14:07:01
169	2	Benites Pacherres Luciana Nadin	\N	0	1	2026-01-07 14:07:40
170	4	Jaramillo Bustamante Ana Paula		0	1	2026-01-07 14:07:45
171	3	La Madrid Rosales Mariana Lucía		0	1	2026-01-07 14:08:42
172	3	Lalupu Carrión Valentino		0	1	2026-01-07 14:09:13
173	3	Nunura Reyyes Andrea de los Milagros		0	1	2026-01-07 14:09:36
174	4	Palacios Campas Ashly Del Carmen		0	1	2026-01-07 14:10:10
175	4	Palacios Campas Diego Fernando		0	1	2026-01-07 14:11:01
176	3	Yovera Ayosa Luis Angel		0	1	2026-01-07 14:11:13
177	4	Paz Mechato Nathaniel Abigail		0	1	2026-01-07 14:11:24
178	3	Torres Morales Aaron Rodrigo		0	1	2026-01-07 14:11:31
179	4	Peña Chuman Shesly Valentina		0	1	2026-01-07 14:11:52
180	3	Pingo Vega Daniela Cristina		0	1	2026-01-07 14:12:12
181	4	Calero Arrunategui Adriana Nicolle		0	1	2026-01-07 14:12:39
182	4	Pintado Román Patrick Leonel		0	1	2026-01-07 14:12:45
183	3	Prado Moscoso Diego José Ricardo	\N	0	1	2026-01-07 14:13:26
184	4	Araujo Castillo Adriano Lionel	\N	0	1	2026-01-07 14:13:32
185	3	Pulache Rivas Diane de los ANgeles	\N	0	1	2026-01-07 14:13:49
186	3	Ramos Alvarado Camila Gabriel	\N	0	1	2026-01-07 14:14:07
187	4	Ruiz Moreno Kamila Nataniel		0	1	2026-01-07 14:14:18
188	3	Saucedo Quinde Valentina		0	1	2026-01-07 14:14:33
189	4	Torres Ricalde Brunella Jimena	\N	0	1	2026-01-07 14:14:40
190	3	Soto Guerra Cesar Ernesto		0	1	2026-01-07 14:14:50
191	3	Timana Ramos Ariana Alexandra	\N	0	1	2026-01-07 14:15:31
192	4	Retamozo Suarez Camila Vanessa		0	1	2026-01-07 14:15:43
193	3	Cienfuegos Lertua Carlos Arturo		0	1	2026-01-07 14:16:09
194	4	Troncos Escobar Leonardo Fabri		0	1	2026-01-07 14:16:15
195	3	Correa Solano Dayanne Nicle		0	1	2026-01-07 14:16:42
196	3	Vegas Bejarano Vannia Aleyda		0	1	2026-01-07 14:16:44
197	4	Yovera Farfán Maria Jimena		0	1	2026-01-07 14:17:37
198	3	Le Stunff Atoche Gael		0	1	2026-01-07 14:17:46
199	4	Viera Yacila Genesis	\N	0	1	2026-01-07 14:18:09
200	3	Garcia Cruz Jenner Matias		0	1	2026-01-07 14:18:49
201	3	Zurita Cespedes Moises Alejandro	\N	0	1	2026-01-07 14:18:51
202	3	Ponce Zavaleta Juan Alonso		0	1	2026-01-07 14:19:13
203	3	Rumiche Calle Karla Renata		0	1	2026-01-07 14:19:32
204	3	Leon Guillen Lia Macarena		0	1	2026-01-07 14:19:53
205	4	Tafur Ancajima Luciana Jazmin		0	1	2026-01-07 14:21:10
206	3	Vargas Guerrero Mayte		0	1	2026-01-07 14:21:26
207	3	Castro Perez Ricardo Alejandro		0	1	2026-01-07 14:22:18
208	3	Chirito Ramirez Shanella Dayana		0	1	2026-01-07 14:22:50
209	3	Aparicio Gonzales Stephanie Dayana		0	1	2026-01-07 14:23:17
210	4	Palomino Vilela Thiago Nicolas	\N	0	1	2026-01-07 14:24:15
211	4	Rubio Guillen Valentina		0	1	2026-01-07 14:24:37
212	4	Rumiche Farfan Carlo Mateo	\N	0	1	2026-01-07 14:25:00
213	4	Olivares Chiroque Isabela Liscet	\N	0	1	2026-01-07 14:25:43
214	3	Garcia Sandoval Emmy		0	1	2026-01-07 14:25:58
215	3	Roman Lopez Yeason Aldair		0	1	2026-01-07 14:26:32
216	4	Camacho Cruz Pierina Lorena	\N	0	0	2026-01-07 14:27:03
217	4	Ocaña Adrianzen Miguel Adrian		0	1	2026-01-07 14:27:52
218	4	Moreno Morocho Crisnhy Loreni	\N	0	1	2026-01-07 14:28:23
219	4	Del Valle Inca Juan Ricardo		0	1	2026-01-07 14:29:44
220	3	Abad Espinoza Romina		0	1	2026-01-07 14:29:58
221	4	Garcia Sedan Jose Miguel		0	1	2026-01-07 14:30:22
222	3	Atarama Maza Camila Alessandra		0	1	2026-01-07 14:30:45
223	4	Otero Velasco Bianca Isabel		0	1	2026-01-07 14:30:59
224	4	Ponce Briceño Angel		0	1	2026-01-07 14:31:33
225	4	Guerrero Castillo Nurit Fernanda	\N	0	1	2026-01-07 14:31:54
226	6	Pozo Pinday Alma Valeria	\N	0	1	2026-01-07 14:36:24
227	6	Monroy Pasapera Jaime Eduardo	\N	0	1	2026-01-07 14:37:13
228	5	Condori Olmedo Angie		0	1	2026-01-07 14:37:30
229	6	Abarca Navarro Ricardo Sebastian	\N	0	1	2026-01-07 14:37:51
230	6	Tamariz Gomez Mateo André	\N	0	1	2026-01-07 14:38:14
231	3	Carrasco Perales Guadalupe	\N	0	1	2026-01-07 17:39:32
232	6	Cienfuegos Ruiz Daniela Mia	\N	0	1	2026-01-07 17:41:25
233	3	Moscol Vasquez Maria Jose	\N	0	0	2026-01-07 17:42:21
234	6	Raul Perez	\N	0	0	2026-01-08 15:22:32
235	5	Cantoral Quispe Mateo André		0	1	2026-01-08 15:23:21
236	5	Perez Carmen Raul Ricardo		0	1	2026-01-08 15:23:31
237	6	Chumacero Cisneros Jefry	\N	0	1	2026-01-08 15:23:51
238	5	Fernandez Salazar Mia Yamile		0	1	2026-01-08 15:24:51
239	5	Chiroque Gamboa Leandro Matias		0	1	2026-01-08 15:25:16
240	3	Bayona Juarez Mathias Nicolas	\N	0	1	2026-01-08 15:30:42
241	1	Bruno Estrada Maria Fatima	\N	0	1	2026-01-08 15:31:33
242	1	Chunga Silupu Thiago Alejandro	\N	0	1	2026-01-08 15:32:07
243	6	Falla León Gabriela Katherine	\N	0	0	2026-01-09 13:57:30
244	6	Rodriguez Cardenas Luhana Elizabeth	\N	0	1	2026-01-09 14:01:09
245	2	Coveñas Cruz Leonardo Nicolas	\N	0	1	2026-01-09 14:01:48
246	2	Moscol Vasquez Maria Jose	\N	0	1	2026-01-09 15:36:09
247	2	Camacho Cruz Pierina	\N	0	1	2026-01-10 16:42:08
248	5	Falla León Gabriela Katherinne		0	1	2026-01-12 12:56:04
249	4	Moscol Vasquez Maria Jose		0	1	2026-01-12 14:09:18
250	4	Camacho Cruz Pierina Lorena	\N	0	1	2026-01-12 14:15:59
251	3	More Mogollon Byrne Harumy		0	1	2026-01-12 14:17:40
252	4	Obregon Zapata Roberto	\N	0	1	2026-01-12 14:18:27
253	5	Calixtro Gómez Maximiliano Stefano		0	1	2026-01-12 14:45:04
254	5	Ramirez Paiva Henry Emanuel Isaias		0	1	2026-01-12 14:45:44
255	6	Sanchez Martell Mateo Zaid	\N	0	1	2026-01-12 14:46:18
256	6	Valdiviezo García Sergio Eduardo	\N	0	1	2026-01-12 14:46:46
257	1	Ibañez Villegas Andres Josue	\N	0	1	2026-01-13 13:55:56
258	1	Saldarriaga Herrera Juan Manuel	\N	0	1	2026-01-13 13:57:08
259	1	Ramirez Paiva Carlos Jose	\N	0	1	2026-01-13 13:57:29
260	1	Calixtro Gómez Fernando Alonso	\N	0	1	2026-01-13 13:59:08
261	1	Sánchez Lozada Fernando Sebastian	\N	0	1	2026-01-13 13:59:49
262	1	Fiestas Cruz Emma Patricia	\N	0	1	2026-01-13 14:00:24
263	1	Herrera Rambla Leyton Sandra Valeria	\N	0	1	2026-01-13 14:00:46
264	1	Tirado Reyes Catalina	\N	0	1	2026-01-13 14:01:11
265	2	Sánchez Lozada Manuel Alejandro	\N	0	1	2026-01-13 14:19:09
266	6	Calitro Gómez Maximiliano	\N	0	0	2026-01-13 14:39:47
267	5	Zavala Lozada Mario Jorge		0	1	2026-01-13 14:41:03
268	6	Sandoval Valdiviezo Luciana Alessandra	\N	0	1	2026-01-13 14:41:50
269	5	Valdiviezo Polo Jesús Alberto		0	1	2026-01-13 14:44:23
270	2	Zapata Navarro Andre Manuel	\N	0	1	2026-01-15 16:34:32
271	1	García Cruz Sergio Luis	\N	0	1	2026-01-15 16:39:21
\.


--
-- TOC entry 4968 (class 0 OID 16395)
-- Dependencies: 219
-- Data for Name: asistencia_horarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asistencia_horarios (id, seccion_id, dia_semana) FROM stdin;
5	1	Jueves
4	1	Martes
6	1	Sábado
7	2	Lunes
8	2	Martes
9	2	Viernes
13	3	Jueves
10	3	Lunes
11	3	Martes
12	3	Miércoles
14	3	Viernes
18	4	Jueves
15	4	Lunes
16	4	Martes
17	4	Miércoles
19	4	Viernes
23	5	Jueves
20	5	Lunes
21	5	Martes
22	5	Miércoles
24	5	Viernes
28	6	Jueves
25	6	Lunes
26	6	Martes
27	6	Miércoles
29	6	Viernes
\.


--
-- TOC entry 4969 (class 0 OID 16398)
-- Dependencies: 220
-- Data for Name: asistencia_registros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asistencia_registros (id, estudiante_id, semana_id, fecha_clase, presente, observaciones, fecha_registro, usuario_registro, estado) FROM stdin;
1	1	1	2026-01-06	1	\N	2026-01-05 21:41:09	ADMIN	tardanza
2	1	1	2026-01-08	0	\N	2026-01-05 21:41:10	ADMIN	justificada
3	1	1	2026-01-10	0	\N	2026-01-05 21:41:12	ADMIN	falto
4	2	1	2026-01-06	0	\N	2026-01-05 21:41:13	ADMIN	falto
5	2	1	2026-01-08	1	\N	2026-01-05 21:41:14	ADMIN	asistio
6	2	1	2026-01-10	1	\N	2026-01-05 21:41:15	ADMIN	tardanza
7	39	1	2026-01-05	1	\N	2026-01-09 16:35:20	ADMIN	asistio
8	39	1	2026-01-06	1	\N	2026-01-09 16:35:20	ADMIN	tardanza
9	39	1	2026-01-07	1	\N	2026-01-09 16:35:20	ADMIN	asistio
10	39	1	2026-01-08	1	\N	2026-01-09 16:35:21	ADMIN	asistio
11	39	1	2026-01-09	1	\N	2026-01-09 16:35:21	ADMIN	asistio
12	4	1	2026-01-05	1	\N	2026-01-13 15:14:39	ADMIN	asistio
13	4	1	2026-01-06	1	\N	2026-01-13 15:14:39	ADMIN	asistio
14	4	1	2026-01-07	1	\N	2026-01-13 15:14:40	ADMIN	asistio
15	4	1	2026-01-08	1	\N	2026-01-13 15:14:40	ADMIN	asistio
16	4	1	2026-01-09	1	\N	2026-01-13 15:14:41	ADMIN	asistio
17	5	1	2026-01-05	1	\N	2026-01-13 15:14:41	ADMIN	asistio
18	5	1	2026-01-06	1	\N	2026-01-13 15:14:41	ADMIN	asistio
19	5	1	2026-01-07	1	\N	2026-01-13 15:14:42	ADMIN	asistio
20	5	1	2026-01-08	1	\N	2026-01-13 15:14:43	ADMIN	asistio
21	5	1	2026-01-09	1	\N	2026-01-13 15:14:43	ADMIN	asistio
22	8	1	2026-01-05	1	\N	2026-01-13 15:14:55	ADMIN	asistio
23	8	1	2026-01-06	1	\N	2026-01-13 15:14:55	ADMIN	asistio
24	8	1	2026-01-07	1	\N	2026-01-13 15:14:56	ADMIN	asistio
25	8	1	2026-01-08	1	\N	2026-01-13 15:14:56	ADMIN	asistio
26	8	1	2026-01-09	1	\N	2026-01-13 15:14:57	ADMIN	asistio
27	9	1	2026-01-05	1	\N	2026-01-13 15:15:01	ADMIN	asistio
28	9	1	2026-01-06	1	\N	2026-01-13 15:15:01	ADMIN	asistio
29	9	1	2026-01-07	1	\N	2026-01-13 15:15:02	ADMIN	asistio
30	9	1	2026-01-08	1	\N	2026-01-13 15:15:02	ADMIN	asistio
31	9	1	2026-01-09	1	\N	2026-01-13 15:15:03	ADMIN	asistio
32	11	1	2026-01-05	1	\N	2026-01-09 16:35:29	ADMIN	asistio
33	11	1	2026-01-06	1	\N	2026-01-09 16:35:29	ADMIN	asistio
34	11	1	2026-01-07	1	\N	2026-01-09 16:35:29	ADMIN	asistio
35	11	1	2026-01-08	1	\N	2026-01-09 16:35:29	ADMIN	asistio
36	11	1	2026-01-09	1	\N	2026-01-09 16:35:29	ADMIN	asistio
37	46	1	2026-01-05	1	\N	2026-01-09 16:35:29	ADMIN	asistio
38	46	1	2026-01-06	1	\N	2026-01-09 16:35:30	ADMIN	asistio
39	46	1	2026-01-07	1	\N	2026-01-09 16:35:30	ADMIN	asistio
40	46	1	2026-01-08	1	\N	2026-01-09 16:35:30	ADMIN	asistio
41	46	1	2026-01-09	1	\N	2026-01-09 16:35:30	ADMIN	asistio
42	37	1	2026-01-05	1	\N	2026-01-09 16:35:31	ADMIN	asistio
43	37	1	2026-01-06	1	\N	2026-01-09 16:35:31	ADMIN	asistio
44	37	1	2026-01-07	1	\N	2026-01-09 16:35:31	ADMIN	asistio
45	37	1	2026-01-08	1	\N	2026-01-09 16:35:32	ADMIN	asistio
46	37	1	2026-01-09	1	\N	2026-01-09 16:35:32	ADMIN	asistio
47	13	1	2026-01-05	1	\N	2026-01-06 14:26:26	ADMIN	asistio
48	13	1	2026-01-06	0	\N	2026-01-06 14:26:26	ADMIN	falto
49	13	1	2026-01-07	0	\N	2026-01-06 14:26:26	ADMIN	falto
50	13	1	2026-01-08	0	\N	2026-01-06 14:26:26	ADMIN	falto
51	13	1	2026-01-09	0	\N	2026-01-06 14:26:26	ADMIN	falto
52	48	1	2026-01-05	1	\N	2026-01-09 16:35:32	ADMIN	asistio
53	48	1	2026-01-06	1	\N	2026-01-09 16:35:32	ADMIN	asistio
54	48	1	2026-01-07	1	\N	2026-01-09 16:35:32	ADMIN	asistio
55	48	1	2026-01-08	1	\N	2026-01-09 16:35:32	ADMIN	asistio
56	48	1	2026-01-09	1	\N	2026-01-09 16:35:32	ADMIN	asistio
57	15	1	2026-01-05	1	\N	2026-01-09 16:35:32	ADMIN	asistio
58	15	1	2026-01-06	1	\N	2026-01-09 16:35:33	ADMIN	asistio
59	15	1	2026-01-07	1	\N	2026-01-09 16:35:33	ADMIN	asistio
60	15	1	2026-01-08	1	\N	2026-01-09 16:35:33	ADMIN	asistio
61	15	1	2026-01-09	1	\N	2026-01-09 16:35:33	ADMIN	asistio
62	17	1	2026-01-05	1	\N	2026-01-09 16:35:33	ADMIN	asistio
63	17	1	2026-01-06	1	\N	2026-01-09 16:35:33	ADMIN	asistio
64	17	1	2026-01-07	1	\N	2026-01-09 16:35:33	ADMIN	asistio
65	17	1	2026-01-08	1	\N	2026-01-09 16:35:33	ADMIN	asistio
66	17	1	2026-01-09	1	\N	2026-01-09 16:35:34	ADMIN	asistio
67	50	1	2026-01-05	1	\N	2026-01-09 16:35:34	ADMIN	asistio
68	50	1	2026-01-06	1	\N	2026-01-09 16:35:34	ADMIN	asistio
69	50	1	2026-01-07	1	\N	2026-01-09 16:35:34	ADMIN	asistio
70	50	1	2026-01-08	1	\N	2026-01-09 16:35:34	ADMIN	asistio
71	50	1	2026-01-09	1	\N	2026-01-09 16:35:34	ADMIN	asistio
72	19	1	2026-01-05	1	\N	2026-01-09 16:35:34	ADMIN	asistio
73	19	1	2026-01-06	1	\N	2026-01-09 16:35:34	ADMIN	asistio
74	19	1	2026-01-07	1	\N	2026-01-09 16:35:34	ADMIN	asistio
75	19	1	2026-01-08	1	\N	2026-01-09 16:35:35	ADMIN	asistio
76	19	1	2026-01-09	1	\N	2026-01-09 16:35:35	ADMIN	asistio
77	21	1	2026-01-05	1	\N	2026-01-09 16:35:35	ADMIN	asistio
78	21	1	2026-01-06	1	\N	2026-01-09 16:35:35	ADMIN	asistio
79	21	1	2026-01-07	1	\N	2026-01-09 16:35:35	ADMIN	asistio
80	21	1	2026-01-08	1	\N	2026-01-09 16:35:35	ADMIN	asistio
81	21	1	2026-01-09	1	\N	2026-01-09 16:35:35	ADMIN	asistio
82	23	1	2026-01-05	0	\N	2026-01-13 15:15:27	ADMIN	falto
83	23	1	2026-01-06	1	\N	2026-01-13 15:15:27	ADMIN	asistio
84	23	1	2026-01-07	1	\N	2026-01-13 15:15:27	ADMIN	asistio
85	23	1	2026-01-08	1	\N	2026-01-13 15:15:28	ADMIN	asistio
86	23	1	2026-01-09	1	\N	2026-01-13 15:15:28	ADMIN	asistio
87	25	1	2026-01-05	1	\N	2026-01-13 15:15:30	ADMIN	asistio
88	25	1	2026-01-06	1	\N	2026-01-13 15:15:30	ADMIN	asistio
89	25	1	2026-01-07	1	\N	2026-01-13 15:15:31	ADMIN	asistio
90	25	1	2026-01-08	1	\N	2026-01-13 15:15:31	ADMIN	asistio
91	25	1	2026-01-09	1	\N	2026-01-13 15:15:32	ADMIN	asistio
92	52	1	2026-01-05	1	\N	2026-01-09 16:35:39	ADMIN	asistio
93	52	1	2026-01-06	1	\N	2026-01-09 16:35:39	ADMIN	asistio
94	52	1	2026-01-07	1	\N	2026-01-09 16:35:39	ADMIN	asistio
95	52	1	2026-01-08	1	\N	2026-01-09 16:35:39	ADMIN	asistio
96	52	1	2026-01-09	1	\N	2026-01-09 16:35:39	ADMIN	asistio
97	42	1	2026-01-05	1	\N	2026-01-09 16:35:41	ADMIN	asistio
98	42	1	2026-01-06	1	\N	2026-01-09 16:35:41	ADMIN	tardanza
99	42	1	2026-01-07	1	\N	2026-01-09 16:35:41	ADMIN	tardanza
100	42	1	2026-01-08	1	\N	2026-01-09 16:35:41	ADMIN	asistio
101	42	1	2026-01-09	1	\N	2026-01-09 16:35:41	ADMIN	asistio
102	27	1	2026-01-05	1	\N	2026-01-09 16:35:41	ADMIN	asistio
103	27	1	2026-01-06	1	\N	2026-01-09 16:35:42	ADMIN	asistio
104	27	1	2026-01-07	1	\N	2026-01-09 16:35:42	ADMIN	asistio
105	27	1	2026-01-08	1	\N	2026-01-09 16:35:42	ADMIN	asistio
106	27	1	2026-01-09	0	\N	2026-01-09 16:35:42	ADMIN	falto
107	30	1	2026-01-05	1	\N	2026-01-13 15:15:43	ADMIN	asistio
108	30	1	2026-01-06	1	\N	2026-01-13 15:15:43	ADMIN	asistio
109	30	1	2026-01-07	1	\N	2026-01-13 15:15:44	ADMIN	asistio
110	30	1	2026-01-08	1	\N	2026-01-13 15:15:44	ADMIN	asistio
111	30	1	2026-01-09	1	\N	2026-01-13 15:15:44	ADMIN	asistio
112	33	1	2026-01-05	1	\N	2026-01-13 15:15:45	ADMIN	asistio
113	33	1	2026-01-06	1	\N	2026-01-13 15:15:45	ADMIN	asistio
114	33	1	2026-01-07	1	\N	2026-01-13 15:15:45	ADMIN	asistio
115	33	1	2026-01-08	1	\N	2026-01-13 15:15:46	ADMIN	asistio
116	33	1	2026-01-09	1	\N	2026-01-13 15:15:46	ADMIN	asistio
117	29	1	2026-01-05	1	\N	2026-01-13 15:15:47	ADMIN	asistio
118	29	1	2026-01-06	1	\N	2026-01-13 15:15:47	ADMIN	asistio
119	29	1	2026-01-07	1	\N	2026-01-13 15:15:47	ADMIN	asistio
120	29	1	2026-01-08	1	\N	2026-01-13 15:15:48	ADMIN	asistio
121	29	1	2026-01-09	1	\N	2026-01-13 15:15:48	ADMIN	asistio
122	34	1	2026-01-05	1	\N	2026-01-13 15:15:48	ADMIN	asistio
123	34	1	2026-01-06	1	\N	2026-01-13 15:15:49	ADMIN	asistio
124	34	1	2026-01-07	1	\N	2026-01-13 15:15:49	ADMIN	asistio
125	34	1	2026-01-08	1	\N	2026-01-13 15:15:49	ADMIN	asistio
126	34	1	2026-01-09	1	\N	2026-01-13 15:15:50	ADMIN	asistio
127	36	1	2026-01-05	1	\N	2026-01-09 16:35:45	ADMIN	asistio
128	36	1	2026-01-06	1	\N	2026-01-09 16:35:45	ADMIN	asistio
129	36	1	2026-01-07	1	\N	2026-01-09 16:35:45	ADMIN	asistio
130	36	1	2026-01-08	1	\N	2026-01-09 16:35:45	ADMIN	asistio
131	36	1	2026-01-09	1	\N	2026-01-09 16:35:45	ADMIN	asistio
132	64	1	2026-01-06	1	\N	2026-01-10 16:13:21	ADMIN	asistio
133	64	1	2026-01-08	1	\N	2026-01-10 16:13:21	ADMIN	asistio
134	64	1	2026-01-10	1	\N	2026-01-10 16:13:21	ADMIN	asistio
135	63	1	2026-01-06	1	\N	2026-01-10 16:13:21	ADMIN	asistio
136	63	1	2026-01-08	1	\N	2026-01-10 16:13:21	ADMIN	asistio
137	63	1	2026-01-10	1	\N	2026-01-10 16:13:21	ADMIN	asistio
138	65	1	2026-01-06	1	\N	2026-01-08 03:04:38	ADMIN	asistio
139	65	1	2026-01-08	0	\N	2026-01-08 03:04:38	ADMIN	falto
140	65	1	2026-01-10	0	\N	2026-01-08 03:04:39	ADMIN	falto
141	66	1	2026-01-06	1	\N	2026-01-10 16:13:22	ADMIN	asistio
142	66	1	2026-01-08	1	\N	2026-01-10 16:13:22	ADMIN	asistio
143	66	1	2026-01-10	0	\N	2026-01-10 16:13:22	ADMIN	falto
144	78	1	2026-01-06	1	\N	2026-01-10 16:13:22	ADMIN	asistio
145	78	1	2026-01-08	1	\N	2026-01-10 16:13:22	ADMIN	asistio
146	78	1	2026-01-10	1	\N	2026-01-10 16:13:22	ADMIN	asistio
147	67	1	2026-01-06	1	\N	2026-01-08 03:04:41	ADMIN	asistio
148	67	1	2026-01-08	0	\N	2026-01-08 03:04:41	ADMIN	falto
149	67	1	2026-01-10	0	\N	2026-01-08 03:04:41	ADMIN	falto
150	68	1	2026-01-06	1	\N	2026-01-10 16:13:24	ADMIN	asistio
151	68	1	2026-01-08	1	\N	2026-01-10 16:13:24	ADMIN	asistio
152	68	1	2026-01-10	1	\N	2026-01-10 16:13:24	ADMIN	asistio
153	69	1	2026-01-06	1	\N	2026-01-10 16:13:24	ADMIN	asistio
154	69	1	2026-01-08	1	\N	2026-01-10 16:13:24	ADMIN	asistio
155	69	1	2026-01-10	1	\N	2026-01-10 16:13:24	ADMIN	asistio
156	80	1	2026-01-06	1	\N	2026-01-10 16:13:25	ADMIN	asistio
157	80	1	2026-01-08	1	\N	2026-01-10 16:13:25	ADMIN	asistio
158	80	1	2026-01-10	1	\N	2026-01-10 16:13:25	ADMIN	asistio
159	79	1	2026-01-06	1	\N	2026-01-10 16:13:25	ADMIN	asistio
160	79	1	2026-01-08	1	\N	2026-01-10 16:13:25	ADMIN	asistio
161	79	1	2026-01-10	0	\N	2026-01-10 16:13:25	ADMIN	justificada
162	81	1	2026-01-06	1	\N	2026-01-08 03:04:46	ADMIN	asistio
163	81	1	2026-01-08	0	\N	2026-01-08 03:04:46	ADMIN	falto
164	81	1	2026-01-10	0	\N	2026-01-08 03:04:46	ADMIN	falto
165	70	1	2026-01-06	1	\N	2026-01-10 16:13:26	ADMIN	asistio
166	70	1	2026-01-08	1	\N	2026-01-10 16:13:26	ADMIN	asistio
167	70	1	2026-01-10	0	\N	2026-01-10 16:13:26	ADMIN	falto
168	71	1	2026-01-06	1	\N	2026-01-08 03:04:47	ADMIN	asistio
169	71	1	2026-01-08	0	\N	2026-01-08 03:04:47	ADMIN	falto
170	71	1	2026-01-10	0	\N	2026-01-08 03:04:47	ADMIN	falto
171	77	1	2026-01-06	1	\N	2026-01-10 16:13:26	ADMIN	asistio
172	77	1	2026-01-08	1	\N	2026-01-10 16:13:27	ADMIN	asistio
173	77	1	2026-01-10	1	\N	2026-01-10 16:13:27	ADMIN	asistio
174	72	1	2026-01-06	1	\N	2026-01-08 03:04:48	ADMIN	asistio
175	72	1	2026-01-08	0	\N	2026-01-08 03:04:49	ADMIN	falto
176	72	1	2026-01-10	0	\N	2026-01-08 03:04:49	ADMIN	falto
177	73	1	2026-01-06	1	\N	2026-01-08 03:04:50	ADMIN	asistio
178	73	1	2026-01-08	0	\N	2026-01-08 03:04:50	ADMIN	falto
179	73	1	2026-01-10	0	\N	2026-01-08 03:04:50	ADMIN	falto
180	82	1	2026-01-06	1	\N	2026-01-10 16:13:27	ADMIN	asistio
181	82	1	2026-01-08	1	\N	2026-01-10 16:13:28	ADMIN	asistio
182	82	1	2026-01-10	1	\N	2026-01-10 16:13:28	ADMIN	asistio
183	74	1	2026-01-06	1	\N	2026-01-08 03:04:51	ADMIN	asistio
184	74	1	2026-01-08	0	\N	2026-01-08 03:04:51	ADMIN	falto
185	74	1	2026-01-10	0	\N	2026-01-08 03:04:52	ADMIN	falto
186	76	1	2026-01-06	1	\N	2026-01-08 03:04:52	ADMIN	asistio
187	76	1	2026-01-08	0	\N	2026-01-08 03:04:52	ADMIN	falto
188	76	1	2026-01-10	0	\N	2026-01-08 03:04:52	ADMIN	falto
189	75	1	2026-01-06	1	\N	2026-01-08 03:04:53	ADMIN	asistio
190	75	1	2026-01-08	0	\N	2026-01-08 03:04:53	ADMIN	falto
191	75	1	2026-01-10	0	\N	2026-01-08 03:04:53	ADMIN	falto
192	93	1	2026-01-05	1	\N	2026-01-10 16:42:47	ADMIN	asistio
193	93	1	2026-01-07	1	\N	2026-01-10 16:42:47	ADMIN	asistio
194	93	1	2026-01-09	1	\N	2026-01-10 16:42:47	ADMIN	asistio
195	94	1	2026-01-05	0	\N	2026-01-10 16:42:47	ADMIN	falto
196	94	1	2026-01-07	1	\N	2026-01-10 16:42:47	ADMIN	asistio
197	94	1	2026-01-09	1	\N	2026-01-10 16:42:48	ADMIN	asistio
198	97	1	2026-01-05	1	\N	2026-01-10 16:42:48	ADMIN	asistio
199	97	1	2026-01-07	1	\N	2026-01-10 16:42:48	ADMIN	asistio
200	97	1	2026-01-09	1	\N	2026-01-10 16:42:48	ADMIN	asistio
201	99	1	2026-01-05	1	\N	2026-01-10 16:42:48	ADMIN	asistio
202	99	1	2026-01-07	1	\N	2026-01-10 16:42:48	ADMIN	asistio
203	99	1	2026-01-09	1	\N	2026-01-10 16:42:48	ADMIN	asistio
204	100	1	2026-01-05	1	\N	2026-01-10 16:42:48	ADMIN	asistio
205	100	1	2026-01-07	1	\N	2026-01-10 16:42:48	ADMIN	asistio
206	100	1	2026-01-09	1	\N	2026-01-10 16:42:49	ADMIN	asistio
207	169	1	2026-01-05	0	\N	2026-01-10 16:42:49	ADMIN	falto
208	169	1	2026-01-07	1	\N	2026-01-10 16:42:49	ADMIN	asistio
209	169	1	2026-01-09	1	\N	2026-01-10 16:42:49	ADMIN	asistio
210	101	1	2026-01-05	1	\N	2026-01-10 16:42:49	ADMIN	asistio
211	101	1	2026-01-07	1	\N	2026-01-10 16:42:50	ADMIN	asistio
212	101	1	2026-01-09	1	\N	2026-01-10 16:42:50	ADMIN	asistio
213	102	1	2026-01-05	1	\N	2026-01-10 16:42:50	ADMIN	asistio
214	102	1	2026-01-07	1	\N	2026-01-10 16:42:50	ADMIN	asistio
215	102	1	2026-01-09	0	\N	2026-01-10 16:42:50	ADMIN	justificada
216	104	1	2026-01-05	1	\N	2026-01-10 16:42:50	ADMIN	asistio
217	104	1	2026-01-07	1	\N	2026-01-10 16:42:50	ADMIN	asistio
218	104	1	2026-01-09	1	\N	2026-01-10 16:42:50	ADMIN	asistio
219	105	1	2026-01-05	1	\N	2026-01-10 16:42:50	ADMIN	asistio
220	105	1	2026-01-07	1	\N	2026-01-10 16:42:51	ADMIN	asistio
221	105	1	2026-01-09	0	\N	2026-01-10 16:42:51	ADMIN	falto
222	107	1	2026-01-05	1	\N	2026-01-10 16:42:51	ADMIN	asistio
223	107	1	2026-01-07	1	\N	2026-01-10 16:42:51	ADMIN	asistio
224	107	1	2026-01-09	1	\N	2026-01-10 16:42:51	ADMIN	asistio
225	109	1	2026-01-05	1	\N	2026-01-10 16:42:51	ADMIN	asistio
226	109	1	2026-01-07	1	\N	2026-01-10 16:42:51	ADMIN	asistio
227	109	1	2026-01-09	1	\N	2026-01-10 16:42:51	ADMIN	asistio
228	110	1	2026-01-05	1	\N	2026-01-10 16:42:52	ADMIN	asistio
229	110	1	2026-01-07	1	\N	2026-01-10 16:42:52	ADMIN	asistio
230	110	1	2026-01-09	1	\N	2026-01-10 16:42:52	ADMIN	asistio
231	111	1	2026-01-05	0	\N	2026-01-10 16:42:52	ADMIN	falto
232	111	1	2026-01-07	1	\N	2026-01-10 16:42:52	ADMIN	asistio
233	111	1	2026-01-09	1	\N	2026-01-10 16:42:52	ADMIN	asistio
234	112	1	2026-01-05	1	\N	2026-01-10 16:42:53	ADMIN	asistio
235	112	1	2026-01-07	1	\N	2026-01-10 16:42:53	ADMIN	asistio
236	112	1	2026-01-09	1	\N	2026-01-10 16:42:53	ADMIN	asistio
237	114	1	2026-01-05	1	\N	2026-01-10 16:42:53	ADMIN	asistio
238	114	1	2026-01-07	1	\N	2026-01-10 16:42:53	ADMIN	asistio
239	114	1	2026-01-09	1	\N	2026-01-10 16:42:53	ADMIN	asistio
240	117	1	2026-01-05	1	\N	2026-01-10 16:42:53	ADMIN	asistio
241	117	1	2026-01-07	1	\N	2026-01-10 16:42:54	ADMIN	asistio
242	117	1	2026-01-09	1	\N	2026-01-10 16:42:54	ADMIN	asistio
243	120	1	2026-01-05	1	\N	2026-01-10 16:42:54	ADMIN	asistio
244	120	1	2026-01-07	1	\N	2026-01-10 16:42:54	ADMIN	asistio
245	120	1	2026-01-09	1	\N	2026-01-10 16:42:54	ADMIN	asistio
246	121	1	2026-01-05	1	\N	2026-01-10 16:42:54	ADMIN	asistio
247	121	1	2026-01-07	1	\N	2026-01-10 16:42:54	ADMIN	asistio
248	121	1	2026-01-09	1	\N	2026-01-10 16:42:54	ADMIN	asistio
249	122	1	2026-01-05	1	\N	2026-01-10 16:42:55	ADMIN	asistio
250	122	1	2026-01-07	1	\N	2026-01-10 16:42:55	ADMIN	asistio
251	122	1	2026-01-09	1	\N	2026-01-10 16:42:55	ADMIN	asistio
252	124	1	2026-01-05	1	\N	2026-01-10 16:42:55	ADMIN	asistio
253	124	1	2026-01-07	1	\N	2026-01-10 16:42:55	ADMIN	asistio
254	124	1	2026-01-09	1	\N	2026-01-10 16:42:55	ADMIN	asistio
255	125	1	2026-01-05	1	\N	2026-01-10 16:42:55	ADMIN	asistio
256	125	1	2026-01-07	1	\N	2026-01-10 16:42:55	ADMIN	asistio
257	125	1	2026-01-09	1	\N	2026-01-10 16:42:55	ADMIN	asistio
258	165	1	2026-01-05	0	\N	2026-01-10 16:42:56	ADMIN	falto
259	165	1	2026-01-07	1	\N	2026-01-10 16:42:56	ADMIN	asistio
260	165	1	2026-01-09	1	\N	2026-01-10 16:42:56	ADMIN	asistio
261	129	1	2026-01-05	1	\N	2026-01-10 16:42:56	ADMIN	asistio
262	129	1	2026-01-07	1	\N	2026-01-10 16:42:56	ADMIN	asistio
263	129	1	2026-01-09	1	\N	2026-01-10 16:42:56	ADMIN	asistio
264	127	1	2026-01-05	1	\N	2026-01-10 16:42:56	ADMIN	asistio
265	127	1	2026-01-07	1	\N	2026-01-10 16:42:56	ADMIN	asistio
266	127	1	2026-01-09	1	\N	2026-01-10 16:42:57	ADMIN	asistio
267	132	1	2026-01-05	1	\N	2026-01-10 16:42:57	ADMIN	asistio
268	132	1	2026-01-07	1	\N	2026-01-10 16:42:57	ADMIN	asistio
269	132	1	2026-01-09	1	\N	2026-01-10 16:42:57	ADMIN	asistio
270	133	1	2026-01-05	1	\N	2026-01-10 16:42:57	ADMIN	asistio
271	133	1	2026-01-07	1	\N	2026-01-10 16:42:57	ADMIN	asistio
272	133	1	2026-01-09	1	\N	2026-01-10 16:42:57	ADMIN	asistio
273	164	1	2026-01-05	0	\N	2026-01-10 16:42:57	ADMIN	falto
274	164	1	2026-01-07	1	\N	2026-01-10 16:42:57	ADMIN	asistio
275	164	1	2026-01-09	1	\N	2026-01-10 16:42:58	ADMIN	asistio
276	134	1	2026-01-05	1	\N	2026-01-10 16:42:58	ADMIN	asistio
277	134	1	2026-01-07	1	\N	2026-01-10 16:42:58	ADMIN	asistio
278	134	1	2026-01-09	1	\N	2026-01-10 16:42:58	ADMIN	asistio
279	137	1	2026-01-05	1	\N	2026-01-10 16:42:58	ADMIN	asistio
280	137	1	2026-01-07	1	\N	2026-01-10 16:42:58	ADMIN	asistio
281	137	1	2026-01-09	1	\N	2026-01-10 16:42:58	ADMIN	asistio
282	138	1	2026-01-05	1	\N	2026-01-10 16:42:58	ADMIN	asistio
283	138	1	2026-01-07	1	\N	2026-01-10 16:42:58	ADMIN	asistio
284	138	1	2026-01-09	1	\N	2026-01-10 16:42:59	ADMIN	asistio
285	139	1	2026-01-05	1	\N	2026-01-10 16:42:59	ADMIN	asistio
286	139	1	2026-01-07	1	\N	2026-01-10 16:42:59	ADMIN	asistio
287	139	1	2026-01-09	1	\N	2026-01-10 16:42:59	ADMIN	asistio
288	140	1	2026-01-05	1	\N	2026-01-10 16:42:59	ADMIN	asistio
289	140	1	2026-01-07	1	\N	2026-01-10 16:42:59	ADMIN	asistio
290	140	1	2026-01-09	1	\N	2026-01-10 16:42:59	ADMIN	asistio
291	141	1	2026-01-05	1	\N	2026-01-10 16:42:59	ADMIN	asistio
292	141	1	2026-01-07	1	\N	2026-01-10 16:43:00	ADMIN	asistio
293	141	1	2026-01-09	1	\N	2026-01-10 16:43:00	ADMIN	asistio
294	162	1	2026-01-05	1	\N	2026-01-10 16:43:00	ADMIN	asistio
295	162	1	2026-01-07	1	\N	2026-01-10 16:43:00	ADMIN	asistio
296	162	1	2026-01-09	1	\N	2026-01-10 16:43:00	ADMIN	asistio
297	142	1	2026-01-05	1	\N	2026-01-10 16:43:01	ADMIN	asistio
298	142	1	2026-01-07	0	\N	2026-01-10 16:43:01	ADMIN	falto
299	142	1	2026-01-09	1	\N	2026-01-10 16:43:01	ADMIN	asistio
300	143	1	2026-01-05	1	\N	2026-01-10 16:43:01	ADMIN	asistio
301	143	1	2026-01-07	1	\N	2026-01-10 16:43:01	ADMIN	asistio
302	143	1	2026-01-09	1	\N	2026-01-10 16:43:01	ADMIN	asistio
303	145	1	2026-01-05	1	\N	2026-01-10 16:43:01	ADMIN	asistio
304	145	1	2026-01-07	1	\N	2026-01-10 16:43:01	ADMIN	asistio
305	145	1	2026-01-09	1	\N	2026-01-10 16:43:02	ADMIN	asistio
306	146	1	2026-01-05	1	\N	2026-01-10 16:43:02	ADMIN	asistio
307	146	1	2026-01-07	1	\N	2026-01-10 16:43:02	ADMIN	asistio
308	146	1	2026-01-09	1	\N	2026-01-10 16:43:02	ADMIN	asistio
309	157	1	2026-01-05	1	\N	2026-01-10 16:43:02	ADMIN	asistio
310	157	1	2026-01-07	1	\N	2026-01-10 16:43:02	ADMIN	asistio
311	157	1	2026-01-09	1	\N	2026-01-10 16:43:02	ADMIN	asistio
312	147	1	2026-01-05	1	\N	2026-01-10 16:43:02	ADMIN	asistio
313	147	1	2026-01-07	1	\N	2026-01-10 16:43:03	ADMIN	asistio
314	147	1	2026-01-09	1	\N	2026-01-10 16:43:03	ADMIN	asistio
315	148	1	2026-01-05	1	\N	2026-01-10 16:43:03	ADMIN	asistio
316	148	1	2026-01-07	1	\N	2026-01-10 16:43:03	ADMIN	asistio
317	148	1	2026-01-09	1	\N	2026-01-10 16:43:03	ADMIN	asistio
318	158	1	2026-01-05	1	\N	2026-01-10 16:43:03	ADMIN	asistio
319	158	1	2026-01-07	1	\N	2026-01-10 16:43:03	ADMIN	asistio
320	158	1	2026-01-09	1	\N	2026-01-10 16:43:03	ADMIN	asistio
321	150	1	2026-01-05	1	\N	2026-01-10 16:43:03	ADMIN	asistio
322	150	1	2026-01-07	1	\N	2026-01-10 16:43:04	ADMIN	asistio
323	150	1	2026-01-09	1	\N	2026-01-10 16:43:04	ADMIN	asistio
324	152	1	2026-01-05	1	\N	2026-01-10 16:43:04	ADMIN	asistio
325	152	1	2026-01-07	1	\N	2026-01-10 16:43:04	ADMIN	asistio
326	152	1	2026-01-09	1	\N	2026-01-10 16:43:04	ADMIN	asistio
327	154	1	2026-01-05	1	\N	2026-01-10 16:43:04	ADMIN	asistio
328	154	1	2026-01-07	1	\N	2026-01-10 16:43:04	ADMIN	asistio
329	154	1	2026-01-09	1	\N	2026-01-10 16:43:04	ADMIN	asistio
330	160	1	2026-01-05	0	\N	2026-01-10 16:43:05	ADMIN	falto
331	160	1	2026-01-07	1	\N	2026-01-10 16:43:05	ADMIN	asistio
332	160	1	2026-01-09	1	\N	2026-01-10 16:43:05	ADMIN	asistio
333	156	1	2026-01-05	1	\N	2026-01-10 16:43:05	ADMIN	asistio
334	156	1	2026-01-07	1	\N	2026-01-10 16:43:05	ADMIN	asistio
335	156	1	2026-01-09	1	\N	2026-01-10 16:43:05	ADMIN	tardanza
336	135	1	2026-01-05	1	\N	2026-01-09 16:40:36	ADMIN	asistio
337	135	1	2026-01-06	1	\N	2026-01-09 16:40:36	ADMIN	asistio
338	135	1	2026-01-07	1	\N	2026-01-09 16:40:36	ADMIN	asistio
339	135	1	2026-01-08	1	\N	2026-01-09 16:40:36	ADMIN	asistio
340	135	1	2026-01-09	0	\N	2026-01-09 16:40:36	ADMIN	falto
341	136	1	2026-01-05	1	\N	2026-01-09 16:40:36	ADMIN	asistio
342	136	1	2026-01-06	1	\N	2026-01-09 16:40:36	ADMIN	asistio
343	136	1	2026-01-07	1	\N	2026-01-09 16:40:37	ADMIN	asistio
344	136	1	2026-01-08	1	\N	2026-01-09 16:40:37	ADMIN	asistio
345	136	1	2026-01-09	1	\N	2026-01-09 16:40:37	ADMIN	asistio
346	149	1	2026-01-05	1	\N	2026-01-09 16:40:38	ADMIN	asistio
347	149	1	2026-01-06	1	\N	2026-01-09 16:40:38	ADMIN	asistio
348	149	1	2026-01-07	1	\N	2026-01-09 16:40:38	ADMIN	asistio
349	149	1	2026-01-08	1	\N	2026-01-09 16:40:38	ADMIN	asistio
350	149	1	2026-01-09	1	\N	2026-01-09 16:40:38	ADMIN	asistio
351	151	1	2026-01-05	1	\N	2026-01-09 16:40:38	ADMIN	asistio
352	151	1	2026-01-06	1	\N	2026-01-09 16:40:38	ADMIN	asistio
353	151	1	2026-01-07	1	\N	2026-01-09 16:40:38	ADMIN	asistio
354	151	1	2026-01-08	1	\N	2026-01-09 16:40:39	ADMIN	asistio
355	151	1	2026-01-09	1	\N	2026-01-09 16:40:39	ADMIN	asistio
356	153	1	2026-01-05	1	\N	2026-01-09 16:40:39	ADMIN	asistio
357	153	1	2026-01-06	1	\N	2026-01-09 16:40:39	ADMIN	asistio
358	153	1	2026-01-07	1	\N	2026-01-09 16:40:39	ADMIN	asistio
359	153	1	2026-01-08	1	\N	2026-01-09 16:40:39	ADMIN	asistio
360	153	1	2026-01-09	1	\N	2026-01-09 16:40:39	ADMIN	asistio
361	159	1	2026-01-05	1	\N	2026-01-09 16:40:39	ADMIN	asistio
362	159	1	2026-01-06	1	\N	2026-01-09 16:40:40	ADMIN	asistio
363	159	1	2026-01-07	1	\N	2026-01-09 16:40:40	ADMIN	asistio
364	159	1	2026-01-08	1	\N	2026-01-09 16:40:40	ADMIN	asistio
365	159	1	2026-01-09	1	\N	2026-01-09 16:40:40	ADMIN	asistio
366	155	1	2026-01-05	1	\N	2026-01-09 16:40:40	ADMIN	asistio
367	155	1	2026-01-06	1	\N	2026-01-09 16:40:40	ADMIN	asistio
368	155	1	2026-01-07	1	\N	2026-01-09 16:40:40	ADMIN	asistio
369	155	1	2026-01-08	1	\N	2026-01-09 16:40:40	ADMIN	asistio
370	155	1	2026-01-09	1	\N	2026-01-09 16:40:41	ADMIN	asistio
371	161	1	2026-01-05	1	\N	2026-01-09 16:40:41	ADMIN	asistio
372	161	1	2026-01-06	1	\N	2026-01-09 16:40:41	ADMIN	asistio
373	161	1	2026-01-07	1	\N	2026-01-09 16:40:41	ADMIN	asistio
374	161	1	2026-01-08	1	\N	2026-01-09 16:40:41	ADMIN	asistio
375	161	1	2026-01-09	1	\N	2026-01-09 16:40:41	ADMIN	asistio
376	163	1	2026-01-05	1	\N	2026-01-09 16:40:41	ADMIN	asistio
377	163	1	2026-01-06	1	\N	2026-01-09 16:40:42	ADMIN	asistio
378	163	1	2026-01-07	1	\N	2026-01-09 16:40:42	ADMIN	asistio
379	163	1	2026-01-08	1	\N	2026-01-09 16:40:42	ADMIN	asistio
380	163	1	2026-01-09	1	\N	2026-01-09 16:40:42	ADMIN	asistio
381	166	1	2026-01-05	1	\N	2026-01-09 16:40:42	ADMIN	asistio
382	166	1	2026-01-06	1	\N	2026-01-09 16:40:42	ADMIN	asistio
383	166	1	2026-01-07	1	\N	2026-01-09 16:40:42	ADMIN	asistio
384	166	1	2026-01-08	1	\N	2026-01-09 16:40:42	ADMIN	asistio
385	166	1	2026-01-09	1	\N	2026-01-09 16:40:42	ADMIN	asistio
386	167	1	2026-01-05	1	\N	2026-01-09 16:40:43	ADMIN	asistio
387	167	1	2026-01-06	1	\N	2026-01-09 16:40:43	ADMIN	asistio
388	167	1	2026-01-07	1	\N	2026-01-09 16:40:43	ADMIN	asistio
389	167	1	2026-01-08	1	\N	2026-01-09 16:40:43	ADMIN	asistio
390	167	1	2026-01-09	1	\N	2026-01-09 16:40:43	ADMIN	asistio
391	168	1	2026-01-05	1	\N	2026-01-09 16:40:43	ADMIN	asistio
392	168	1	2026-01-06	1	\N	2026-01-09 16:40:43	ADMIN	asistio
393	168	1	2026-01-07	1	\N	2026-01-09 16:40:43	ADMIN	asistio
394	168	1	2026-01-08	1	\N	2026-01-09 16:40:44	ADMIN	asistio
395	168	1	2026-01-09	0	\N	2026-01-09 16:40:44	ADMIN	falto
396	170	1	2026-01-05	1	\N	2026-01-09 16:40:44	ADMIN	asistio
397	170	1	2026-01-06	1	\N	2026-01-09 16:40:44	ADMIN	asistio
398	170	1	2026-01-07	1	\N	2026-01-09 16:40:44	ADMIN	asistio
399	170	1	2026-01-08	1	\N	2026-01-09 16:40:44	ADMIN	asistio
400	170	1	2026-01-09	1	\N	2026-01-09 16:40:44	ADMIN	asistio
401	171	1	2026-01-05	1	\N	2026-01-09 16:40:44	ADMIN	asistio
402	171	1	2026-01-06	1	\N	2026-01-09 16:40:45	ADMIN	asistio
403	171	1	2026-01-07	1	\N	2026-01-09 16:40:45	ADMIN	asistio
404	171	1	2026-01-08	1	\N	2026-01-09 16:40:45	ADMIN	asistio
405	171	1	2026-01-09	1	\N	2026-01-09 16:40:45	ADMIN	asistio
406	172	1	2026-01-05	0	\N	2026-01-09 16:40:45	ADMIN	falto
407	172	1	2026-01-06	0	\N	2026-01-09 16:40:45	ADMIN	falto
408	172	1	2026-01-07	1	\N	2026-01-09 16:40:45	ADMIN	asistio
409	172	1	2026-01-08	1	\N	2026-01-09 16:40:45	ADMIN	asistio
410	172	1	2026-01-09	1	\N	2026-01-09 16:40:46	ADMIN	asistio
411	173	1	2026-01-05	1	\N	2026-01-09 16:40:46	ADMIN	asistio
412	173	1	2026-01-06	1	\N	2026-01-09 16:40:46	ADMIN	asistio
413	173	1	2026-01-07	1	\N	2026-01-09 16:40:46	ADMIN	asistio
414	173	1	2026-01-08	1	\N	2026-01-09 16:40:46	ADMIN	asistio
415	173	1	2026-01-09	1	\N	2026-01-09 16:40:46	ADMIN	asistio
416	174	1	2026-01-05	1	\N	2026-01-09 16:40:46	ADMIN	asistio
417	174	1	2026-01-06	1	\N	2026-01-09 16:40:46	ADMIN	asistio
418	174	1	2026-01-07	1	\N	2026-01-09 16:40:47	ADMIN	asistio
419	174	1	2026-01-08	1	\N	2026-01-09 16:40:47	ADMIN	asistio
420	174	1	2026-01-09	1	\N	2026-01-09 16:40:47	ADMIN	asistio
421	175	1	2026-01-05	1	\N	2026-01-09 16:40:47	ADMIN	asistio
422	175	1	2026-01-06	1	\N	2026-01-09 16:40:47	ADMIN	asistio
423	175	1	2026-01-07	1	\N	2026-01-09 16:40:47	ADMIN	asistio
424	175	1	2026-01-08	1	\N	2026-01-09 16:40:47	ADMIN	asistio
425	175	1	2026-01-09	1	\N	2026-01-09 16:40:47	ADMIN	asistio
426	177	1	2026-01-05	1	\N	2026-01-09 16:40:48	ADMIN	asistio
427	177	1	2026-01-06	1	\N	2026-01-09 16:40:48	ADMIN	asistio
428	177	1	2026-01-07	1	\N	2026-01-09 16:40:48	ADMIN	asistio
429	177	1	2026-01-08	1	\N	2026-01-09 16:40:48	ADMIN	asistio
430	177	1	2026-01-09	1	\N	2026-01-09 16:40:48	ADMIN	asistio
431	179	1	2026-01-05	1	\N	2026-01-09 16:40:48	ADMIN	asistio
432	179	1	2026-01-06	1	\N	2026-01-09 16:40:48	ADMIN	asistio
433	179	1	2026-01-07	1	\N	2026-01-09 16:40:48	ADMIN	asistio
434	179	1	2026-01-08	1	\N	2026-01-09 16:40:48	ADMIN	asistio
435	179	1	2026-01-09	1	\N	2026-01-09 16:40:49	ADMIN	asistio
436	180	1	2026-01-05	1	\N	2026-01-09 16:40:49	ADMIN	asistio
437	180	1	2026-01-06	1	\N	2026-01-09 16:40:49	ADMIN	asistio
438	180	1	2026-01-07	1	\N	2026-01-09 16:40:49	ADMIN	asistio
439	180	1	2026-01-08	1	\N	2026-01-09 16:40:49	ADMIN	asistio
440	180	1	2026-01-09	1	\N	2026-01-09 16:40:49	ADMIN	asistio
441	182	1	2026-01-05	1	\N	2026-01-09 16:40:49	ADMIN	asistio
442	182	1	2026-01-06	1	\N	2026-01-09 16:40:49	ADMIN	asistio
443	182	1	2026-01-07	1	\N	2026-01-09 16:40:50	ADMIN	asistio
444	182	1	2026-01-08	1	\N	2026-01-09 16:40:50	ADMIN	asistio
445	182	1	2026-01-09	1	\N	2026-01-09 16:40:50	ADMIN	asistio
446	183	1	2026-01-05	1	\N	2026-01-09 16:40:50	ADMIN	asistio
447	183	1	2026-01-06	1	\N	2026-01-09 16:40:50	ADMIN	asistio
448	183	1	2026-01-07	1	\N	2026-01-09 16:40:50	ADMIN	asistio
449	183	1	2026-01-08	1	\N	2026-01-09 16:40:50	ADMIN	asistio
450	183	1	2026-01-09	1	\N	2026-01-09 16:40:50	ADMIN	asistio
451	185	1	2026-01-05	1	\N	2026-01-09 16:40:50	ADMIN	asistio
452	185	1	2026-01-06	1	\N	2026-01-09 16:40:51	ADMIN	asistio
453	185	1	2026-01-07	1	\N	2026-01-09 16:40:51	ADMIN	asistio
454	185	1	2026-01-08	1	\N	2026-01-09 16:40:51	ADMIN	asistio
455	185	1	2026-01-09	1	\N	2026-01-09 16:40:51	ADMIN	asistio
456	186	1	2026-01-05	1	\N	2026-01-09 16:40:51	ADMIN	asistio
457	186	1	2026-01-06	1	\N	2026-01-09 16:40:51	ADMIN	asistio
458	186	1	2026-01-07	1	\N	2026-01-09 16:40:51	ADMIN	asistio
459	186	1	2026-01-08	1	\N	2026-01-09 16:40:51	ADMIN	asistio
460	186	1	2026-01-09	1	\N	2026-01-09 16:40:52	ADMIN	asistio
461	187	1	2026-01-05	1	\N	2026-01-09 16:40:52	ADMIN	asistio
462	187	1	2026-01-06	1	\N	2026-01-09 16:40:52	ADMIN	asistio
463	187	1	2026-01-07	1	\N	2026-01-09 16:40:52	ADMIN	asistio
464	187	1	2026-01-08	1	\N	2026-01-09 16:40:52	ADMIN	asistio
465	187	1	2026-01-09	1	\N	2026-01-09 16:40:52	ADMIN	asistio
466	188	1	2026-01-05	1	\N	2026-01-09 16:40:52	ADMIN	asistio
467	188	1	2026-01-06	1	\N	2026-01-09 16:40:52	ADMIN	asistio
468	188	1	2026-01-07	1	\N	2026-01-09 16:40:53	ADMIN	asistio
469	188	1	2026-01-08	1	\N	2026-01-09 16:40:53	ADMIN	asistio
470	188	1	2026-01-09	1	\N	2026-01-09 16:40:53	ADMIN	asistio
471	190	1	2026-01-05	1	\N	2026-01-09 16:40:53	ADMIN	asistio
472	190	1	2026-01-06	1	\N	2026-01-09 16:40:53	ADMIN	asistio
473	190	1	2026-01-07	1	\N	2026-01-09 16:40:53	ADMIN	asistio
474	190	1	2026-01-08	0	\N	2026-01-09 16:40:53	ADMIN	falto
475	190	1	2026-01-09	0	\N	2026-01-09 16:40:53	ADMIN	falto
476	191	1	2026-01-05	1	\N	2026-01-09 16:40:53	ADMIN	asistio
477	191	1	2026-01-06	1	\N	2026-01-09 16:40:54	ADMIN	asistio
478	191	1	2026-01-07	1	\N	2026-01-09 16:40:54	ADMIN	asistio
479	191	1	2026-01-08	1	\N	2026-01-09 16:40:54	ADMIN	asistio
480	191	1	2026-01-09	1	\N	2026-01-09 16:40:54	ADMIN	asistio
481	194	1	2026-01-05	1	\N	2026-01-09 16:40:54	ADMIN	asistio
482	194	1	2026-01-06	0	\N	2026-01-09 16:40:54	ADMIN	falto
483	194	1	2026-01-07	1	\N	2026-01-09 16:40:54	ADMIN	asistio
484	194	1	2026-01-08	1	\N	2026-01-09 16:40:55	ADMIN	asistio
485	194	1	2026-01-09	1	\N	2026-01-09 16:40:55	ADMIN	asistio
486	196	1	2026-01-05	1	\N	2026-01-09 16:40:55	ADMIN	asistio
487	196	1	2026-01-06	1	\N	2026-01-09 16:40:55	ADMIN	asistio
488	196	1	2026-01-07	1	\N	2026-01-09 16:40:55	ADMIN	asistio
489	196	1	2026-01-08	1	\N	2026-01-09 16:40:55	ADMIN	asistio
490	196	1	2026-01-09	1	\N	2026-01-09 16:40:55	ADMIN	asistio
491	197	1	2026-01-05	1	\N	2026-01-09 16:40:55	ADMIN	asistio
492	197	1	2026-01-06	1	\N	2026-01-09 16:40:56	ADMIN	asistio
493	197	1	2026-01-07	1	\N	2026-01-09 16:40:56	ADMIN	asistio
494	197	1	2026-01-08	1	\N	2026-01-09 16:40:56	ADMIN	asistio
495	197	1	2026-01-09	1	\N	2026-01-09 16:40:56	ADMIN	asistio
496	201	1	2026-01-05	1	\N	2026-01-09 16:40:56	ADMIN	asistio
497	201	1	2026-01-06	1	\N	2026-01-09 16:40:56	ADMIN	asistio
498	201	1	2026-01-07	1	\N	2026-01-09 16:40:56	ADMIN	asistio
499	201	1	2026-01-08	1	\N	2026-01-09 16:40:56	ADMIN	asistio
500	201	1	2026-01-09	1	\N	2026-01-09 16:40:56	ADMIN	asistio
501	220	1	2026-01-05	0	\N	2026-01-10 16:43:25	ADMIN	falto
502	220	1	2026-01-06	1	\N	2026-01-10 16:43:25	ADMIN	asistio
503	220	1	2026-01-07	1	\N	2026-01-10 16:43:25	ADMIN	asistio
504	220	1	2026-01-08	1	\N	2026-01-10 16:43:25	ADMIN	asistio
505	220	1	2026-01-09	1	\N	2026-01-10 16:43:25	ADMIN	asistio
506	209	1	2026-01-05	1	\N	2026-01-10 16:43:25	ADMIN	asistio
507	209	1	2026-01-06	1	\N	2026-01-10 16:43:25	ADMIN	asistio
508	209	1	2026-01-07	1	\N	2026-01-10 16:43:26	ADMIN	asistio
509	209	1	2026-01-08	1	\N	2026-01-10 16:43:26	ADMIN	asistio
510	209	1	2026-01-09	1	\N	2026-01-10 16:43:26	ADMIN	asistio
511	184	1	2026-01-05	1	\N	2026-01-10 16:43:26	ADMIN	asistio
512	184	1	2026-01-06	1	\N	2026-01-10 16:43:26	ADMIN	asistio
513	184	1	2026-01-07	1	\N	2026-01-10 16:43:26	ADMIN	asistio
514	184	1	2026-01-08	1	\N	2026-01-10 16:43:26	ADMIN	asistio
515	184	1	2026-01-09	1	\N	2026-01-10 16:43:26	ADMIN	asistio
516	222	1	2026-01-05	0	\N	2026-01-10 16:43:27	ADMIN	falto
517	222	1	2026-01-06	1	\N	2026-01-10 16:43:27	ADMIN	asistio
518	222	1	2026-01-07	1	\N	2026-01-10 16:43:27	ADMIN	asistio
519	222	1	2026-01-08	1	\N	2026-01-10 16:43:27	ADMIN	asistio
520	222	1	2026-01-09	1	\N	2026-01-10 16:43:27	ADMIN	asistio
521	181	1	2026-01-05	1	\N	2026-01-10 16:43:27	ADMIN	asistio
522	181	1	2026-01-06	1	\N	2026-01-10 16:43:27	ADMIN	asistio
523	181	1	2026-01-07	1	\N	2026-01-10 16:43:27	ADMIN	asistio
524	181	1	2026-01-08	1	\N	2026-01-10 16:43:27	ADMIN	asistio
525	181	1	2026-01-09	1	\N	2026-01-10 16:43:28	ADMIN	tardanza
526	216	1	2026-01-05	1	\N	2026-01-09 16:29:29	ADMIN	asistio
527	216	1	2026-01-06	1	\N	2026-01-09 16:29:29	ADMIN	asistio
528	216	1	2026-01-07	0	\N	2026-01-09 16:29:29	ADMIN	falto
529	216	1	2026-01-08	0	\N	2026-01-09 16:29:29	ADMIN	falto
530	216	1	2026-01-09	0	\N	2026-01-09 16:29:29	ADMIN	falto
531	207	1	2026-01-05	1	\N	2026-01-10 16:43:28	ADMIN	asistio
532	207	1	2026-01-06	1	\N	2026-01-10 16:43:28	ADMIN	asistio
533	207	1	2026-01-07	1	\N	2026-01-10 16:43:28	ADMIN	asistio
534	207	1	2026-01-08	1	\N	2026-01-10 16:43:28	ADMIN	asistio
535	207	1	2026-01-09	1	\N	2026-01-10 16:43:28	ADMIN	asistio
536	208	1	2026-01-05	1	\N	2026-01-10 16:43:28	ADMIN	asistio
537	208	1	2026-01-06	1	\N	2026-01-10 16:43:28	ADMIN	asistio
538	208	1	2026-01-07	1	\N	2026-01-10 16:43:29	ADMIN	asistio
539	208	1	2026-01-08	1	\N	2026-01-10 16:43:29	ADMIN	asistio
540	208	1	2026-01-09	1	\N	2026-01-10 16:43:29	ADMIN	asistio
541	193	1	2026-01-05	1	\N	2026-01-10 16:43:29	ADMIN	asistio
542	193	1	2026-01-06	1	\N	2026-01-10 16:43:29	ADMIN	asistio
543	193	1	2026-01-07	1	\N	2026-01-10 16:43:29	ADMIN	asistio
544	193	1	2026-01-08	1	\N	2026-01-10 16:43:29	ADMIN	asistio
545	193	1	2026-01-09	1	\N	2026-01-10 16:43:29	ADMIN	asistio
546	195	1	2026-01-05	1	\N	2026-01-10 16:43:29	ADMIN	asistio
547	195	1	2026-01-06	1	\N	2026-01-10 16:43:30	ADMIN	asistio
548	195	1	2026-01-07	1	\N	2026-01-10 16:43:30	ADMIN	asistio
549	195	1	2026-01-08	1	\N	2026-01-10 16:43:30	ADMIN	asistio
550	195	1	2026-01-09	1	\N	2026-01-10 16:43:30	ADMIN	asistio
551	219	1	2026-01-05	0	\N	2026-01-10 16:43:30	ADMIN	falto
552	219	1	2026-01-06	1	\N	2026-01-10 16:43:30	ADMIN	asistio
553	219	1	2026-01-07	1	\N	2026-01-10 16:43:30	ADMIN	asistio
554	219	1	2026-01-08	1	\N	2026-01-10 16:43:30	ADMIN	tardanza
555	219	1	2026-01-09	1	\N	2026-01-10 16:43:31	ADMIN	asistio
556	200	1	2026-01-05	0	\N	2026-01-10 16:43:31	ADMIN	falto
557	200	1	2026-01-06	1	\N	2026-01-10 16:43:31	ADMIN	asistio
558	200	1	2026-01-07	1	\N	2026-01-10 16:43:31	ADMIN	asistio
559	200	1	2026-01-08	1	\N	2026-01-10 16:43:31	ADMIN	asistio
560	200	1	2026-01-09	1	\N	2026-01-10 16:43:31	ADMIN	asistio
561	214	1	2026-01-05	1	\N	2026-01-10 16:43:31	ADMIN	asistio
562	214	1	2026-01-06	1	\N	2026-01-10 16:43:31	ADMIN	asistio
563	214	1	2026-01-07	1	\N	2026-01-10 16:43:31	ADMIN	asistio
564	214	1	2026-01-08	1	\N	2026-01-10 16:43:32	ADMIN	asistio
565	214	1	2026-01-09	1	\N	2026-01-10 16:43:32	ADMIN	asistio
566	221	1	2026-01-05	1	\N	2026-01-10 16:43:32	ADMIN	asistio
567	221	1	2026-01-06	1	\N	2026-01-10 16:43:32	ADMIN	asistio
568	221	1	2026-01-07	1	\N	2026-01-10 16:43:32	ADMIN	asistio
569	221	1	2026-01-08	1	\N	2026-01-10 16:43:32	ADMIN	asistio
570	221	1	2026-01-09	1	\N	2026-01-10 16:43:32	ADMIN	asistio
571	225	1	2026-01-05	0	\N	2026-01-10 16:43:32	ADMIN	falto
572	225	1	2026-01-06	0	\N	2026-01-10 16:43:33	ADMIN	falto
573	225	1	2026-01-07	1	\N	2026-01-10 16:43:33	ADMIN	asistio
574	225	1	2026-01-08	1	\N	2026-01-10 16:43:33	ADMIN	asistio
575	225	1	2026-01-09	1	\N	2026-01-10 16:43:33	ADMIN	asistio
576	198	1	2026-01-05	1	\N	2026-01-10 16:43:33	ADMIN	asistio
577	198	1	2026-01-06	1	\N	2026-01-10 16:43:33	ADMIN	asistio
578	198	1	2026-01-07	1	\N	2026-01-10 16:43:33	ADMIN	asistio
579	198	1	2026-01-08	1	\N	2026-01-10 16:43:33	ADMIN	asistio
580	198	1	2026-01-09	1	\N	2026-01-10 16:43:33	ADMIN	asistio
581	204	1	2026-01-05	1	\N	2026-01-10 16:43:34	ADMIN	asistio
582	204	1	2026-01-06	1	\N	2026-01-10 16:43:34	ADMIN	asistio
583	204	1	2026-01-07	1	\N	2026-01-10 16:43:34	ADMIN	asistio
584	204	1	2026-01-08	1	\N	2026-01-10 16:43:34	ADMIN	asistio
585	204	1	2026-01-09	1	\N	2026-01-10 16:43:34	ADMIN	asistio
586	218	1	2026-01-05	1	\N	2026-01-10 16:43:34	ADMIN	asistio
587	218	1	2026-01-06	1	\N	2026-01-10 16:43:34	ADMIN	asistio
588	218	1	2026-01-07	1	\N	2026-01-10 16:43:34	ADMIN	asistio
589	218	1	2026-01-08	1	\N	2026-01-10 16:43:35	ADMIN	asistio
590	218	1	2026-01-09	1	\N	2026-01-10 16:43:35	ADMIN	asistio
591	217	1	2026-01-05	1	\N	2026-01-10 16:43:35	ADMIN	asistio
592	217	1	2026-01-06	1	\N	2026-01-10 16:43:35	ADMIN	asistio
593	217	1	2026-01-07	1	\N	2026-01-10 16:43:35	ADMIN	asistio
594	217	1	2026-01-08	1	\N	2026-01-10 16:43:35	ADMIN	asistio
595	217	1	2026-01-09	1	\N	2026-01-10 16:43:35	ADMIN	asistio
596	213	1	2026-01-05	1	\N	2026-01-10 16:43:35	ADMIN	asistio
597	213	1	2026-01-06	1	\N	2026-01-10 16:43:36	ADMIN	asistio
598	213	1	2026-01-07	1	\N	2026-01-10 16:43:36	ADMIN	asistio
599	213	1	2026-01-08	1	\N	2026-01-10 16:43:36	ADMIN	asistio
600	213	1	2026-01-09	1	\N	2026-01-10 16:43:36	ADMIN	asistio
601	223	1	2026-01-05	0	\N	2026-01-10 16:43:36	ADMIN	falto
602	223	1	2026-01-06	0	\N	2026-01-10 16:43:36	ADMIN	falto
603	223	1	2026-01-07	1	\N	2026-01-10 16:43:36	ADMIN	asistio
604	223	1	2026-01-08	1	\N	2026-01-10 16:43:36	ADMIN	asistio
605	223	1	2026-01-09	1	\N	2026-01-10 16:43:36	ADMIN	asistio
606	210	1	2026-01-05	1	\N	2026-01-10 16:43:37	ADMIN	asistio
607	210	1	2026-01-06	1	\N	2026-01-10 16:43:37	ADMIN	asistio
608	210	1	2026-01-07	1	\N	2026-01-10 16:43:37	ADMIN	asistio
609	210	1	2026-01-08	1	\N	2026-01-10 16:43:37	ADMIN	asistio
610	210	1	2026-01-09	1	\N	2026-01-10 16:43:37	ADMIN	asistio
611	224	1	2026-01-05	0	\N	2026-01-10 16:43:37	ADMIN	falto
612	224	1	2026-01-06	0	\N	2026-01-10 16:43:37	ADMIN	falto
613	224	1	2026-01-07	1	\N	2026-01-10 16:43:37	ADMIN	asistio
614	224	1	2026-01-08	1	\N	2026-01-10 16:43:38	ADMIN	asistio
615	224	1	2026-01-09	1	\N	2026-01-10 16:43:38	ADMIN	asistio
616	202	1	2026-01-05	1	\N	2026-01-10 16:43:38	ADMIN	asistio
617	202	1	2026-01-06	1	\N	2026-01-10 16:43:38	ADMIN	asistio
618	202	1	2026-01-07	1	\N	2026-01-10 16:43:38	ADMIN	asistio
619	202	1	2026-01-08	1	\N	2026-01-10 16:43:38	ADMIN	asistio
620	202	1	2026-01-09	1	\N	2026-01-10 16:43:38	ADMIN	asistio
621	192	1	2026-01-05	1	\N	2026-01-10 16:43:38	ADMIN	asistio
622	192	1	2026-01-06	1	\N	2026-01-10 16:43:38	ADMIN	asistio
623	192	1	2026-01-07	1	\N	2026-01-10 16:43:39	ADMIN	asistio
624	192	1	2026-01-08	1	\N	2026-01-10 16:43:39	ADMIN	asistio
625	192	1	2026-01-09	1	\N	2026-01-10 16:43:39	ADMIN	asistio
626	215	1	2026-01-05	1	\N	2026-01-10 16:43:39	ADMIN	asistio
627	215	1	2026-01-06	1	\N	2026-01-10 16:43:39	ADMIN	asistio
628	215	1	2026-01-07	1	\N	2026-01-10 16:43:39	ADMIN	asistio
629	215	1	2026-01-08	1	\N	2026-01-10 16:43:39	ADMIN	asistio
630	215	1	2026-01-09	1	\N	2026-01-10 16:43:39	ADMIN	asistio
631	211	1	2026-01-05	1	\N	2026-01-10 16:43:40	ADMIN	asistio
632	211	1	2026-01-06	1	\N	2026-01-10 16:43:40	ADMIN	asistio
633	211	1	2026-01-07	1	\N	2026-01-10 16:43:40	ADMIN	asistio
634	211	1	2026-01-08	1	\N	2026-01-10 16:43:40	ADMIN	asistio
635	211	1	2026-01-09	1	\N	2026-01-10 16:43:40	ADMIN	asistio
636	203	1	2026-01-05	1	\N	2026-01-10 16:43:40	ADMIN	asistio
637	203	1	2026-01-06	1	\N	2026-01-10 16:43:40	ADMIN	asistio
638	203	1	2026-01-07	1	\N	2026-01-10 16:43:40	ADMIN	asistio
639	203	1	2026-01-08	1	\N	2026-01-10 16:43:41	ADMIN	asistio
640	203	1	2026-01-09	1	\N	2026-01-10 16:43:41	ADMIN	asistio
641	212	1	2026-01-05	1	\N	2026-01-10 16:43:41	ADMIN	asistio
642	212	1	2026-01-06	1	\N	2026-01-10 16:43:41	ADMIN	asistio
643	212	1	2026-01-07	1	\N	2026-01-10 16:43:41	ADMIN	asistio
644	212	1	2026-01-08	1	\N	2026-01-10 16:43:41	ADMIN	asistio
645	212	1	2026-01-09	0	\N	2026-01-10 16:43:41	ADMIN	falto
646	205	1	2026-01-05	1	\N	2026-01-10 16:43:41	ADMIN	asistio
647	205	1	2026-01-06	1	\N	2026-01-10 16:43:41	ADMIN	asistio
648	205	1	2026-01-07	1	\N	2026-01-10 16:43:42	ADMIN	asistio
649	205	1	2026-01-08	1	\N	2026-01-10 16:43:42	ADMIN	asistio
650	205	1	2026-01-09	1	\N	2026-01-10 16:43:42	ADMIN	asistio
651	178	1	2026-01-05	1	\N	2026-01-10 16:43:42	ADMIN	asistio
652	178	1	2026-01-06	1	\N	2026-01-10 16:43:42	ADMIN	asistio
653	178	1	2026-01-07	1	\N	2026-01-10 16:43:42	ADMIN	asistio
654	178	1	2026-01-08	1	\N	2026-01-10 16:43:42	ADMIN	asistio
655	178	1	2026-01-09	1	\N	2026-01-10 16:43:42	ADMIN	asistio
656	189	1	2026-01-05	1	\N	2026-01-10 16:43:43	ADMIN	asistio
657	189	1	2026-01-06	1	\N	2026-01-10 16:43:43	ADMIN	asistio
658	189	1	2026-01-07	1	\N	2026-01-10 16:43:43	ADMIN	asistio
659	189	1	2026-01-08	1	\N	2026-01-10 16:43:43	ADMIN	asistio
660	189	1	2026-01-09	1	\N	2026-01-10 16:43:43	ADMIN	asistio
661	206	1	2026-01-05	1	\N	2026-01-10 16:43:43	ADMIN	asistio
662	206	1	2026-01-06	1	\N	2026-01-10 16:43:43	ADMIN	asistio
663	206	1	2026-01-07	1	\N	2026-01-10 16:43:43	ADMIN	asistio
664	206	1	2026-01-08	1	\N	2026-01-10 16:43:43	ADMIN	asistio
665	206	1	2026-01-09	1	\N	2026-01-10 16:43:44	ADMIN	asistio
666	199	1	2026-01-05	1	\N	2026-01-10 16:43:44	ADMIN	asistio
667	199	1	2026-01-06	1	\N	2026-01-10 16:43:44	ADMIN	asistio
668	199	1	2026-01-07	1	\N	2026-01-10 16:43:44	ADMIN	tardanza
669	199	1	2026-01-08	1	\N	2026-01-10 16:43:44	ADMIN	asistio
670	199	1	2026-01-09	0	\N	2026-01-10 16:43:44	ADMIN	falto
671	176	1	2026-01-05	1	\N	2026-01-10 16:43:44	ADMIN	asistio
672	176	1	2026-01-06	1	\N	2026-01-10 16:43:44	ADMIN	asistio
673	176	1	2026-01-07	1	\N	2026-01-10 16:43:45	ADMIN	asistio
674	176	1	2026-01-08	1	\N	2026-01-10 16:43:45	ADMIN	asistio
675	176	1	2026-01-09	1	\N	2026-01-10 16:43:45	ADMIN	asistio
676	229	1	2026-01-05	0	\N	2026-01-09 16:35:20	ADMIN	falto
677	229	1	2026-01-06	0	\N	2026-01-09 16:35:20	ADMIN	falto
678	229	1	2026-01-07	1	\N	2026-01-09 16:35:20	ADMIN	asistio
679	229	1	2026-01-08	1	\N	2026-01-09 16:35:20	ADMIN	asistio
680	229	1	2026-01-09	1	\N	2026-01-09 16:35:20	ADMIN	asistio
681	87	1	2026-01-05	0	\N	2026-01-13 15:14:36	ADMIN	falto
682	87	1	2026-01-06	1	\N	2026-01-13 15:14:36	ADMIN	asistio
683	87	1	2026-01-07	1	\N	2026-01-13 15:14:36	ADMIN	asistio
684	87	1	2026-01-08	1	\N	2026-01-13 15:14:37	ADMIN	asistio
685	87	1	2026-01-09	1	\N	2026-01-13 15:14:37	ADMIN	asistio
686	85	1	2026-01-05	0	\N	2026-01-09 16:35:21	ADMIN	falto
687	85	1	2026-01-06	1	\N	2026-01-09 16:35:22	ADMIN	asistio
688	85	1	2026-01-07	1	\N	2026-01-09 16:35:22	ADMIN	asistio
689	85	1	2026-01-08	1	\N	2026-01-09 16:35:22	ADMIN	asistio
690	85	1	2026-01-09	1	\N	2026-01-09 16:35:22	ADMIN	asistio
691	86	1	2026-01-05	0	\N	2026-01-09 16:35:22	ADMIN	falto
692	86	1	2026-01-06	1	\N	2026-01-09 16:35:22	ADMIN	asistio
693	86	1	2026-01-07	1	\N	2026-01-09 16:35:22	ADMIN	asistio
694	86	1	2026-01-08	1	\N	2026-01-09 16:35:22	ADMIN	asistio
695	86	1	2026-01-09	0	\N	2026-01-09 16:35:23	ADMIN	falto
696	88	1	2026-01-05	0	\N	2026-01-13 15:14:49	ADMIN	falto
697	88	1	2026-01-06	0	\N	2026-01-13 15:14:50	ADMIN	falto
698	88	1	2026-01-07	1	\N	2026-01-13 15:14:50	ADMIN	asistio
699	88	1	2026-01-08	1	\N	2026-01-13 15:14:51	ADMIN	asistio
700	88	1	2026-01-09	1	\N	2026-01-13 15:14:51	ADMIN	asistio
701	228	1	2026-01-05	0	\N	2026-01-13 15:14:59	ADMIN	falto
702	228	1	2026-01-06	0	\N	2026-01-13 15:15:00	ADMIN	falto
703	228	1	2026-01-07	0	\N	2026-01-13 15:15:00	ADMIN	falto
704	228	1	2026-01-08	0	\N	2026-01-13 15:15:00	ADMIN	falto
705	228	1	2026-01-09	1	\N	2026-01-13 15:15:01	ADMIN	asistio
706	227	1	2026-01-05	0	\N	2026-01-09 16:35:35	ADMIN	falto
707	227	1	2026-01-06	0	\N	2026-01-09 16:35:36	ADMIN	falto
708	227	1	2026-01-07	1	\N	2026-01-09 16:35:36	ADMIN	asistio
709	227	1	2026-01-08	1	\N	2026-01-09 16:35:36	ADMIN	asistio
710	227	1	2026-01-09	0	\N	2026-01-09 16:35:36	ADMIN	falto
711	84	1	2026-01-05	1	\N	2026-01-09 16:35:37	ADMIN	asistio
712	84	1	2026-01-06	1	\N	2026-01-09 16:35:37	ADMIN	asistio
713	84	1	2026-01-07	1	\N	2026-01-09 16:35:37	ADMIN	asistio
714	84	1	2026-01-08	1	\N	2026-01-09 16:35:38	ADMIN	asistio
715	84	1	2026-01-09	1	\N	2026-01-09 16:35:38	ADMIN	asistio
716	226	1	2026-01-05	0	\N	2026-01-09 16:35:38	ADMIN	falto
717	226	1	2026-01-06	0	\N	2026-01-09 16:35:39	ADMIN	falto
718	226	1	2026-01-07	1	\N	2026-01-09 16:35:39	ADMIN	asistio
719	226	1	2026-01-08	1	\N	2026-01-09 16:35:39	ADMIN	asistio
720	226	1	2026-01-09	1	\N	2026-01-09 16:35:39	ADMIN	asistio
721	83	1	2026-01-05	1	\N	2026-01-09 16:35:40	ADMIN	asistio
722	83	1	2026-01-06	1	\N	2026-01-09 16:35:40	ADMIN	tardanza
723	83	1	2026-01-07	1	\N	2026-01-09 16:35:40	ADMIN	tardanza
724	83	1	2026-01-08	1	\N	2026-01-09 16:35:41	ADMIN	asistio
725	83	1	2026-01-09	1	\N	2026-01-09 16:35:41	ADMIN	asistio
726	230	1	2026-01-05	1	\N	2026-01-09 16:35:42	ADMIN	asistio
727	230	1	2026-01-06	0	\N	2026-01-09 16:35:42	ADMIN	falto
728	230	1	2026-01-07	1	\N	2026-01-09 16:35:42	ADMIN	asistio
729	230	1	2026-01-08	1	\N	2026-01-09 16:35:42	ADMIN	asistio
730	230	1	2026-01-09	1	\N	2026-01-09 16:35:43	ADMIN	asistio
731	231	1	2026-01-05	1	\N	2026-01-09 16:40:37	ADMIN	asistio
732	231	1	2026-01-06	1	\N	2026-01-09 16:40:37	ADMIN	asistio
733	231	1	2026-01-07	1	\N	2026-01-09 16:40:37	ADMIN	asistio
734	231	1	2026-01-08	1	\N	2026-01-09 16:40:37	ADMIN	asistio
735	231	1	2026-01-09	1	\N	2026-01-09 16:40:37	ADMIN	asistio
736	233	1	2026-01-05	1	\N	2026-01-09 14:45:52	ADMIN	asistio
737	233	1	2026-01-06	1	\N	2026-01-09 14:45:52	ADMIN	asistio
738	233	1	2026-01-07	1	\N	2026-01-09 14:45:52	ADMIN	asistio
739	233	1	2026-01-08	1	\N	2026-01-09 14:45:52	ADMIN	asistio
740	233	1	2026-01-09	0	\N	2026-01-09 14:45:52	ADMIN	falto
741	3	1	2026-01-05	1	\N	2026-01-13 15:14:33	ADMIN	asistio
742	3	1	2026-01-06	1	\N	2026-01-13 15:14:34	ADMIN	asistio
743	3	1	2026-01-07	1	\N	2026-01-13 15:14:34	ADMIN	asistio
744	3	1	2026-01-08	1	\N	2026-01-13 15:14:35	ADMIN	asistio
745	3	1	2026-01-09	1	\N	2026-01-13 15:14:35	ADMIN	asistio
746	6	1	2026-01-05	1	\N	2026-01-13 15:14:37	ADMIN	asistio
747	6	1	2026-01-06	1	\N	2026-01-13 15:14:38	ADMIN	asistio
748	6	1	2026-01-07	1	\N	2026-01-13 15:14:38	ADMIN	asistio
749	6	1	2026-01-08	1	\N	2026-01-13 15:14:38	ADMIN	asistio
750	6	1	2026-01-09	1	\N	2026-01-13 15:14:39	ADMIN	asistio
751	7	1	2026-01-05	1	\N	2026-01-13 15:14:44	ADMIN	asistio
752	7	1	2026-01-06	1	\N	2026-01-13 15:14:45	ADMIN	asistio
753	7	1	2026-01-07	1	\N	2026-01-13 15:14:45	ADMIN	asistio
754	7	1	2026-01-08	1	\N	2026-01-13 15:14:45	ADMIN	asistio
755	7	1	2026-01-09	1	\N	2026-01-13 15:14:46	ADMIN	asistio
756	10	1	2026-01-05	1	\N	2026-01-13 15:14:46	ADMIN	asistio
757	10	1	2026-01-06	1	\N	2026-01-13 15:14:46	ADMIN	asistio
758	10	1	2026-01-07	1	\N	2026-01-13 15:14:47	ADMIN	asistio
759	10	1	2026-01-08	1	\N	2026-01-13 15:14:47	ADMIN	asistio
760	10	1	2026-01-09	1	\N	2026-01-13 15:14:47	ADMIN	asistio
761	12	1	2026-01-05	1	\N	2026-01-13 15:14:53	ADMIN	asistio
762	12	1	2026-01-06	1	\N	2026-01-13 15:14:54	ADMIN	asistio
763	12	1	2026-01-07	1	\N	2026-01-13 15:14:54	ADMIN	asistio
764	12	1	2026-01-08	1	\N	2026-01-13 15:14:54	ADMIN	asistio
765	12	1	2026-01-09	1	\N	2026-01-13 15:14:55	ADMIN	asistio
766	14	1	2026-01-05	1	\N	2026-01-13 15:14:57	ADMIN	asistio
767	14	1	2026-01-06	1	\N	2026-01-13 15:14:58	ADMIN	asistio
768	14	1	2026-01-07	1	\N	2026-01-13 15:14:58	ADMIN	asistio
769	14	1	2026-01-08	1	\N	2026-01-13 15:14:59	ADMIN	asistio
770	14	1	2026-01-09	1	\N	2026-01-13 15:14:59	ADMIN	asistio
771	16	1	2026-01-05	1	\N	2026-01-10 13:06:50	ADMIN	asistio
772	16	1	2026-01-06	1	\N	2026-01-10 13:06:50	ADMIN	asistio
773	16	1	2026-01-07	1	\N	2026-01-10 13:06:50	ADMIN	asistio
774	16	1	2026-01-08	1	\N	2026-01-10 13:06:50	ADMIN	asistio
775	16	1	2026-01-09	1	\N	2026-01-10 13:06:50	ADMIN	asistio
776	18	1	2026-01-05	1	\N	2026-01-10 13:06:50	ADMIN	asistio
777	18	1	2026-01-06	1	\N	2026-01-10 13:06:50	ADMIN	asistio
778	18	1	2026-01-07	1	\N	2026-01-10 13:06:51	ADMIN	asistio
779	18	1	2026-01-08	1	\N	2026-01-10 13:06:51	ADMIN	asistio
780	18	1	2026-01-09	1	\N	2026-01-10 13:06:51	ADMIN	asistio
781	20	1	2026-01-05	0	\N	2026-01-13 15:15:06	ADMIN	falto
782	20	1	2026-01-06	1	\N	2026-01-13 15:15:07	ADMIN	asistio
783	20	1	2026-01-07	1	\N	2026-01-13 15:15:07	ADMIN	asistio
784	20	1	2026-01-08	1	\N	2026-01-13 15:15:08	ADMIN	asistio
785	20	1	2026-01-09	1	\N	2026-01-13 15:15:08	ADMIN	asistio
786	22	1	2026-01-05	1	\N	2026-01-13 15:15:08	ADMIN	asistio
787	22	1	2026-01-06	1	\N	2026-01-13 15:15:09	ADMIN	asistio
788	22	1	2026-01-07	1	\N	2026-01-13 15:15:09	ADMIN	asistio
789	22	1	2026-01-08	1	\N	2026-01-13 15:15:10	ADMIN	asistio
790	22	1	2026-01-09	1	\N	2026-01-13 15:15:10	ADMIN	asistio
791	24	1	2026-01-05	1	\N	2026-01-13 15:15:10	ADMIN	asistio
792	24	1	2026-01-06	1	\N	2026-01-13 15:15:11	ADMIN	asistio
793	24	1	2026-01-07	1	\N	2026-01-13 15:15:11	ADMIN	asistio
794	24	1	2026-01-08	1	\N	2026-01-13 15:15:12	ADMIN	asistio
795	24	1	2026-01-09	1	\N	2026-01-13 15:15:12	ADMIN	asistio
796	26	1	2026-01-05	1	\N	2026-01-13 15:15:12	ADMIN	asistio
797	26	1	2026-01-06	1	\N	2026-01-13 15:15:13	ADMIN	asistio
798	26	1	2026-01-07	1	\N	2026-01-13 15:15:13	ADMIN	asistio
799	26	1	2026-01-08	1	\N	2026-01-13 15:15:13	ADMIN	asistio
800	26	1	2026-01-09	1	\N	2026-01-13 15:15:14	ADMIN	asistio
801	28	1	2026-01-05	1	\N	2026-01-10 13:06:53	ADMIN	asistio
802	28	1	2026-01-06	1	\N	2026-01-10 13:06:53	ADMIN	asistio
803	28	1	2026-01-07	1	\N	2026-01-10 13:06:53	ADMIN	asistio
804	28	1	2026-01-08	1	\N	2026-01-10 13:06:54	ADMIN	asistio
805	28	1	2026-01-09	1	\N	2026-01-10 13:06:54	ADMIN	asistio
806	31	1	2026-01-05	1	\N	2026-01-13 15:15:14	ADMIN	asistio
807	31	1	2026-01-06	1	\N	2026-01-13 15:15:14	ADMIN	asistio
808	31	1	2026-01-07	1	\N	2026-01-13 15:15:15	ADMIN	asistio
809	31	1	2026-01-08	1	\N	2026-01-13 15:15:15	ADMIN	asistio
810	31	1	2026-01-09	1	\N	2026-01-13 15:15:16	ADMIN	asistio
811	32	1	2026-01-05	1	\N	2026-01-13 15:15:16	ADMIN	asistio
812	32	1	2026-01-06	1	\N	2026-01-13 15:15:16	ADMIN	asistio
813	32	1	2026-01-07	1	\N	2026-01-13 15:15:17	ADMIN	asistio
814	32	1	2026-01-08	1	\N	2026-01-13 15:15:17	ADMIN	asistio
815	32	1	2026-01-09	1	\N	2026-01-13 15:15:17	ADMIN	asistio
816	35	1	2026-01-05	1	\N	2026-01-10 13:06:55	ADMIN	asistio
817	35	1	2026-01-06	1	\N	2026-01-10 13:06:55	ADMIN	asistio
818	35	1	2026-01-07	1	\N	2026-01-10 13:06:55	ADMIN	asistio
819	35	1	2026-01-08	1	\N	2026-01-10 13:06:55	ADMIN	asistio
820	35	1	2026-01-09	1	\N	2026-01-10 13:06:55	ADMIN	asistio
821	38	1	2026-01-05	1	\N	2026-01-13 15:15:18	ADMIN	asistio
822	38	1	2026-01-06	1	\N	2026-01-13 15:15:19	ADMIN	asistio
823	38	1	2026-01-07	1	\N	2026-01-13 15:15:19	ADMIN	asistio
824	38	1	2026-01-08	1	\N	2026-01-13 15:15:19	ADMIN	asistio
825	38	1	2026-01-09	1	\N	2026-01-13 15:15:20	ADMIN	asistio
826	40	1	2026-01-05	1	\N	2026-01-13 15:15:20	ADMIN	asistio
827	40	1	2026-01-06	1	\N	2026-01-13 15:15:20	ADMIN	asistio
828	40	1	2026-01-07	0	\N	2026-01-13 15:15:21	ADMIN	falto
829	40	1	2026-01-08	1	\N	2026-01-13 15:15:21	ADMIN	asistio
830	40	1	2026-01-09	1	\N	2026-01-13 15:15:21	ADMIN	asistio
831	41	1	2026-01-05	1	\N	2026-01-13 15:15:22	ADMIN	asistio
832	41	1	2026-01-06	1	\N	2026-01-13 15:15:22	ADMIN	asistio
833	41	1	2026-01-07	1	\N	2026-01-13 15:15:22	ADMIN	asistio
834	41	1	2026-01-08	1	\N	2026-01-13 15:15:23	ADMIN	asistio
835	41	1	2026-01-09	1	\N	2026-01-13 15:15:23	ADMIN	asistio
836	43	1	2026-01-05	1	\N	2026-01-13 15:15:23	ADMIN	asistio
837	43	1	2026-01-06	1	\N	2026-01-13 15:15:24	ADMIN	asistio
838	43	1	2026-01-07	1	\N	2026-01-13 15:15:24	ADMIN	asistio
839	43	1	2026-01-08	1	\N	2026-01-13 15:15:24	ADMIN	asistio
840	43	1	2026-01-09	1	\N	2026-01-13 15:15:25	ADMIN	asistio
841	44	1	2026-01-05	1	\N	2026-01-13 15:15:25	ADMIN	asistio
842	44	1	2026-01-06	1	\N	2026-01-13 15:15:25	ADMIN	asistio
843	44	1	2026-01-07	1	\N	2026-01-13 15:15:26	ADMIN	asistio
844	44	1	2026-01-08	1	\N	2026-01-13 15:15:26	ADMIN	asistio
845	44	1	2026-01-09	1	\N	2026-01-13 15:15:26	ADMIN	asistio
846	45	1	2026-01-05	1	\N	2026-01-13 15:15:28	ADMIN	asistio
847	45	1	2026-01-06	1	\N	2026-01-13 15:15:29	ADMIN	asistio
848	45	1	2026-01-07	1	\N	2026-01-13 15:15:29	ADMIN	asistio
849	45	1	2026-01-08	1	\N	2026-01-13 15:15:29	ADMIN	asistio
850	45	1	2026-01-09	1	\N	2026-01-13 15:15:30	ADMIN	asistio
851	47	1	2026-01-05	1	\N	2026-01-10 13:06:59	ADMIN	asistio
852	47	1	2026-01-06	1	\N	2026-01-10 13:06:59	ADMIN	asistio
853	47	1	2026-01-07	0	\N	2026-01-10 13:06:59	ADMIN	falto
854	47	1	2026-01-08	1	\N	2026-01-10 13:06:59	ADMIN	asistio
855	47	1	2026-01-09	1	\N	2026-01-10 13:07:00	ADMIN	tardanza
856	49	1	2026-01-05	1	\N	2026-01-10 13:07:00	ADMIN	asistio
857	49	1	2026-01-06	1	\N	2026-01-10 13:07:00	ADMIN	asistio
858	49	1	2026-01-07	1	\N	2026-01-10 13:07:00	ADMIN	asistio
859	49	1	2026-01-08	1	\N	2026-01-10 13:07:00	ADMIN	asistio
860	49	1	2026-01-09	1	\N	2026-01-10 13:07:00	ADMIN	asistio
861	51	1	2026-01-05	1	\N	2026-01-13 15:15:34	ADMIN	asistio
862	51	1	2026-01-06	1	\N	2026-01-13 15:15:34	ADMIN	asistio
863	51	1	2026-01-07	1	\N	2026-01-13 15:15:34	ADMIN	asistio
864	51	1	2026-01-08	0	\N	2026-01-13 15:15:35	ADMIN	falto
865	51	1	2026-01-09	1	\N	2026-01-13 15:15:35	ADMIN	asistio
866	53	1	2026-01-05	1	\N	2026-01-10 13:07:01	ADMIN	asistio
867	53	1	2026-01-06	1	\N	2026-01-10 13:07:01	ADMIN	asistio
868	53	1	2026-01-07	1	\N	2026-01-10 13:07:01	ADMIN	asistio
869	53	1	2026-01-08	1	\N	2026-01-10 13:07:01	ADMIN	asistio
870	53	1	2026-01-09	1	\N	2026-01-10 13:07:02	ADMIN	asistio
871	54	1	2026-01-05	1	\N	2026-01-13 15:15:36	ADMIN	asistio
872	54	1	2026-01-06	1	\N	2026-01-13 15:15:36	ADMIN	asistio
873	54	1	2026-01-07	1	\N	2026-01-13 15:15:36	ADMIN	asistio
874	54	1	2026-01-08	1	\N	2026-01-13 15:15:37	ADMIN	asistio
875	54	1	2026-01-09	1	\N	2026-01-13 15:15:37	ADMIN	asistio
876	55	1	2026-01-05	1	\N	2026-01-10 13:07:02	ADMIN	asistio
877	55	1	2026-01-06	1	\N	2026-01-10 13:07:02	ADMIN	asistio
878	55	1	2026-01-07	1	\N	2026-01-10 13:07:03	ADMIN	asistio
879	55	1	2026-01-08	1	\N	2026-01-10 13:07:03	ADMIN	asistio
880	55	1	2026-01-09	1	\N	2026-01-10 13:07:03	ADMIN	asistio
881	56	1	2026-01-05	1	\N	2026-01-13 15:15:37	ADMIN	asistio
882	56	1	2026-01-06	1	\N	2026-01-13 15:15:38	ADMIN	asistio
883	56	1	2026-01-07	1	\N	2026-01-13 15:15:38	ADMIN	asistio
884	56	1	2026-01-08	0	\N	2026-01-13 15:15:38	ADMIN	justificada
885	56	1	2026-01-09	1	\N	2026-01-13 15:15:39	ADMIN	asistio
886	57	1	2026-01-05	1	\N	2026-01-10 13:07:03	ADMIN	asistio
887	57	1	2026-01-06	1	\N	2026-01-10 13:07:04	ADMIN	asistio
888	57	1	2026-01-07	1	\N	2026-01-10 13:07:04	ADMIN	asistio
889	57	1	2026-01-08	1	\N	2026-01-10 13:07:04	ADMIN	asistio
890	57	1	2026-01-09	1	\N	2026-01-10 13:07:04	ADMIN	asistio
891	58	1	2026-01-05	1	\N	2026-01-13 15:15:39	ADMIN	asistio
892	58	1	2026-01-06	1	\N	2026-01-13 15:15:39	ADMIN	asistio
893	58	1	2026-01-07	1	\N	2026-01-13 15:15:40	ADMIN	asistio
894	58	1	2026-01-08	1	\N	2026-01-13 15:15:41	ADMIN	asistio
895	58	1	2026-01-09	1	\N	2026-01-13 15:15:41	ADMIN	asistio
896	59	1	2026-01-05	1	\N	2026-01-13 15:15:41	ADMIN	asistio
897	59	1	2026-01-06	1	\N	2026-01-13 15:15:42	ADMIN	asistio
898	59	1	2026-01-07	1	\N	2026-01-13 15:15:42	ADMIN	asistio
899	59	1	2026-01-08	0	\N	2026-01-13 15:15:42	ADMIN	justificada
900	59	1	2026-01-09	1	\N	2026-01-13 15:15:43	ADMIN	asistio
901	60	1	2026-01-05	1	\N	2026-01-10 13:07:05	ADMIN	asistio
902	60	1	2026-01-06	1	\N	2026-01-10 13:07:05	ADMIN	asistio
903	60	1	2026-01-07	1	\N	2026-01-10 13:07:05	ADMIN	asistio
904	60	1	2026-01-08	1	\N	2026-01-10 13:07:06	ADMIN	asistio
905	60	1	2026-01-09	0	\N	2026-01-10 13:07:06	ADMIN	falto
906	61	1	2026-01-05	1	\N	2026-01-10 13:07:06	ADMIN	asistio
907	61	1	2026-01-06	1	\N	2026-01-10 13:07:06	ADMIN	asistio
908	61	1	2026-01-07	1	\N	2026-01-10 13:07:06	ADMIN	asistio
909	61	1	2026-01-08	1	\N	2026-01-10 13:07:06	ADMIN	asistio
910	61	1	2026-01-09	1	\N	2026-01-10 13:07:06	ADMIN	asistio
911	62	1	2026-01-05	1	\N	2026-01-10 13:07:06	ADMIN	asistio
912	62	1	2026-01-06	1	\N	2026-01-10 13:07:07	ADMIN	asistio
913	62	1	2026-01-07	0	\N	2026-01-10 13:07:07	ADMIN	falto
914	62	1	2026-01-08	1	\N	2026-01-10 13:07:07	ADMIN	asistio
915	62	1	2026-01-09	1	\N	2026-01-10 13:07:07	ADMIN	asistio
916	90	1	2026-01-06	0	\N	2026-01-08 03:04:37	ADMIN	falto
917	90	1	2026-01-08	0	\N	2026-01-08 03:04:37	ADMIN	falto
918	90	1	2026-01-10	0	\N	2026-01-08 03:04:37	ADMIN	falto
919	89	1	2026-01-06	0	\N	2026-01-08 03:04:38	ADMIN	falto
920	89	1	2026-01-08	0	\N	2026-01-08 03:04:38	ADMIN	falto
921	89	1	2026-01-10	0	\N	2026-01-08 03:04:38	ADMIN	falto
922	91	1	2026-01-06	1	\N	2026-01-10 16:13:21	ADMIN	asistio
923	91	1	2026-01-08	1	\N	2026-01-10 16:13:21	ADMIN	asistio
924	91	1	2026-01-10	1	\N	2026-01-10 16:13:22	ADMIN	asistio
925	92	1	2026-01-06	0	\N	2026-01-08 03:04:39	ADMIN	falto
926	92	1	2026-01-08	0	\N	2026-01-08 03:04:39	ADMIN	falto
927	92	1	2026-01-10	0	\N	2026-01-08 03:04:39	ADMIN	falto
928	123	1	2026-01-06	0	\N	2026-01-08 03:04:40	ADMIN	falto
929	123	1	2026-01-08	0	\N	2026-01-08 03:04:40	ADMIN	falto
930	123	1	2026-01-10	0	\N	2026-01-08 03:04:40	ADMIN	falto
931	95	1	2026-01-06	1	\N	2026-01-10 16:13:22	ADMIN	asistio
932	95	1	2026-01-08	1	\N	2026-01-10 16:13:23	ADMIN	asistio
933	95	1	2026-01-10	0	\N	2026-01-10 16:13:23	ADMIN	falto
934	144	1	2026-01-06	1	\N	2026-01-10 16:13:23	ADMIN	asistio
935	144	1	2026-01-08	0	\N	2026-01-10 16:13:23	ADMIN	falto
936	144	1	2026-01-10	0	\N	2026-01-10 16:13:23	ADMIN	falto
937	96	1	2026-01-06	0	\N	2026-01-08 03:04:42	ADMIN	falto
938	96	1	2026-01-08	0	\N	2026-01-08 03:04:43	ADMIN	falto
939	96	1	2026-01-10	0	\N	2026-01-08 03:04:43	ADMIN	falto
940	98	1	2026-01-06	0	\N	2026-01-08 03:04:43	ADMIN	falto
941	98	1	2026-01-08	0	\N	2026-01-08 03:04:43	ADMIN	falto
942	98	1	2026-01-10	0	\N	2026-01-08 03:04:43	ADMIN	falto
943	128	1	2026-01-06	0	\N	2026-01-08 03:04:44	ADMIN	falto
944	128	1	2026-01-08	0	\N	2026-01-08 03:04:44	ADMIN	falto
945	128	1	2026-01-10	0	\N	2026-01-08 03:04:44	ADMIN	falto
946	126	1	2026-01-06	0	\N	2026-01-08 03:04:45	ADMIN	falto
947	126	1	2026-01-08	0	\N	2026-01-08 03:04:45	ADMIN	falto
948	126	1	2026-01-10	0	\N	2026-01-08 03:04:45	ADMIN	falto
949	130	1	2026-01-06	1	\N	2026-01-10 16:13:25	ADMIN	asistio
950	130	1	2026-01-08	1	\N	2026-01-10 16:13:25	ADMIN	asistio
951	130	1	2026-01-10	1	\N	2026-01-10 16:13:26	ADMIN	asistio
952	103	1	2026-01-06	0	\N	2026-01-08 03:04:46	ADMIN	falto
953	103	1	2026-01-08	0	\N	2026-01-08 03:04:47	ADMIN	falto
954	103	1	2026-01-10	0	\N	2026-01-08 03:04:47	ADMIN	falto
955	106	1	2026-01-06	1	\N	2026-01-10 16:13:26	ADMIN	asistio
956	106	1	2026-01-08	1	\N	2026-01-10 16:13:26	ADMIN	asistio
957	106	1	2026-01-10	0	\N	2026-01-10 16:13:26	ADMIN	falto
958	119	1	2026-01-06	0	\N	2026-01-08 03:04:48	ADMIN	falto
959	119	1	2026-01-08	0	\N	2026-01-08 03:04:48	ADMIN	falto
960	119	1	2026-01-10	0	\N	2026-01-08 03:04:48	ADMIN	falto
961	108	1	2026-01-06	1	\N	2026-01-10 16:13:27	ADMIN	asistio
962	108	1	2026-01-08	1	\N	2026-01-10 16:13:27	ADMIN	asistio
963	108	1	2026-01-10	1	\N	2026-01-10 16:13:27	ADMIN	asistio
964	113	1	2026-01-06	1	\N	2026-01-10 16:13:27	ADMIN	asistio
965	113	1	2026-01-08	1	\N	2026-01-10 16:13:27	ADMIN	asistio
966	113	1	2026-01-10	1	\N	2026-01-10 16:13:27	ADMIN	asistio
967	131	1	2026-01-06	0	\N	2026-01-08 03:04:50	ADMIN	falto
968	131	1	2026-01-08	0	\N	2026-01-08 03:04:51	ADMIN	falto
969	131	1	2026-01-10	0	\N	2026-01-08 03:04:51	ADMIN	falto
970	115	1	2026-01-06	1	\N	2026-01-10 16:13:28	ADMIN	asistio
971	115	1	2026-01-08	1	\N	2026-01-10 16:13:28	ADMIN	asistio
972	115	1	2026-01-10	1	\N	2026-01-10 16:13:28	ADMIN	asistio
973	118	1	2026-01-06	1	\N	2026-01-10 16:13:28	ADMIN	asistio
974	118	1	2026-01-08	1	\N	2026-01-10 16:13:28	ADMIN	asistio
975	118	1	2026-01-10	1	\N	2026-01-10 16:13:28	ADMIN	asistio
976	116	1	2026-01-06	1	\N	2026-01-10 16:13:29	ADMIN	asistio
977	116	1	2026-01-08	1	\N	2026-01-10 16:13:29	ADMIN	asistio
978	116	1	2026-01-10	1	\N	2026-01-10 16:13:29	ADMIN	asistio
979	241	1	2026-01-06	0	\N	2026-01-10 16:13:23	ADMIN	falto
980	241	1	2026-01-08	1	\N	2026-01-10 16:13:23	ADMIN	asistio
981	241	1	2026-01-10	1	\N	2026-01-10 16:13:23	ADMIN	asistio
982	242	1	2026-01-06	0	\N	2026-01-10 16:13:23	ADMIN	falto
983	242	1	2026-01-08	1	\N	2026-01-10 16:13:24	ADMIN	asistio
984	242	1	2026-01-10	1	\N	2026-01-10 16:13:24	ADMIN	asistio
985	240	1	2026-01-05	0	\N	2026-01-09 16:40:35	ADMIN	falto
986	240	1	2026-01-06	0	\N	2026-01-09 16:40:35	ADMIN	falto
987	240	1	2026-01-07	0	\N	2026-01-09 16:40:35	ADMIN	falto
988	240	1	2026-01-08	1	\N	2026-01-09 16:40:35	ADMIN	asistio
989	240	1	2026-01-09	1	\N	2026-01-09 16:40:36	ADMIN	asistio
990	235	1	2026-01-05	0	\N	2026-01-13 15:14:48	ADMIN	falto
991	235	1	2026-01-06	0	\N	2026-01-13 15:14:48	ADMIN	falto
992	235	1	2026-01-07	0	\N	2026-01-13 15:14:48	ADMIN	falto
993	235	1	2026-01-08	0	\N	2026-01-13 15:14:49	ADMIN	falto
994	235	1	2026-01-09	0	\N	2026-01-13 15:14:49	ADMIN	falto
995	239	1	2026-01-05	0	\N	2026-01-13 15:14:52	ADMIN	falto
996	239	1	2026-01-06	0	\N	2026-01-13 15:14:52	ADMIN	falto
997	239	1	2026-01-07	0	\N	2026-01-13 15:14:52	ADMIN	falto
998	239	1	2026-01-08	1	\N	2026-01-13 15:14:53	ADMIN	asistio
999	239	1	2026-01-09	1	\N	2026-01-13 15:14:53	ADMIN	asistio
1000	237	1	2026-01-05	0	\N	2026-01-09 16:35:26	ADMIN	falto
1001	237	1	2026-01-06	0	\N	2026-01-09 16:35:26	ADMIN	falto
1002	237	1	2026-01-07	0	\N	2026-01-09 16:35:26	ADMIN	falto
1003	237	1	2026-01-08	1	\N	2026-01-09 16:35:26	ADMIN	asistio
1004	237	1	2026-01-09	0	\N	2026-01-09 16:35:26	ADMIN	falto
1005	232	1	2026-01-05	0	\N	2026-01-09 16:35:27	ADMIN	falto
1006	232	1	2026-01-06	0	\N	2026-01-09 16:35:27	ADMIN	falto
1007	232	1	2026-01-07	0	\N	2026-01-09 16:35:27	ADMIN	falto
1008	232	1	2026-01-08	1	\N	2026-01-09 16:35:27	ADMIN	asistio
1009	232	1	2026-01-09	0	\N	2026-01-09 16:35:27	ADMIN	falto
1010	238	1	2026-01-05	0	\N	2026-01-13 15:15:05	ADMIN	falto
1011	238	1	2026-01-06	0	\N	2026-01-13 15:15:05	ADMIN	falto
1012	238	1	2026-01-07	0	\N	2026-01-13 15:15:05	ADMIN	falto
1013	238	1	2026-01-08	1	\N	2026-01-13 15:15:06	ADMIN	asistio
1014	238	1	2026-01-09	1	\N	2026-01-13 15:15:06	ADMIN	asistio
1015	236	1	2026-01-05	0	\N	2026-01-13 15:15:32	ADMIN	falto
1016	236	1	2026-01-06	0	\N	2026-01-13 15:15:32	ADMIN	falto
1017	236	1	2026-01-07	0	\N	2026-01-13 15:15:33	ADMIN	falto
1018	236	1	2026-01-08	0	\N	2026-01-13 15:15:33	ADMIN	falto
1019	236	1	2026-01-09	0	\N	2026-01-13 15:15:33	ADMIN	falto
1020	243	1	2026-01-05	0	\N	2026-01-09 16:35:30	ADMIN	falto
1021	243	1	2026-01-06	0	\N	2026-01-09 16:35:30	ADMIN	falto
1022	243	1	2026-01-07	0	\N	2026-01-09 16:35:30	ADMIN	falto
1023	243	1	2026-01-08	0	\N	2026-01-09 16:35:30	ADMIN	falto
1024	243	1	2026-01-09	1	\N	2026-01-09 16:35:31	ADMIN	asistio
1025	244	1	2026-01-05	0	\N	2026-01-09 16:35:40	ADMIN	falto
1026	244	1	2026-01-06	0	\N	2026-01-09 16:35:40	ADMIN	falto
1027	244	1	2026-01-07	0	\N	2026-01-09 16:35:40	ADMIN	falto
1028	244	1	2026-01-08	0	\N	2026-01-09 16:35:40	ADMIN	falto
1029	244	1	2026-01-09	0	\N	2026-01-09 16:35:40	ADMIN	falto
1030	245	1	2026-01-05	0	\N	2026-01-10 16:42:52	ADMIN	falto
1031	245	1	2026-01-07	0	\N	2026-01-10 16:42:52	ADMIN	falto
1032	245	1	2026-01-09	1	\N	2026-01-10 16:42:53	ADMIN	asistio
1033	246	1	2026-01-05	1	\N	2026-01-10 16:43:00	ADMIN	asistio
1034	246	1	2026-01-07	1	\N	2026-01-10 16:43:00	ADMIN	asistio
1035	246	1	2026-01-09	0	\N	2026-01-10 16:43:01	ADMIN	falto
1036	247	1	2026-01-05	1	\N	2026-01-10 16:42:49	ADMIN	asistio
1037	247	1	2026-01-07	1	\N	2026-01-10 16:42:49	ADMIN	asistio
1038	247	1	2026-01-09	1	\N	2026-01-10 16:42:49	ADMIN	asistio
1039	209	2	2026-01-12	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1040	209	2	2026-01-13	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1041	209	2	2026-01-14	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1042	209	2	2026-01-15	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1043	209	2	2026-01-16	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1044	184	2	2026-01-12	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1045	184	2	2026-01-13	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1046	184	2	2026-01-14	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1047	184	2	2026-01-15	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1048	184	2	2026-01-16	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1049	222	2	2026-01-12	0	\N	2026-01-16 16:44:22	ADMIN	falto
1050	222	2	2026-01-13	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1051	222	2	2026-01-14	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1052	222	2	2026-01-15	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1053	222	2	2026-01-16	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1054	250	2	2026-01-12	0	\N	2026-01-16 16:44:22	ADMIN	falto
1055	250	2	2026-01-13	0	\N	2026-01-16 16:44:22	ADMIN	falto
1056	250	2	2026-01-14	0	\N	2026-01-16 16:44:22	ADMIN	falto
1057	250	2	2026-01-15	0	\N	2026-01-16 16:44:22	ADMIN	falto
1058	250	2	2026-01-16	0	\N	2026-01-16 16:44:22	ADMIN	falto
1059	135	2	2026-01-12	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1060	135	2	2026-01-13	1	\N	2026-01-16 16:44:22	ADMIN	asistio
1061	135	2	2026-01-14	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1062	135	2	2026-01-15	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1063	135	2	2026-01-16	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1064	208	2	2026-01-12	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1065	208	2	2026-01-13	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1066	208	2	2026-01-14	0	\N	2026-01-16 16:44:23	ADMIN	falto
1067	208	2	2026-01-15	0	\N	2026-01-16 16:44:23	ADMIN	falto
1068	208	2	2026-01-16	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1069	193	2	2026-01-12	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1070	193	2	2026-01-13	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1071	193	2	2026-01-14	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1072	193	2	2026-01-15	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1073	193	2	2026-01-16	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1074	219	2	2026-01-12	1	\N	2026-01-16 16:44:23	ADMIN	tardanza
1075	219	2	2026-01-13	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1076	219	2	2026-01-14	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1077	219	2	2026-01-15	0	\N	2026-01-16 16:44:23	ADMIN	falto
1078	219	2	2026-01-16	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1079	153	2	2026-01-12	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1080	153	2	2026-01-13	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1081	153	2	2026-01-14	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1082	153	2	2026-01-15	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1083	153	2	2026-01-16	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1084	155	2	2026-01-12	0	\N	2026-01-16 16:44:23	ADMIN	falto
1085	155	2	2026-01-13	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1086	155	2	2026-01-14	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1087	155	2	2026-01-15	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1088	155	2	2026-01-16	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1089	225	2	2026-01-12	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1090	225	2	2026-01-13	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1091	225	2	2026-01-14	0	\N	2026-01-16 16:44:23	ADMIN	falto
1092	225	2	2026-01-15	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1093	225	2	2026-01-16	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1094	168	2	2026-01-12	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1095	168	2	2026-01-13	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1096	168	2	2026-01-14	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1097	168	2	2026-01-15	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1098	168	2	2026-01-16	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1099	171	2	2026-01-12	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1100	171	2	2026-01-13	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1101	171	2	2026-01-14	1	\N	2026-01-16 16:44:23	ADMIN	asistio
1102	171	2	2026-01-15	0	\N	2026-01-16 16:44:23	ADMIN	falto
1103	171	2	2026-01-16	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1104	172	2	2026-01-12	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1105	172	2	2026-01-13	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1106	172	2	2026-01-14	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1107	172	2	2026-01-15	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1108	172	2	2026-01-16	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1109	251	2	2026-01-12	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1110	251	2	2026-01-13	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1111	251	2	2026-01-14	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1112	251	2	2026-01-15	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1113	251	2	2026-01-16	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1114	218	2	2026-01-12	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1115	218	2	2026-01-13	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1116	218	2	2026-01-14	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1117	218	2	2026-01-15	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1118	218	2	2026-01-16	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1119	173	2	2026-01-12	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1120	173	2	2026-01-13	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1121	173	2	2026-01-14	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1122	173	2	2026-01-15	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1123	173	2	2026-01-16	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1124	252	2	2026-01-12	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1125	252	2	2026-01-13	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1126	252	2	2026-01-14	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1127	252	2	2026-01-15	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1128	252	2	2026-01-16	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1129	217	2	2026-01-12	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1130	217	2	2026-01-13	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1131	217	2	2026-01-14	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1132	217	2	2026-01-15	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1133	217	2	2026-01-16	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1134	213	2	2026-01-12	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1135	213	2	2026-01-13	0	\N	2026-01-16 16:44:24	ADMIN	falto
1136	213	2	2026-01-14	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1137	213	2	2026-01-15	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1138	213	2	2026-01-16	0	\N	2026-01-16 16:44:24	ADMIN	falto
1139	210	2	2026-01-12	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1140	210	2	2026-01-13	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1141	210	2	2026-01-14	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1142	210	2	2026-01-15	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1143	210	2	2026-01-16	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1144	177	2	2026-01-12	1	\N	2026-01-16 16:44:24	ADMIN	asistio
1145	177	2	2026-01-13	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1146	177	2	2026-01-14	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1147	177	2	2026-01-15	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1148	177	2	2026-01-16	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1149	180	2	2026-01-12	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1150	180	2	2026-01-13	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1151	180	2	2026-01-14	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1152	180	2	2026-01-15	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1153	180	2	2026-01-16	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1154	202	2	2026-01-12	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1155	202	2	2026-01-13	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1156	202	2	2026-01-14	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1157	202	2	2026-01-15	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1158	202	2	2026-01-16	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1159	192	2	2026-01-12	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1160	192	2	2026-01-13	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1161	192	2	2026-01-14	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1162	192	2	2026-01-15	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1163	192	2	2026-01-16	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1164	187	2	2026-01-12	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1165	187	2	2026-01-13	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1166	187	2	2026-01-14	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1167	187	2	2026-01-15	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1168	187	2	2026-01-16	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1169	203	2	2026-01-12	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1170	203	2	2026-01-13	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1171	203	2	2026-01-14	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1172	203	2	2026-01-15	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1173	203	2	2026-01-16	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1174	212	2	2026-01-12	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1175	212	2	2026-01-13	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1176	212	2	2026-01-14	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1177	212	2	2026-01-15	0	\N	2026-01-16 16:44:25	ADMIN	falto
1178	212	2	2026-01-16	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1179	188	2	2026-01-12	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1180	188	2	2026-01-13	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1181	188	2	2026-01-14	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1182	188	2	2026-01-15	0	\N	2026-01-16 16:44:25	ADMIN	falto
1183	188	2	2026-01-16	0	\N	2026-01-16 16:44:25	ADMIN	falto
1184	189	2	2026-01-12	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1185	189	2	2026-01-13	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1186	189	2	2026-01-14	1	\N	2026-01-16 16:44:25	ADMIN	asistio
1187	189	2	2026-01-15	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1188	189	2	2026-01-16	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1189	196	2	2026-01-12	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1190	196	2	2026-01-13	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1191	196	2	2026-01-14	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1192	196	2	2026-01-15	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1193	196	2	2026-01-16	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1194	199	2	2026-01-12	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1195	199	2	2026-01-13	0	\N	2026-01-16 16:44:26	ADMIN	falto
1196	199	2	2026-01-14	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1197	199	2	2026-01-15	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1198	199	2	2026-01-16	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1199	197	2	2026-01-12	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1200	197	2	2026-01-13	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1201	197	2	2026-01-14	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1202	197	2	2026-01-15	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1203	197	2	2026-01-16	1	\N	2026-01-16 16:44:26	ADMIN	asistio
1204	3	2	2026-01-12	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1205	3	2	2026-01-13	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1206	3	2	2026-01-14	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1207	3	2	2026-01-15	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1208	3	2	2026-01-16	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1209	87	2	2026-01-12	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1210	87	2	2026-01-13	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1211	87	2	2026-01-14	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1212	87	2	2026-01-15	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1213	87	2	2026-01-16	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1214	6	2	2026-01-12	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1215	6	2	2026-01-13	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1216	6	2	2026-01-14	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1217	6	2	2026-01-15	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1218	6	2	2026-01-16	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1219	4	2	2026-01-12	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1220	4	2	2026-01-13	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1221	4	2	2026-01-14	1	\N	2026-01-18 02:08:05	ADMIN	asistio
1222	4	2	2026-01-15	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1223	4	2	2026-01-16	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1224	5	2	2026-01-12	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1225	5	2	2026-01-13	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1226	5	2	2026-01-14	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1227	5	2	2026-01-15	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1228	5	2	2026-01-16	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1229	7	2	2026-01-12	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1230	7	2	2026-01-13	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1231	7	2	2026-01-14	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1232	7	2	2026-01-15	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1233	7	2	2026-01-16	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1234	10	2	2026-01-12	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1235	10	2	2026-01-13	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1236	10	2	2026-01-14	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1237	10	2	2026-01-15	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1238	10	2	2026-01-16	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1239	235	2	2026-01-12	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1240	235	2	2026-01-13	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1241	235	2	2026-01-14	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1242	235	2	2026-01-15	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1243	235	2	2026-01-16	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1244	88	2	2026-01-12	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1245	88	2	2026-01-13	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1246	88	2	2026-01-14	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1247	88	2	2026-01-15	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1248	88	2	2026-01-16	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1249	239	2	2026-01-12	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1250	239	2	2026-01-13	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1251	239	2	2026-01-14	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1252	239	2	2026-01-15	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1253	239	2	2026-01-16	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1254	12	2	2026-01-12	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1255	12	2	2026-01-13	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1256	12	2	2026-01-14	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1257	12	2	2026-01-15	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1258	12	2	2026-01-16	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1259	8	2	2026-01-12	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1260	8	2	2026-01-13	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1261	8	2	2026-01-14	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1262	8	2	2026-01-15	1	\N	2026-01-18 02:08:06	ADMIN	asistio
1263	8	2	2026-01-16	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1264	14	2	2026-01-12	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1265	14	2	2026-01-13	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1266	14	2	2026-01-14	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1267	14	2	2026-01-15	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1268	14	2	2026-01-16	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1269	228	2	2026-01-12	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1270	228	2	2026-01-13	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1271	228	2	2026-01-14	0	\N	2026-01-18 02:08:07	ADMIN	falto
1272	228	2	2026-01-15	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1273	228	2	2026-01-16	0	\N	2026-01-18 02:08:07	ADMIN	falto
1274	9	2	2026-01-12	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1275	9	2	2026-01-13	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1276	9	2	2026-01-14	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1277	9	2	2026-01-15	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1278	9	2	2026-01-16	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1279	248	2	2026-01-12	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1280	248	2	2026-01-13	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1281	248	2	2026-01-14	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1282	248	2	2026-01-15	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1283	248	2	2026-01-16	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1284	238	2	2026-01-12	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1285	238	2	2026-01-13	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1286	238	2	2026-01-14	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1287	238	2	2026-01-15	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1288	238	2	2026-01-16	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1289	20	2	2026-01-12	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1290	20	2	2026-01-13	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1291	20	2	2026-01-14	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1292	20	2	2026-01-15	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1293	20	2	2026-01-16	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1294	22	2	2026-01-12	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1295	22	2	2026-01-13	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1296	22	2	2026-01-14	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1297	22	2	2026-01-15	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1298	22	2	2026-01-16	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1299	24	2	2026-01-12	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1300	24	2	2026-01-13	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1301	24	2	2026-01-14	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1302	24	2	2026-01-15	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1303	24	2	2026-01-16	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1304	26	2	2026-01-12	1	\N	2026-01-18 02:08:07	ADMIN	asistio
1305	26	2	2026-01-13	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1306	26	2	2026-01-14	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1307	26	2	2026-01-15	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1308	26	2	2026-01-16	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1309	31	2	2026-01-12	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1310	31	2	2026-01-13	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1311	31	2	2026-01-14	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1312	31	2	2026-01-15	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1313	31	2	2026-01-16	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1314	32	2	2026-01-12	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1315	32	2	2026-01-13	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1316	32	2	2026-01-14	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1317	32	2	2026-01-15	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1318	32	2	2026-01-16	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1319	38	2	2026-01-12	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1320	38	2	2026-01-13	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1321	38	2	2026-01-14	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1322	38	2	2026-01-15	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1323	38	2	2026-01-16	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1324	40	2	2026-01-12	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1325	40	2	2026-01-13	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1326	40	2	2026-01-14	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1327	40	2	2026-01-15	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1328	40	2	2026-01-16	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1329	41	2	2026-01-12	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1330	41	2	2026-01-13	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1331	41	2	2026-01-14	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1332	41	2	2026-01-15	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1333	41	2	2026-01-16	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1334	43	2	2026-01-12	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1335	43	2	2026-01-13	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1336	43	2	2026-01-14	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1337	43	2	2026-01-15	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1338	43	2	2026-01-16	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1339	44	2	2026-01-12	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1340	44	2	2026-01-13	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1341	44	2	2026-01-14	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1342	44	2	2026-01-15	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1343	44	2	2026-01-16	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1344	23	2	2026-01-12	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1345	23	2	2026-01-13	1	\N	2026-01-18 02:08:08	ADMIN	asistio
1346	23	2	2026-01-14	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1347	23	2	2026-01-15	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1348	23	2	2026-01-16	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1349	45	2	2026-01-12	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1350	45	2	2026-01-13	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1351	45	2	2026-01-14	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1352	45	2	2026-01-15	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1353	45	2	2026-01-16	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1354	25	2	2026-01-12	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1355	25	2	2026-01-13	0	\N	2026-01-18 02:08:09	ADMIN	justificada
1356	25	2	2026-01-14	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1357	25	2	2026-01-15	0	\N	2026-01-18 02:08:09	ADMIN	falto
1358	25	2	2026-01-16	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1359	236	2	2026-01-12	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1360	236	2	2026-01-13	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1361	236	2	2026-01-14	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1362	236	2	2026-01-15	0	\N	2026-01-18 02:08:09	ADMIN	falto
1363	236	2	2026-01-16	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1364	51	2	2026-01-12	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1365	51	2	2026-01-13	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1366	51	2	2026-01-14	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1367	51	2	2026-01-15	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1368	51	2	2026-01-16	0	\N	2026-01-18 02:08:09	ADMIN	falto
1369	54	2	2026-01-12	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1370	54	2	2026-01-13	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1371	54	2	2026-01-14	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1372	54	2	2026-01-15	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1373	54	2	2026-01-16	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1374	56	2	2026-01-12	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1375	56	2	2026-01-13	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1376	56	2	2026-01-14	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1377	56	2	2026-01-15	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1378	56	2	2026-01-16	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1379	58	2	2026-01-12	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1380	58	2	2026-01-13	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1381	58	2	2026-01-14	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1382	58	2	2026-01-15	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1383	58	2	2026-01-16	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1384	59	2	2026-01-12	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1385	59	2	2026-01-13	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1386	59	2	2026-01-14	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1387	59	2	2026-01-15	1	\N	2026-01-18 02:08:09	ADMIN	asistio
1388	59	2	2026-01-16	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1389	30	2	2026-01-12	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1390	30	2	2026-01-13	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1391	30	2	2026-01-14	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1392	30	2	2026-01-15	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1393	30	2	2026-01-16	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1394	33	2	2026-01-12	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1395	33	2	2026-01-13	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1396	33	2	2026-01-14	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1397	33	2	2026-01-15	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1398	33	2	2026-01-16	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1399	29	2	2026-01-12	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1400	29	2	2026-01-13	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1401	29	2	2026-01-14	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1402	29	2	2026-01-15	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1403	29	2	2026-01-16	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1404	34	2	2026-01-12	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1405	34	2	2026-01-13	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1406	34	2	2026-01-14	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1407	34	2	2026-01-15	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1408	34	2	2026-01-16	1	\N	2026-01-18 02:08:10	ADMIN	asistio
1409	229	2	2026-01-12	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1410	229	2	2026-01-13	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1411	229	2	2026-01-14	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1412	229	2	2026-01-15	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1413	229	2	2026-01-16	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1414	39	2	2026-01-12	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1415	39	2	2026-01-13	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1416	39	2	2026-01-14	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1417	39	2	2026-01-15	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1418	39	2	2026-01-16	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1419	85	2	2026-01-12	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1420	85	2	2026-01-13	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1421	85	2	2026-01-14	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1422	85	2	2026-01-15	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1423	85	2	2026-01-16	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1424	86	2	2026-01-12	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1425	86	2	2026-01-13	1	\N	2026-01-16 16:46:01	ADMIN	asistio
1426	86	2	2026-01-14	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1427	86	2	2026-01-15	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1428	86	2	2026-01-16	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1429	253	2	2026-01-12	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1430	253	2	2026-01-13	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1431	253	2	2026-01-14	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1432	253	2	2026-01-15	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1433	253	2	2026-01-16	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1434	237	2	2026-01-12	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1435	237	2	2026-01-13	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1436	237	2	2026-01-14	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1437	237	2	2026-01-15	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1438	237	2	2026-01-16	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1439	232	2	2026-01-12	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1440	232	2	2026-01-13	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1441	232	2	2026-01-14	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1442	232	2	2026-01-15	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1443	232	2	2026-01-16	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1444	11	2	2026-01-12	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1445	11	2	2026-01-13	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1446	11	2	2026-01-14	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1447	11	2	2026-01-15	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1448	11	2	2026-01-16	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1449	16	2	2026-01-12	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1450	16	2	2026-01-13	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1451	16	2	2026-01-14	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1452	16	2	2026-01-15	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1453	16	2	2026-01-16	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1454	18	2	2026-01-12	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1455	18	2	2026-01-13	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1456	18	2	2026-01-14	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1457	18	2	2026-01-15	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1458	18	2	2026-01-16	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1459	46	2	2026-01-12	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1460	46	2	2026-01-13	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1461	46	2	2026-01-14	1	\N	2026-01-16 16:46:02	ADMIN	asistio
1462	46	2	2026-01-15	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1463	46	2	2026-01-16	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1464	37	2	2026-01-12	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1465	37	2	2026-01-13	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1466	37	2	2026-01-14	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1467	37	2	2026-01-15	0	\N	2026-01-16 16:46:03	ADMIN	falto
1468	37	2	2026-01-16	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1469	48	2	2026-01-12	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1470	48	2	2026-01-13	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1471	48	2	2026-01-14	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1472	48	2	2026-01-15	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1473	48	2	2026-01-16	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1474	15	2	2026-01-12	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1475	15	2	2026-01-13	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1476	15	2	2026-01-14	0	\N	2026-01-16 16:46:03	ADMIN	falto
1477	15	2	2026-01-15	0	\N	2026-01-16 16:46:03	ADMIN	falto
1478	15	2	2026-01-16	0	\N	2026-01-16 16:46:03	ADMIN	falto
1479	17	2	2026-01-12	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1480	17	2	2026-01-13	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1481	17	2	2026-01-14	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1482	17	2	2026-01-15	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1483	17	2	2026-01-16	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1484	50	2	2026-01-12	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1485	50	2	2026-01-13	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1486	50	2	2026-01-14	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1487	50	2	2026-01-15	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1488	50	2	2026-01-16	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1489	28	2	2026-01-12	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1490	28	2	2026-01-13	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1491	28	2	2026-01-14	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1492	28	2	2026-01-15	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1493	28	2	2026-01-16	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1494	35	2	2026-01-12	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1495	35	2	2026-01-13	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1496	35	2	2026-01-14	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1497	35	2	2026-01-15	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1498	35	2	2026-01-16	1	\N	2026-01-16 16:46:03	ADMIN	asistio
1499	19	2	2026-01-12	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1500	19	2	2026-01-13	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1501	19	2	2026-01-14	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1502	19	2	2026-01-15	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1503	19	2	2026-01-16	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1504	21	2	2026-01-12	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1505	21	2	2026-01-13	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1506	21	2	2026-01-14	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1507	21	2	2026-01-15	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1508	21	2	2026-01-16	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1509	227	2	2026-01-12	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1510	227	2	2026-01-13	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1511	227	2	2026-01-14	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1512	227	2	2026-01-15	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1513	227	2	2026-01-16	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1514	84	2	2026-01-12	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1515	84	2	2026-01-13	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1516	84	2	2026-01-14	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1517	84	2	2026-01-15	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1518	84	2	2026-01-16	0	\N	2026-01-16 16:46:04	ADMIN	falto
1519	47	2	2026-01-12	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1520	47	2	2026-01-13	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1521	47	2	2026-01-14	0	\N	2026-01-16 16:46:04	ADMIN	falto
1522	47	2	2026-01-15	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1523	47	2	2026-01-16	0	\N	2026-01-16 16:46:04	ADMIN	falto
1524	226	2	2026-01-12	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1525	226	2	2026-01-13	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1526	226	2	2026-01-14	0	\N	2026-01-16 16:46:04	ADMIN	falto
1527	226	2	2026-01-15	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1528	226	2	2026-01-16	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1529	49	2	2026-01-12	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1530	49	2	2026-01-13	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1531	49	2	2026-01-14	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1532	49	2	2026-01-15	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1533	49	2	2026-01-16	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1534	254	2	2026-01-12	1	\N	2026-01-16 16:46:04	ADMIN	asistio
1535	254	2	2026-01-13	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1536	254	2	2026-01-14	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1537	254	2	2026-01-15	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1538	254	2	2026-01-16	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1539	52	2	2026-01-12	0	\N	2026-01-16 16:46:05	ADMIN	falto
1540	52	2	2026-01-13	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1541	52	2	2026-01-14	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1542	52	2	2026-01-15	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1543	52	2	2026-01-16	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1544	53	2	2026-01-12	0	\N	2026-01-16 16:46:05	ADMIN	falto
1545	53	2	2026-01-13	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1546	53	2	2026-01-14	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1547	53	2	2026-01-15	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1548	53	2	2026-01-16	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1549	244	2	2026-01-12	0	\N	2026-01-16 16:46:05	ADMIN	falto
1550	244	2	2026-01-13	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1551	244	2	2026-01-14	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1552	244	2	2026-01-15	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1553	244	2	2026-01-16	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1554	42	2	2026-01-12	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1555	42	2	2026-01-13	1	\N	2026-01-16 16:46:05	ADMIN	tardanza
1556	42	2	2026-01-14	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1557	42	2	2026-01-15	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1558	42	2	2026-01-16	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1559	55	2	2026-01-12	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1560	55	2	2026-01-13	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1561	55	2	2026-01-14	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1562	55	2	2026-01-15	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1563	55	2	2026-01-16	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1564	27	2	2026-01-12	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1565	27	2	2026-01-13	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1566	27	2	2026-01-14	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1567	27	2	2026-01-15	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1568	27	2	2026-01-16	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1569	57	2	2026-01-12	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1570	57	2	2026-01-13	1	\N	2026-01-16 16:46:05	ADMIN	asistio
1571	57	2	2026-01-14	0	\N	2026-01-16 16:46:05	ADMIN	falto
1572	57	2	2026-01-15	0	\N	2026-01-16 16:46:06	ADMIN	falto
1573	57	2	2026-01-16	0	\N	2026-01-16 16:46:06	ADMIN	falto
1574	255	2	2026-01-12	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1575	255	2	2026-01-13	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1576	255	2	2026-01-14	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1577	255	2	2026-01-15	0	\N	2026-01-16 16:46:06	ADMIN	falto
1578	255	2	2026-01-16	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1579	60	2	2026-01-12	0	\N	2026-01-16 16:46:06	ADMIN	falto
1580	60	2	2026-01-13	0	\N	2026-01-16 16:46:06	ADMIN	falto
1581	60	2	2026-01-14	0	\N	2026-01-16 16:46:06	ADMIN	falto
1582	60	2	2026-01-15	0	\N	2026-01-16 16:46:06	ADMIN	falto
1583	60	2	2026-01-16	0	\N	2026-01-16 16:46:06	ADMIN	falto
1584	230	2	2026-01-12	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1585	230	2	2026-01-13	0	\N	2026-01-16 16:46:06	ADMIN	justificada
1586	230	2	2026-01-14	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1587	230	2	2026-01-15	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1588	230	2	2026-01-16	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1589	61	2	2026-01-12	0	\N	2026-01-16 16:46:06	ADMIN	falto
1590	61	2	2026-01-13	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1591	61	2	2026-01-14	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1592	61	2	2026-01-15	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1593	61	2	2026-01-16	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1594	256	2	2026-01-12	0	\N	2026-01-16 16:46:06	ADMIN	falto
1595	256	2	2026-01-13	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1596	256	2	2026-01-14	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1597	256	2	2026-01-15	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1598	256	2	2026-01-16	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1599	62	2	2026-01-12	0	\N	2026-01-16 16:46:07	ADMIN	falto
1600	62	2	2026-01-13	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1601	62	2	2026-01-14	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1602	62	2	2026-01-15	0	\N	2026-01-16 16:46:07	ADMIN	falto
1603	62	2	2026-01-16	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1604	36	2	2026-01-12	0	\N	2026-01-16 16:46:07	ADMIN	falto
1605	36	2	2026-01-13	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1606	36	2	2026-01-14	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1607	36	2	2026-01-15	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1608	36	2	2026-01-16	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1609	93	2	2026-01-12	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1610	93	2	2026-01-14	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1611	93	2	2026-01-16	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1612	94	2	2026-01-12	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1613	94	2	2026-01-14	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1614	94	2	2026-01-16	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1615	97	2	2026-01-12	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1616	97	2	2026-01-14	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1617	97	2	2026-01-16	0	\N	2026-01-16 16:39:24	ADMIN	falto
1618	99	2	2026-01-12	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1619	99	2	2026-01-14	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1620	99	2	2026-01-16	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1621	100	2	2026-01-12	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1622	100	2	2026-01-14	0	\N	2026-01-16 16:39:24	ADMIN	falto
1623	100	2	2026-01-16	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1624	169	2	2026-01-12	1	\N	2026-01-16 16:39:24	ADMIN	asistio
1625	169	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1626	169	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1627	247	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1628	247	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1629	247	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1630	101	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1631	101	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1632	101	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1633	102	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1634	102	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1635	102	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1636	104	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1637	104	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1638	104	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1639	105	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1640	105	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1641	105	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1642	107	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1643	107	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1644	107	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1645	109	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1646	109	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1647	109	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1648	110	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1649	110	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1650	110	2	2026-01-16	0	\N	2026-01-16 16:39:25	ADMIN	falto
1651	111	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1652	111	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1653	111	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1654	245	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1655	245	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1656	245	2	2026-01-16	0	\N	2026-01-16 16:39:25	ADMIN	falto
1657	112	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1658	112	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1659	112	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1660	114	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1661	114	2	2026-01-14	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1662	114	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1663	117	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1664	117	2	2026-01-14	0	\N	2026-01-16 16:39:25	ADMIN	falto
1665	117	2	2026-01-16	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1666	120	2	2026-01-12	1	\N	2026-01-16 16:39:25	ADMIN	asistio
1667	120	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1668	120	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1669	121	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1670	121	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1671	121	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1672	122	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1673	122	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1674	122	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1675	124	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1676	124	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1677	124	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1678	125	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1679	125	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1680	125	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1681	165	2	2026-01-12	0	\N	2026-01-16 16:39:26	ADMIN	falto
1682	165	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1683	165	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1684	129	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1685	129	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1686	129	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1687	127	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1688	127	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1689	127	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1690	132	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1691	132	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1692	132	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1693	133	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1694	133	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1695	133	2	2026-01-16	0	\N	2026-01-16 16:39:26	ADMIN	falto
1696	164	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1697	164	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1698	164	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1699	134	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1700	134	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1701	134	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1702	137	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1703	137	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1704	137	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1705	138	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1706	138	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1707	138	2	2026-01-16	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1708	139	2	2026-01-12	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1709	139	2	2026-01-14	1	\N	2026-01-16 16:39:26	ADMIN	asistio
1710	139	2	2026-01-16	0	\N	2026-01-16 16:39:27	ADMIN	falto
1711	140	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1712	140	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1713	140	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1714	141	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1715	141	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1716	141	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1717	162	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1718	162	2	2026-01-14	0	\N	2026-01-16 16:39:27	ADMIN	justificada
1719	162	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1720	246	2	2026-01-12	0	\N	2026-01-16 16:39:27	ADMIN	falto
1721	246	2	2026-01-14	0	\N	2026-01-16 16:39:27	ADMIN	falto
1722	246	2	2026-01-16	0	\N	2026-01-16 16:39:27	ADMIN	falto
1723	142	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1724	142	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1725	142	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1726	143	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1727	143	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1728	143	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1729	145	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1730	145	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1731	145	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1732	146	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1733	146	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1734	146	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1735	157	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1736	157	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1737	157	2	2026-01-16	0	\N	2026-01-16 16:39:27	ADMIN	falto
1738	147	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1739	147	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1740	147	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1741	148	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1742	148	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1743	148	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1744	158	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1745	158	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1746	158	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1747	150	2	2026-01-12	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1748	150	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
1749	150	2	2026-01-16	1	\N	2026-01-16 16:39:28	ADMIN	asistio
1750	152	2	2026-01-12	1	\N	2026-01-16 16:39:28	ADMIN	asistio
1751	152	2	2026-01-14	1	\N	2026-01-16 16:39:28	ADMIN	asistio
1752	152	2	2026-01-16	1	\N	2026-01-16 16:39:28	ADMIN	asistio
1753	154	2	2026-01-12	1	\N	2026-01-16 16:39:28	ADMIN	asistio
1754	154	2	2026-01-14	1	\N	2026-01-16 16:39:28	ADMIN	asistio
1755	154	2	2026-01-16	1	\N	2026-01-16 16:39:28	ADMIN	asistio
1756	160	2	2026-01-12	1	\N	2026-01-16 16:39:28	ADMIN	asistio
1757	160	2	2026-01-14	1	\N	2026-01-16 16:39:28	ADMIN	asistio
1758	160	2	2026-01-16	1	\N	2026-01-16 16:39:28	ADMIN	asistio
1759	156	2	2026-01-12	0	\N	2026-01-15 16:05:04	ADMIN	justificada
1760	156	2	2026-01-14	1	\N	2026-01-15 16:05:04	ADMIN	asistio
1761	156	2	2026-01-16	0	\N	2026-01-15 16:05:04	ADMIN	falto
1762	220	2	2026-01-12	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1763	220	2	2026-01-13	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1764	220	2	2026-01-14	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1765	220	2	2026-01-15	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1766	220	2	2026-01-16	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1767	240	2	2026-01-12	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1768	240	2	2026-01-13	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1769	240	2	2026-01-14	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1770	240	2	2026-01-15	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1771	240	2	2026-01-16	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1772	181	2	2026-01-12	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1773	181	2	2026-01-13	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1774	181	2	2026-01-14	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1775	181	2	2026-01-15	0	\N	2026-01-20 16:50:09	ADMIN	falto
1776	181	2	2026-01-16	0	\N	2026-01-20 16:50:09	ADMIN	falto
1777	136	2	2026-01-12	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1778	136	2	2026-01-13	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1779	136	2	2026-01-14	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1780	136	2	2026-01-15	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1781	136	2	2026-01-16	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1782	231	2	2026-01-12	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1783	231	2	2026-01-13	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1784	231	2	2026-01-14	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1785	231	2	2026-01-15	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1786	231	2	2026-01-16	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1787	149	2	2026-01-12	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1788	149	2	2026-01-13	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1789	149	2	2026-01-14	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1790	149	2	2026-01-15	0	\N	2026-01-20 16:50:09	ADMIN	falto
1791	149	2	2026-01-16	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1792	207	2	2026-01-12	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1793	207	2	2026-01-13	1	\N	2026-01-20 16:50:09	ADMIN	asistio
1794	207	2	2026-01-14	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1795	207	2	2026-01-15	0	\N	2026-01-20 16:50:10	ADMIN	falto
1796	207	2	2026-01-16	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1797	151	2	2026-01-12	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1798	151	2	2026-01-13	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1799	151	2	2026-01-14	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1800	151	2	2026-01-15	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1801	151	2	2026-01-16	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1802	195	2	2026-01-12	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1803	195	2	2026-01-13	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1804	195	2	2026-01-14	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1805	195	2	2026-01-15	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1806	195	2	2026-01-16	0	\N	2026-01-20 16:50:10	ADMIN	falto
1807	200	2	2026-01-12	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1808	200	2	2026-01-13	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1809	200	2	2026-01-14	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1810	200	2	2026-01-15	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1811	200	2	2026-01-16	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1812	159	2	2026-01-12	0	\N	2026-01-20 16:50:10	ADMIN	falto
1813	159	2	2026-01-13	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1814	159	2	2026-01-14	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1815	159	2	2026-01-15	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1816	159	2	2026-01-16	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1817	214	2	2026-01-12	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1818	214	2	2026-01-13	0	\N	2026-01-20 16:50:10	ADMIN	justificada
1819	214	2	2026-01-14	0	\N	2026-01-20 16:50:10	ADMIN	justificada
1820	214	2	2026-01-15	0	\N	2026-01-20 16:50:10	ADMIN	justificada
1821	214	2	2026-01-16	0	\N	2026-01-20 16:50:10	ADMIN	justificada
1822	221	2	2026-01-12	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1823	221	2	2026-01-13	0	\N	2026-01-20 16:50:10	ADMIN	falto
1824	221	2	2026-01-14	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1825	221	2	2026-01-15	1	\N	2026-01-20 16:50:10	ADMIN	asistio
1826	221	2	2026-01-16	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1827	161	2	2026-01-12	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1828	161	2	2026-01-13	0	\N	2026-01-20 16:50:11	ADMIN	falto
1829	161	2	2026-01-14	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1830	161	2	2026-01-15	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1831	161	2	2026-01-16	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1832	163	2	2026-01-12	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1833	163	2	2026-01-13	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1834	163	2	2026-01-14	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1835	163	2	2026-01-15	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1836	163	2	2026-01-16	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1837	166	2	2026-01-12	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1838	166	2	2026-01-13	0	\N	2026-01-20 16:50:11	ADMIN	falto
1839	166	2	2026-01-14	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1840	166	2	2026-01-15	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1841	166	2	2026-01-16	0	\N	2026-01-20 16:50:11	ADMIN	falto
1842	167	2	2026-01-12	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1843	167	2	2026-01-13	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1844	167	2	2026-01-14	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1845	167	2	2026-01-15	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1846	167	2	2026-01-16	0	\N	2026-01-20 16:50:11	ADMIN	falto
1847	170	2	2026-01-12	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1848	170	2	2026-01-13	0	\N	2026-01-20 16:50:11	ADMIN	falto
1849	170	2	2026-01-14	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1850	170	2	2026-01-15	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1851	170	2	2026-01-16	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1852	198	2	2026-01-12	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1853	198	2	2026-01-13	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1854	198	2	2026-01-14	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1855	198	2	2026-01-15	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1856	198	2	2026-01-16	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1857	204	2	2026-01-12	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1858	204	2	2026-01-13	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1859	204	2	2026-01-14	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1860	204	2	2026-01-15	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1861	204	2	2026-01-16	1	\N	2026-01-20 16:50:11	ADMIN	asistio
1862	249	2	2026-01-12	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1863	249	2	2026-01-13	0	\N	2026-01-20 16:50:12	ADMIN	falto
1864	249	2	2026-01-14	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1865	249	2	2026-01-15	0	\N	2026-01-20 16:50:12	ADMIN	falto
1866	249	2	2026-01-16	0	\N	2026-01-20 16:50:12	ADMIN	falto
1867	223	2	2026-01-12	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1868	223	2	2026-01-13	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1869	223	2	2026-01-14	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1870	223	2	2026-01-15	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1871	223	2	2026-01-16	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1872	174	2	2026-01-12	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1873	174	2	2026-01-13	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1874	174	2	2026-01-14	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1875	174	2	2026-01-15	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1876	174	2	2026-01-16	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1877	175	2	2026-01-12	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1878	175	2	2026-01-13	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1879	175	2	2026-01-14	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1880	175	2	2026-01-15	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1881	175	2	2026-01-16	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1882	179	2	2026-01-12	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1883	179	2	2026-01-13	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1884	179	2	2026-01-14	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1885	179	2	2026-01-15	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1886	179	2	2026-01-16	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1887	182	2	2026-01-12	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1888	182	2	2026-01-13	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1889	182	2	2026-01-14	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1890	182	2	2026-01-15	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1891	182	2	2026-01-16	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1892	224	2	2026-01-12	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1893	224	2	2026-01-13	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1894	224	2	2026-01-14	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1895	224	2	2026-01-15	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1896	224	2	2026-01-16	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1897	183	2	2026-01-12	1	\N	2026-01-20 16:50:12	ADMIN	asistio
1898	183	2	2026-01-13	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1899	183	2	2026-01-14	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1900	183	2	2026-01-15	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1901	183	2	2026-01-16	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1902	185	2	2026-01-12	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1903	185	2	2026-01-13	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1904	185	2	2026-01-14	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1905	185	2	2026-01-15	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1906	185	2	2026-01-16	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1907	186	2	2026-01-12	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1908	186	2	2026-01-13	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1909	186	2	2026-01-14	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1910	186	2	2026-01-15	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1911	186	2	2026-01-16	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1912	215	2	2026-01-12	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1913	215	2	2026-01-13	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1914	215	2	2026-01-14	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1915	215	2	2026-01-15	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1916	215	2	2026-01-16	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1917	211	2	2026-01-12	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1918	211	2	2026-01-13	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1919	211	2	2026-01-14	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1920	211	2	2026-01-15	0	\N	2026-01-20 16:50:13	ADMIN	falto
1921	211	2	2026-01-16	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1922	190	2	2026-01-12	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1923	190	2	2026-01-13	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1924	190	2	2026-01-14	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1925	190	2	2026-01-15	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1926	190	2	2026-01-16	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1927	205	2	2026-01-12	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1928	205	2	2026-01-13	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1929	205	2	2026-01-14	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1930	205	2	2026-01-15	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1931	205	2	2026-01-16	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1932	191	2	2026-01-12	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1933	191	2	2026-01-13	1	\N	2026-01-20 16:50:13	ADMIN	asistio
1934	191	2	2026-01-14	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1935	191	2	2026-01-15	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1936	191	2	2026-01-16	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1937	178	2	2026-01-12	0	\N	2026-01-20 16:50:14	ADMIN	falto
1938	178	2	2026-01-13	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1939	178	2	2026-01-14	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1940	178	2	2026-01-15	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1941	178	2	2026-01-16	0	\N	2026-01-20 16:50:14	ADMIN	falto
1942	194	2	2026-01-12	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1943	194	2	2026-01-13	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1944	194	2	2026-01-14	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1945	194	2	2026-01-15	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1946	194	2	2026-01-16	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1947	206	2	2026-01-12	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1948	206	2	2026-01-13	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1949	206	2	2026-01-14	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1950	206	2	2026-01-15	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1951	206	2	2026-01-16	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1952	176	2	2026-01-12	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1953	176	2	2026-01-13	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1954	176	2	2026-01-14	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1955	176	2	2026-01-15	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1956	176	2	2026-01-16	0	\N	2026-01-20 16:50:14	ADMIN	falto
1957	201	2	2026-01-12	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1958	201	2	2026-01-13	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1959	201	2	2026-01-14	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1960	201	2	2026-01-15	0	\N	2026-01-20 16:50:14	ADMIN	justificada
1961	201	2	2026-01-16	1	\N	2026-01-20 16:50:14	ADMIN	asistio
1962	268	2	2026-01-12	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1963	268	2	2026-01-13	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1964	268	2	2026-01-14	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1965	268	2	2026-01-15	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1966	268	2	2026-01-16	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1967	269	2	2026-01-12	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1968	269	2	2026-01-13	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1969	269	2	2026-01-14	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1970	269	2	2026-01-15	1	\N	2026-01-16 16:46:06	ADMIN	asistio
1971	269	2	2026-01-16	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1972	267	2	2026-01-12	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1973	267	2	2026-01-13	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1974	267	2	2026-01-14	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1975	267	2	2026-01-15	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1976	267	2	2026-01-16	1	\N	2026-01-16 16:46:07	ADMIN	asistio
1977	248	1	2026-01-05	0	\N	2026-01-13 15:15:03	ADMIN	falto
1978	248	1	2026-01-06	0	\N	2026-01-13 15:15:03	ADMIN	falto
1979	248	1	2026-01-07	0	\N	2026-01-13 15:15:04	ADMIN	falto
1980	248	1	2026-01-08	0	\N	2026-01-13 15:15:04	ADMIN	falto
1981	248	1	2026-01-09	0	\N	2026-01-13 15:15:04	ADMIN	falto
1982	64	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1983	64	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1984	64	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1985	63	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1986	63	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1987	63	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1988	91	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1989	91	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1990	91	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1991	66	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1992	66	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1993	66	2	2026-01-17	0	\N	2026-01-18 02:09:33	ADMIN	justificada
1994	78	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1995	78	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1996	78	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1997	95	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1998	95	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
1999	95	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2000	241	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2001	241	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2002	241	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2003	260	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2004	260	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2005	260	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2006	242	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2007	242	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2008	242	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2009	68	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2010	68	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2011	68	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2012	69	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2013	69	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2014	69	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2015	262	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2016	262	2	2026-01-15	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2017	262	2	2026-01-17	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2018	79	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2019	79	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2020	79	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2021	130	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2022	130	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2023	130	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2024	70	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2025	70	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2026	70	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2027	263	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2028	263	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2029	263	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2030	106	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2031	106	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2032	106	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2033	257	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2034	257	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2035	257	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2036	77	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2037	77	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2038	77	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2039	108	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2040	108	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2041	108	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2042	113	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2043	113	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2044	113	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2045	259	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2046	259	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2047	259	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2048	258	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2049	258	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2050	258	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2051	261	2	2026-01-13	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2052	261	2	2026-01-15	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2053	261	2	2026-01-17	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2054	264	2	2026-01-13	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2055	264	2	2026-01-15	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2056	264	2	2026-01-17	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2057	82	2	2026-01-13	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2058	82	2	2026-01-15	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2059	82	2	2026-01-17	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2060	115	2	2026-01-13	0	\N	2026-01-18 02:09:35	ADMIN	justificada
2061	115	2	2026-01-15	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2062	115	2	2026-01-17	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2063	118	2	2026-01-13	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2064	118	2	2026-01-15	0	\N	2026-01-18 02:09:35	ADMIN	justificada
2065	118	2	2026-01-17	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2066	116	2	2026-01-13	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2067	116	2	2026-01-15	0	\N	2026-01-18 02:09:35	ADMIN	justificada
2068	116	2	2026-01-17	1	\N	2026-01-18 02:09:35	ADMIN	asistio
2069	80	2	2026-01-12	0	\N	2026-01-20 16:50:10	ADMIN	falto
2070	80	2	2026-01-13	0	\N	2026-01-20 16:50:10	ADMIN	falto
2071	80	2	2026-01-14	0	\N	2026-01-20 16:50:10	ADMIN	falto
2072	80	2	2026-01-15	0	\N	2026-01-20 16:50:10	ADMIN	falto
2073	80	2	2026-01-16	0	\N	2026-01-20 16:50:10	ADMIN	falto
2074	265	2	2026-01-12	0	\N	2026-01-16 16:39:27	ADMIN	falto
2075	265	2	2026-01-14	1	\N	2026-01-16 16:39:27	ADMIN	asistio
2076	265	2	2026-01-16	1	\N	2026-01-16 16:39:27	ADMIN	asistio
2077	271	2	2026-01-13	1	\N	2026-01-18 02:09:33	ADMIN	asistio
2078	271	2	2026-01-15	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2079	271	2	2026-01-17	1	\N	2026-01-18 02:09:34	ADMIN	asistio
2080	270	2	2026-01-12	0	\N	2026-01-16 16:39:28	ADMIN	falto
2081	270	2	2026-01-14	1	\N	2026-01-16 16:39:28	ADMIN	tardanza
2082	270	2	2026-01-16	1	\N	2026-01-16 16:39:28	ADMIN	tardanza
2083	3	3	2026-01-19	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2084	3	3	2026-01-20	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2085	3	3	2026-01-21	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2086	3	3	2026-01-22	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2087	3	3	2026-01-23	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2088	87	3	2026-01-19	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2089	87	3	2026-01-20	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2090	87	3	2026-01-21	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2091	87	3	2026-01-22	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2092	87	3	2026-01-23	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2093	6	3	2026-01-19	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2094	6	3	2026-01-20	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2095	6	3	2026-01-21	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2096	6	3	2026-01-22	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2097	6	3	2026-01-23	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2098	4	3	2026-01-19	0	\N	2026-01-23 17:54:23	ADMIN	justificada
2099	4	3	2026-01-20	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2100	4	3	2026-01-21	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2101	4	3	2026-01-22	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2102	4	3	2026-01-23	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2103	5	3	2026-01-19	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2104	5	3	2026-01-20	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2105	5	3	2026-01-21	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2106	5	3	2026-01-22	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2107	5	3	2026-01-23	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2108	7	3	2026-01-19	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2109	7	3	2026-01-20	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2110	7	3	2026-01-21	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2111	7	3	2026-01-22	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2112	7	3	2026-01-23	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2113	10	3	2026-01-19	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2114	10	3	2026-01-20	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2115	10	3	2026-01-21	1	\N	2026-01-23 17:54:23	ADMIN	asistio
2116	10	3	2026-01-22	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2117	10	3	2026-01-23	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2118	235	3	2026-01-19	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2119	235	3	2026-01-20	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2120	235	3	2026-01-21	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2121	235	3	2026-01-22	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2122	235	3	2026-01-23	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2123	88	3	2026-01-19	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2124	88	3	2026-01-20	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2125	88	3	2026-01-21	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2126	88	3	2026-01-22	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2127	88	3	2026-01-23	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2128	239	3	2026-01-19	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2129	239	3	2026-01-20	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2130	239	3	2026-01-21	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2131	239	3	2026-01-22	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2132	239	3	2026-01-23	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2133	12	3	2026-01-19	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2134	12	3	2026-01-20	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2135	12	3	2026-01-21	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2136	12	3	2026-01-22	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2137	12	3	2026-01-23	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2138	8	3	2026-01-19	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2139	8	3	2026-01-20	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2140	8	3	2026-01-21	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2141	8	3	2026-01-22	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2142	8	3	2026-01-23	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2143	14	3	2026-01-19	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2144	14	3	2026-01-20	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2145	14	3	2026-01-21	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2146	14	3	2026-01-22	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2147	14	3	2026-01-23	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2148	228	3	2026-01-19	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2149	228	3	2026-01-20	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2150	228	3	2026-01-21	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2151	228	3	2026-01-22	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2152	228	3	2026-01-23	1	\N	2026-01-23 17:54:24	ADMIN	asistio
2153	9	3	2026-01-19	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2154	9	3	2026-01-20	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2155	9	3	2026-01-21	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2156	9	3	2026-01-22	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2157	9	3	2026-01-23	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2158	248	3	2026-01-19	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2159	248	3	2026-01-20	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2160	248	3	2026-01-21	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2161	248	3	2026-01-22	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2162	248	3	2026-01-23	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2163	238	3	2026-01-19	0	\N	2026-01-23 17:54:25	ADMIN	falto
2164	238	3	2026-01-20	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2165	238	3	2026-01-21	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2166	238	3	2026-01-22	0	\N	2026-01-23 17:54:25	ADMIN	falto
2167	238	3	2026-01-23	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2168	20	3	2026-01-19	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2169	20	3	2026-01-20	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2170	20	3	2026-01-21	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2171	20	3	2026-01-22	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2172	20	3	2026-01-23	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2173	22	3	2026-01-19	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2174	22	3	2026-01-20	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2175	22	3	2026-01-21	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2176	22	3	2026-01-22	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2177	22	3	2026-01-23	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2178	24	3	2026-01-19	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2179	24	3	2026-01-20	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2180	24	3	2026-01-21	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2181	24	3	2026-01-22	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2182	24	3	2026-01-23	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2183	26	3	2026-01-19	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2184	26	3	2026-01-20	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2185	26	3	2026-01-21	0	\N	2026-01-23 17:54:25	ADMIN	falto
2186	26	3	2026-01-22	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2187	26	3	2026-01-23	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2188	31	3	2026-01-19	1	\N	2026-01-23 17:54:25	ADMIN	asistio
2189	31	3	2026-01-20	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2190	31	3	2026-01-21	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2191	31	3	2026-01-22	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2192	31	3	2026-01-23	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2193	32	3	2026-01-19	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2194	32	3	2026-01-20	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2195	32	3	2026-01-21	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2196	32	3	2026-01-22	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2197	32	3	2026-01-23	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2198	38	3	2026-01-19	0	\N	2026-01-23 17:54:26	ADMIN	falto
2199	38	3	2026-01-20	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2200	38	3	2026-01-21	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2201	38	3	2026-01-22	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2202	38	3	2026-01-23	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2203	40	3	2026-01-19	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2204	40	3	2026-01-20	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2205	40	3	2026-01-21	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2206	40	3	2026-01-22	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2207	40	3	2026-01-23	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2208	41	3	2026-01-19	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2209	41	3	2026-01-20	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2210	41	3	2026-01-21	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2211	41	3	2026-01-22	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2212	41	3	2026-01-23	0	\N	2026-01-23 17:54:26	ADMIN	falto
2213	43	3	2026-01-19	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2214	43	3	2026-01-20	0	\N	2026-01-23 17:54:26	ADMIN	falto
2215	43	3	2026-01-21	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2216	43	3	2026-01-22	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2217	43	3	2026-01-23	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2218	44	3	2026-01-19	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2219	44	3	2026-01-20	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2220	44	3	2026-01-21	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2221	44	3	2026-01-22	0	\N	2026-01-23 17:54:26	ADMIN	justificada
2222	44	3	2026-01-23	0	\N	2026-01-23 17:54:26	ADMIN	justificada
2223	23	3	2026-01-19	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2224	23	3	2026-01-20	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2225	23	3	2026-01-21	1	\N	2026-01-23 17:54:26	ADMIN	asistio
2226	23	3	2026-01-22	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2227	23	3	2026-01-23	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2228	45	3	2026-01-19	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2229	45	3	2026-01-20	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2230	45	3	2026-01-21	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2231	45	3	2026-01-22	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2232	45	3	2026-01-23	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2233	25	3	2026-01-19	0	\N	2026-01-23 17:54:27	ADMIN	falto
2234	25	3	2026-01-20	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2235	25	3	2026-01-21	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2236	25	3	2026-01-22	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2237	25	3	2026-01-23	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2238	236	3	2026-01-19	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2239	236	3	2026-01-20	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2240	236	3	2026-01-21	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2241	236	3	2026-01-22	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2242	236	3	2026-01-23	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2243	51	3	2026-01-19	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2244	51	3	2026-01-20	0	\N	2026-01-23 17:54:27	ADMIN	falto
2245	51	3	2026-01-21	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2246	51	3	2026-01-22	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2247	51	3	2026-01-23	0	\N	2026-01-23 17:54:27	ADMIN	falto
2248	54	3	2026-01-19	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2249	54	3	2026-01-20	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2250	54	3	2026-01-21	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2251	54	3	2026-01-22	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2252	54	3	2026-01-23	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2253	56	3	2026-01-19	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2254	56	3	2026-01-20	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2255	56	3	2026-01-21	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2256	56	3	2026-01-22	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2257	56	3	2026-01-23	0	\N	2026-01-23 17:54:27	ADMIN	falto
2258	58	3	2026-01-19	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2259	58	3	2026-01-20	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2260	58	3	2026-01-21	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2261	58	3	2026-01-22	1	\N	2026-01-23 17:54:27	ADMIN	asistio
2262	58	3	2026-01-23	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2263	59	3	2026-01-19	0	\N	2026-01-23 17:54:28	ADMIN	justificada
2264	59	3	2026-01-20	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2265	59	3	2026-01-21	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2266	59	3	2026-01-22	0	\N	2026-01-23 17:54:28	ADMIN	falto
2267	59	3	2026-01-23	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2268	30	3	2026-01-19	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2269	30	3	2026-01-20	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2270	30	3	2026-01-21	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2271	30	3	2026-01-22	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2272	30	3	2026-01-23	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2273	33	3	2026-01-19	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2274	33	3	2026-01-20	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2275	33	3	2026-01-21	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2276	33	3	2026-01-22	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2277	33	3	2026-01-23	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2278	29	3	2026-01-19	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2279	29	3	2026-01-20	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2280	29	3	2026-01-21	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2281	29	3	2026-01-22	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2282	29	3	2026-01-23	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2283	34	3	2026-01-19	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2284	34	3	2026-01-20	0	\N	2026-01-23 17:54:28	ADMIN	justificada
2285	34	3	2026-01-21	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2286	34	3	2026-01-22	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2287	34	3	2026-01-23	1	\N	2026-01-23 17:54:28	ADMIN	asistio
2288	229	3	2026-01-19	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2289	229	3	2026-01-20	0	\N	2026-01-23 17:41:55	ADMIN	falto
2290	229	3	2026-01-21	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2291	229	3	2026-01-22	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2292	229	3	2026-01-23	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2293	39	3	2026-01-19	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2294	39	3	2026-01-20	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2295	39	3	2026-01-21	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2296	39	3	2026-01-22	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2297	39	3	2026-01-23	0	\N	2026-01-23 17:41:55	ADMIN	falto
2298	85	3	2026-01-19	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2299	85	3	2026-01-20	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2300	85	3	2026-01-21	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2301	85	3	2026-01-22	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2302	85	3	2026-01-23	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2303	86	3	2026-01-19	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2304	86	3	2026-01-20	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2305	86	3	2026-01-21	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2306	86	3	2026-01-22	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2307	86	3	2026-01-23	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2308	253	3	2026-01-19	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2309	253	3	2026-01-20	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2310	253	3	2026-01-21	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2311	253	3	2026-01-22	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2312	253	3	2026-01-23	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2313	237	3	2026-01-19	0	\N	2026-01-23 17:41:55	ADMIN	falto
2314	237	3	2026-01-20	0	\N	2026-01-23 17:41:55	ADMIN	falto
2315	237	3	2026-01-21	0	\N	2026-01-23 17:41:55	ADMIN	falto
2316	237	3	2026-01-22	0	\N	2026-01-23 17:41:55	ADMIN	falto
2317	237	3	2026-01-23	0	\N	2026-01-23 17:41:55	ADMIN	falto
2318	232	3	2026-01-19	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2319	232	3	2026-01-20	1	\N	2026-01-23 17:41:55	ADMIN	asistio
2320	232	3	2026-01-21	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2321	232	3	2026-01-22	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2322	232	3	2026-01-23	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2323	11	3	2026-01-19	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2324	11	3	2026-01-20	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2325	11	3	2026-01-21	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2326	11	3	2026-01-22	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2327	11	3	2026-01-23	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2328	16	3	2026-01-19	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2329	16	3	2026-01-20	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2330	16	3	2026-01-21	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2331	16	3	2026-01-22	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2332	16	3	2026-01-23	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2333	18	3	2026-01-19	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2334	18	3	2026-01-20	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2335	18	3	2026-01-21	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2336	18	3	2026-01-22	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2337	18	3	2026-01-23	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2338	46	3	2026-01-19	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2339	46	3	2026-01-20	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2340	46	3	2026-01-21	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2341	46	3	2026-01-22	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2342	46	3	2026-01-23	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2343	37	3	2026-01-19	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2344	37	3	2026-01-20	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2345	37	3	2026-01-21	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2346	37	3	2026-01-22	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2347	37	3	2026-01-23	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2348	48	3	2026-01-19	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2349	48	3	2026-01-20	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2350	48	3	2026-01-21	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2351	48	3	2026-01-22	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2352	48	3	2026-01-23	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2353	15	3	2026-01-19	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2354	15	3	2026-01-20	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2355	15	3	2026-01-21	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2356	15	3	2026-01-22	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2357	15	3	2026-01-23	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2358	17	3	2026-01-19	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2359	17	3	2026-01-20	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2360	17	3	2026-01-21	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2361	17	3	2026-01-22	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2362	17	3	2026-01-23	1	\N	2026-01-23 17:41:56	ADMIN	asistio
2363	50	3	2026-01-19	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2364	50	3	2026-01-20	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2365	50	3	2026-01-21	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2366	50	3	2026-01-22	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2367	50	3	2026-01-23	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2368	28	3	2026-01-19	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2369	28	3	2026-01-20	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2370	28	3	2026-01-21	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2371	28	3	2026-01-22	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2372	28	3	2026-01-23	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2373	35	3	2026-01-19	0	\N	2026-01-23 17:41:57	ADMIN	falto
2374	35	3	2026-01-20	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2375	35	3	2026-01-21	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2376	35	3	2026-01-22	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2377	35	3	2026-01-23	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2378	19	3	2026-01-19	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2379	19	3	2026-01-20	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2380	19	3	2026-01-21	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2381	19	3	2026-01-22	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2382	19	3	2026-01-23	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2383	21	3	2026-01-19	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2384	21	3	2026-01-20	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2385	21	3	2026-01-21	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2386	21	3	2026-01-22	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2387	21	3	2026-01-23	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2388	227	3	2026-01-19	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2389	227	3	2026-01-20	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2390	227	3	2026-01-21	0	\N	2026-01-23 17:41:57	ADMIN	falto
2391	227	3	2026-01-22	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2392	227	3	2026-01-23	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2393	84	3	2026-01-19	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2394	84	3	2026-01-20	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2395	84	3	2026-01-21	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2396	84	3	2026-01-22	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2397	84	3	2026-01-23	0	\N	2026-01-23 17:41:57	ADMIN	falto
2398	47	3	2026-01-19	1	\N	2026-01-23 17:41:57	ADMIN	tardanza
2399	47	3	2026-01-20	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2400	47	3	2026-01-21	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2401	47	3	2026-01-22	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2402	47	3	2026-01-23	0	\N	2026-01-23 17:41:57	ADMIN	falto
2403	226	3	2026-01-19	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2404	226	3	2026-01-20	1	\N	2026-01-23 17:41:57	ADMIN	asistio
2405	226	3	2026-01-21	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2406	226	3	2026-01-22	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2407	226	3	2026-01-23	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2408	49	3	2026-01-19	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2409	49	3	2026-01-20	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2410	49	3	2026-01-21	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2411	49	3	2026-01-22	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2412	49	3	2026-01-23	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2413	254	3	2026-01-19	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2414	254	3	2026-01-20	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2415	254	3	2026-01-21	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2416	254	3	2026-01-22	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2417	254	3	2026-01-23	0	\N	2026-01-23 17:41:58	ADMIN	falto
2418	52	3	2026-01-19	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2419	52	3	2026-01-20	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2420	52	3	2026-01-21	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2421	52	3	2026-01-22	0	\N	2026-01-23 17:41:58	ADMIN	falto
2422	52	3	2026-01-23	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2423	53	3	2026-01-19	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2424	53	3	2026-01-20	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2425	53	3	2026-01-21	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2426	53	3	2026-01-22	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2427	53	3	2026-01-23	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2428	244	3	2026-01-19	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2429	244	3	2026-01-20	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2430	244	3	2026-01-21	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2431	244	3	2026-01-22	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2432	244	3	2026-01-23	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2433	42	3	2026-01-19	1	\N	2026-01-23 17:41:58	ADMIN	tardanza
2434	42	3	2026-01-20	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2435	42	3	2026-01-21	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2436	42	3	2026-01-22	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2437	42	3	2026-01-23	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2438	55	3	2026-01-19	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2439	55	3	2026-01-20	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2440	55	3	2026-01-21	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2441	55	3	2026-01-22	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2442	55	3	2026-01-23	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2443	27	3	2026-01-19	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2444	27	3	2026-01-20	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2445	27	3	2026-01-21	0	\N	2026-01-23 17:41:58	ADMIN	falto
2446	27	3	2026-01-22	1	\N	2026-01-23 17:41:58	ADMIN	asistio
2447	27	3	2026-01-23	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2448	57	3	2026-01-19	0	\N	2026-01-23 17:41:59	ADMIN	falto
2449	57	3	2026-01-20	0	\N	2026-01-23 17:41:59	ADMIN	falto
2450	57	3	2026-01-21	0	\N	2026-01-23 17:41:59	ADMIN	falto
2451	57	3	2026-01-22	0	\N	2026-01-23 17:41:59	ADMIN	falto
2452	57	3	2026-01-23	0	\N	2026-01-23 17:41:59	ADMIN	falto
2453	255	3	2026-01-19	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2454	255	3	2026-01-20	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2455	255	3	2026-01-21	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2456	255	3	2026-01-22	0	\N	2026-01-23 17:41:59	ADMIN	falto
2457	255	3	2026-01-23	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2458	268	3	2026-01-19	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2459	268	3	2026-01-20	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2460	268	3	2026-01-21	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2461	268	3	2026-01-22	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2462	268	3	2026-01-23	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2463	60	3	2026-01-19	0	\N	2026-01-23 17:41:59	ADMIN	falto
2464	60	3	2026-01-20	0	\N	2026-01-23 17:41:59	ADMIN	falto
2465	60	3	2026-01-21	0	\N	2026-01-23 17:41:59	ADMIN	falto
2466	60	3	2026-01-22	0	\N	2026-01-23 17:41:59	ADMIN	falto
2467	60	3	2026-01-23	0	\N	2026-01-23 17:41:59	ADMIN	falto
2468	230	3	2026-01-19	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2469	230	3	2026-01-20	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2470	230	3	2026-01-21	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2471	230	3	2026-01-22	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2472	230	3	2026-01-23	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2473	61	3	2026-01-19	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2474	61	3	2026-01-20	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2475	61	3	2026-01-21	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2476	61	3	2026-01-22	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2477	61	3	2026-01-23	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2478	256	3	2026-01-19	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2479	256	3	2026-01-20	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2480	256	3	2026-01-21	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2481	256	3	2026-01-22	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2482	256	3	2026-01-23	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2483	269	3	2026-01-19	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2484	269	3	2026-01-20	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2485	269	3	2026-01-21	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2486	269	3	2026-01-22	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2487	269	3	2026-01-23	1	\N	2026-01-23 17:41:59	ADMIN	asistio
2488	62	3	2026-01-19	0	\N	2026-01-23 17:41:59	ADMIN	falto
2489	62	3	2026-01-20	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2490	62	3	2026-01-21	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2491	62	3	2026-01-22	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2492	62	3	2026-01-23	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2493	36	3	2026-01-19	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2494	36	3	2026-01-20	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2495	36	3	2026-01-21	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2496	36	3	2026-01-22	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2497	36	3	2026-01-23	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2498	267	3	2026-01-19	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2499	267	3	2026-01-20	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2500	267	3	2026-01-21	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2501	267	3	2026-01-22	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2502	267	3	2026-01-23	1	\N	2026-01-23 17:42:00	ADMIN	asistio
2503	220	3	2026-01-19	1	\N	2026-01-23 16:33:24	ADMIN	asistio
2504	220	3	2026-01-20	1	\N	2026-01-23 16:33:24	ADMIN	asistio
2505	220	3	2026-01-21	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2506	220	3	2026-01-22	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2507	220	3	2026-01-23	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2508	240	3	2026-01-19	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2509	240	3	2026-01-20	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2510	240	3	2026-01-21	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2511	240	3	2026-01-22	0	\N	2026-01-23 16:33:25	ADMIN	falto
2512	240	3	2026-01-23	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2513	181	3	2026-01-19	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2514	181	3	2026-01-20	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2515	181	3	2026-01-21	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2516	181	3	2026-01-22	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2517	181	3	2026-01-23	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2518	136	3	2026-01-19	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2519	136	3	2026-01-20	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2520	136	3	2026-01-21	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2521	136	3	2026-01-22	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2522	136	3	2026-01-23	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2523	231	3	2026-01-19	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2524	231	3	2026-01-20	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2525	231	3	2026-01-21	0	\N	2026-01-23 16:33:25	ADMIN	falto
2526	231	3	2026-01-22	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2527	231	3	2026-01-23	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2528	149	3	2026-01-19	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2529	149	3	2026-01-20	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2530	149	3	2026-01-21	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2531	149	3	2026-01-22	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2532	149	3	2026-01-23	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2533	207	3	2026-01-19	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2534	207	3	2026-01-20	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2535	207	3	2026-01-21	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2536	207	3	2026-01-22	0	\N	2026-01-23 16:33:25	ADMIN	falto
2537	207	3	2026-01-23	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2538	151	3	2026-01-19	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2539	151	3	2026-01-20	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2540	151	3	2026-01-21	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2541	151	3	2026-01-22	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2542	151	3	2026-01-23	0	\N	2026-01-23 16:33:25	ADMIN	falto
2543	195	3	2026-01-19	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2544	195	3	2026-01-20	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2545	195	3	2026-01-21	1	\N	2026-01-23 16:33:25	ADMIN	asistio
2546	195	3	2026-01-22	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2547	195	3	2026-01-23	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2548	200	3	2026-01-19	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2549	200	3	2026-01-20	0	\N	2026-01-23 16:33:26	ADMIN	falto
2550	200	3	2026-01-21	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2551	200	3	2026-01-22	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2552	200	3	2026-01-23	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2553	80	3	2026-01-19	0	\N	2026-01-23 16:33:26	ADMIN	falto
2554	80	3	2026-01-20	0	\N	2026-01-23 16:33:26	ADMIN	falto
2555	80	3	2026-01-21	0	\N	2026-01-23 16:33:26	ADMIN	falto
2556	80	3	2026-01-22	0	\N	2026-01-23 16:33:26	ADMIN	falto
2557	80	3	2026-01-23	0	\N	2026-01-23 16:33:26	ADMIN	falto
2558	159	3	2026-01-19	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2559	159	3	2026-01-20	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2560	159	3	2026-01-21	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2561	159	3	2026-01-22	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2562	159	3	2026-01-23	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2563	214	3	2026-01-19	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2564	214	3	2026-01-20	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2565	214	3	2026-01-21	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2566	214	3	2026-01-22	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2567	214	3	2026-01-23	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2568	221	3	2026-01-19	0	\N	2026-01-23 16:33:26	ADMIN	justificada
2569	221	3	2026-01-20	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2570	221	3	2026-01-21	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2571	221	3	2026-01-22	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2572	221	3	2026-01-23	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2573	161	3	2026-01-19	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2574	161	3	2026-01-20	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2575	161	3	2026-01-21	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2576	161	3	2026-01-22	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2577	161	3	2026-01-23	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2578	163	3	2026-01-19	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2579	163	3	2026-01-20	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2580	163	3	2026-01-21	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2581	163	3	2026-01-22	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2582	163	3	2026-01-23	0	\N	2026-01-23 16:33:26	ADMIN	falto
2583	166	3	2026-01-19	0	\N	2026-01-23 16:33:26	ADMIN	falto
2584	166	3	2026-01-20	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2585	166	3	2026-01-21	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2586	166	3	2026-01-22	1	\N	2026-01-23 16:33:26	ADMIN	asistio
2587	166	3	2026-01-23	0	\N	2026-01-23 16:33:26	ADMIN	falto
2588	167	3	2026-01-19	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2589	167	3	2026-01-20	0	\N	2026-01-23 16:33:27	ADMIN	falto
2590	167	3	2026-01-21	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2591	167	3	2026-01-22	0	\N	2026-01-23 16:33:27	ADMIN	falto
2592	167	3	2026-01-23	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2593	170	3	2026-01-19	1	\N	2026-01-23 16:33:27	ADMIN	tardanza
2594	170	3	2026-01-20	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2595	170	3	2026-01-21	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2596	170	3	2026-01-22	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2597	170	3	2026-01-23	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2598	198	3	2026-01-19	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2599	198	3	2026-01-20	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2600	198	3	2026-01-21	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2601	198	3	2026-01-22	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2602	198	3	2026-01-23	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2603	204	3	2026-01-19	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2604	204	3	2026-01-20	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2605	204	3	2026-01-21	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2606	204	3	2026-01-22	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2607	204	3	2026-01-23	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2608	249	3	2026-01-19	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2609	249	3	2026-01-20	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2610	249	3	2026-01-21	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2611	249	3	2026-01-22	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2612	249	3	2026-01-23	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2613	223	3	2026-01-19	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2614	223	3	2026-01-20	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2615	223	3	2026-01-21	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2616	223	3	2026-01-22	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2617	223	3	2026-01-23	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2618	174	3	2026-01-19	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2619	174	3	2026-01-20	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2620	174	3	2026-01-21	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2621	174	3	2026-01-22	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2622	174	3	2026-01-23	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2623	175	3	2026-01-19	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2624	175	3	2026-01-20	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2625	175	3	2026-01-21	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2626	175	3	2026-01-22	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2627	175	3	2026-01-23	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2628	179	3	2026-01-19	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2629	179	3	2026-01-20	1	\N	2026-01-23 16:33:27	ADMIN	asistio
2630	179	3	2026-01-21	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2631	179	3	2026-01-22	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2632	179	3	2026-01-23	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2633	182	3	2026-01-19	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2634	182	3	2026-01-20	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2635	182	3	2026-01-21	0	\N	2026-01-23 16:33:28	ADMIN	falto
2636	182	3	2026-01-22	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2637	182	3	2026-01-23	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2638	224	3	2026-01-19	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2639	224	3	2026-01-20	0	\N	2026-01-23 16:33:28	ADMIN	falto
2640	224	3	2026-01-21	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2641	224	3	2026-01-22	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2642	224	3	2026-01-23	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2643	183	3	2026-01-19	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2644	183	3	2026-01-20	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2645	183	3	2026-01-21	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2646	183	3	2026-01-22	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2647	183	3	2026-01-23	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2648	185	3	2026-01-19	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2649	185	3	2026-01-20	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2650	185	3	2026-01-21	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2651	185	3	2026-01-22	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2652	185	3	2026-01-23	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2653	186	3	2026-01-19	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2654	186	3	2026-01-20	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2655	186	3	2026-01-21	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2656	186	3	2026-01-22	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2657	186	3	2026-01-23	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2658	215	3	2026-01-19	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2659	215	3	2026-01-20	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2660	215	3	2026-01-21	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2661	215	3	2026-01-22	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2662	215	3	2026-01-23	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2663	211	3	2026-01-19	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2664	211	3	2026-01-20	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2665	211	3	2026-01-21	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2666	211	3	2026-01-22	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2667	211	3	2026-01-23	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2668	190	3	2026-01-19	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2669	190	3	2026-01-20	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2670	190	3	2026-01-21	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2671	190	3	2026-01-22	1	\N	2026-01-23 16:33:28	ADMIN	asistio
2672	190	3	2026-01-23	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2673	205	3	2026-01-19	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2674	205	3	2026-01-20	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2675	205	3	2026-01-21	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2676	205	3	2026-01-22	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2677	205	3	2026-01-23	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2678	191	3	2026-01-19	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2679	191	3	2026-01-20	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2680	191	3	2026-01-21	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2681	191	3	2026-01-22	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2682	191	3	2026-01-23	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2683	178	3	2026-01-19	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2684	178	3	2026-01-20	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2685	178	3	2026-01-21	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2686	178	3	2026-01-22	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2687	178	3	2026-01-23	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2688	194	3	2026-01-19	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2689	194	3	2026-01-20	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2690	194	3	2026-01-21	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2691	194	3	2026-01-22	0	\N	2026-01-23 16:33:29	ADMIN	falto
2692	194	3	2026-01-23	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2693	206	3	2026-01-19	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2694	206	3	2026-01-20	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2695	206	3	2026-01-21	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2696	206	3	2026-01-22	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2697	206	3	2026-01-23	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2698	176	3	2026-01-19	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2699	176	3	2026-01-20	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2700	176	3	2026-01-21	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2701	176	3	2026-01-22	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2702	176	3	2026-01-23	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2703	201	3	2026-01-19	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2704	201	3	2026-01-20	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2705	201	3	2026-01-21	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2706	201	3	2026-01-22	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2707	201	3	2026-01-23	1	\N	2026-01-23 16:33:29	ADMIN	asistio
2708	93	3	2026-01-19	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2709	93	3	2026-01-21	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2710	93	3	2026-01-23	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2711	94	3	2026-01-19	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2712	94	3	2026-01-21	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2713	94	3	2026-01-23	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2714	97	3	2026-01-19	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2715	97	3	2026-01-21	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2716	97	3	2026-01-23	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2717	99	3	2026-01-19	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2718	99	3	2026-01-21	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2719	99	3	2026-01-23	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2720	100	3	2026-01-19	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2721	100	3	2026-01-21	1	\N	2026-01-23 16:25:21	ADMIN	asistio
2722	100	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2723	169	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2724	169	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2725	169	3	2026-01-23	0	\N	2026-01-23 16:25:22	ADMIN	falto
2726	247	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2727	247	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2728	247	3	2026-01-23	0	\N	2026-01-23 16:25:22	ADMIN	falto
2729	101	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2730	101	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2731	101	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2732	102	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2733	102	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2734	102	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2735	104	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2736	104	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2737	104	3	2026-01-23	0	\N	2026-01-23 16:25:22	ADMIN	falto
2738	105	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2739	105	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2740	105	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2741	107	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2742	107	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2743	107	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2744	109	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2745	109	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2746	109	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2747	110	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2748	110	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2749	110	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2750	111	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2751	111	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2752	111	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2753	245	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2754	245	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2755	245	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2756	112	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2757	112	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2758	112	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2759	114	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2760	114	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2761	114	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2762	117	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2763	117	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2764	117	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2765	120	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2766	120	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2767	120	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2768	121	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2769	121	3	2026-01-21	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2770	121	3	2026-01-23	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2771	122	3	2026-01-19	1	\N	2026-01-23 16:25:22	ADMIN	asistio
2772	122	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2773	122	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2774	124	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2775	124	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2776	124	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2777	125	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2778	125	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2779	125	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2780	165	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2781	165	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2782	165	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2783	129	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2784	129	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2785	129	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2786	127	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2787	127	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2788	127	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2789	132	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2790	132	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2791	132	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2792	133	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2793	133	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2794	133	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2795	164	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2796	164	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2797	164	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2798	134	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2799	134	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2800	134	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2801	137	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2802	137	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2803	137	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2804	138	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2805	138	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2806	138	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2807	139	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2808	139	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2809	139	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2810	140	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2811	140	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2812	140	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2813	141	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2814	141	3	2026-01-21	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2815	141	3	2026-01-23	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2816	162	3	2026-01-19	1	\N	2026-01-23 16:25:23	ADMIN	asistio
2817	162	3	2026-01-21	0	\N	2026-01-23 16:25:23	ADMIN	falto
2818	162	3	2026-01-23	0	\N	2026-01-23 16:25:23	ADMIN	falto
2819	246	3	2026-01-19	0	\N	2026-01-23 16:25:23	ADMIN	falto
2820	246	3	2026-01-21	0	\N	2026-01-23 16:25:23	ADMIN	falto
2821	246	3	2026-01-23	0	\N	2026-01-23 16:25:23	ADMIN	falto
2822	142	3	2026-01-19	0	\N	2026-01-23 16:25:24	ADMIN	falto
2823	142	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2824	142	3	2026-01-23	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2825	143	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2826	143	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2827	143	3	2026-01-23	0	\N	2026-01-23 16:25:24	ADMIN	falto
2828	145	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2829	145	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2830	145	3	2026-01-23	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2831	146	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2832	146	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2833	146	3	2026-01-23	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2834	157	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2835	157	3	2026-01-21	0	\N	2026-01-23 16:25:24	ADMIN	falto
2836	157	3	2026-01-23	0	\N	2026-01-23 16:25:24	ADMIN	falto
2837	147	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2838	147	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2839	147	3	2026-01-23	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2840	148	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2841	148	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2842	148	3	2026-01-23	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2843	265	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2844	265	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2845	265	3	2026-01-23	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2846	158	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2847	158	3	2026-01-21	0	\N	2026-01-23 16:25:24	ADMIN	falto
2848	158	3	2026-01-23	0	\N	2026-01-23 16:25:24	ADMIN	falto
2849	150	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2850	150	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2851	150	3	2026-01-23	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2852	152	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2853	152	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2854	152	3	2026-01-23	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2855	154	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2856	154	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2857	154	3	2026-01-23	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2858	160	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2859	160	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2860	160	3	2026-01-23	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2861	270	3	2026-01-19	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2862	270	3	2026-01-21	1	\N	2026-01-23 16:25:24	ADMIN	asistio
2863	270	3	2026-01-23	0	\N	2026-01-23 16:25:24	ADMIN	falto
2864	209	3	2026-01-19	1	\N	2026-01-23 16:42:34	ADMIN	asistio
2865	209	3	2026-01-20	1	\N	2026-01-23 16:42:34	ADMIN	asistio
2866	209	3	2026-01-21	1	\N	2026-01-23 16:42:34	ADMIN	asistio
2867	209	3	2026-01-22	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2868	209	3	2026-01-23	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2869	184	3	2026-01-19	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2870	184	3	2026-01-20	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2871	184	3	2026-01-21	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2872	184	3	2026-01-22	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2873	184	3	2026-01-23	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2874	222	3	2026-01-19	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2875	222	3	2026-01-20	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2876	222	3	2026-01-21	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2877	222	3	2026-01-22	0	\N	2026-01-23 16:42:35	ADMIN	falto
2878	222	3	2026-01-23	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2879	250	3	2026-01-19	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2880	250	3	2026-01-20	0	\N	2026-01-23 16:42:35	ADMIN	falto
2881	250	3	2026-01-21	0	\N	2026-01-23 16:42:35	ADMIN	falto
2882	250	3	2026-01-22	0	\N	2026-01-23 16:42:35	ADMIN	falto
2883	250	3	2026-01-23	0	\N	2026-01-23 16:42:35	ADMIN	falto
2884	135	3	2026-01-19	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2885	135	3	2026-01-20	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2886	135	3	2026-01-21	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2887	135	3	2026-01-22	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2888	135	3	2026-01-23	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2889	208	3	2026-01-19	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2890	208	3	2026-01-20	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2891	208	3	2026-01-21	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2892	208	3	2026-01-22	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2893	208	3	2026-01-23	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2894	193	3	2026-01-19	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2895	193	3	2026-01-20	0	\N	2026-01-23 16:42:35	ADMIN	falto
2896	193	3	2026-01-21	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2897	193	3	2026-01-22	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2898	193	3	2026-01-23	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2899	219	3	2026-01-19	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2900	219	3	2026-01-20	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2901	219	3	2026-01-21	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2902	219	3	2026-01-22	0	\N	2026-01-23 16:42:35	ADMIN	falto
2903	219	3	2026-01-23	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2904	153	3	2026-01-19	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2905	153	3	2026-01-20	0	\N	2026-01-23 16:42:35	ADMIN	falto
2906	153	3	2026-01-21	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2907	153	3	2026-01-22	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2908	153	3	2026-01-23	1	\N	2026-01-23 16:42:35	ADMIN	asistio
2909	155	3	2026-01-19	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2910	155	3	2026-01-20	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2911	155	3	2026-01-21	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2912	155	3	2026-01-22	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2913	155	3	2026-01-23	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2914	225	3	2026-01-19	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2915	225	3	2026-01-20	0	\N	2026-01-23 16:42:36	ADMIN	falto
2916	225	3	2026-01-21	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2917	225	3	2026-01-22	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2918	225	3	2026-01-23	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2919	168	3	2026-01-19	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2920	168	3	2026-01-20	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2921	168	3	2026-01-21	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2922	168	3	2026-01-22	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2923	168	3	2026-01-23	0	\N	2026-01-23 16:42:36	ADMIN	falto
2924	171	3	2026-01-19	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2925	171	3	2026-01-20	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2926	171	3	2026-01-21	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2927	171	3	2026-01-22	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2928	171	3	2026-01-23	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2929	172	3	2026-01-19	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2930	172	3	2026-01-20	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2931	172	3	2026-01-21	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2932	172	3	2026-01-22	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2933	172	3	2026-01-23	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2934	251	3	2026-01-19	0	\N	2026-01-23 16:42:36	ADMIN	falto
2935	251	3	2026-01-20	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2936	251	3	2026-01-21	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2937	251	3	2026-01-22	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2938	251	3	2026-01-23	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2939	218	3	2026-01-19	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2940	218	3	2026-01-20	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2941	218	3	2026-01-21	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2942	218	3	2026-01-22	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2943	218	3	2026-01-23	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2944	173	3	2026-01-19	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2945	173	3	2026-01-20	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2946	173	3	2026-01-21	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2947	173	3	2026-01-22	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2948	173	3	2026-01-23	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2949	252	3	2026-01-19	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2950	252	3	2026-01-20	1	\N	2026-01-23 16:42:36	ADMIN	asistio
2951	252	3	2026-01-21	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2952	252	3	2026-01-22	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2953	252	3	2026-01-23	0	\N	2026-01-23 16:42:37	ADMIN	falto
2954	217	3	2026-01-19	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2955	217	3	2026-01-20	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2956	217	3	2026-01-21	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2957	217	3	2026-01-22	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2958	217	3	2026-01-23	0	\N	2026-01-23 16:42:37	ADMIN	falto
2959	213	3	2026-01-19	0	\N	2026-01-23 16:42:37	ADMIN	falto
2960	213	3	2026-01-20	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2961	213	3	2026-01-21	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2962	213	3	2026-01-22	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2963	213	3	2026-01-23	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2964	210	3	2026-01-19	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2965	210	3	2026-01-20	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2966	210	3	2026-01-21	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2967	210	3	2026-01-22	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2968	210	3	2026-01-23	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2969	177	3	2026-01-19	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2970	177	3	2026-01-20	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2971	177	3	2026-01-21	0	\N	2026-01-23 16:42:37	ADMIN	falto
2972	177	3	2026-01-22	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2973	177	3	2026-01-23	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2974	180	3	2026-01-19	0	\N	2026-01-23 16:42:37	ADMIN	falto
2975	180	3	2026-01-20	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2976	180	3	2026-01-21	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2977	180	3	2026-01-22	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2978	180	3	2026-01-23	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2979	202	3	2026-01-19	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2980	202	3	2026-01-20	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2981	202	3	2026-01-21	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2982	202	3	2026-01-22	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2983	202	3	2026-01-23	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2984	192	3	2026-01-19	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2985	192	3	2026-01-20	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2986	192	3	2026-01-21	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2987	192	3	2026-01-22	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2988	192	3	2026-01-23	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2989	187	3	2026-01-19	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2990	187	3	2026-01-20	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2991	187	3	2026-01-21	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2992	187	3	2026-01-22	1	\N	2026-01-23 16:42:37	ADMIN	asistio
2993	187	3	2026-01-23	1	\N	2026-01-23 16:42:38	ADMIN	asistio
2994	203	3	2026-01-19	1	\N	2026-01-23 16:42:38	ADMIN	asistio
2995	203	3	2026-01-20	0	\N	2026-01-23 16:42:38	ADMIN	falto
2996	203	3	2026-01-21	1	\N	2026-01-23 16:42:38	ADMIN	asistio
2997	203	3	2026-01-22	1	\N	2026-01-23 16:42:38	ADMIN	asistio
2998	203	3	2026-01-23	1	\N	2026-01-23 16:42:38	ADMIN	asistio
2999	212	3	2026-01-19	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3000	212	3	2026-01-20	0	\N	2026-01-23 16:42:38	ADMIN	falto
3001	212	3	2026-01-21	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3002	212	3	2026-01-22	0	\N	2026-01-23 16:42:38	ADMIN	falto
3003	212	3	2026-01-23	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3004	188	3	2026-01-19	0	\N	2026-01-23 16:42:38	ADMIN	falto
3005	188	3	2026-01-20	0	\N	2026-01-23 16:42:38	ADMIN	falto
3006	188	3	2026-01-21	0	\N	2026-01-23 16:42:38	ADMIN	falto
3007	188	3	2026-01-22	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3008	188	3	2026-01-23	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3009	189	3	2026-01-19	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3010	189	3	2026-01-20	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3011	189	3	2026-01-21	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3012	189	3	2026-01-22	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3013	189	3	2026-01-23	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3014	196	3	2026-01-19	0	\N	2026-01-23 16:42:38	ADMIN	falto
3015	196	3	2026-01-20	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3016	196	3	2026-01-21	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3017	196	3	2026-01-22	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3018	196	3	2026-01-23	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3019	199	3	2026-01-19	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3020	199	3	2026-01-20	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3021	199	3	2026-01-21	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3022	199	3	2026-01-22	0	\N	2026-01-23 16:42:38	ADMIN	falto
3023	199	3	2026-01-23	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3024	197	3	2026-01-19	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3025	197	3	2026-01-20	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3026	197	3	2026-01-21	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3027	197	3	2026-01-22	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3028	197	3	2026-01-23	1	\N	2026-01-23 16:42:38	ADMIN	asistio
3029	64	3	2026-01-20	1	\N	2026-01-24 16:15:39	ADMIN	asistio
3030	64	3	2026-01-22	1	\N	2026-01-24 16:15:39	ADMIN	asistio
3031	64	3	2026-01-24	0	\N	2026-01-24 16:15:39	ADMIN	falto
3032	63	3	2026-01-20	1	\N	2026-01-24 16:15:39	ADMIN	asistio
3033	63	3	2026-01-22	1	\N	2026-01-24 16:15:39	ADMIN	asistio
3034	63	3	2026-01-24	0	\N	2026-01-24 16:15:39	ADMIN	falto
3035	91	3	2026-01-20	1	\N	2026-01-24 16:15:39	ADMIN	asistio
3036	91	3	2026-01-22	1	\N	2026-01-24 16:15:39	ADMIN	asistio
3037	91	3	2026-01-24	1	\N	2026-01-24 16:15:39	ADMIN	asistio
3038	66	3	2026-01-20	1	\N	2026-01-24 16:15:39	ADMIN	asistio
3039	66	3	2026-01-22	1	\N	2026-01-24 16:15:39	ADMIN	asistio
3040	66	3	2026-01-24	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3041	78	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3042	78	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3043	78	3	2026-01-24	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3044	95	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3045	95	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3046	95	3	2026-01-24	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3047	241	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3048	241	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3049	241	3	2026-01-24	0	\N	2026-01-24 16:15:40	ADMIN	falto
3050	260	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3051	260	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3052	260	3	2026-01-24	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3053	242	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3054	242	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3055	242	3	2026-01-24	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3056	68	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3057	68	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3058	68	3	2026-01-24	0	\N	2026-01-24 16:15:40	ADMIN	falto
3059	69	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3060	69	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3061	69	3	2026-01-24	0	\N	2026-01-24 16:15:40	ADMIN	falto
3062	262	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3063	262	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3064	262	3	2026-01-24	0	\N	2026-01-24 16:15:40	ADMIN	falto
3065	271	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3066	271	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3067	271	3	2026-01-24	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3068	79	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3069	79	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3070	79	3	2026-01-24	0	\N	2026-01-24 16:15:40	ADMIN	falto
3071	130	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3072	130	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3073	130	3	2026-01-24	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3074	70	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3075	70	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3076	70	3	2026-01-24	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3077	263	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3078	263	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3079	263	3	2026-01-24	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3080	106	3	2026-01-20	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3081	106	3	2026-01-22	1	\N	2026-01-24 16:15:40	ADMIN	asistio
3082	106	3	2026-01-24	0	\N	2026-01-24 16:15:40	ADMIN	falto
3083	257	3	2026-01-20	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3084	257	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3085	257	3	2026-01-24	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3086	77	3	2026-01-20	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3087	77	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3088	77	3	2026-01-24	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3089	108	3	2026-01-20	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3090	108	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3091	108	3	2026-01-24	0	\N	2026-01-24 16:15:41	ADMIN	falto
3092	113	3	2026-01-20	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3093	113	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3094	113	3	2026-01-24	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3095	259	3	2026-01-20	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3096	259	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3097	259	3	2026-01-24	0	\N	2026-01-24 16:15:41	ADMIN	falto
3098	258	3	2026-01-20	0	\N	2026-01-24 16:15:41	ADMIN	justificada
3099	258	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3100	258	3	2026-01-24	0	\N	2026-01-24 16:15:41	ADMIN	falto
3101	261	3	2026-01-20	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3102	261	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3103	261	3	2026-01-24	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3104	264	3	2026-01-20	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3105	264	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3106	264	3	2026-01-24	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3107	82	3	2026-01-20	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3108	82	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3109	82	3	2026-01-24	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3110	115	3	2026-01-20	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3111	115	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3112	115	3	2026-01-24	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3113	118	3	2026-01-20	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3114	118	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3115	118	3	2026-01-24	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3116	116	3	2026-01-20	0	\N	2026-01-24 16:15:41	ADMIN	justificada
3117	116	3	2026-01-22	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3118	116	3	2026-01-24	1	\N	2026-01-24 16:15:41	ADMIN	asistio
3119	3	4	2026-01-26	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3120	3	4	2026-01-27	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3121	3	4	2026-01-28	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3122	3	4	2026-01-29	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3123	3	4	2026-01-30	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3124	87	4	2026-01-26	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3125	87	4	2026-01-27	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3126	87	4	2026-01-28	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3127	87	4	2026-01-29	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3128	87	4	2026-01-30	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3129	6	4	2026-01-26	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3130	6	4	2026-01-27	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3131	6	4	2026-01-28	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3132	6	4	2026-01-29	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3133	6	4	2026-01-30	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3134	4	4	2026-01-26	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3135	4	4	2026-01-27	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3136	4	4	2026-01-28	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3137	4	4	2026-01-29	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3138	4	4	2026-01-30	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3139	5	4	2026-01-26	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3140	5	4	2026-01-27	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3141	5	4	2026-01-28	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3142	5	4	2026-01-29	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3143	5	4	2026-01-30	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3144	7	4	2026-01-26	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3145	7	4	2026-01-27	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3146	7	4	2026-01-28	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3147	7	4	2026-01-29	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3148	7	4	2026-01-30	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3149	10	4	2026-01-26	0	\N	2026-01-30 16:43:11	ADMIN	falto
3150	10	4	2026-01-27	0	\N	2026-01-30 16:43:11	ADMIN	falto
3151	10	4	2026-01-28	0	\N	2026-01-30 16:43:11	ADMIN	falto
3152	10	4	2026-01-29	0	\N	2026-01-30 16:43:11	ADMIN	falto
3153	10	4	2026-01-30	0	\N	2026-01-30 16:43:11	ADMIN	falto
3154	235	4	2026-01-26	0	\N	2026-01-30 16:43:11	ADMIN	falto
3155	235	4	2026-01-27	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3156	235	4	2026-01-28	0	\N	2026-01-30 16:43:11	ADMIN	falto
3157	235	4	2026-01-29	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3158	235	4	2026-01-30	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3159	88	4	2026-01-26	1	\N	2026-01-30 16:43:11	ADMIN	asistio
3160	88	4	2026-01-27	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3161	88	4	2026-01-28	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3162	88	4	2026-01-29	0	\N	2026-01-30 16:43:12	ADMIN	falto
3163	88	4	2026-01-30	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3164	239	4	2026-01-26	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3165	239	4	2026-01-27	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3166	239	4	2026-01-28	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3167	239	4	2026-01-29	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3168	239	4	2026-01-30	1	\N	2026-01-30 16:43:12	ADMIN	tardanza
3169	12	4	2026-01-26	0	\N	2026-01-30 16:43:12	ADMIN	falto
3170	12	4	2026-01-27	0	\N	2026-01-30 16:43:12	ADMIN	falto
3171	12	4	2026-01-28	0	\N	2026-01-30 16:43:12	ADMIN	falto
3172	12	4	2026-01-29	0	\N	2026-01-30 16:43:12	ADMIN	falto
3173	12	4	2026-01-30	0	\N	2026-01-30 16:43:12	ADMIN	falto
3174	8	4	2026-01-26	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3175	8	4	2026-01-27	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3176	8	4	2026-01-28	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3177	8	4	2026-01-29	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3178	8	4	2026-01-30	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3179	14	4	2026-01-26	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3180	14	4	2026-01-27	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3181	14	4	2026-01-28	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3182	14	4	2026-01-29	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3183	14	4	2026-01-30	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3184	228	4	2026-01-26	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3185	228	4	2026-01-27	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3186	228	4	2026-01-28	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3187	228	4	2026-01-29	0	\N	2026-01-30 16:43:12	ADMIN	falto
3188	228	4	2026-01-30	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3189	9	4	2026-01-26	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3190	9	4	2026-01-27	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3191	9	4	2026-01-28	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3192	9	4	2026-01-29	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3193	9	4	2026-01-30	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3194	248	4	2026-01-26	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3195	248	4	2026-01-27	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3196	248	4	2026-01-28	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3197	248	4	2026-01-29	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3198	248	4	2026-01-30	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3199	238	4	2026-01-26	0	\N	2026-01-30 16:43:12	ADMIN	falto
3200	238	4	2026-01-27	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3201	238	4	2026-01-28	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3202	238	4	2026-01-29	1	\N	2026-01-30 16:43:12	ADMIN	asistio
3203	238	4	2026-01-30	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3204	20	4	2026-01-26	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3205	20	4	2026-01-27	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3206	20	4	2026-01-28	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3207	20	4	2026-01-29	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3208	20	4	2026-01-30	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3209	22	4	2026-01-26	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3210	22	4	2026-01-27	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3211	22	4	2026-01-28	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3212	22	4	2026-01-29	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3213	22	4	2026-01-30	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3214	24	4	2026-01-26	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3215	24	4	2026-01-27	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3216	24	4	2026-01-28	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3217	24	4	2026-01-29	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3218	24	4	2026-01-30	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3219	26	4	2026-01-26	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3220	26	4	2026-01-27	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3221	26	4	2026-01-28	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3222	26	4	2026-01-29	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3223	26	4	2026-01-30	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3224	31	4	2026-01-26	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3225	31	4	2026-01-27	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3226	31	4	2026-01-28	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3227	31	4	2026-01-29	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3228	31	4	2026-01-30	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3229	32	4	2026-01-26	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3230	32	4	2026-01-27	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3231	32	4	2026-01-28	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3232	32	4	2026-01-29	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3233	32	4	2026-01-30	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3234	38	4	2026-01-26	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3235	38	4	2026-01-27	0	\N	2026-01-30 16:43:13	ADMIN	falto
3236	38	4	2026-01-28	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3237	38	4	2026-01-29	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3238	38	4	2026-01-30	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3239	40	4	2026-01-26	0	\N	2026-01-30 16:43:13	ADMIN	falto
3240	40	4	2026-01-27	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3241	40	4	2026-01-28	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3242	40	4	2026-01-29	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3243	40	4	2026-01-30	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3244	41	4	2026-01-26	1	\N	2026-01-30 16:43:13	ADMIN	asistio
3245	41	4	2026-01-27	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3246	41	4	2026-01-28	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3247	41	4	2026-01-29	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3248	41	4	2026-01-30	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3249	43	4	2026-01-26	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3250	43	4	2026-01-27	0	\N	2026-01-30 16:43:14	ADMIN	falto
3251	43	4	2026-01-28	0	\N	2026-01-30 16:43:14	ADMIN	falto
3252	43	4	2026-01-29	0	\N	2026-01-30 16:43:14	ADMIN	falto
3253	43	4	2026-01-30	0	\N	2026-01-30 16:43:14	ADMIN	falto
3254	44	4	2026-01-26	0	\N	2026-01-30 16:43:14	ADMIN	justificada
3255	44	4	2026-01-27	0	\N	2026-01-30 16:43:14	ADMIN	justificada
3256	44	4	2026-01-28	0	\N	2026-01-30 16:43:14	ADMIN	justificada
3257	44	4	2026-01-29	0	\N	2026-01-30 16:43:14	ADMIN	justificada
3258	44	4	2026-01-30	0	\N	2026-01-30 16:43:14	ADMIN	justificada
3259	23	4	2026-01-26	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3260	23	4	2026-01-27	0	\N	2026-01-30 16:43:14	ADMIN	falto
3261	23	4	2026-01-28	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3262	23	4	2026-01-29	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3263	23	4	2026-01-30	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3264	45	4	2026-01-26	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3265	45	4	2026-01-27	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3266	45	4	2026-01-28	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3267	45	4	2026-01-29	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3268	45	4	2026-01-30	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3269	25	4	2026-01-26	0	\N	2026-01-30 16:43:14	ADMIN	falto
3270	25	4	2026-01-27	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3271	25	4	2026-01-28	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3272	25	4	2026-01-29	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3273	25	4	2026-01-30	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3274	236	4	2026-01-26	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3275	236	4	2026-01-27	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3276	236	4	2026-01-28	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3277	236	4	2026-01-29	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3278	236	4	2026-01-30	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3279	51	4	2026-01-26	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3280	51	4	2026-01-27	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3281	51	4	2026-01-28	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3282	51	4	2026-01-29	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3283	51	4	2026-01-30	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3284	54	4	2026-01-26	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3285	54	4	2026-01-27	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3286	54	4	2026-01-28	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3287	54	4	2026-01-29	1	\N	2026-01-30 16:43:14	ADMIN	asistio
3288	54	4	2026-01-30	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3289	56	4	2026-01-26	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3290	56	4	2026-01-27	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3291	56	4	2026-01-28	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3292	56	4	2026-01-29	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3293	56	4	2026-01-30	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3294	58	4	2026-01-26	0	\N	2026-01-30 16:43:15	ADMIN	falto
3295	58	4	2026-01-27	0	\N	2026-01-30 16:43:15	ADMIN	falto
3296	58	4	2026-01-28	0	\N	2026-01-30 16:43:15	ADMIN	falto
3297	58	4	2026-01-29	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3298	58	4	2026-01-30	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3299	59	4	2026-01-26	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3300	59	4	2026-01-27	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3301	59	4	2026-01-28	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3302	59	4	2026-01-29	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3303	59	4	2026-01-30	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3304	30	4	2026-01-26	0	\N	2026-01-30 16:43:15	ADMIN	falto
3305	30	4	2026-01-27	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3306	30	4	2026-01-28	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3307	30	4	2026-01-29	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3308	30	4	2026-01-30	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3309	33	4	2026-01-26	0	\N	2026-01-30 16:43:15	ADMIN	falto
3310	33	4	2026-01-27	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3311	33	4	2026-01-28	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3312	33	4	2026-01-29	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3313	33	4	2026-01-30	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3314	29	4	2026-01-26	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3315	29	4	2026-01-27	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3316	29	4	2026-01-28	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3317	29	4	2026-01-29	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3318	29	4	2026-01-30	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3319	34	4	2026-01-26	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3320	34	4	2026-01-27	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3321	34	4	2026-01-28	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3322	34	4	2026-01-29	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3323	34	4	2026-01-30	1	\N	2026-01-30 16:43:15	ADMIN	asistio
3324	93	4	2026-01-26	1	\N	2026-01-30 15:53:59	ADMIN	asistio
3325	93	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3326	93	4	2026-01-30	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3327	94	4	2026-01-26	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3328	94	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3329	94	4	2026-01-30	0	\N	2026-01-30 15:54:00	ADMIN	falto
3330	97	4	2026-01-26	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3331	97	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3332	97	4	2026-01-30	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3333	99	4	2026-01-26	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3334	99	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3335	99	4	2026-01-30	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3336	100	4	2026-01-26	0	\N	2026-01-30 15:54:00	ADMIN	falto
3337	100	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3338	100	4	2026-01-30	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3339	169	4	2026-01-26	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3340	169	4	2026-01-28	0	\N	2026-01-30 15:54:00	ADMIN	falto
3341	169	4	2026-01-30	0	\N	2026-01-30 15:54:00	ADMIN	falto
3342	247	4	2026-01-26	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3343	247	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3344	247	4	2026-01-30	0	\N	2026-01-30 15:54:00	ADMIN	falto
3345	101	4	2026-01-26	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3346	101	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3347	101	4	2026-01-30	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3348	102	4	2026-01-26	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3349	102	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3350	102	4	2026-01-30	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3351	104	4	2026-01-26	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3352	104	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3353	104	4	2026-01-30	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3354	105	4	2026-01-26	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3355	105	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3356	105	4	2026-01-30	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3357	107	4	2026-01-26	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3358	107	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3359	107	4	2026-01-30	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3360	109	4	2026-01-26	0	\N	2026-01-30 15:54:00	ADMIN	falto
3361	109	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3362	109	4	2026-01-30	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3363	110	4	2026-01-26	0	\N	2026-01-30 15:54:00	ADMIN	falto
3364	110	4	2026-01-28	1	\N	2026-01-30 15:54:00	ADMIN	asistio
3365	110	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3366	111	4	2026-01-26	0	\N	2026-01-30 15:54:01	ADMIN	falto
3367	111	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3368	111	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3369	245	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3370	245	4	2026-01-28	0	\N	2026-01-30 15:54:01	ADMIN	falto
3371	245	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3372	112	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3373	112	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3374	112	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3375	114	4	2026-01-26	0	\N	2026-01-30 15:54:01	ADMIN	falto
3376	114	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3377	114	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3378	117	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3379	117	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3380	117	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3381	120	4	2026-01-26	0	\N	2026-01-30 15:54:01	ADMIN	falto
3382	120	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3383	120	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3384	121	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3385	121	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3386	121	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3387	122	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3388	122	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3389	122	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3390	124	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3391	124	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3392	124	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3393	125	4	2026-01-26	0	\N	2026-01-30 15:54:01	ADMIN	falto
3394	125	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3395	125	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3396	165	4	2026-01-26	0	\N	2026-01-30 15:54:01	ADMIN	falto
3397	165	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3398	165	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3399	129	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3400	129	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3401	129	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3402	127	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3403	127	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3404	127	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3405	132	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3406	132	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3407	132	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3408	133	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3409	133	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3410	133	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3411	164	4	2026-01-26	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3412	164	4	2026-01-28	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3413	164	4	2026-01-30	1	\N	2026-01-30 15:54:01	ADMIN	asistio
3414	134	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3415	134	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3416	134	4	2026-01-30	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3417	137	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3418	137	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3419	137	4	2026-01-30	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3420	138	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3421	138	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3422	138	4	2026-01-30	0	\N	2026-01-30 15:54:02	ADMIN	falto
3423	139	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3424	139	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3425	139	4	2026-01-30	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3426	140	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3427	140	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3428	140	4	2026-01-30	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3429	141	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3430	141	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3431	141	4	2026-01-30	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3432	162	4	2026-01-26	0	\N	2026-01-30 15:54:02	ADMIN	falto
3433	162	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3434	162	4	2026-01-30	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3435	246	4	2026-01-26	0	\N	2026-01-30 15:54:02	ADMIN	falto
3436	246	4	2026-01-28	0	\N	2026-01-30 15:54:02	ADMIN	falto
3437	246	4	2026-01-30	0	\N	2026-01-30 15:54:02	ADMIN	falto
3438	142	4	2026-01-26	0	\N	2026-01-30 15:54:02	ADMIN	falto
3439	142	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3440	142	4	2026-01-30	0	\N	2026-01-30 15:54:02	ADMIN	falto
3441	143	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3442	143	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3443	143	4	2026-01-30	0	\N	2026-01-30 15:54:02	ADMIN	falto
3444	145	4	2026-01-26	0	\N	2026-01-30 15:54:02	ADMIN	falto
3445	145	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3446	145	4	2026-01-30	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3447	146	4	2026-01-26	0	\N	2026-01-30 15:54:02	ADMIN	falto
3448	146	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3449	146	4	2026-01-30	0	\N	2026-01-30 15:54:02	ADMIN	falto
3450	157	4	2026-01-26	0	\N	2026-01-30 15:54:02	ADMIN	falto
3451	157	4	2026-01-28	0	\N	2026-01-30 15:54:02	ADMIN	falto
3452	157	4	2026-01-30	0	\N	2026-01-30 15:54:02	ADMIN	falto
3453	147	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3454	147	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3455	147	4	2026-01-30	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3456	148	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3457	148	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3458	148	4	2026-01-30	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3459	265	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3460	265	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3461	265	4	2026-01-30	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3462	158	4	2026-01-26	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3463	158	4	2026-01-28	1	\N	2026-01-30 15:54:02	ADMIN	asistio
3464	158	4	2026-01-30	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3465	150	4	2026-01-26	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3466	150	4	2026-01-28	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3467	150	4	2026-01-30	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3468	152	4	2026-01-26	0	\N	2026-01-30 15:54:03	ADMIN	falto
3469	152	4	2026-01-28	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3470	152	4	2026-01-30	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3471	154	4	2026-01-26	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3472	154	4	2026-01-28	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3473	154	4	2026-01-30	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3474	160	4	2026-01-26	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3475	160	4	2026-01-28	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3476	160	4	2026-01-30	1	\N	2026-01-30 15:54:03	ADMIN	asistio
3477	270	4	2026-01-26	0	\N	2026-01-30 15:54:03	ADMIN	falto
3478	270	4	2026-01-28	0	\N	2026-01-30 15:54:03	ADMIN	falto
3479	270	4	2026-01-30	0	\N	2026-01-30 15:54:03	ADMIN	falto
3480	220	4	2026-01-26	1	\N	2026-01-30 16:40:17	ADMIN	asistio
3481	220	4	2026-01-27	1	\N	2026-01-30 16:40:17	ADMIN	asistio
3482	220	4	2026-01-28	1	\N	2026-01-30 16:40:17	ADMIN	asistio
3483	220	4	2026-01-29	1	\N	2026-01-30 16:40:17	ADMIN	asistio
3484	220	4	2026-01-30	1	\N	2026-01-30 16:40:17	ADMIN	asistio
3485	240	4	2026-01-26	0	\N	2026-01-30 16:40:17	ADMIN	falto
3486	240	4	2026-01-27	0	\N	2026-01-30 16:40:17	ADMIN	falto
3487	240	4	2026-01-28	0	\N	2026-01-30 16:40:17	ADMIN	falto
3488	240	4	2026-01-29	0	\N	2026-01-30 16:40:17	ADMIN	falto
3489	240	4	2026-01-30	1	\N	2026-01-30 16:40:17	ADMIN	asistio
3490	181	4	2026-01-26	1	\N	2026-01-30 16:40:17	ADMIN	asistio
3491	181	4	2026-01-27	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3492	181	4	2026-01-28	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3493	181	4	2026-01-29	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3494	181	4	2026-01-30	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3495	136	4	2026-01-26	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3496	136	4	2026-01-27	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3497	136	4	2026-01-28	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3498	136	4	2026-01-29	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3499	136	4	2026-01-30	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3500	231	4	2026-01-26	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3501	231	4	2026-01-27	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3502	231	4	2026-01-28	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3503	231	4	2026-01-29	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3504	231	4	2026-01-30	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3505	149	4	2026-01-26	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3506	149	4	2026-01-27	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3507	149	4	2026-01-28	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3508	149	4	2026-01-29	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3509	149	4	2026-01-30	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3510	207	4	2026-01-26	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3511	207	4	2026-01-27	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3512	207	4	2026-01-28	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3513	207	4	2026-01-29	0	\N	2026-01-30 16:40:18	ADMIN	falto
3514	207	4	2026-01-30	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3515	151	4	2026-01-26	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3516	151	4	2026-01-27	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3517	151	4	2026-01-28	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3518	151	4	2026-01-29	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3519	151	4	2026-01-30	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3520	195	4	2026-01-26	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3521	195	4	2026-01-27	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3522	195	4	2026-01-28	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3523	195	4	2026-01-29	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3524	195	4	2026-01-30	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3525	200	4	2026-01-26	1	\N	2026-01-30 16:40:18	ADMIN	asistio
3526	200	4	2026-01-27	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3527	200	4	2026-01-28	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3528	200	4	2026-01-29	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3529	200	4	2026-01-30	1	\N	2026-01-30 16:40:19	ADMIN	tardanza
3530	80	4	2026-01-26	0	\N	2026-01-30 16:40:19	ADMIN	falto
3531	80	4	2026-01-27	0	\N	2026-01-30 16:40:19	ADMIN	falto
3532	80	4	2026-01-28	0	\N	2026-01-30 16:40:19	ADMIN	falto
3533	80	4	2026-01-29	0	\N	2026-01-30 16:40:19	ADMIN	falto
3534	80	4	2026-01-30	0	\N	2026-01-30 16:40:19	ADMIN	falto
3535	159	4	2026-01-26	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3536	159	4	2026-01-27	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3537	159	4	2026-01-28	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3538	159	4	2026-01-29	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3539	159	4	2026-01-30	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3540	214	4	2026-01-26	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3541	214	4	2026-01-27	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3542	214	4	2026-01-28	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3543	214	4	2026-01-29	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3544	214	4	2026-01-30	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3545	221	4	2026-01-26	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3546	221	4	2026-01-27	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3547	221	4	2026-01-28	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3548	221	4	2026-01-29	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3549	221	4	2026-01-30	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3550	161	4	2026-01-26	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3551	161	4	2026-01-27	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3552	161	4	2026-01-28	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3553	161	4	2026-01-29	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3554	161	4	2026-01-30	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3555	163	4	2026-01-26	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3556	163	4	2026-01-27	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3557	163	4	2026-01-28	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3558	163	4	2026-01-29	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3559	163	4	2026-01-30	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3560	166	4	2026-01-26	1	\N	2026-01-30 16:40:19	ADMIN	asistio
3561	166	4	2026-01-27	0	\N	2026-01-30 16:40:20	ADMIN	falto
3562	166	4	2026-01-28	0	\N	2026-01-30 16:40:20	ADMIN	falto
3563	166	4	2026-01-29	0	\N	2026-01-30 16:40:20	ADMIN	falto
3564	166	4	2026-01-30	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3565	167	4	2026-01-26	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3566	167	4	2026-01-27	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3567	167	4	2026-01-28	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3568	167	4	2026-01-29	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3569	167	4	2026-01-30	0	\N	2026-01-30 16:40:20	ADMIN	falto
3570	170	4	2026-01-26	0	\N	2026-01-30 16:40:20	ADMIN	falto
3571	170	4	2026-01-27	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3572	170	4	2026-01-28	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3573	170	4	2026-01-29	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3574	170	4	2026-01-30	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3575	198	4	2026-01-26	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3576	198	4	2026-01-27	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3577	198	4	2026-01-28	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3578	198	4	2026-01-29	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3579	198	4	2026-01-30	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3580	204	4	2026-01-26	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3581	204	4	2026-01-27	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3582	204	4	2026-01-28	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3583	204	4	2026-01-29	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3584	204	4	2026-01-30	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3585	249	4	2026-01-26	0	\N	2026-01-30 16:40:20	ADMIN	falto
3586	249	4	2026-01-27	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3587	249	4	2026-01-28	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3588	249	4	2026-01-29	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3589	249	4	2026-01-30	0	\N	2026-01-30 16:40:20	ADMIN	falto
3590	223	4	2026-01-26	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3591	223	4	2026-01-27	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3592	223	4	2026-01-28	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3593	223	4	2026-01-29	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3594	223	4	2026-01-30	1	\N	2026-01-30 16:40:20	ADMIN	asistio
3595	174	4	2026-01-26	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3596	174	4	2026-01-27	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3597	174	4	2026-01-28	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3598	174	4	2026-01-29	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3599	174	4	2026-01-30	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3600	175	4	2026-01-26	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3601	175	4	2026-01-27	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3602	175	4	2026-01-28	0	\N	2026-01-30 16:40:21	ADMIN	justificada
3603	175	4	2026-01-29	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3604	175	4	2026-01-30	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3605	179	4	2026-01-26	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3606	179	4	2026-01-27	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3607	179	4	2026-01-28	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3608	179	4	2026-01-29	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3609	179	4	2026-01-30	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3610	182	4	2026-01-26	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3611	182	4	2026-01-27	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3612	182	4	2026-01-28	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3613	182	4	2026-01-29	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3614	182	4	2026-01-30	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3615	224	4	2026-01-26	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3616	224	4	2026-01-27	0	\N	2026-01-30 16:40:21	ADMIN	falto
3617	224	4	2026-01-28	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3618	224	4	2026-01-29	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3619	224	4	2026-01-30	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3620	183	4	2026-01-26	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3621	183	4	2026-01-27	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3622	183	4	2026-01-28	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3623	183	4	2026-01-29	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3624	183	4	2026-01-30	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3625	185	4	2026-01-26	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3626	185	4	2026-01-27	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3627	185	4	2026-01-28	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3628	185	4	2026-01-29	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3629	185	4	2026-01-30	1	\N	2026-01-30 16:40:21	ADMIN	asistio
3630	186	4	2026-01-26	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3631	186	4	2026-01-27	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3632	186	4	2026-01-28	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3633	186	4	2026-01-29	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3634	186	4	2026-01-30	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3635	215	4	2026-01-26	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3636	215	4	2026-01-27	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3637	215	4	2026-01-28	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3638	215	4	2026-01-29	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3639	215	4	2026-01-30	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3640	211	4	2026-01-26	0	\N	2026-01-30 16:40:22	ADMIN	falto
3641	211	4	2026-01-27	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3642	211	4	2026-01-28	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3643	211	4	2026-01-29	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3644	211	4	2026-01-30	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3645	190	4	2026-01-26	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3646	190	4	2026-01-27	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3647	190	4	2026-01-28	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3648	190	4	2026-01-29	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3649	190	4	2026-01-30	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3650	205	4	2026-01-26	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3651	205	4	2026-01-27	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3652	205	4	2026-01-28	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3653	205	4	2026-01-29	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3654	205	4	2026-01-30	0	\N	2026-01-30 16:40:22	ADMIN	falto
3655	191	4	2026-01-26	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3656	191	4	2026-01-27	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3657	191	4	2026-01-28	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3658	191	4	2026-01-29	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3659	191	4	2026-01-30	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3660	178	4	2026-01-26	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3661	178	4	2026-01-27	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3662	178	4	2026-01-28	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3663	178	4	2026-01-29	1	\N	2026-01-30 16:40:22	ADMIN	asistio
3664	178	4	2026-01-30	0	\N	2026-01-30 16:40:22	ADMIN	falto
3665	194	4	2026-01-26	0	\N	2026-01-30 16:40:23	ADMIN	falto
3666	194	4	2026-01-27	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3667	194	4	2026-01-28	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3668	194	4	2026-01-29	0	\N	2026-01-30 16:40:23	ADMIN	falto
3669	194	4	2026-01-30	0	\N	2026-01-30 16:40:23	ADMIN	falto
3670	206	4	2026-01-26	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3671	206	4	2026-01-27	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3672	206	4	2026-01-28	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3673	206	4	2026-01-29	0	\N	2026-01-30 16:40:23	ADMIN	falto
3674	206	4	2026-01-30	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3675	176	4	2026-01-26	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3676	176	4	2026-01-27	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3677	176	4	2026-01-28	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3678	176	4	2026-01-29	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3679	176	4	2026-01-30	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3680	201	4	2026-01-26	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3681	201	4	2026-01-27	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3682	201	4	2026-01-28	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3683	201	4	2026-01-29	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3684	201	4	2026-01-30	1	\N	2026-01-30 16:40:23	ADMIN	asistio
3685	209	4	2026-01-26	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3686	209	4	2026-01-27	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3687	209	4	2026-01-28	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3688	209	4	2026-01-29	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3689	209	4	2026-01-30	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3690	184	4	2026-01-26	0	\N	2026-01-30 16:45:34	ADMIN	falto
3691	184	4	2026-01-27	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3692	184	4	2026-01-28	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3693	184	4	2026-01-29	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3694	184	4	2026-01-30	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3695	222	4	2026-01-26	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3696	222	4	2026-01-27	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3697	222	4	2026-01-28	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3698	222	4	2026-01-29	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3699	222	4	2026-01-30	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3700	250	4	2026-01-26	0	\N	2026-01-30 16:45:34	ADMIN	falto
3701	250	4	2026-01-27	0	\N	2026-01-30 16:45:34	ADMIN	falto
3702	250	4	2026-01-28	0	\N	2026-01-30 16:45:34	ADMIN	falto
3703	250	4	2026-01-29	0	\N	2026-01-30 16:45:34	ADMIN	falto
3704	250	4	2026-01-30	0	\N	2026-01-30 16:45:34	ADMIN	falto
3705	135	4	2026-01-26	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3706	135	4	2026-01-27	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3707	135	4	2026-01-28	0	\N	2026-01-30 16:45:34	ADMIN	falto
3708	135	4	2026-01-29	0	\N	2026-01-30 16:45:34	ADMIN	falto
3709	135	4	2026-01-30	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3710	208	4	2026-01-26	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3711	208	4	2026-01-27	1	\N	2026-01-30 16:45:34	ADMIN	asistio
3712	208	4	2026-01-28	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3713	208	4	2026-01-29	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3714	208	4	2026-01-30	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3715	193	4	2026-01-26	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3716	193	4	2026-01-27	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3717	193	4	2026-01-28	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3718	193	4	2026-01-29	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3719	193	4	2026-01-30	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3720	219	4	2026-01-26	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3721	219	4	2026-01-27	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3722	219	4	2026-01-28	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3723	219	4	2026-01-29	0	\N	2026-01-30 16:45:35	ADMIN	falto
3724	219	4	2026-01-30	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3725	153	4	2026-01-26	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3726	153	4	2026-01-27	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3727	153	4	2026-01-28	0	\N	2026-01-30 16:45:35	ADMIN	falto
3728	153	4	2026-01-29	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3729	153	4	2026-01-30	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3730	155	4	2026-01-26	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3731	155	4	2026-01-27	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3732	155	4	2026-01-28	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3733	155	4	2026-01-29	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3734	155	4	2026-01-30	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3735	225	4	2026-01-26	0	\N	2026-01-30 16:45:35	ADMIN	falto
3736	225	4	2026-01-27	0	\N	2026-01-30 16:45:35	ADMIN	falto
3737	225	4	2026-01-28	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3738	225	4	2026-01-29	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3739	225	4	2026-01-30	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3740	168	4	2026-01-26	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3741	168	4	2026-01-27	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3742	168	4	2026-01-28	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3743	168	4	2026-01-29	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3744	168	4	2026-01-30	0	\N	2026-01-30 16:45:35	ADMIN	falto
3745	171	4	2026-01-26	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3746	171	4	2026-01-27	0	\N	2026-01-30 16:45:35	ADMIN	falto
3747	171	4	2026-01-28	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3748	171	4	2026-01-29	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3749	171	4	2026-01-30	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3750	172	4	2026-01-26	0	\N	2026-01-30 16:45:35	ADMIN	falto
3751	172	4	2026-01-27	0	\N	2026-01-30 16:45:35	ADMIN	falto
3752	172	4	2026-01-28	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3753	172	4	2026-01-29	1	\N	2026-01-30 16:45:35	ADMIN	asistio
3754	172	4	2026-01-30	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3755	251	4	2026-01-26	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3756	251	4	2026-01-27	0	\N	2026-01-30 16:45:36	ADMIN	falto
3757	251	4	2026-01-28	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3758	251	4	2026-01-29	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3759	251	4	2026-01-30	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3760	218	4	2026-01-26	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3761	218	4	2026-01-27	0	\N	2026-01-30 16:45:36	ADMIN	falto
3762	218	4	2026-01-28	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3763	218	4	2026-01-29	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3764	218	4	2026-01-30	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3765	173	4	2026-01-26	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3766	173	4	2026-01-27	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3767	173	4	2026-01-28	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3768	173	4	2026-01-29	0	\N	2026-01-30 16:45:36	ADMIN	falto
3769	173	4	2026-01-30	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3770	252	4	2026-01-26	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3771	252	4	2026-01-27	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3772	252	4	2026-01-28	0	\N	2026-01-30 16:45:36	ADMIN	falto
3773	252	4	2026-01-29	0	\N	2026-01-30 16:45:36	ADMIN	falto
3774	252	4	2026-01-30	0	\N	2026-01-30 16:45:36	ADMIN	falto
3775	217	4	2026-01-26	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3776	217	4	2026-01-27	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3777	217	4	2026-01-28	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3778	217	4	2026-01-29	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3779	217	4	2026-01-30	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3780	213	4	2026-01-26	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3781	213	4	2026-01-27	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3782	213	4	2026-01-28	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3783	213	4	2026-01-29	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3784	213	4	2026-01-30	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3785	210	4	2026-01-26	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3786	210	4	2026-01-27	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3787	210	4	2026-01-28	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3788	210	4	2026-01-29	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3789	210	4	2026-01-30	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3790	177	4	2026-01-26	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3791	177	4	2026-01-27	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3792	177	4	2026-01-28	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3793	177	4	2026-01-29	0	\N	2026-01-30 16:45:36	ADMIN	falto
3794	177	4	2026-01-30	0	\N	2026-01-30 16:45:36	ADMIN	falto
3795	180	4	2026-01-26	0	\N	2026-01-30 16:45:36	ADMIN	falto
3796	180	4	2026-01-27	1	\N	2026-01-30 16:45:36	ADMIN	asistio
3797	180	4	2026-01-28	0	\N	2026-01-30 16:45:37	ADMIN	falto
3798	180	4	2026-01-29	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3799	180	4	2026-01-30	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3800	202	4	2026-01-26	0	\N	2026-01-30 16:45:37	ADMIN	falto
3801	202	4	2026-01-27	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3802	202	4	2026-01-28	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3803	202	4	2026-01-29	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3804	202	4	2026-01-30	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3805	192	4	2026-01-26	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3806	192	4	2026-01-27	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3807	192	4	2026-01-28	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3808	192	4	2026-01-29	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3809	192	4	2026-01-30	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3810	187	4	2026-01-26	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3811	187	4	2026-01-27	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3812	187	4	2026-01-28	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3813	187	4	2026-01-29	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3814	187	4	2026-01-30	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3815	203	4	2026-01-26	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3816	203	4	2026-01-27	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3817	203	4	2026-01-28	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3818	203	4	2026-01-29	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3819	203	4	2026-01-30	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3820	212	4	2026-01-26	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3821	212	4	2026-01-27	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3822	212	4	2026-01-28	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3823	212	4	2026-01-29	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3824	212	4	2026-01-30	0	\N	2026-01-30 16:45:37	ADMIN	falto
3825	188	4	2026-01-26	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3826	188	4	2026-01-27	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3827	188	4	2026-01-28	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3828	188	4	2026-01-29	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3829	188	4	2026-01-30	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3830	189	4	2026-01-26	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3831	189	4	2026-01-27	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3832	189	4	2026-01-28	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3833	189	4	2026-01-29	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3834	189	4	2026-01-30	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3835	196	4	2026-01-26	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3836	196	4	2026-01-27	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3837	196	4	2026-01-28	1	\N	2026-01-30 16:45:37	ADMIN	asistio
3838	196	4	2026-01-29	0	\N	2026-01-30 16:45:37	ADMIN	falto
3839	196	4	2026-01-30	1	\N	2026-01-30 16:45:38	ADMIN	asistio
3840	199	4	2026-01-26	1	\N	2026-01-30 16:45:38	ADMIN	asistio
3841	199	4	2026-01-27	1	\N	2026-01-30 16:45:38	ADMIN	asistio
3842	199	4	2026-01-28	1	\N	2026-01-30 16:45:38	ADMIN	asistio
3843	199	4	2026-01-29	1	\N	2026-01-30 16:45:38	ADMIN	asistio
3844	199	4	2026-01-30	1	\N	2026-01-30 16:45:38	ADMIN	asistio
3845	197	4	2026-01-26	1	\N	2026-01-30 16:45:38	ADMIN	asistio
3846	197	4	2026-01-27	1	\N	2026-01-30 16:45:38	ADMIN	asistio
3847	197	4	2026-01-28	1	\N	2026-01-30 16:45:38	ADMIN	asistio
3848	197	4	2026-01-29	0	\N	2026-01-30 16:45:38	ADMIN	falto
3849	197	4	2026-01-30	0	\N	2026-01-30 16:45:38	ADMIN	falto
3850	229	4	2026-01-26	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3851	229	4	2026-01-27	0	\N	2026-01-30 16:48:16	ADMIN	falto
3852	229	4	2026-01-28	0	\N	2026-01-30 16:48:16	ADMIN	falto
3853	229	4	2026-01-29	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3854	229	4	2026-01-30	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3855	39	4	2026-01-26	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3856	39	4	2026-01-27	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3857	39	4	2026-01-28	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3858	39	4	2026-01-29	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3859	39	4	2026-01-30	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3860	85	4	2026-01-26	0	\N	2026-01-30 16:48:16	ADMIN	falto
3861	85	4	2026-01-27	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3862	85	4	2026-01-28	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3863	85	4	2026-01-29	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3864	85	4	2026-01-30	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3865	86	4	2026-01-26	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3866	86	4	2026-01-27	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3867	86	4	2026-01-28	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3868	86	4	2026-01-29	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3869	86	4	2026-01-30	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3870	253	4	2026-01-26	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3871	253	4	2026-01-27	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3872	253	4	2026-01-28	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3873	253	4	2026-01-29	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3874	253	4	2026-01-30	1	\N	2026-01-30 16:48:16	ADMIN	asistio
3875	237	4	2026-01-26	0	\N	2026-01-30 16:48:16	ADMIN	falto
3876	237	4	2026-01-27	0	\N	2026-01-30 16:48:16	ADMIN	falto
3877	237	4	2026-01-28	0	\N	2026-01-30 16:48:16	ADMIN	falto
3878	237	4	2026-01-29	0	\N	2026-01-30 16:48:17	ADMIN	falto
3879	237	4	2026-01-30	0	\N	2026-01-30 16:48:17	ADMIN	falto
3880	232	4	2026-01-26	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3881	232	4	2026-01-27	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3882	232	4	2026-01-28	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3883	232	4	2026-01-29	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3884	232	4	2026-01-30	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3885	11	4	2026-01-26	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3886	11	4	2026-01-27	0	\N	2026-01-30 16:48:17	ADMIN	falto
3887	11	4	2026-01-28	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3888	11	4	2026-01-29	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3889	11	4	2026-01-30	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3890	16	4	2026-01-26	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3891	16	4	2026-01-27	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3892	16	4	2026-01-28	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3893	16	4	2026-01-29	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3894	16	4	2026-01-30	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3895	18	4	2026-01-26	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3896	18	4	2026-01-27	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3897	18	4	2026-01-28	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3898	18	4	2026-01-29	0	\N	2026-01-30 16:48:17	ADMIN	falto
3899	18	4	2026-01-30	0	\N	2026-01-30 16:48:17	ADMIN	falto
3900	46	4	2026-01-26	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3901	46	4	2026-01-27	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3902	46	4	2026-01-28	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3903	46	4	2026-01-29	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3904	46	4	2026-01-30	0	\N	2026-01-30 16:48:17	ADMIN	falto
3905	37	4	2026-01-26	0	\N	2026-01-30 16:48:17	ADMIN	falto
3906	37	4	2026-01-27	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3907	37	4	2026-01-28	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3908	37	4	2026-01-29	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3909	37	4	2026-01-30	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3910	48	4	2026-01-26	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3911	48	4	2026-01-27	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3912	48	4	2026-01-28	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3913	48	4	2026-01-29	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3914	48	4	2026-01-30	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3915	15	4	2026-01-26	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3916	15	4	2026-01-27	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3917	15	4	2026-01-28	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3918	15	4	2026-01-29	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3919	15	4	2026-01-30	1	\N	2026-01-30 16:48:17	ADMIN	asistio
3920	17	4	2026-01-26	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3921	17	4	2026-01-27	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3922	17	4	2026-01-28	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3923	17	4	2026-01-29	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3924	17	4	2026-01-30	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3925	50	4	2026-01-26	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3926	50	4	2026-01-27	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3927	50	4	2026-01-28	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3928	50	4	2026-01-29	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3929	50	4	2026-01-30	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3930	28	4	2026-01-26	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3931	28	4	2026-01-27	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3932	28	4	2026-01-28	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3933	28	4	2026-01-29	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3934	28	4	2026-01-30	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3935	35	4	2026-01-26	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3936	35	4	2026-01-27	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3937	35	4	2026-01-28	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3938	35	4	2026-01-29	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3939	35	4	2026-01-30	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3940	19	4	2026-01-26	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3941	19	4	2026-01-27	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3942	19	4	2026-01-28	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3943	19	4	2026-01-29	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3944	19	4	2026-01-30	0	\N	2026-01-30 16:48:18	ADMIN	falto
3945	21	4	2026-01-26	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3946	21	4	2026-01-27	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3947	21	4	2026-01-28	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3948	21	4	2026-01-29	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3949	21	4	2026-01-30	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3950	227	4	2026-01-26	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3951	227	4	2026-01-27	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3952	227	4	2026-01-28	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3953	227	4	2026-01-29	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3954	227	4	2026-01-30	0	\N	2026-01-30 16:48:18	ADMIN	falto
3955	84	4	2026-01-26	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3956	84	4	2026-01-27	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3957	84	4	2026-01-28	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3958	84	4	2026-01-29	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3959	84	4	2026-01-30	0	\N	2026-01-30 16:48:18	ADMIN	justificada
3960	47	4	2026-01-26	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3961	47	4	2026-01-27	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3962	47	4	2026-01-28	1	\N	2026-01-30 16:48:18	ADMIN	asistio
3963	47	4	2026-01-29	0	\N	2026-01-30 16:48:19	ADMIN	falto
3964	47	4	2026-01-30	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3965	226	4	2026-01-26	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3966	226	4	2026-01-27	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3967	226	4	2026-01-28	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3968	226	4	2026-01-29	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3969	226	4	2026-01-30	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3970	49	4	2026-01-26	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3971	49	4	2026-01-27	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3972	49	4	2026-01-28	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3973	49	4	2026-01-29	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3974	49	4	2026-01-30	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3975	254	4	2026-01-26	0	\N	2026-01-30 16:48:19	ADMIN	falto
3976	254	4	2026-01-27	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3977	254	4	2026-01-28	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3978	254	4	2026-01-29	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3979	254	4	2026-01-30	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3980	52	4	2026-01-26	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3981	52	4	2026-01-27	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3982	52	4	2026-01-28	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3983	52	4	2026-01-29	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3984	52	4	2026-01-30	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3985	53	4	2026-01-26	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3986	53	4	2026-01-27	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3987	53	4	2026-01-28	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3988	53	4	2026-01-29	0	\N	2026-01-30 16:48:19	ADMIN	falto
3989	53	4	2026-01-30	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3990	244	4	2026-01-26	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3991	244	4	2026-01-27	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3992	244	4	2026-01-28	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3993	244	4	2026-01-29	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3994	244	4	2026-01-30	0	\N	2026-01-30 16:48:19	ADMIN	falto
3995	42	4	2026-01-26	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3996	42	4	2026-01-27	1	\N	2026-01-30 16:48:19	ADMIN	tardanza
3997	42	4	2026-01-28	1	\N	2026-01-30 16:48:19	ADMIN	tardanza
3998	42	4	2026-01-29	1	\N	2026-01-30 16:48:19	ADMIN	asistio
3999	42	4	2026-01-30	1	\N	2026-01-30 16:48:19	ADMIN	asistio
4000	55	4	2026-01-26	0	\N	2026-01-30 16:48:19	ADMIN	falto
4001	55	4	2026-01-27	1	\N	2026-01-30 16:48:19	ADMIN	asistio
4002	55	4	2026-01-28	1	\N	2026-01-30 16:48:19	ADMIN	asistio
4003	55	4	2026-01-29	1	\N	2026-01-30 16:48:19	ADMIN	asistio
4004	55	4	2026-01-30	1	\N	2026-01-30 16:48:19	ADMIN	asistio
4005	27	4	2026-01-26	1	\N	2026-01-30 16:48:19	ADMIN	asistio
4006	27	4	2026-01-27	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4007	27	4	2026-01-28	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4008	27	4	2026-01-29	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4009	27	4	2026-01-30	0	\N	2026-01-30 16:48:20	ADMIN	falto
4010	57	4	2026-01-26	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4011	57	4	2026-01-27	0	\N	2026-01-30 16:48:20	ADMIN	falto
4012	57	4	2026-01-28	0	\N	2026-01-30 16:48:20	ADMIN	falto
4013	57	4	2026-01-29	0	\N	2026-01-30 16:48:20	ADMIN	falto
4014	57	4	2026-01-30	0	\N	2026-01-30 16:48:20	ADMIN	falto
4015	255	4	2026-01-26	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4016	255	4	2026-01-27	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4017	255	4	2026-01-28	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4018	255	4	2026-01-29	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4019	255	4	2026-01-30	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4020	268	4	2026-01-26	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4021	268	4	2026-01-27	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4022	268	4	2026-01-28	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4023	268	4	2026-01-29	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4024	268	4	2026-01-30	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4025	60	4	2026-01-26	0	\N	2026-01-30 16:48:20	ADMIN	falto
4026	60	4	2026-01-27	0	\N	2026-01-30 16:48:20	ADMIN	falto
4027	60	4	2026-01-28	0	\N	2026-01-30 16:48:20	ADMIN	falto
4028	60	4	2026-01-29	0	\N	2026-01-30 16:48:20	ADMIN	falto
4029	60	4	2026-01-30	0	\N	2026-01-30 16:48:20	ADMIN	falto
4030	230	4	2026-01-26	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4031	230	4	2026-01-27	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4032	230	4	2026-01-28	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4033	230	4	2026-01-29	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4034	230	4	2026-01-30	0	\N	2026-01-30 16:48:20	ADMIN	falto
4035	61	4	2026-01-26	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4036	61	4	2026-01-27	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4037	61	4	2026-01-28	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4038	61	4	2026-01-29	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4039	61	4	2026-01-30	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4040	256	4	2026-01-26	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4041	256	4	2026-01-27	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4042	256	4	2026-01-28	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4043	256	4	2026-01-29	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4044	256	4	2026-01-30	0	\N	2026-01-30 16:48:20	ADMIN	falto
4045	269	4	2026-01-26	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4046	269	4	2026-01-27	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4047	269	4	2026-01-28	1	\N	2026-01-30 16:48:20	ADMIN	asistio
4048	269	4	2026-01-29	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4049	269	4	2026-01-30	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4050	62	4	2026-01-26	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4051	62	4	2026-01-27	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4052	62	4	2026-01-28	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4053	62	4	2026-01-29	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4054	62	4	2026-01-30	0	\N	2026-01-30 16:48:21	ADMIN	falto
4055	36	4	2026-01-26	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4056	36	4	2026-01-27	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4057	36	4	2026-01-28	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4058	36	4	2026-01-29	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4059	36	4	2026-01-30	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4060	267	4	2026-01-26	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4061	267	4	2026-01-27	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4062	267	4	2026-01-28	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4063	267	4	2026-01-29	0	\N	2026-01-30 16:48:21	ADMIN	falto
4064	267	4	2026-01-30	1	\N	2026-01-30 16:48:21	ADMIN	asistio
4065	64	4	2026-01-27	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4066	64	4	2026-01-29	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4067	64	4	2026-01-31	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4068	63	4	2026-01-27	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4069	63	4	2026-01-29	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4070	63	4	2026-01-31	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4071	91	4	2026-01-27	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4072	91	4	2026-01-29	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4073	91	4	2026-01-31	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4074	66	4	2026-01-27	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4075	66	4	2026-01-29	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4076	66	4	2026-01-31	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4077	78	4	2026-01-27	0	\N	2026-01-31 16:50:31	ADMIN	falto
4078	78	4	2026-01-29	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4079	78	4	2026-01-31	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4080	95	4	2026-01-27	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4081	95	4	2026-01-29	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4082	95	4	2026-01-31	0	\N	2026-01-31 16:50:31	ADMIN	falto
4083	241	4	2026-01-27	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4084	241	4	2026-01-29	1	\N	2026-01-31 16:50:31	ADMIN	asistio
4085	241	4	2026-01-31	0	\N	2026-01-31 16:50:32	ADMIN	falto
4086	260	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4087	260	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4088	260	4	2026-01-31	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4089	242	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4090	242	4	2026-01-29	0	\N	2026-01-31 16:50:32	ADMIN	falto
4091	242	4	2026-01-31	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4092	68	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4093	68	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4094	68	4	2026-01-31	0	\N	2026-01-31 16:50:32	ADMIN	falto
4095	69	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4096	69	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4097	69	4	2026-01-31	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4098	262	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4099	262	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4100	262	4	2026-01-31	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4101	271	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4102	271	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4103	271	4	2026-01-31	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4104	79	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4105	79	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4106	79	4	2026-01-31	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4107	130	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4108	130	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4109	130	4	2026-01-31	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4110	70	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4111	70	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4112	70	4	2026-01-31	0	\N	2026-01-31 16:50:32	ADMIN	falto
4113	263	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4114	263	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4115	263	4	2026-01-31	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4116	106	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4117	106	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4118	106	4	2026-01-31	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4119	257	4	2026-01-27	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4120	257	4	2026-01-29	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4121	257	4	2026-01-31	1	\N	2026-01-31 16:50:32	ADMIN	asistio
4122	77	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4123	77	4	2026-01-29	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4124	77	4	2026-01-31	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4125	108	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4126	108	4	2026-01-29	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4127	108	4	2026-01-31	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4128	113	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4129	113	4	2026-01-29	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4130	113	4	2026-01-31	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4131	259	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4132	259	4	2026-01-29	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4133	259	4	2026-01-31	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4134	258	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4135	258	4	2026-01-29	0	\N	2026-01-31 16:50:33	ADMIN	falto
4136	258	4	2026-01-31	0	\N	2026-01-31 16:50:33	ADMIN	falto
4137	261	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4138	261	4	2026-01-29	0	\N	2026-01-31 16:50:33	ADMIN	falto
4139	261	4	2026-01-31	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4140	264	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4141	264	4	2026-01-29	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4142	264	4	2026-01-31	0	\N	2026-01-31 16:50:33	ADMIN	falto
4143	82	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4144	82	4	2026-01-29	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4145	82	4	2026-01-31	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4146	115	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4147	115	4	2026-01-29	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4148	115	4	2026-01-31	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4149	118	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4150	118	4	2026-01-29	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4151	118	4	2026-01-31	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4152	116	4	2026-01-27	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4153	116	4	2026-01-29	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4154	116	4	2026-01-31	1	\N	2026-01-31 16:50:33	ADMIN	asistio
4155	220	5	2026-02-02	1	\N	2026-02-02 17:55:28	ADMIN	asistio
4156	220	5	2026-02-03	0	\N	2026-02-02 17:55:28	ADMIN	falto
4157	220	5	2026-02-04	0	\N	2026-02-02 17:55:28	ADMIN	falto
4158	220	5	2026-02-05	0	\N	2026-02-02 17:55:28	ADMIN	falto
4159	220	5	2026-02-06	0	\N	2026-02-02 17:55:28	ADMIN	falto
4160	240	5	2026-02-02	1	\N	2026-02-02 17:55:28	ADMIN	asistio
4161	240	5	2026-02-03	0	\N	2026-02-02 17:55:29	ADMIN	falto
4162	240	5	2026-02-04	0	\N	2026-02-02 17:55:29	ADMIN	falto
4163	240	5	2026-02-05	0	\N	2026-02-02 17:55:29	ADMIN	falto
4164	240	5	2026-02-06	0	\N	2026-02-02 17:55:29	ADMIN	falto
4165	181	5	2026-02-02	1	\N	2026-02-02 17:50:02	ADMIN	asistio
4166	181	5	2026-02-03	0	\N	2026-02-02 17:50:02	ADMIN	falto
4167	181	5	2026-02-04	0	\N	2026-02-02 17:50:02	ADMIN	falto
4168	181	5	2026-02-05	0	\N	2026-02-02 17:50:02	ADMIN	falto
4169	181	5	2026-02-06	0	\N	2026-02-02 17:50:02	ADMIN	falto
4170	136	5	2026-02-02	1	\N	2026-02-02 17:55:29	ADMIN	asistio
4171	136	5	2026-02-03	0	\N	2026-02-02 17:55:29	ADMIN	falto
4172	136	5	2026-02-04	0	\N	2026-02-02 17:55:29	ADMIN	falto
4173	136	5	2026-02-05	0	\N	2026-02-02 17:55:29	ADMIN	falto
4174	136	5	2026-02-06	0	\N	2026-02-02 17:55:29	ADMIN	falto
4175	231	5	2026-02-02	1	\N	2026-02-02 17:55:29	ADMIN	asistio
4176	231	5	2026-02-03	0	\N	2026-02-02 17:55:29	ADMIN	falto
4177	231	5	2026-02-04	0	\N	2026-02-02 17:55:29	ADMIN	falto
4178	231	5	2026-02-05	0	\N	2026-02-02 17:55:29	ADMIN	falto
4179	231	5	2026-02-06	0	\N	2026-02-02 17:55:29	ADMIN	falto
4180	149	5	2026-02-02	1	\N	2026-02-02 17:55:29	ADMIN	asistio
4181	149	5	2026-02-03	0	\N	2026-02-02 17:55:29	ADMIN	falto
4182	149	5	2026-02-04	0	\N	2026-02-02 17:55:29	ADMIN	falto
4183	149	5	2026-02-05	0	\N	2026-02-02 17:55:29	ADMIN	falto
4184	149	5	2026-02-06	0	\N	2026-02-02 17:55:29	ADMIN	falto
4185	207	5	2026-02-02	0	\N	2026-02-02 17:55:29	ADMIN	falto
4186	207	5	2026-02-03	0	\N	2026-02-02 17:55:29	ADMIN	falto
4187	207	5	2026-02-04	0	\N	2026-02-02 17:55:29	ADMIN	falto
4188	207	5	2026-02-05	0	\N	2026-02-02 17:55:29	ADMIN	falto
4189	207	5	2026-02-06	0	\N	2026-02-02 17:55:29	ADMIN	falto
4190	151	5	2026-02-02	1	\N	2026-02-02 17:55:29	ADMIN	asistio
4191	151	5	2026-02-03	0	\N	2026-02-02 17:55:29	ADMIN	falto
4192	151	5	2026-02-04	0	\N	2026-02-02 17:55:29	ADMIN	falto
4193	151	5	2026-02-05	0	\N	2026-02-02 17:55:29	ADMIN	falto
4194	151	5	2026-02-06	0	\N	2026-02-02 17:55:29	ADMIN	falto
4195	195	5	2026-02-02	1	\N	2026-02-02 17:55:29	ADMIN	asistio
4196	195	5	2026-02-03	0	\N	2026-02-02 17:55:29	ADMIN	falto
4197	195	5	2026-02-04	0	\N	2026-02-02 17:55:30	ADMIN	falto
4198	195	5	2026-02-05	0	\N	2026-02-02 17:55:30	ADMIN	falto
4199	195	5	2026-02-06	0	\N	2026-02-02 17:55:30	ADMIN	falto
4200	200	5	2026-02-02	0	\N	2026-02-02 17:55:30	ADMIN	falto
4201	200	5	2026-02-03	0	\N	2026-02-02 17:55:30	ADMIN	falto
4202	200	5	2026-02-04	0	\N	2026-02-02 17:55:30	ADMIN	falto
4203	200	5	2026-02-05	0	\N	2026-02-02 17:55:30	ADMIN	falto
4204	200	5	2026-02-06	0	\N	2026-02-02 17:55:30	ADMIN	falto
4205	80	5	2026-02-02	0	\N	2026-01-28 13:20:38	ADMIN	falto
4206	80	5	2026-02-03	0	\N	2026-01-28 13:20:38	ADMIN	falto
4207	80	5	2026-02-04	0	\N	2026-01-28 13:20:38	ADMIN	falto
4208	80	5	2026-02-05	0	\N	2026-01-28 13:20:38	ADMIN	falto
4209	80	5	2026-02-06	0	\N	2026-01-28 13:20:38	ADMIN	falto
4210	159	5	2026-02-02	1	\N	2026-02-02 17:55:30	ADMIN	asistio
4211	159	5	2026-02-03	0	\N	2026-02-02 17:55:30	ADMIN	falto
4212	159	5	2026-02-04	0	\N	2026-02-02 17:55:30	ADMIN	falto
4213	159	5	2026-02-05	0	\N	2026-02-02 17:55:30	ADMIN	falto
4214	159	5	2026-02-06	0	\N	2026-02-02 17:55:30	ADMIN	falto
4215	214	5	2026-02-02	1	\N	2026-02-02 17:55:30	ADMIN	asistio
4216	214	5	2026-02-03	0	\N	2026-02-02 17:55:30	ADMIN	falto
4217	214	5	2026-02-04	0	\N	2026-02-02 17:55:30	ADMIN	falto
4218	214	5	2026-02-05	0	\N	2026-02-02 17:55:30	ADMIN	falto
4219	214	5	2026-02-06	0	\N	2026-02-02 17:55:30	ADMIN	falto
4220	221	5	2026-02-02	1	\N	2026-02-02 17:50:02	ADMIN	asistio
4221	221	5	2026-02-03	0	\N	2026-02-02 17:50:02	ADMIN	falto
4222	221	5	2026-02-04	0	\N	2026-02-02 17:50:02	ADMIN	falto
4223	221	5	2026-02-05	0	\N	2026-02-02 17:50:02	ADMIN	falto
4224	221	5	2026-02-06	0	\N	2026-02-02 17:50:02	ADMIN	falto
4225	161	5	2026-02-02	1	\N	2026-02-02 17:55:30	ADMIN	asistio
4226	161	5	2026-02-03	0	\N	2026-02-02 17:55:30	ADMIN	falto
4227	161	5	2026-02-04	0	\N	2026-02-02 17:55:30	ADMIN	falto
4228	161	5	2026-02-05	0	\N	2026-02-02 17:55:30	ADMIN	falto
4229	161	5	2026-02-06	0	\N	2026-02-02 17:55:30	ADMIN	falto
4230	163	5	2026-02-02	1	\N	2026-02-02 17:50:02	ADMIN	asistio
4231	163	5	2026-02-03	0	\N	2026-02-02 17:50:02	ADMIN	falto
4232	163	5	2026-02-04	0	\N	2026-02-02 17:50:02	ADMIN	falto
4233	163	5	2026-02-05	0	\N	2026-02-02 17:50:02	ADMIN	falto
4234	163	5	2026-02-06	0	\N	2026-02-02 17:50:02	ADMIN	falto
4235	166	5	2026-02-02	0	\N	2026-02-02 17:50:03	ADMIN	falto
4236	166	5	2026-02-03	0	\N	2026-02-02 17:50:03	ADMIN	falto
4237	166	5	2026-02-04	0	\N	2026-02-02 17:50:03	ADMIN	falto
4238	166	5	2026-02-05	0	\N	2026-02-02 17:50:03	ADMIN	falto
4239	166	5	2026-02-06	0	\N	2026-02-02 17:50:03	ADMIN	falto
4240	167	5	2026-02-02	1	\N	2026-02-02 17:50:03	ADMIN	asistio
4241	167	5	2026-02-03	0	\N	2026-02-02 17:50:03	ADMIN	falto
4242	167	5	2026-02-04	0	\N	2026-02-02 17:50:03	ADMIN	falto
4243	167	5	2026-02-05	0	\N	2026-02-02 17:50:03	ADMIN	falto
4244	167	5	2026-02-06	0	\N	2026-02-02 17:50:03	ADMIN	falto
4245	170	5	2026-02-02	1	\N	2026-02-02 17:50:03	ADMIN	asistio
4246	170	5	2026-02-03	0	\N	2026-02-02 17:50:03	ADMIN	falto
4247	170	5	2026-02-04	0	\N	2026-02-02 17:50:03	ADMIN	falto
4248	170	5	2026-02-05	0	\N	2026-02-02 17:50:03	ADMIN	falto
4249	170	5	2026-02-06	0	\N	2026-02-02 17:50:03	ADMIN	falto
4250	198	5	2026-02-02	1	\N	2026-02-02 17:55:31	ADMIN	asistio
4251	198	5	2026-02-03	0	\N	2026-02-02 17:55:31	ADMIN	falto
4252	198	5	2026-02-04	0	\N	2026-02-02 17:55:31	ADMIN	falto
4253	198	5	2026-02-05	0	\N	2026-02-02 17:55:31	ADMIN	falto
4254	198	5	2026-02-06	0	\N	2026-02-02 17:55:31	ADMIN	falto
4255	204	5	2026-02-02	1	\N	2026-02-02 17:55:31	ADMIN	asistio
4256	204	5	2026-02-03	0	\N	2026-02-02 17:55:31	ADMIN	falto
4257	204	5	2026-02-04	0	\N	2026-02-02 17:55:31	ADMIN	falto
4258	204	5	2026-02-05	0	\N	2026-02-02 17:55:31	ADMIN	falto
4259	204	5	2026-02-06	0	\N	2026-02-02 17:55:31	ADMIN	falto
4260	249	5	2026-02-02	1	\N	2026-02-02 17:50:03	ADMIN	asistio
4261	249	5	2026-02-03	0	\N	2026-02-02 17:50:03	ADMIN	falto
4262	249	5	2026-02-04	0	\N	2026-02-02 17:50:03	ADMIN	falto
4263	249	5	2026-02-05	0	\N	2026-02-02 17:50:03	ADMIN	falto
4264	249	5	2026-02-06	0	\N	2026-02-02 17:50:03	ADMIN	falto
4265	223	5	2026-02-02	1	\N	2026-02-02 17:50:04	ADMIN	asistio
4266	223	5	2026-02-03	0	\N	2026-02-02 17:50:04	ADMIN	falto
4267	223	5	2026-02-04	0	\N	2026-02-02 17:50:04	ADMIN	falto
4268	223	5	2026-02-05	0	\N	2026-02-02 17:50:04	ADMIN	falto
4269	223	5	2026-02-06	0	\N	2026-02-02 17:50:04	ADMIN	falto
4270	174	5	2026-02-02	1	\N	2026-02-02 17:50:04	ADMIN	asistio
4271	174	5	2026-02-03	0	\N	2026-02-02 17:50:04	ADMIN	falto
4272	174	5	2026-02-04	0	\N	2026-02-02 17:50:04	ADMIN	falto
4273	174	5	2026-02-05	0	\N	2026-02-02 17:50:04	ADMIN	falto
4274	174	5	2026-02-06	0	\N	2026-02-02 17:50:04	ADMIN	falto
4275	175	5	2026-02-02	1	\N	2026-02-02 17:50:04	ADMIN	asistio
4276	175	5	2026-02-03	0	\N	2026-02-02 17:50:04	ADMIN	justificada
4277	175	5	2026-02-04	0	\N	2026-02-02 17:50:04	ADMIN	justificada
4278	175	5	2026-02-05	0	\N	2026-02-02 17:50:04	ADMIN	justificada
4279	175	5	2026-02-06	0	\N	2026-02-02 17:50:04	ADMIN	justificada
4280	179	5	2026-02-02	1	\N	2026-02-02 17:50:04	ADMIN	asistio
4281	179	5	2026-02-03	0	\N	2026-02-02 17:50:04	ADMIN	falto
4282	179	5	2026-02-04	0	\N	2026-02-02 17:50:04	ADMIN	falto
4283	179	5	2026-02-05	0	\N	2026-02-02 17:50:04	ADMIN	falto
4284	179	5	2026-02-06	0	\N	2026-02-02 17:50:04	ADMIN	falto
4285	182	5	2026-02-02	1	\N	2026-02-02 17:50:04	ADMIN	asistio
4286	182	5	2026-02-03	0	\N	2026-02-02 17:50:04	ADMIN	falto
4287	182	5	2026-02-04	0	\N	2026-02-02 17:50:04	ADMIN	falto
4288	182	5	2026-02-05	0	\N	2026-02-02 17:50:04	ADMIN	falto
4289	182	5	2026-02-06	0	\N	2026-02-02 17:50:04	ADMIN	falto
4290	224	5	2026-02-02	1	\N	2026-02-02 17:50:04	ADMIN	asistio
4291	224	5	2026-02-03	0	\N	2026-02-02 17:50:04	ADMIN	falto
4292	224	5	2026-02-04	0	\N	2026-02-02 17:50:05	ADMIN	falto
4293	224	5	2026-02-05	0	\N	2026-02-02 17:50:05	ADMIN	falto
4294	224	5	2026-02-06	0	\N	2026-02-02 17:50:05	ADMIN	falto
4295	183	5	2026-02-02	1	\N	2026-02-02 17:55:31	ADMIN	asistio
4296	183	5	2026-02-03	0	\N	2026-02-02 17:55:31	ADMIN	falto
4297	183	5	2026-02-04	0	\N	2026-02-02 17:55:31	ADMIN	falto
4298	183	5	2026-02-05	0	\N	2026-02-02 17:55:31	ADMIN	falto
4299	183	5	2026-02-06	0	\N	2026-02-02 17:55:31	ADMIN	falto
4300	185	5	2026-02-02	1	\N	2026-02-02 17:55:31	ADMIN	asistio
4301	185	5	2026-02-03	0	\N	2026-02-02 17:55:31	ADMIN	falto
4302	185	5	2026-02-04	0	\N	2026-02-02 17:55:31	ADMIN	falto
4303	185	5	2026-02-05	0	\N	2026-02-02 17:55:31	ADMIN	falto
4304	185	5	2026-02-06	0	\N	2026-02-02 17:55:31	ADMIN	falto
4305	186	5	2026-02-02	1	\N	2026-02-02 17:55:31	ADMIN	asistio
4306	186	5	2026-02-03	0	\N	2026-02-02 17:55:31	ADMIN	falto
4307	186	5	2026-02-04	0	\N	2026-02-02 17:55:32	ADMIN	falto
4308	186	5	2026-02-05	0	\N	2026-02-02 17:55:32	ADMIN	falto
4309	186	5	2026-02-06	0	\N	2026-02-02 17:55:32	ADMIN	falto
4310	215	5	2026-02-02	1	\N	2026-02-02 17:55:32	ADMIN	asistio
4311	215	5	2026-02-03	0	\N	2026-02-02 17:55:32	ADMIN	falto
4312	215	5	2026-02-04	0	\N	2026-02-02 17:55:32	ADMIN	falto
4313	215	5	2026-02-05	0	\N	2026-02-02 17:55:32	ADMIN	falto
4314	215	5	2026-02-06	0	\N	2026-02-02 17:55:32	ADMIN	falto
4315	211	5	2026-02-02	1	\N	2026-02-02 17:50:05	ADMIN	asistio
4316	211	5	2026-02-03	0	\N	2026-02-02 17:50:05	ADMIN	falto
4317	211	5	2026-02-04	0	\N	2026-02-02 17:50:05	ADMIN	falto
4318	211	5	2026-02-05	0	\N	2026-02-02 17:50:05	ADMIN	falto
4319	211	5	2026-02-06	0	\N	2026-02-02 17:50:05	ADMIN	falto
4320	190	5	2026-02-02	0	\N	2026-02-02 17:55:32	ADMIN	falto
4321	190	5	2026-02-03	0	\N	2026-02-02 17:55:32	ADMIN	falto
4322	190	5	2026-02-04	0	\N	2026-02-02 17:55:32	ADMIN	falto
4323	190	5	2026-02-05	0	\N	2026-02-02 17:55:32	ADMIN	falto
4324	190	5	2026-02-06	0	\N	2026-02-02 17:55:32	ADMIN	falto
4325	205	5	2026-02-02	1	\N	2026-02-02 17:50:05	ADMIN	asistio
4326	205	5	2026-02-03	0	\N	2026-02-02 17:50:05	ADMIN	falto
4327	205	5	2026-02-04	0	\N	2026-02-02 17:50:05	ADMIN	falto
4328	205	5	2026-02-05	0	\N	2026-02-02 17:50:05	ADMIN	falto
4329	205	5	2026-02-06	0	\N	2026-02-02 17:50:05	ADMIN	falto
4330	191	5	2026-02-02	0	\N	2026-02-02 17:55:32	ADMIN	falto
4331	191	5	2026-02-03	0	\N	2026-02-02 17:55:32	ADMIN	falto
4332	191	5	2026-02-04	0	\N	2026-02-02 17:55:32	ADMIN	falto
4333	191	5	2026-02-05	0	\N	2026-02-02 17:55:32	ADMIN	falto
4334	191	5	2026-02-06	0	\N	2026-02-02 17:55:32	ADMIN	falto
4335	178	5	2026-02-02	1	\N	2026-02-02 17:55:32	ADMIN	asistio
4336	178	5	2026-02-03	0	\N	2026-02-02 17:55:32	ADMIN	falto
4337	178	5	2026-02-04	0	\N	2026-02-02 17:55:32	ADMIN	falto
4338	178	5	2026-02-05	0	\N	2026-02-02 17:55:32	ADMIN	falto
4339	178	5	2026-02-06	0	\N	2026-02-02 17:55:32	ADMIN	falto
4340	194	5	2026-02-02	1	\N	2026-02-02 17:50:05	ADMIN	asistio
4341	194	5	2026-02-03	0	\N	2026-02-02 17:50:05	ADMIN	falto
4342	194	5	2026-02-04	0	\N	2026-02-02 17:50:05	ADMIN	falto
4343	194	5	2026-02-05	0	\N	2026-02-02 17:50:05	ADMIN	falto
4344	194	5	2026-02-06	0	\N	2026-02-02 17:50:05	ADMIN	falto
4345	206	5	2026-02-02	1	\N	2026-02-02 17:55:32	ADMIN	asistio
4346	206	5	2026-02-03	0	\N	2026-02-02 17:55:32	ADMIN	falto
4347	206	5	2026-02-04	0	\N	2026-02-02 17:55:32	ADMIN	falto
4348	206	5	2026-02-05	0	\N	2026-02-02 17:55:32	ADMIN	falto
4349	206	5	2026-02-06	0	\N	2026-02-02 17:55:32	ADMIN	falto
4350	176	5	2026-02-02	0	\N	2026-02-02 17:55:33	ADMIN	falto
4351	176	5	2026-02-03	0	\N	2026-02-02 17:55:33	ADMIN	falto
4352	176	5	2026-02-04	0	\N	2026-02-02 17:55:33	ADMIN	falto
4353	176	5	2026-02-05	0	\N	2026-02-02 17:55:33	ADMIN	falto
4354	176	5	2026-02-06	0	\N	2026-02-02 17:55:33	ADMIN	falto
4355	201	5	2026-02-02	1	\N	2026-02-02 17:55:33	ADMIN	asistio
4356	201	5	2026-02-03	0	\N	2026-02-02 17:55:33	ADMIN	falto
4357	201	5	2026-02-04	0	\N	2026-02-02 17:55:33	ADMIN	falto
4358	201	5	2026-02-05	0	\N	2026-02-02 17:55:33	ADMIN	falto
4359	201	5	2026-02-06	0	\N	2026-02-02 17:55:33	ADMIN	falto
4360	93	5	2026-02-02	1	\N	2026-02-02 16:16:51	ADMIN	asistio
4361	93	5	2026-02-04	0	\N	2026-02-02 16:16:51	ADMIN	falto
4362	93	5	2026-02-06	0	\N	2026-02-02 16:16:51	ADMIN	falto
4363	94	5	2026-02-02	1	\N	2026-02-02 16:16:51	ADMIN	asistio
4364	94	5	2026-02-04	0	\N	2026-02-02 16:16:51	ADMIN	falto
4365	94	5	2026-02-06	0	\N	2026-02-02 16:16:51	ADMIN	falto
4366	97	5	2026-02-02	1	\N	2026-02-02 16:16:51	ADMIN	asistio
4367	97	5	2026-02-04	0	\N	2026-02-02 16:16:51	ADMIN	falto
4368	97	5	2026-02-06	0	\N	2026-02-02 16:16:51	ADMIN	falto
4369	99	5	2026-02-02	0	\N	2026-02-02 16:16:51	ADMIN	falto
4370	99	5	2026-02-04	0	\N	2026-02-02 16:16:51	ADMIN	falto
4371	99	5	2026-02-06	0	\N	2026-02-02 16:16:51	ADMIN	falto
4372	100	5	2026-02-02	0	\N	2026-02-02 16:16:51	ADMIN	falto
4373	100	5	2026-02-04	0	\N	2026-02-02 16:16:51	ADMIN	falto
4374	100	5	2026-02-06	0	\N	2026-02-02 16:16:51	ADMIN	falto
4375	169	5	2026-02-02	0	\N	2026-02-02 16:16:51	ADMIN	falto
4376	169	5	2026-02-04	0	\N	2026-02-02 16:16:51	ADMIN	falto
4377	169	5	2026-02-06	0	\N	2026-02-02 16:16:51	ADMIN	falto
4378	247	5	2026-02-02	0	\N	2026-02-02 16:16:51	ADMIN	falto
4379	247	5	2026-02-04	0	\N	2026-02-02 16:16:51	ADMIN	falto
4380	247	5	2026-02-06	0	\N	2026-02-02 16:16:51	ADMIN	falto
4381	101	5	2026-02-02	0	\N	2026-02-02 16:16:51	ADMIN	falto
4382	101	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4383	101	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4384	102	5	2026-02-02	0	\N	2026-02-02 16:16:52	ADMIN	falto
4385	102	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4386	102	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4387	104	5	2026-02-02	1	\N	2026-02-02 16:16:52	ADMIN	asistio
4388	104	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4389	104	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4390	105	5	2026-02-02	0	\N	2026-02-02 16:16:52	ADMIN	falto
4391	105	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4392	105	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4393	107	5	2026-02-02	0	\N	2026-02-02 16:16:52	ADMIN	falto
4394	107	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4395	107	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4396	109	5	2026-02-02	1	\N	2026-02-02 16:16:52	ADMIN	asistio
4397	109	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4398	109	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4399	110	5	2026-02-02	0	\N	2026-02-02 16:16:52	ADMIN	falto
4400	110	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4401	110	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4402	111	5	2026-02-02	0	\N	2026-02-02 16:16:52	ADMIN	falto
4403	111	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4404	111	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4405	245	5	2026-02-02	0	\N	2026-02-02 16:16:52	ADMIN	falto
4406	245	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4407	245	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4408	112	5	2026-02-02	0	\N	2026-02-02 16:16:52	ADMIN	falto
4409	112	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4410	112	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4411	114	5	2026-02-02	1	\N	2026-02-02 16:16:52	ADMIN	asistio
4412	114	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4413	114	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4414	117	5	2026-02-02	0	\N	2026-02-02 16:16:52	ADMIN	falto
4415	117	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4416	117	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4417	120	5	2026-02-02	1	\N	2026-02-02 16:16:52	ADMIN	asistio
4418	120	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4419	120	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4420	121	5	2026-02-02	0	\N	2026-02-02 16:16:52	ADMIN	falto
4421	121	5	2026-02-04	0	\N	2026-02-02 16:16:52	ADMIN	falto
4422	121	5	2026-02-06	0	\N	2026-02-02 16:16:52	ADMIN	falto
4423	122	5	2026-02-02	0	\N	2026-02-02 16:16:52	ADMIN	falto
4424	122	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4425	122	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4426	124	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4427	124	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4428	124	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4429	125	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4430	125	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4431	125	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4432	165	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4433	165	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4434	165	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4435	127	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4436	127	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4437	127	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4438	129	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4439	129	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4440	129	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4441	132	5	2026-02-02	1	\N	2026-02-02 16:16:53	ADMIN	asistio
4442	132	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4443	132	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4444	133	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4445	133	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4446	133	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4447	164	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4448	164	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4449	164	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4450	134	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4451	134	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4452	134	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4453	137	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4454	137	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4455	137	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4456	138	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4457	138	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4458	138	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4459	139	5	2026-02-02	0	\N	2026-02-02 16:16:53	ADMIN	falto
4460	139	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4461	139	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4462	140	5	2026-02-02	1	\N	2026-02-02 16:16:53	ADMIN	asistio
4463	140	5	2026-02-04	0	\N	2026-02-02 16:16:53	ADMIN	falto
4464	140	5	2026-02-06	0	\N	2026-02-02 16:16:53	ADMIN	falto
4465	141	5	2026-02-02	1	\N	2026-02-02 16:16:53	ADMIN	asistio
4466	141	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4467	141	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4468	162	5	2026-02-02	0	\N	2026-02-02 16:16:54	ADMIN	falto
4469	162	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4470	162	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4471	246	5	2026-02-02	0	\N	2026-02-02 16:16:54	ADMIN	falto
4472	246	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4473	246	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4474	142	5	2026-02-02	0	\N	2026-02-02 16:16:54	ADMIN	falto
4475	142	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4476	142	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4477	143	5	2026-02-02	1	\N	2026-02-02 16:16:54	ADMIN	asistio
4478	143	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4479	143	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4480	145	5	2026-02-02	1	\N	2026-02-02 16:16:54	ADMIN	asistio
4481	145	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4482	145	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4483	146	5	2026-02-02	1	\N	2026-02-02 16:16:54	ADMIN	asistio
4484	146	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4485	146	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4486	157	5	2026-02-02	0	\N	2026-02-02 16:16:54	ADMIN	falto
4487	157	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4488	157	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4489	147	5	2026-02-02	0	\N	2026-02-02 16:16:54	ADMIN	falto
4490	147	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4491	147	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4492	148	5	2026-02-02	0	\N	2026-02-02 16:16:54	ADMIN	falto
4493	148	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4494	148	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4495	265	5	2026-02-02	1	\N	2026-02-02 16:16:54	ADMIN	asistio
4496	265	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4497	265	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4498	158	5	2026-02-02	1	\N	2026-02-02 16:16:54	ADMIN	asistio
4499	158	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4500	158	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4501	150	5	2026-02-02	0	\N	2026-02-02 16:16:54	ADMIN	falto
4502	150	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4503	150	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4504	152	5	2026-02-02	1	\N	2026-02-02 16:16:54	ADMIN	asistio
4505	152	5	2026-02-04	0	\N	2026-02-02 16:16:54	ADMIN	falto
4506	152	5	2026-02-06	0	\N	2026-02-02 16:16:54	ADMIN	falto
4507	154	5	2026-02-02	0	\N	2026-02-02 16:16:54	ADMIN	falto
4508	154	5	2026-02-04	0	\N	2026-02-02 16:16:55	ADMIN	falto
4509	154	5	2026-02-06	0	\N	2026-02-02 16:16:55	ADMIN	falto
4510	160	5	2026-02-02	0	\N	2026-02-02 16:16:55	ADMIN	falto
4511	160	5	2026-02-04	0	\N	2026-02-02 16:16:55	ADMIN	falto
4512	160	5	2026-02-06	0	\N	2026-02-02 16:16:55	ADMIN	falto
4513	270	5	2026-02-02	1	\N	2026-02-02 16:16:55	ADMIN	asistio
4514	270	5	2026-02-04	0	\N	2026-02-02 16:16:55	ADMIN	falto
4515	270	5	2026-02-06	0	\N	2026-02-02 16:16:55	ADMIN	falto
4516	229	5	2026-02-02	1	\N	2026-02-02 17:46:39	ADMIN	asistio
4517	229	5	2026-02-03	0	\N	2026-02-02 17:46:39	ADMIN	falto
4518	229	5	2026-02-04	0	\N	2026-02-02 17:46:39	ADMIN	falto
4519	229	5	2026-02-05	0	\N	2026-02-02 17:46:39	ADMIN	falto
4520	229	5	2026-02-06	0	\N	2026-02-02 17:46:39	ADMIN	falto
4521	39	5	2026-02-02	0	\N	2026-02-02 17:46:39	ADMIN	falto
4522	39	5	2026-02-03	0	\N	2026-02-02 17:46:39	ADMIN	falto
4523	39	5	2026-02-04	0	\N	2026-02-02 17:46:39	ADMIN	falto
4524	39	5	2026-02-05	0	\N	2026-02-02 17:46:39	ADMIN	falto
4525	39	5	2026-02-06	0	\N	2026-02-02 17:46:39	ADMIN	falto
4526	85	5	2026-02-02	0	\N	2026-02-02 17:46:39	ADMIN	falto
4527	85	5	2026-02-03	0	\N	2026-02-02 17:46:39	ADMIN	falto
4528	85	5	2026-02-04	0	\N	2026-02-02 17:46:39	ADMIN	falto
4529	85	5	2026-02-05	0	\N	2026-02-02 17:46:39	ADMIN	falto
4530	85	5	2026-02-06	0	\N	2026-02-02 17:46:39	ADMIN	falto
4531	88	5	2026-02-02	1	\N	2026-02-02 17:46:39	ADMIN	asistio
4532	88	5	2026-02-03	0	\N	2026-02-02 17:46:39	ADMIN	falto
4533	88	5	2026-02-04	0	\N	2026-02-02 17:46:39	ADMIN	falto
4534	88	5	2026-02-05	0	\N	2026-02-02 17:46:39	ADMIN	falto
4535	88	5	2026-02-06	0	\N	2026-02-02 17:46:39	ADMIN	falto
4536	237	5	2026-02-02	0	\N	2026-02-02 17:46:39	ADMIN	falto
4537	237	5	2026-02-03	0	\N	2026-02-02 17:46:39	ADMIN	falto
4538	237	5	2026-02-04	0	\N	2026-02-02 17:46:39	ADMIN	falto
4539	237	5	2026-02-05	0	\N	2026-02-02 17:46:39	ADMIN	falto
4540	237	5	2026-02-06	0	\N	2026-02-02 17:46:39	ADMIN	falto
4541	232	5	2026-02-02	1	\N	2026-02-02 17:46:39	ADMIN	asistio
4542	232	5	2026-02-03	0	\N	2026-02-02 17:46:39	ADMIN	falto
4543	232	5	2026-02-04	0	\N	2026-02-02 17:46:39	ADMIN	falto
4544	232	5	2026-02-05	0	\N	2026-02-02 17:46:39	ADMIN	falto
4545	232	5	2026-02-06	0	\N	2026-02-02 17:46:39	ADMIN	falto
4546	9	5	2026-02-02	1	\N	2026-02-02 17:46:39	ADMIN	asistio
4547	9	5	2026-02-03	0	\N	2026-02-02 17:46:39	ADMIN	falto
4548	9	5	2026-02-04	0	\N	2026-02-02 17:46:40	ADMIN	falto
4549	9	5	2026-02-05	0	\N	2026-02-02 17:46:40	ADMIN	falto
4550	9	5	2026-02-06	0	\N	2026-02-02 17:46:40	ADMIN	falto
4551	11	5	2026-02-02	1	\N	2026-02-02 17:46:40	ADMIN	asistio
4552	11	5	2026-02-03	0	\N	2026-02-02 17:46:40	ADMIN	falto
4553	11	5	2026-02-04	0	\N	2026-02-02 17:46:40	ADMIN	falto
4554	11	5	2026-02-05	0	\N	2026-02-02 17:46:40	ADMIN	falto
4555	11	5	2026-02-06	0	\N	2026-02-02 17:46:40	ADMIN	falto
4556	16	5	2026-02-02	1	\N	2026-02-02 17:46:40	ADMIN	asistio
4557	16	5	2026-02-03	0	\N	2026-02-02 17:46:40	ADMIN	falto
4558	16	5	2026-02-04	0	\N	2026-02-02 17:46:40	ADMIN	falto
4559	16	5	2026-02-05	0	\N	2026-02-02 17:46:40	ADMIN	falto
4560	16	5	2026-02-06	0	\N	2026-02-02 17:46:40	ADMIN	falto
4561	18	5	2026-02-02	1	\N	2026-02-02 17:46:40	ADMIN	asistio
4562	18	5	2026-02-03	0	\N	2026-02-02 17:46:40	ADMIN	falto
4563	18	5	2026-02-04	0	\N	2026-02-02 17:46:40	ADMIN	falto
4564	18	5	2026-02-05	0	\N	2026-02-02 17:46:40	ADMIN	falto
4565	18	5	2026-02-06	0	\N	2026-02-02 17:46:40	ADMIN	falto
4566	46	5	2026-02-02	1	\N	2026-02-02 17:46:40	ADMIN	asistio
4567	46	5	2026-02-03	0	\N	2026-02-02 17:46:40	ADMIN	falto
4568	46	5	2026-02-04	0	\N	2026-02-02 17:46:40	ADMIN	falto
4569	46	5	2026-02-05	0	\N	2026-02-02 17:46:40	ADMIN	falto
4570	46	5	2026-02-06	0	\N	2026-02-02 17:46:40	ADMIN	falto
4571	20	5	2026-02-02	0	\N	2026-02-02 17:46:40	ADMIN	falto
4572	20	5	2026-02-03	0	\N	2026-02-02 17:46:40	ADMIN	falto
4573	20	5	2026-02-04	0	\N	2026-02-02 17:46:40	ADMIN	falto
4574	20	5	2026-02-05	0	\N	2026-02-02 17:46:40	ADMIN	falto
4575	20	5	2026-02-06	0	\N	2026-02-02 17:46:40	ADMIN	falto
4576	37	5	2026-02-02	1	\N	2026-02-02 17:46:40	ADMIN	asistio
4577	37	5	2026-02-03	0	\N	2026-02-02 17:46:40	ADMIN	falto
4578	37	5	2026-02-04	0	\N	2026-02-02 17:46:40	ADMIN	falto
4579	37	5	2026-02-05	0	\N	2026-02-02 17:46:40	ADMIN	falto
4580	37	5	2026-02-06	0	\N	2026-02-02 17:46:40	ADMIN	falto
4581	48	5	2026-02-02	1	\N	2026-02-02 17:46:40	ADMIN	asistio
4582	48	5	2026-02-03	0	\N	2026-02-02 17:46:40	ADMIN	falto
4583	48	5	2026-02-04	0	\N	2026-02-02 17:46:40	ADMIN	falto
4584	48	5	2026-02-05	0	\N	2026-02-02 17:46:40	ADMIN	falto
4585	48	5	2026-02-06	0	\N	2026-02-02 17:46:40	ADMIN	falto
4586	15	5	2026-02-02	0	\N	2026-02-02 17:46:40	ADMIN	falto
4587	15	5	2026-02-03	0	\N	2026-02-02 17:46:40	ADMIN	falto
4588	15	5	2026-02-04	0	\N	2026-02-02 17:46:41	ADMIN	falto
4589	15	5	2026-02-05	0	\N	2026-02-02 17:46:41	ADMIN	falto
4590	15	5	2026-02-06	0	\N	2026-02-02 17:46:41	ADMIN	falto
4591	35	5	2026-02-02	1	\N	2026-02-02 17:46:41	ADMIN	asistio
4592	35	5	2026-02-03	0	\N	2026-02-02 17:46:41	ADMIN	falto
4593	35	5	2026-02-04	0	\N	2026-02-02 17:46:41	ADMIN	falto
4594	35	5	2026-02-05	0	\N	2026-02-02 17:46:41	ADMIN	falto
4595	35	5	2026-02-06	0	\N	2026-02-02 17:46:41	ADMIN	falto
4596	38	5	2026-02-02	1	\N	2026-02-02 17:46:41	ADMIN	asistio
4597	38	5	2026-02-03	0	\N	2026-02-02 17:46:41	ADMIN	falto
4598	38	5	2026-02-04	0	\N	2026-02-02 17:46:41	ADMIN	falto
4599	38	5	2026-02-05	0	\N	2026-02-02 17:46:41	ADMIN	falto
4600	38	5	2026-02-06	0	\N	2026-02-02 17:46:41	ADMIN	falto
4601	19	5	2026-02-02	1	\N	2026-02-02 17:46:41	ADMIN	asistio
4602	19	5	2026-02-03	0	\N	2026-02-02 17:46:41	ADMIN	falto
4603	19	5	2026-02-04	0	\N	2026-02-02 17:46:41	ADMIN	falto
4604	19	5	2026-02-05	0	\N	2026-02-02 17:46:41	ADMIN	falto
4605	19	5	2026-02-06	0	\N	2026-02-02 17:46:41	ADMIN	falto
4606	21	5	2026-02-02	1	\N	2026-02-02 17:46:41	ADMIN	asistio
4607	21	5	2026-02-03	0	\N	2026-02-02 17:46:41	ADMIN	falto
4608	21	5	2026-02-04	0	\N	2026-02-02 17:46:41	ADMIN	falto
4609	21	5	2026-02-05	0	\N	2026-02-02 17:46:41	ADMIN	falto
4610	21	5	2026-02-06	0	\N	2026-02-02 17:46:41	ADMIN	falto
4611	227	5	2026-02-02	1	\N	2026-02-02 17:46:41	ADMIN	asistio
4612	227	5	2026-02-03	0	\N	2026-02-02 17:46:41	ADMIN	falto
4613	227	5	2026-02-04	0	\N	2026-02-02 17:46:41	ADMIN	falto
4614	227	5	2026-02-05	0	\N	2026-02-02 17:46:41	ADMIN	falto
4615	227	5	2026-02-06	0	\N	2026-02-02 17:46:41	ADMIN	falto
4616	43	5	2026-02-02	1	\N	2026-02-02 17:46:41	ADMIN	asistio
4617	43	5	2026-02-03	0	\N	2026-02-02 17:46:41	ADMIN	falto
4618	43	5	2026-02-04	0	\N	2026-02-02 17:46:41	ADMIN	falto
4619	43	5	2026-02-05	0	\N	2026-02-02 17:46:41	ADMIN	falto
4620	43	5	2026-02-06	0	\N	2026-02-02 17:46:41	ADMIN	falto
4621	44	5	2026-02-02	0	\N	2026-02-02 17:46:41	ADMIN	falto
4622	44	5	2026-02-03	0	\N	2026-02-02 17:46:41	ADMIN	falto
4623	44	5	2026-02-04	0	\N	2026-02-02 17:46:41	ADMIN	falto
4624	44	5	2026-02-05	0	\N	2026-02-02 17:46:41	ADMIN	falto
4625	44	5	2026-02-06	0	\N	2026-02-02 17:46:41	ADMIN	falto
4626	25	5	2026-02-02	0	\N	2026-02-02 17:46:41	ADMIN	falto
4627	25	5	2026-02-03	0	\N	2026-02-02 17:46:41	ADMIN	falto
4628	25	5	2026-02-04	0	\N	2026-02-02 17:46:41	ADMIN	falto
4629	25	5	2026-02-05	0	\N	2026-02-02 17:46:41	ADMIN	falto
4630	25	5	2026-02-06	0	\N	2026-02-02 17:46:42	ADMIN	falto
4631	84	5	2026-02-02	1	\N	2026-02-02 17:46:42	ADMIN	asistio
4632	84	5	2026-02-03	0	\N	2026-02-02 17:46:42	ADMIN	falto
4633	84	5	2026-02-04	0	\N	2026-02-02 17:46:42	ADMIN	falto
4634	84	5	2026-02-05	0	\N	2026-02-02 17:46:42	ADMIN	falto
4635	84	5	2026-02-06	0	\N	2026-02-02 17:46:42	ADMIN	falto
4636	47	5	2026-02-02	0	\N	2026-02-02 17:46:42	ADMIN	falto
4637	47	5	2026-02-03	0	\N	2026-02-02 17:46:42	ADMIN	falto
4638	47	5	2026-02-04	0	\N	2026-02-02 17:46:42	ADMIN	falto
4639	47	5	2026-02-05	0	\N	2026-02-02 17:46:42	ADMIN	falto
4640	47	5	2026-02-06	0	\N	2026-02-02 17:46:42	ADMIN	falto
4641	226	5	2026-02-02	1	\N	2026-02-02 17:46:42	ADMIN	asistio
4642	226	5	2026-02-03	0	\N	2026-02-02 17:46:42	ADMIN	falto
4643	226	5	2026-02-04	0	\N	2026-02-02 17:46:42	ADMIN	falto
4644	226	5	2026-02-05	0	\N	2026-02-02 17:46:42	ADMIN	falto
4645	226	5	2026-02-06	0	\N	2026-02-02 17:46:42	ADMIN	falto
4646	49	5	2026-02-02	1	\N	2026-02-02 17:46:42	ADMIN	asistio
4647	49	5	2026-02-03	0	\N	2026-02-02 17:46:42	ADMIN	falto
4648	49	5	2026-02-04	0	\N	2026-02-02 17:46:42	ADMIN	falto
4649	49	5	2026-02-05	0	\N	2026-02-02 17:46:42	ADMIN	falto
4650	49	5	2026-02-06	0	\N	2026-02-02 17:46:42	ADMIN	falto
4651	52	5	2026-02-02	1	\N	2026-02-02 17:46:42	ADMIN	asistio
4652	52	5	2026-02-03	0	\N	2026-02-02 17:46:42	ADMIN	falto
4653	52	5	2026-02-04	0	\N	2026-02-02 17:46:42	ADMIN	falto
4654	52	5	2026-02-05	0	\N	2026-02-02 17:46:42	ADMIN	falto
4655	52	5	2026-02-06	0	\N	2026-02-02 17:46:42	ADMIN	falto
4656	53	5	2026-02-02	1	\N	2026-02-02 17:46:42	ADMIN	asistio
4657	53	5	2026-02-03	0	\N	2026-02-02 17:46:42	ADMIN	falto
4658	53	5	2026-02-04	0	\N	2026-02-02 17:46:42	ADMIN	falto
4659	53	5	2026-02-05	0	\N	2026-02-02 17:46:42	ADMIN	falto
4660	53	5	2026-02-06	0	\N	2026-02-02 17:46:42	ADMIN	falto
4661	54	5	2026-02-02	1	\N	2026-02-02 17:46:42	ADMIN	asistio
4662	54	5	2026-02-03	0	\N	2026-02-02 17:46:42	ADMIN	falto
4663	54	5	2026-02-04	0	\N	2026-02-02 17:46:42	ADMIN	falto
4664	54	5	2026-02-05	0	\N	2026-02-02 17:46:42	ADMIN	falto
4665	54	5	2026-02-06	0	\N	2026-02-02 17:46:42	ADMIN	falto
4666	244	5	2026-02-02	0	\N	2026-02-02 17:46:42	ADMIN	falto
4667	244	5	2026-02-03	0	\N	2026-02-02 17:46:42	ADMIN	falto
4668	244	5	2026-02-04	0	\N	2026-02-02 17:46:42	ADMIN	falto
4669	244	5	2026-02-05	0	\N	2026-02-02 17:46:42	ADMIN	falto
4670	244	5	2026-02-06	0	\N	2026-02-02 17:46:42	ADMIN	falto
4671	42	5	2026-02-02	1	\N	2026-02-02 17:46:43	ADMIN	asistio
4672	42	5	2026-02-03	0	\N	2026-02-02 17:46:43	ADMIN	falto
4673	42	5	2026-02-04	0	\N	2026-02-02 17:46:43	ADMIN	falto
4674	42	5	2026-02-05	0	\N	2026-02-02 17:46:43	ADMIN	falto
4675	42	5	2026-02-06	0	\N	2026-02-02 17:46:43	ADMIN	falto
4676	27	5	2026-02-02	0	\N	2026-02-02 17:46:43	ADMIN	falto
4677	27	5	2026-02-03	0	\N	2026-02-02 17:46:43	ADMIN	falto
4678	27	5	2026-02-04	0	\N	2026-02-02 17:46:43	ADMIN	falto
4679	27	5	2026-02-05	0	\N	2026-02-02 17:46:43	ADMIN	falto
4680	27	5	2026-02-06	0	\N	2026-02-02 17:46:43	ADMIN	falto
4681	57	5	2026-02-02	0	\N	2026-02-02 17:46:43	ADMIN	falto
4682	57	5	2026-02-03	0	\N	2026-02-02 17:46:43	ADMIN	falto
4683	57	5	2026-02-04	0	\N	2026-02-02 17:46:43	ADMIN	falto
4684	57	5	2026-02-05	0	\N	2026-02-02 17:46:43	ADMIN	falto
4685	57	5	2026-02-06	0	\N	2026-02-02 17:46:43	ADMIN	falto
4686	59	5	2026-02-02	1	\N	2026-02-02 17:46:43	ADMIN	asistio
4687	59	5	2026-02-03	0	\N	2026-02-02 17:46:43	ADMIN	falto
4688	59	5	2026-02-04	0	\N	2026-02-02 17:46:43	ADMIN	falto
4689	59	5	2026-02-05	0	\N	2026-02-02 17:46:43	ADMIN	falto
4690	59	5	2026-02-06	0	\N	2026-02-02 17:46:43	ADMIN	falto
4691	255	5	2026-02-02	1	\N	2026-02-02 17:46:43	ADMIN	asistio
4692	255	5	2026-02-03	0	\N	2026-02-02 17:46:43	ADMIN	falto
4693	255	5	2026-02-04	0	\N	2026-02-02 17:46:43	ADMIN	falto
4694	255	5	2026-02-05	0	\N	2026-02-02 17:46:43	ADMIN	falto
4695	255	5	2026-02-06	0	\N	2026-02-02 17:46:43	ADMIN	falto
4696	268	5	2026-02-02	0	\N	2026-02-02 17:46:43	ADMIN	falto
4697	268	5	2026-02-03	0	\N	2026-02-02 17:46:43	ADMIN	falto
4698	268	5	2026-02-04	0	\N	2026-02-02 17:46:43	ADMIN	falto
4699	268	5	2026-02-05	0	\N	2026-02-02 17:46:43	ADMIN	falto
4700	268	5	2026-02-06	0	\N	2026-02-02 17:46:43	ADMIN	falto
4701	60	5	2026-02-02	1	\N	2026-02-02 17:46:43	ADMIN	asistio
4702	60	5	2026-02-03	0	\N	2026-02-02 17:46:43	ADMIN	falto
4703	60	5	2026-02-04	0	\N	2026-02-02 17:46:43	ADMIN	falto
4704	60	5	2026-02-05	0	\N	2026-02-02 17:46:43	ADMIN	falto
4705	60	5	2026-02-06	0	\N	2026-02-02 17:46:43	ADMIN	falto
4706	230	5	2026-02-02	1	\N	2026-02-02 17:46:43	ADMIN	asistio
4707	230	5	2026-02-03	0	\N	2026-02-02 17:46:43	ADMIN	falto
4708	230	5	2026-02-04	0	\N	2026-02-02 17:46:43	ADMIN	falto
4709	230	5	2026-02-05	0	\N	2026-02-02 17:46:43	ADMIN	falto
4710	230	5	2026-02-06	0	\N	2026-02-02 17:46:43	ADMIN	falto
4711	256	5	2026-02-02	0	\N	2026-02-02 17:46:43	ADMIN	falto
4712	256	5	2026-02-03	0	\N	2026-02-02 17:46:43	ADMIN	falto
4713	256	5	2026-02-04	0	\N	2026-02-02 17:46:44	ADMIN	falto
4714	256	5	2026-02-05	0	\N	2026-02-02 17:46:44	ADMIN	falto
4715	256	5	2026-02-06	0	\N	2026-02-02 17:46:44	ADMIN	falto
4716	62	5	2026-02-02	1	\N	2026-02-02 17:46:44	ADMIN	asistio
4717	62	5	2026-02-03	0	\N	2026-02-02 17:46:44	ADMIN	falto
4718	62	5	2026-02-04	0	\N	2026-02-02 17:46:44	ADMIN	falto
4719	62	5	2026-02-05	0	\N	2026-02-02 17:46:44	ADMIN	falto
4720	62	5	2026-02-06	0	\N	2026-02-02 17:46:44	ADMIN	falto
4721	3	5	2026-02-02	1	\N	2026-02-02 17:52:59	ADMIN	asistio
4722	3	5	2026-02-03	0	\N	2026-02-02 17:52:59	ADMIN	falto
4723	3	5	2026-02-04	0	\N	2026-02-02 17:52:59	ADMIN	falto
4724	3	5	2026-02-05	0	\N	2026-02-02 17:53:00	ADMIN	falto
4725	3	5	2026-02-06	0	\N	2026-02-02 17:53:00	ADMIN	falto
4726	87	5	2026-02-02	1	\N	2026-02-02 17:53:00	ADMIN	asistio
4727	87	5	2026-02-03	0	\N	2026-02-02 17:53:00	ADMIN	falto
4728	87	5	2026-02-04	0	\N	2026-02-02 17:53:00	ADMIN	falto
4729	87	5	2026-02-05	0	\N	2026-02-02 17:53:00	ADMIN	falto
4730	87	5	2026-02-06	0	\N	2026-02-02 17:53:00	ADMIN	falto
4731	86	5	2026-02-02	1	\N	2026-02-02 17:53:00	ADMIN	asistio
4732	86	5	2026-02-03	0	\N	2026-02-02 17:53:00	ADMIN	falto
4733	86	5	2026-02-04	0	\N	2026-02-02 17:53:00	ADMIN	falto
4734	86	5	2026-02-05	0	\N	2026-02-02 17:53:00	ADMIN	falto
4735	86	5	2026-02-06	0	\N	2026-02-02 17:53:00	ADMIN	falto
4736	6	5	2026-02-02	1	\N	2026-02-02 17:53:00	ADMIN	asistio
4737	6	5	2026-02-03	0	\N	2026-02-02 17:53:00	ADMIN	falto
4738	6	5	2026-02-04	0	\N	2026-02-02 17:53:00	ADMIN	falto
4739	6	5	2026-02-05	0	\N	2026-02-02 17:53:00	ADMIN	falto
4740	6	5	2026-02-06	0	\N	2026-02-02 17:53:00	ADMIN	falto
4741	4	5	2026-02-02	1	\N	2026-02-02 17:53:00	ADMIN	asistio
4742	4	5	2026-02-03	0	\N	2026-02-02 17:53:00	ADMIN	falto
4743	4	5	2026-02-04	0	\N	2026-02-02 17:53:00	ADMIN	falto
4744	4	5	2026-02-05	0	\N	2026-02-02 17:53:00	ADMIN	falto
4745	4	5	2026-02-06	0	\N	2026-02-02 17:53:00	ADMIN	falto
4746	5	5	2026-02-02	1	\N	2026-02-02 17:53:00	ADMIN	asistio
4747	5	5	2026-02-03	0	\N	2026-02-02 17:53:00	ADMIN	falto
4748	5	5	2026-02-04	0	\N	2026-02-02 17:53:00	ADMIN	falto
4749	5	5	2026-02-05	0	\N	2026-02-02 17:53:00	ADMIN	falto
4750	5	5	2026-02-06	0	\N	2026-02-02 17:53:00	ADMIN	falto
4751	7	5	2026-02-02	1	\N	2026-02-02 17:53:00	ADMIN	asistio
4752	7	5	2026-02-03	0	\N	2026-02-02 17:53:00	ADMIN	falto
4753	7	5	2026-02-04	0	\N	2026-02-02 17:53:00	ADMIN	falto
4754	7	5	2026-02-05	0	\N	2026-02-02 17:53:00	ADMIN	falto
4755	7	5	2026-02-06	0	\N	2026-02-02 17:53:00	ADMIN	falto
4756	253	5	2026-02-02	1	\N	2026-02-02 17:53:00	ADMIN	asistio
4757	253	5	2026-02-03	0	\N	2026-02-02 17:53:00	ADMIN	falto
4758	253	5	2026-02-04	0	\N	2026-02-02 17:53:00	ADMIN	falto
4759	253	5	2026-02-05	0	\N	2026-02-02 17:53:00	ADMIN	falto
4760	253	5	2026-02-06	0	\N	2026-02-02 17:53:00	ADMIN	falto
4761	10	5	2026-02-02	0	\N	2026-02-02 17:53:01	ADMIN	falto
4762	10	5	2026-02-03	0	\N	2026-02-02 17:53:01	ADMIN	falto
4763	10	5	2026-02-04	0	\N	2026-02-02 17:53:01	ADMIN	falto
4764	10	5	2026-02-05	0	\N	2026-02-02 17:53:01	ADMIN	falto
4765	10	5	2026-02-06	0	\N	2026-02-02 17:53:01	ADMIN	falto
4766	235	5	2026-02-02	1	\N	2026-02-02 17:53:01	ADMIN	asistio
4767	235	5	2026-02-03	0	\N	2026-02-02 17:53:01	ADMIN	falto
4768	235	5	2026-02-04	0	\N	2026-02-02 17:53:01	ADMIN	falto
4769	235	5	2026-02-05	0	\N	2026-02-02 17:53:01	ADMIN	falto
4770	235	5	2026-02-06	0	\N	2026-02-02 17:53:01	ADMIN	falto
4771	239	5	2026-02-02	1	\N	2026-02-02 17:53:01	ADMIN	asistio
4772	239	5	2026-02-03	0	\N	2026-02-02 17:53:01	ADMIN	falto
4773	239	5	2026-02-04	0	\N	2026-02-02 17:53:01	ADMIN	falto
4774	239	5	2026-02-05	0	\N	2026-02-02 17:53:01	ADMIN	falto
4775	239	5	2026-02-06	0	\N	2026-02-02 17:53:01	ADMIN	falto
4776	12	5	2026-02-02	0	\N	2026-02-02 17:53:01	ADMIN	falto
4777	12	5	2026-02-03	0	\N	2026-02-02 17:53:01	ADMIN	falto
4778	12	5	2026-02-04	0	\N	2026-02-02 17:53:01	ADMIN	falto
4779	12	5	2026-02-05	0	\N	2026-02-02 17:53:01	ADMIN	falto
4780	12	5	2026-02-06	0	\N	2026-02-02 17:53:01	ADMIN	falto
4781	8	5	2026-02-02	1	\N	2026-02-02 17:53:01	ADMIN	asistio
4782	8	5	2026-02-03	0	\N	2026-02-02 17:53:01	ADMIN	falto
4783	8	5	2026-02-04	0	\N	2026-02-02 17:53:01	ADMIN	falto
4784	8	5	2026-02-05	0	\N	2026-02-02 17:53:01	ADMIN	falto
4785	8	5	2026-02-06	0	\N	2026-02-02 17:53:01	ADMIN	falto
4786	14	5	2026-02-02	1	\N	2026-02-02 17:53:01	ADMIN	asistio
4787	14	5	2026-02-03	0	\N	2026-02-02 17:53:01	ADMIN	falto
4788	14	5	2026-02-04	0	\N	2026-02-02 17:53:01	ADMIN	falto
4789	14	5	2026-02-05	0	\N	2026-02-02 17:53:01	ADMIN	falto
4790	14	5	2026-02-06	0	\N	2026-02-02 17:53:01	ADMIN	falto
4791	228	5	2026-02-02	1	\N	2026-02-02 17:53:01	ADMIN	asistio
4792	228	5	2026-02-03	0	\N	2026-02-02 17:53:01	ADMIN	falto
4793	228	5	2026-02-04	0	\N	2026-02-02 17:53:01	ADMIN	falto
4794	228	5	2026-02-05	0	\N	2026-02-02 17:53:01	ADMIN	falto
4795	228	5	2026-02-06	0	\N	2026-02-02 17:53:01	ADMIN	falto
4796	248	5	2026-02-02	1	\N	2026-02-02 17:53:01	ADMIN	asistio
4797	248	5	2026-02-03	0	\N	2026-02-02 17:53:01	ADMIN	falto
4798	248	5	2026-02-04	0	\N	2026-02-02 17:53:01	ADMIN	falto
4799	248	5	2026-02-05	0	\N	2026-02-02 17:53:01	ADMIN	falto
4800	248	5	2026-02-06	0	\N	2026-02-02 17:53:01	ADMIN	falto
4801	238	5	2026-02-02	0	\N	2026-02-02 17:53:01	ADMIN	falto
4802	238	5	2026-02-03	0	\N	2026-02-02 17:53:01	ADMIN	falto
4803	238	5	2026-02-04	0	\N	2026-02-02 17:53:01	ADMIN	falto
4804	238	5	2026-02-05	0	\N	2026-02-02 17:53:01	ADMIN	falto
4805	238	5	2026-02-06	0	\N	2026-02-02 17:53:01	ADMIN	falto
4806	17	5	2026-02-02	1	\N	2026-02-02 17:53:01	ADMIN	asistio
4807	17	5	2026-02-03	0	\N	2026-02-02 17:53:01	ADMIN	falto
4808	17	5	2026-02-04	0	\N	2026-02-02 17:53:01	ADMIN	falto
4809	17	5	2026-02-05	0	\N	2026-02-02 17:53:02	ADMIN	falto
4810	17	5	2026-02-06	0	\N	2026-02-02 17:53:02	ADMIN	falto
4811	22	5	2026-02-02	1	\N	2026-02-02 17:53:02	ADMIN	asistio
4812	22	5	2026-02-03	0	\N	2026-02-02 17:53:02	ADMIN	falto
4813	22	5	2026-02-04	0	\N	2026-02-02 17:53:02	ADMIN	falto
4814	22	5	2026-02-05	0	\N	2026-02-02 17:53:02	ADMIN	falto
4815	22	5	2026-02-06	0	\N	2026-02-02 17:53:02	ADMIN	falto
4816	50	5	2026-02-02	1	\N	2026-02-02 17:53:02	ADMIN	asistio
4817	50	5	2026-02-03	0	\N	2026-02-02 17:53:02	ADMIN	falto
4818	50	5	2026-02-04	0	\N	2026-02-02 17:53:02	ADMIN	falto
4819	50	5	2026-02-05	0	\N	2026-02-02 17:53:02	ADMIN	falto
4820	50	5	2026-02-06	0	\N	2026-02-02 17:53:02	ADMIN	falto
4821	24	5	2026-02-02	1	\N	2026-02-02 17:53:02	ADMIN	asistio
4822	24	5	2026-02-03	0	\N	2026-02-02 17:53:02	ADMIN	falto
4823	24	5	2026-02-04	0	\N	2026-02-02 17:53:02	ADMIN	falto
4824	24	5	2026-02-05	0	\N	2026-02-02 17:53:02	ADMIN	falto
4825	24	5	2026-02-06	0	\N	2026-02-02 17:53:02	ADMIN	falto
4826	26	5	2026-02-02	1	\N	2026-02-02 17:53:02	ADMIN	asistio
4827	26	5	2026-02-03	0	\N	2026-02-02 17:53:02	ADMIN	falto
4828	26	5	2026-02-04	0	\N	2026-02-02 17:53:02	ADMIN	falto
4829	26	5	2026-02-05	0	\N	2026-02-02 17:53:02	ADMIN	falto
4830	26	5	2026-02-06	0	\N	2026-02-02 17:53:02	ADMIN	falto
4831	28	5	2026-02-02	0	\N	2026-02-02 17:53:02	ADMIN	falto
4832	28	5	2026-02-03	0	\N	2026-02-02 17:53:02	ADMIN	falto
4833	28	5	2026-02-04	0	\N	2026-02-02 17:53:02	ADMIN	falto
4834	28	5	2026-02-05	0	\N	2026-02-02 17:53:02	ADMIN	falto
4835	28	5	2026-02-06	0	\N	2026-02-02 17:53:02	ADMIN	falto
4836	31	5	2026-02-02	1	\N	2026-02-02 17:53:02	ADMIN	asistio
4837	31	5	2026-02-03	0	\N	2026-02-02 17:53:02	ADMIN	falto
4838	31	5	2026-02-04	0	\N	2026-02-02 17:53:02	ADMIN	falto
4839	31	5	2026-02-05	0	\N	2026-02-02 17:53:02	ADMIN	falto
4840	31	5	2026-02-06	0	\N	2026-02-02 17:53:02	ADMIN	falto
4841	32	5	2026-02-02	1	\N	2026-02-02 17:53:02	ADMIN	asistio
4842	32	5	2026-02-03	0	\N	2026-02-02 17:53:02	ADMIN	falto
4843	32	5	2026-02-04	0	\N	2026-02-02 17:53:02	ADMIN	falto
4844	32	5	2026-02-05	0	\N	2026-02-02 17:53:02	ADMIN	falto
4845	32	5	2026-02-06	0	\N	2026-02-02 17:53:02	ADMIN	falto
4846	40	5	2026-02-02	1	\N	2026-02-02 17:53:02	ADMIN	asistio
4847	40	5	2026-02-03	0	\N	2026-02-02 17:53:02	ADMIN	falto
4848	40	5	2026-02-04	0	\N	2026-02-02 17:53:02	ADMIN	falto
4849	40	5	2026-02-05	0	\N	2026-02-02 17:53:02	ADMIN	falto
4850	40	5	2026-02-06	0	\N	2026-02-02 17:53:02	ADMIN	falto
4851	41	5	2026-02-02	1	\N	2026-02-02 17:53:02	ADMIN	asistio
4852	41	5	2026-02-03	0	\N	2026-02-02 17:53:02	ADMIN	falto
4853	41	5	2026-02-04	0	\N	2026-02-02 17:53:02	ADMIN	falto
4854	41	5	2026-02-05	0	\N	2026-02-02 17:53:02	ADMIN	falto
4855	41	5	2026-02-06	0	\N	2026-02-02 17:53:02	ADMIN	falto
4856	23	5	2026-02-02	0	\N	2026-02-02 17:53:02	ADMIN	falto
4857	23	5	2026-02-03	0	\N	2026-02-02 17:53:02	ADMIN	falto
4858	23	5	2026-02-04	0	\N	2026-02-02 17:53:02	ADMIN	falto
4859	23	5	2026-02-05	0	\N	2026-02-02 17:53:03	ADMIN	falto
4860	23	5	2026-02-06	0	\N	2026-02-02 17:53:03	ADMIN	falto
4861	45	5	2026-02-02	1	\N	2026-02-02 17:53:03	ADMIN	asistio
4862	45	5	2026-02-03	0	\N	2026-02-02 17:53:03	ADMIN	falto
4863	45	5	2026-02-04	0	\N	2026-02-02 17:53:03	ADMIN	falto
4864	45	5	2026-02-05	0	\N	2026-02-02 17:53:03	ADMIN	falto
4865	45	5	2026-02-06	0	\N	2026-02-02 17:53:03	ADMIN	falto
4866	236	5	2026-02-02	1	\N	2026-02-02 17:53:03	ADMIN	asistio
4867	236	5	2026-02-03	0	\N	2026-02-02 17:53:03	ADMIN	falto
4868	236	5	2026-02-04	0	\N	2026-02-02 17:53:03	ADMIN	falto
4869	236	5	2026-02-05	0	\N	2026-02-02 17:53:03	ADMIN	falto
4870	236	5	2026-02-06	0	\N	2026-02-02 17:53:03	ADMIN	falto
4871	254	5	2026-02-02	1	\N	2026-02-02 17:53:03	ADMIN	asistio
4872	254	5	2026-02-03	0	\N	2026-02-02 17:53:03	ADMIN	falto
4873	254	5	2026-02-04	0	\N	2026-02-02 17:53:03	ADMIN	falto
4874	254	5	2026-02-05	0	\N	2026-02-02 17:53:03	ADMIN	falto
4875	254	5	2026-02-06	0	\N	2026-02-02 17:53:03	ADMIN	falto
4876	51	5	2026-02-02	0	\N	2026-02-02 17:53:03	ADMIN	falto
4877	51	5	2026-02-03	0	\N	2026-02-02 17:53:03	ADMIN	falto
4878	51	5	2026-02-04	0	\N	2026-02-02 17:53:03	ADMIN	falto
4879	51	5	2026-02-05	0	\N	2026-02-02 17:53:03	ADMIN	falto
4880	51	5	2026-02-06	0	\N	2026-02-02 17:53:03	ADMIN	falto
4881	55	5	2026-02-02	0	\N	2026-02-02 17:53:03	ADMIN	falto
4882	55	5	2026-02-03	0	\N	2026-02-02 17:53:03	ADMIN	falto
4883	55	5	2026-02-04	0	\N	2026-02-02 17:53:03	ADMIN	falto
4884	55	5	2026-02-05	0	\N	2026-02-02 17:53:03	ADMIN	falto
4885	55	5	2026-02-06	0	\N	2026-02-02 17:53:03	ADMIN	falto
4886	56	5	2026-02-02	1	\N	2026-02-02 17:53:03	ADMIN	asistio
4887	56	5	2026-02-03	0	\N	2026-02-02 17:53:03	ADMIN	falto
4888	56	5	2026-02-04	0	\N	2026-02-02 17:53:03	ADMIN	falto
4889	56	5	2026-02-05	0	\N	2026-02-02 17:53:03	ADMIN	falto
4890	56	5	2026-02-06	0	\N	2026-02-02 17:53:03	ADMIN	falto
4891	58	5	2026-02-02	1	\N	2026-02-02 17:53:03	ADMIN	asistio
4892	58	5	2026-02-03	0	\N	2026-02-02 17:53:03	ADMIN	falto
4893	58	5	2026-02-04	0	\N	2026-02-02 17:53:03	ADMIN	falto
4894	58	5	2026-02-05	0	\N	2026-02-02 17:53:03	ADMIN	falto
4895	58	5	2026-02-06	0	\N	2026-02-02 17:53:03	ADMIN	falto
4896	61	5	2026-02-02	1	\N	2026-02-02 17:53:03	ADMIN	asistio
4897	61	5	2026-02-03	0	\N	2026-02-02 17:53:03	ADMIN	falto
4898	61	5	2026-02-04	0	\N	2026-02-02 17:53:03	ADMIN	falto
4899	61	5	2026-02-05	0	\N	2026-02-02 17:53:03	ADMIN	falto
4900	61	5	2026-02-06	0	\N	2026-02-02 17:53:03	ADMIN	falto
4901	269	5	2026-02-02	1	\N	2026-02-02 17:53:03	ADMIN	asistio
4902	269	5	2026-02-03	0	\N	2026-02-02 17:53:03	ADMIN	falto
4903	269	5	2026-02-04	0	\N	2026-02-02 17:53:03	ADMIN	falto
4904	269	5	2026-02-05	0	\N	2026-02-02 17:53:03	ADMIN	falto
4905	269	5	2026-02-06	0	\N	2026-02-02 17:53:03	ADMIN	falto
4906	30	5	2026-02-02	1	\N	2026-02-02 17:53:03	ADMIN	asistio
4907	30	5	2026-02-03	0	\N	2026-02-02 17:53:03	ADMIN	falto
4908	30	5	2026-02-04	0	\N	2026-02-02 17:53:03	ADMIN	falto
4909	30	5	2026-02-05	0	\N	2026-02-02 17:53:04	ADMIN	falto
4910	30	5	2026-02-06	0	\N	2026-02-02 17:53:04	ADMIN	falto
4911	33	5	2026-02-02	1	\N	2026-02-02 17:53:04	ADMIN	asistio
4912	33	5	2026-02-03	0	\N	2026-02-02 17:53:04	ADMIN	falto
4913	33	5	2026-02-04	0	\N	2026-02-02 17:53:04	ADMIN	falto
4914	33	5	2026-02-05	0	\N	2026-02-02 17:53:04	ADMIN	falto
4915	33	5	2026-02-06	0	\N	2026-02-02 17:53:04	ADMIN	falto
4916	29	5	2026-02-02	1	\N	2026-02-02 17:53:04	ADMIN	asistio
4917	29	5	2026-02-03	0	\N	2026-02-02 17:53:04	ADMIN	falto
4918	29	5	2026-02-04	0	\N	2026-02-02 17:53:04	ADMIN	falto
4919	29	5	2026-02-05	0	\N	2026-02-02 17:53:04	ADMIN	falto
4920	29	5	2026-02-06	0	\N	2026-02-02 17:53:04	ADMIN	falto
4921	34	5	2026-02-02	1	\N	2026-02-02 17:53:04	ADMIN	asistio
4922	34	5	2026-02-03	0	\N	2026-02-02 17:53:04	ADMIN	falto
4923	34	5	2026-02-04	0	\N	2026-02-02 17:53:04	ADMIN	falto
4924	34	5	2026-02-05	0	\N	2026-02-02 17:53:04	ADMIN	falto
4925	34	5	2026-02-06	0	\N	2026-02-02 17:53:04	ADMIN	falto
4926	36	5	2026-02-02	1	\N	2026-02-02 17:53:04	ADMIN	asistio
4927	36	5	2026-02-03	0	\N	2026-02-02 17:53:04	ADMIN	falto
4928	36	5	2026-02-04	0	\N	2026-02-02 17:53:04	ADMIN	falto
4929	36	5	2026-02-05	0	\N	2026-02-02 17:53:04	ADMIN	falto
4930	36	5	2026-02-06	0	\N	2026-02-02 17:53:04	ADMIN	falto
4931	267	5	2026-02-02	1	\N	2026-02-02 17:53:04	ADMIN	asistio
4932	267	5	2026-02-03	0	\N	2026-02-02 17:53:04	ADMIN	falto
4933	267	5	2026-02-04	0	\N	2026-02-02 17:53:04	ADMIN	falto
4934	267	5	2026-02-05	0	\N	2026-02-02 17:53:04	ADMIN	falto
4935	267	5	2026-02-06	0	\N	2026-02-02 17:53:04	ADMIN	falto
4936	184	5	2026-02-02	1	\N	2026-02-02 17:50:02	ADMIN	asistio
4937	184	5	2026-02-03	0	\N	2026-02-02 17:50:02	ADMIN	falto
4938	184	5	2026-02-04	0	\N	2026-02-02 17:50:02	ADMIN	falto
4939	184	5	2026-02-05	0	\N	2026-02-02 17:50:02	ADMIN	falto
4940	184	5	2026-02-06	0	\N	2026-02-02 17:50:02	ADMIN	falto
4941	250	5	2026-02-02	0	\N	2026-02-02 17:50:02	ADMIN	falto
4942	250	5	2026-02-03	0	\N	2026-02-02 17:50:02	ADMIN	falto
4943	250	5	2026-02-04	0	\N	2026-02-02 17:50:02	ADMIN	falto
4944	250	5	2026-02-05	0	\N	2026-02-02 17:50:02	ADMIN	falto
4945	250	5	2026-02-06	0	\N	2026-02-02 17:50:02	ADMIN	falto
4946	135	5	2026-02-02	1	\N	2026-02-02 17:50:02	ADMIN	asistio
4947	135	5	2026-02-03	0	\N	2026-02-02 17:50:02	ADMIN	falto
4948	135	5	2026-02-04	0	\N	2026-02-02 17:50:02	ADMIN	falto
4949	135	5	2026-02-05	0	\N	2026-02-02 17:50:02	ADMIN	falto
4950	135	5	2026-02-06	0	\N	2026-02-02 17:50:02	ADMIN	falto
4951	219	5	2026-02-02	1	\N	2026-02-02 17:50:02	ADMIN	asistio
4952	219	5	2026-02-03	0	\N	2026-02-02 17:50:02	ADMIN	falto
4953	219	5	2026-02-04	0	\N	2026-02-02 17:50:02	ADMIN	falto
4954	219	5	2026-02-05	0	\N	2026-02-02 17:50:02	ADMIN	falto
4955	219	5	2026-02-06	0	\N	2026-02-02 17:50:02	ADMIN	falto
4956	225	5	2026-02-02	0	\N	2026-02-02 17:50:02	ADMIN	falto
4957	225	5	2026-02-03	0	\N	2026-02-02 17:50:02	ADMIN	falto
4958	225	5	2026-02-04	0	\N	2026-02-02 17:50:03	ADMIN	falto
4959	225	5	2026-02-05	0	\N	2026-02-02 17:50:03	ADMIN	falto
4960	225	5	2026-02-06	0	\N	2026-02-02 17:50:03	ADMIN	falto
4961	168	5	2026-02-02	0	\N	2026-02-02 17:50:03	ADMIN	falto
4962	168	5	2026-02-03	0	\N	2026-02-02 17:50:03	ADMIN	falto
4963	168	5	2026-02-04	0	\N	2026-02-02 17:50:03	ADMIN	falto
4964	168	5	2026-02-05	0	\N	2026-02-02 17:50:03	ADMIN	falto
4965	168	5	2026-02-06	0	\N	2026-02-02 17:50:03	ADMIN	falto
4966	218	5	2026-02-02	1	\N	2026-02-02 17:50:03	ADMIN	asistio
4967	218	5	2026-02-03	0	\N	2026-02-02 17:50:03	ADMIN	falto
4968	218	5	2026-02-04	0	\N	2026-02-02 17:50:03	ADMIN	falto
4969	218	5	2026-02-05	0	\N	2026-02-02 17:50:03	ADMIN	falto
4970	218	5	2026-02-06	0	\N	2026-02-02 17:50:03	ADMIN	falto
4971	252	5	2026-02-02	0	\N	2026-02-02 17:50:03	ADMIN	falto
4972	252	5	2026-02-03	0	\N	2026-02-02 17:50:03	ADMIN	falto
4973	252	5	2026-02-04	0	\N	2026-02-02 17:50:03	ADMIN	falto
4974	252	5	2026-02-05	0	\N	2026-02-02 17:50:03	ADMIN	falto
4975	252	5	2026-02-06	0	\N	2026-02-02 17:50:03	ADMIN	falto
4976	217	5	2026-02-02	0	\N	2026-02-02 17:50:03	ADMIN	falto
4977	217	5	2026-02-03	0	\N	2026-02-02 17:50:03	ADMIN	falto
4978	217	5	2026-02-04	0	\N	2026-02-02 17:50:03	ADMIN	falto
4979	217	5	2026-02-05	0	\N	2026-02-02 17:50:03	ADMIN	falto
4980	217	5	2026-02-06	0	\N	2026-02-02 17:50:04	ADMIN	falto
4981	213	5	2026-02-02	1	\N	2026-02-02 17:50:04	ADMIN	asistio
4982	213	5	2026-02-03	0	\N	2026-02-02 17:50:04	ADMIN	falto
4983	213	5	2026-02-04	0	\N	2026-02-02 17:50:04	ADMIN	falto
4984	213	5	2026-02-05	0	\N	2026-02-02 17:50:04	ADMIN	falto
4985	213	5	2026-02-06	0	\N	2026-02-02 17:50:04	ADMIN	falto
4986	210	5	2026-02-02	1	\N	2026-02-02 17:50:04	ADMIN	asistio
4987	210	5	2026-02-03	0	\N	2026-02-02 17:50:04	ADMIN	falto
4988	210	5	2026-02-04	0	\N	2026-02-02 17:50:04	ADMIN	falto
4989	210	5	2026-02-05	0	\N	2026-02-02 17:50:04	ADMIN	falto
4990	210	5	2026-02-06	0	\N	2026-02-02 17:50:04	ADMIN	falto
4991	177	5	2026-02-02	0	\N	2026-02-02 17:50:04	ADMIN	falto
4992	177	5	2026-02-03	0	\N	2026-02-02 17:50:04	ADMIN	falto
4993	177	5	2026-02-04	0	\N	2026-02-02 17:50:04	ADMIN	falto
4994	177	5	2026-02-05	0	\N	2026-02-02 17:50:04	ADMIN	falto
4995	177	5	2026-02-06	0	\N	2026-02-02 17:50:04	ADMIN	falto
4996	192	5	2026-02-02	1	\N	2026-02-02 17:50:05	ADMIN	asistio
4997	192	5	2026-02-03	0	\N	2026-02-02 17:50:05	ADMIN	falto
4998	192	5	2026-02-04	0	\N	2026-02-02 17:50:05	ADMIN	falto
4999	192	5	2026-02-05	0	\N	2026-02-02 17:50:05	ADMIN	falto
5000	192	5	2026-02-06	0	\N	2026-02-02 17:50:05	ADMIN	falto
5001	187	5	2026-02-02	1	\N	2026-02-02 17:50:05	ADMIN	asistio
5002	187	5	2026-02-03	0	\N	2026-02-02 17:50:05	ADMIN	falto
5003	187	5	2026-02-04	0	\N	2026-02-02 17:50:05	ADMIN	falto
5004	187	5	2026-02-05	0	\N	2026-02-02 17:50:05	ADMIN	falto
5005	187	5	2026-02-06	0	\N	2026-02-02 17:50:05	ADMIN	falto
5006	212	5	2026-02-02	1	\N	2026-02-02 17:50:05	ADMIN	asistio
5007	212	5	2026-02-03	0	\N	2026-02-02 17:50:05	ADMIN	falto
5008	212	5	2026-02-04	0	\N	2026-02-02 17:50:05	ADMIN	falto
5009	212	5	2026-02-05	0	\N	2026-02-02 17:50:05	ADMIN	falto
5010	212	5	2026-02-06	0	\N	2026-02-02 17:50:05	ADMIN	falto
5011	189	5	2026-02-02	1	\N	2026-02-02 17:50:05	ADMIN	asistio
5012	189	5	2026-02-03	0	\N	2026-02-02 17:50:05	ADMIN	falto
5013	189	5	2026-02-04	0	\N	2026-02-02 17:50:05	ADMIN	falto
5014	189	5	2026-02-05	0	\N	2026-02-02 17:50:05	ADMIN	falto
5015	189	5	2026-02-06	0	\N	2026-02-02 17:50:05	ADMIN	falto
5016	199	5	2026-02-02	1	\N	2026-02-02 17:50:05	ADMIN	asistio
5017	199	5	2026-02-03	0	\N	2026-02-02 17:50:05	ADMIN	falto
5018	199	5	2026-02-04	0	\N	2026-02-02 17:50:05	ADMIN	falto
5019	199	5	2026-02-05	0	\N	2026-02-02 17:50:05	ADMIN	falto
5020	199	5	2026-02-06	0	\N	2026-02-02 17:50:06	ADMIN	falto
5021	197	5	2026-02-02	0	\N	2026-02-02 17:50:06	ADMIN	falto
5022	197	5	2026-02-03	0	\N	2026-02-02 17:50:06	ADMIN	falto
5023	197	5	2026-02-04	0	\N	2026-02-02 17:50:06	ADMIN	falto
5024	197	5	2026-02-05	0	\N	2026-02-02 17:50:06	ADMIN	falto
5025	197	5	2026-02-06	0	\N	2026-02-02 17:50:06	ADMIN	falto
5026	209	5	2026-02-02	1	\N	2026-02-02 17:55:28	ADMIN	asistio
5027	209	5	2026-02-03	0	\N	2026-02-02 17:55:28	ADMIN	falto
5028	209	5	2026-02-04	0	\N	2026-02-02 17:55:28	ADMIN	falto
5029	209	5	2026-02-05	0	\N	2026-02-02 17:55:28	ADMIN	falto
5030	209	5	2026-02-06	0	\N	2026-02-02 17:55:28	ADMIN	falto
5031	222	5	2026-02-02	1	\N	2026-02-02 17:55:28	ADMIN	asistio
5032	222	5	2026-02-03	0	\N	2026-02-02 17:55:28	ADMIN	falto
5033	222	5	2026-02-04	0	\N	2026-02-02 17:55:28	ADMIN	falto
5034	222	5	2026-02-05	0	\N	2026-02-02 17:55:28	ADMIN	falto
5035	222	5	2026-02-06	0	\N	2026-02-02 17:55:28	ADMIN	falto
5036	208	5	2026-02-02	1	\N	2026-02-02 17:55:29	ADMIN	asistio
5037	208	5	2026-02-03	0	\N	2026-02-02 17:55:29	ADMIN	falto
5038	208	5	2026-02-04	0	\N	2026-02-02 17:55:29	ADMIN	falto
5039	208	5	2026-02-05	0	\N	2026-02-02 17:55:29	ADMIN	falto
5040	208	5	2026-02-06	0	\N	2026-02-02 17:55:29	ADMIN	falto
5041	193	5	2026-02-02	1	\N	2026-02-02 17:55:29	ADMIN	asistio
5042	193	5	2026-02-03	0	\N	2026-02-02 17:55:29	ADMIN	falto
5043	193	5	2026-02-04	0	\N	2026-02-02 17:55:29	ADMIN	falto
5044	193	5	2026-02-05	0	\N	2026-02-02 17:55:29	ADMIN	falto
5045	193	5	2026-02-06	0	\N	2026-02-02 17:55:29	ADMIN	falto
5046	153	5	2026-02-02	1	\N	2026-02-02 17:55:30	ADMIN	asistio
5047	153	5	2026-02-03	0	\N	2026-02-02 17:55:30	ADMIN	falto
5048	153	5	2026-02-04	0	\N	2026-02-02 17:55:30	ADMIN	falto
5049	153	5	2026-02-05	0	\N	2026-02-02 17:55:30	ADMIN	falto
5050	153	5	2026-02-06	0	\N	2026-02-02 17:55:30	ADMIN	falto
5051	155	5	2026-02-02	1	\N	2026-02-02 17:55:30	ADMIN	asistio
5052	155	5	2026-02-03	0	\N	2026-02-02 17:55:30	ADMIN	falto
5053	155	5	2026-02-04	0	\N	2026-02-02 17:55:30	ADMIN	falto
5054	155	5	2026-02-05	0	\N	2026-02-02 17:55:30	ADMIN	falto
5055	155	5	2026-02-06	0	\N	2026-02-02 17:55:30	ADMIN	falto
5056	171	5	2026-02-02	1	\N	2026-02-02 17:55:30	ADMIN	asistio
5057	171	5	2026-02-03	0	\N	2026-02-02 17:55:30	ADMIN	falto
5058	171	5	2026-02-04	0	\N	2026-02-02 17:55:30	ADMIN	falto
5059	171	5	2026-02-05	0	\N	2026-02-02 17:55:30	ADMIN	falto
5060	171	5	2026-02-06	0	\N	2026-02-02 17:55:30	ADMIN	falto
5061	172	5	2026-02-02	0	\N	2026-02-02 17:55:30	ADMIN	falto
5062	172	5	2026-02-03	0	\N	2026-02-02 17:55:30	ADMIN	falto
5063	172	5	2026-02-04	0	\N	2026-02-02 17:55:30	ADMIN	falto
5064	172	5	2026-02-05	0	\N	2026-02-02 17:55:30	ADMIN	falto
5065	172	5	2026-02-06	0	\N	2026-02-02 17:55:31	ADMIN	falto
5066	251	5	2026-02-02	0	\N	2026-02-02 17:55:31	ADMIN	falto
5067	251	5	2026-02-03	0	\N	2026-02-02 17:55:31	ADMIN	falto
5068	251	5	2026-02-04	0	\N	2026-02-02 17:55:31	ADMIN	falto
5069	251	5	2026-02-05	0	\N	2026-02-02 17:55:31	ADMIN	falto
5070	251	5	2026-02-06	0	\N	2026-02-02 17:55:31	ADMIN	falto
5071	173	5	2026-02-02	1	\N	2026-02-02 17:55:31	ADMIN	asistio
5072	173	5	2026-02-03	0	\N	2026-02-02 17:55:31	ADMIN	falto
5073	173	5	2026-02-04	0	\N	2026-02-02 17:55:31	ADMIN	falto
5074	173	5	2026-02-05	0	\N	2026-02-02 17:55:31	ADMIN	falto
5075	173	5	2026-02-06	0	\N	2026-02-02 17:55:31	ADMIN	falto
5076	180	5	2026-02-02	1	\N	2026-02-02 17:55:31	ADMIN	asistio
5077	180	5	2026-02-03	0	\N	2026-02-02 17:55:31	ADMIN	falto
5078	180	5	2026-02-04	0	\N	2026-02-02 17:55:31	ADMIN	falto
5079	180	5	2026-02-05	0	\N	2026-02-02 17:55:31	ADMIN	falto
5080	180	5	2026-02-06	0	\N	2026-02-02 17:55:31	ADMIN	falto
5081	202	5	2026-02-02	1	\N	2026-02-02 17:55:31	ADMIN	asistio
5082	202	5	2026-02-03	0	\N	2026-02-02 17:55:31	ADMIN	falto
5083	202	5	2026-02-04	0	\N	2026-02-02 17:55:31	ADMIN	falto
5084	202	5	2026-02-05	0	\N	2026-02-02 17:55:31	ADMIN	falto
5085	202	5	2026-02-06	0	\N	2026-02-02 17:55:31	ADMIN	falto
5086	203	5	2026-02-02	1	\N	2026-02-02 17:55:32	ADMIN	asistio
5087	203	5	2026-02-03	0	\N	2026-02-02 17:55:32	ADMIN	falto
5088	203	5	2026-02-04	0	\N	2026-02-02 17:55:32	ADMIN	falto
5089	203	5	2026-02-05	0	\N	2026-02-02 17:55:32	ADMIN	falto
5090	203	5	2026-02-06	0	\N	2026-02-02 17:55:32	ADMIN	falto
5091	188	5	2026-02-02	1	\N	2026-02-02 17:55:32	ADMIN	asistio
5092	188	5	2026-02-03	0	\N	2026-02-02 17:55:32	ADMIN	falto
5093	188	5	2026-02-04	0	\N	2026-02-02 17:55:32	ADMIN	falto
5094	188	5	2026-02-05	0	\N	2026-02-02 17:55:32	ADMIN	falto
5095	188	5	2026-02-06	0	\N	2026-02-02 17:55:32	ADMIN	falto
5096	196	5	2026-02-02	1	\N	2026-02-02 17:55:32	ADMIN	asistio
5097	196	5	2026-02-03	0	\N	2026-02-02 17:55:32	ADMIN	falto
5098	196	5	2026-02-04	0	\N	2026-02-02 17:55:32	ADMIN	falto
5099	196	5	2026-02-05	0	\N	2026-02-02 17:55:32	ADMIN	falto
5100	196	5	2026-02-06	0	\N	2026-02-02 17:55:32	ADMIN	falto
\.


--
-- TOC entry 4970 (class 0 OID 16401)
-- Dependencies: 221
-- Data for Name: asistencia_secciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asistencia_secciones (id, nombre, descripcion, orden, activo) FROM stdin;
1	6to Prim y 1ro Sec	Sexto de primaria y primero de secundaria	1	1
2	2do y 3ro Sec	Segundo y tercero de secundaria	2	1
3	4to Sec - Sección A	Cuarto de secundaria - Sección A	3	1
4	4to Sec - Sección B	Cuarto de secundaria - Sección B	4	1
5	5to Sec - Sección A	Quinto de secundaria - Sección A	5	1
6	5to Sec - Sección B	Quinto de secundaria - Sección B	6	1
\.


--
-- TOC entry 4971 (class 0 OID 16404)
-- Dependencies: 222
-- Data for Name: asistencia_semanas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asistencia_semanas (id, numero_semana, nombre, fecha_inicio, fecha_fin, activa, fecha_creacion) FROM stdin;
1	1	Semana 1	2026-01-05	\N	0	2026-01-05 01:10:30
2	2	Semana 2	2026-01-12	\N	0	2026-01-05 01:10:30
3	3	Semana 3	2026-01-19	\N	0	2026-01-05 01:10:30
4	4	Semana 4	2026-01-26	\N	0	2026-01-05 01:10:30
5	5	Semana 5	2026-02-02	\N	0	2026-01-05 01:10:30
6	6	Semana 6	2026-02-09	\N	0	2026-01-05 01:10:30
7	7	Semana 7	2026-02-16	\N	1	2026-01-05 01:10:30
\.


--
-- TOC entry 4972 (class 0 OID 16407)
-- Dependencies: 223
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.curso (id, nombre, carrera) FROM stdin;
1	Fundamentos de Cálculo	Ingenieria
2	Física General	Ingenieria
3	Álgebra y Geometría Analítica	Ingenieria
4	Introducción a la Programación	Ingenieria
5	Química para Ingeniería	Ingenieria
6	Biología Celular y Molecular	Medicina
7	Química Orgánica	Medicina
8	Anatomía y Fisiología Humana	Medicina
9	Bioquímica Médica	Medicina
10	Introducción a la Microbiología	Medicina
11	Introducción al Derecho y Teoría Jurídica	Derecho
12	Derecho Constitucional	Derecho
13	Metodología de la Investigación Jurídica	Derecho
14	Derecho Civil I	Derecho
15	Redacción y Argumentación Jurídica	Derecho
\.


--
-- TOC entry 4973 (class 0 OID 16410)
-- Dependencies: 224
-- Data for Name: curso_docente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.curso_docente (id, id_curso, id_docente) FROM stdin;
1	3	2
2	5	2
3	2	2
\.


--
-- TOC entry 4974 (class 0 OID 16413)
-- Dependencies: 225
-- Data for Name: grupo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupo (id, nombre, carrera, fecha_creacion) FROM stdin;
1	GRUPO 1		2025-12-18 06:16:11
2	GRUPO 2		2025-12-18 06:16:11
3	GRUPO 3		2025-12-18 06:16:11
\.


--
-- TOC entry 4975 (class 0 OID 16416)
-- Dependencies: 226
-- Data for Name: grupo_estudiante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupo_estudiante (id, id_grupo, id_usuario, id_seccion) FROM stdin;
\.


--
-- TOC entry 4976 (class 0 OID 16419)
-- Dependencies: 227
-- Data for Name: grupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupos (id, nombre, carrera, numero_grupo, fecha_creacion) FROM stdin;
1	I1	Ingenieria	1	2025-07-19 14:46:47
2	I1	Ingenieria	1	2025-07-19 14:59:47
3	I1	Ingenieria	1	2025-07-19 15:01:11
4	I2	Ingenieria	2	2025-07-19 15:01:11
\.


--
-- TOC entry 4977 (class 0 OID 16422)
-- Dependencies: 228
-- Data for Name: horario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.horario (id, id_curso_docente, dia, hora_inicio, hora_fin) FROM stdin;
1	1	Lunes	10:00:00	11:30:00
2	2	Martes	10:00:00	11:30:00
3	3	Miercoles	10:00:00	11:30:00
\.


--
-- TOC entry 4978 (class 0 OID 16425)
-- Dependencies: 229
-- Data for Name: material_curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.material_curso (id, id_usuario, id_curso, id_seccion, titulo, descripcion, archivo, tipo, fecha_subida) FROM stdin;
1	1	3	\N	Semana 1	Semanita 1	18002892-fcef-4201-9248-89e6cfced945_Semana_09_-_Tema_04__Tarea_-_Avance_de_Proyecto_Final_1_-_GRUPO.pdf	PDF	2025-07-22 19:56:39
2	1	3	\N	Semana 2	Semanita 2	6137a330-889e-4e41-ac9b-6a2d4de5d78e_Pregunta4.docx	DOC	2025-07-23 00:46:32
3	1	2	\N	Semana 4	Semanita 4	475d6936-3259-48f3-8979-c6cd153b0e69_Pregunta4__1_.docx	DOC	2025-07-23 02:15:19
\.


--
-- TOC entry 4979 (class 0 OID 16428)
-- Dependencies: 230
-- Data for Name: nota; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nota (id, id_seccion, id_estudiante, nota1, nota2, nota3, nota_final, promedio) FROM stdin;
\.


--
-- TOC entry 4980 (class 0 OID 16431)
-- Dependencies: 231
-- Data for Name: pagos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagos (id, id_preinscripcion, numero_cuota, monto, metodo_pago, referencia_pago, comprobante_pago, fecha_pago, registrado_por, notas) FROM stdin;
31	1	1	400.00	yape	12ab1203	\N	2025-12-20 13:54:47	sistema	Pago de primera cuota - Registro online
\.


--
-- TOC entry 4981 (class 0 OID 16434)
-- Dependencies: 232
-- Data for Name: preinscripcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preinscripcion (id, fecha_registro, nombre, apellido, dni, email, direccion, colegio, nombre_apoderado, apellido_apoderado, dni_apoderado, email_apoderado, telefono_apoderado, telefono2_apoderado, metodo_pago, modalidad_pago, monto_total, monto_pagado, saldo_pendiente, estado_pago, fecha_limite_2da_cuota, referencia_pago, comprobante_pago, boleta_sunat, grado, estado, origen, intentos, seccion_id, intereses, escaneo_id) FROM stdin;
1	2025-12-20 13:54:46	Marycarmen	Cornejo	\N	joaquin@gmail.com	Piura , 26 de octubre ,Villa Hermosa Mz.A lt14	San miguel	Alberto	pruebapadre	12344564	apoderado@gmail.com	989453142	955908626	yape	contado	400.00	400.00	0.00	completo	\N	12ab1203	\N	\N	6to Prim - 1ro Sec	pendiente	online	0	\N	\N	\N
\.


--
-- TOC entry 4982 (class 0 OID 16437)
-- Dependencies: 233
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rol (id, nombre) FROM stdin;
1	administrador
2	docente
3	estudiante
\.


--
-- TOC entry 4983 (class 0 OID 16440)
-- Dependencies: 234
-- Data for Name: seccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seccion (id, id_horario, nombre, id_grupo) FROM stdin;
61	\N	A	1
62	\N	B	1
63	\N	A	2
64	\N	B	2
65	\N	A	3
66	\N	B	3
\.


--
-- TOC entry 4984 (class 0 OID 16443)
-- Dependencies: 235
-- Data for Name: secciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.secciones (id, nombre, grado_grupo, capacidad_maxima, "año_academico", fecha_creacion) FROM stdin;
\.


--
-- TOC entry 4985 (class 0 OID 16446)
-- Dependencies: 236
-- Data for Name: telefono; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telefono (id, id_preinscripcion, numero) FROM stdin;
\.


--
-- TOC entry 4986 (class 0 OID 16449)
-- Dependencies: 237
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, correo, password, nombre, apellido, carrera, grupo, id_rol, estado) FROM stdin;
1	a1@academiaA1.com	admin123	Admin	General	\N	\N	1	1
2	c1001@academiaA1.com	docente123	Juan	Pérez	\N	\N	2	1
4	a2@academiaA1.com	admin123	Ronaldo	Vasquez	\N	\N	1	1
5	a3@academiaA1.com	admin123	Roger	Castro	\N	\N	1	1
6	c1002@academiaA1.com	docente123	Oswaldo	Chorres	\N	\N	2	1
7	c1003@academiaA1.com	docente123	Mary	Herrera	\N	\N	2	1
8	c1004@academiaA1.com	docente123	Elber	Socola	\N	\N	2	1
9	c1005@academiaA1.com	docente123	Javier	Socola	\N	\N	2	1
10	c1006@academiaA1.com	docente123	Aldo	Castro	\N	\N	2	1
11	u73737750@academiaA1.com	C5kct1Pd	Alejandra	Chorres	Ingenieria	\N	3	1
12	u22212954@academiaA1.com	estudiante123	Ana	Gómez	Ingenieria	\N	3	1
13	u12345678@academiaA1.com	nR7Sh8QH	Milton	Suarez	Ingenieria	\N	3	1
14	u71128890@academiaA1.com	JIdFpIf4	hebert	cornejo	Ingenieria	\N	3	1
15	u71128888@academiaA1.com	wBwwp8XG	diego	vera	Ingenieria	\N	3	1
16	u71128889@academiaA1.com	D6pN0zDc	Mirrella	Estrada 	Derecho	\N	3	1
17	u12312312@academiaA1.com	4chJ3E1M	Marycarmen	Cornejo	Medicina	\N	3	1
18	u73737751@academiaA1.com	6TivQOxX	Alexa	Herrera	Medicina	\N	3	1
19	u73737752@academiaA1.com	GL8i7ewL	Alessia	Quezada	Ingenieria	\N	3	1
20	u12312333@academiaA1.com	rLpwRtip	Marycarmen	marucho	Derecho	\N	3	1
21	u71282213@academiaA1.com	6dFiub2n	joaquin	prueba	Medicina	\N	3	1
22	u71189892@academiaA1.com	HIVMNohA	Jennifer	Cornejo	Derecho	\N	3	1
23	u02850715@academiaA1.com	tdxT9w2z	JENNY	GARCIA	Ingenieria	\N	3	1
24	u12344423@academiaA1.com	Hl7Sh10i	alaia	castillo	Ingenieria	\N	3	1
25	u51116266@academiaA1.com	bCUTx4ju	Alaia	Cornejo	Ingenieria	\N	3	1
26	u12333332@academiaA1.com	5ZqvyEf3	manolito	vera	Derecho	\N	3	1
27	u12399494@academiaA1.com	uzC8kJz6	maiucol	sexudo	Ingenieria	\N	3	1
28	u12312324@academiaA1.com	TWT7FZQF	keñin	loscaon	Derecho	\N	3	1
29	u72834838@academiaA1.com	nsD46BfH	kervin	Ñescano	Ingenieria	\N	3	1
30	unull@academiaA1.com	cpW3pz3J	Marycarmen	prueba	Derecho	\N	3	1
\.


-- Completed on 2026-02-03 08:58:39

--
-- PostgreSQL database dump complete
--

