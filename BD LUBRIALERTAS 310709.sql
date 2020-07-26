--
-- PostgreSQL database dump
--

-- Started on 2009-07-31 16:41:28

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1700 (class 1262 OID 203368493)
-- Name: sislub; Type: DATABASE; Schema: -; Owner: sislub_adm
--

CREATE DATABASE sislub WITH TEMPLATE = template0 ENCODING = 'UTF8';


ALTER DATABASE sislub OWNER TO sislub_adm;

\connect sislub

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1236 (class 1259 OID 246301120)
-- Dependencies: 5
-- Name: TH001_Roles; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TH001_Roles" (
    "id_Roles" integer NOT NULL,
    "id_Perfiles" integer NOT NULL,
    "id_Modulos" integer NOT NULL,
    "Acceso_Agregar" integer,
    "Acceso_Modificar" integer,
    "Acceso_Eliminar" integer
);


ALTER TABLE public."TH001_Roles" OWNER TO sislub_adm;

--
-- TOC entry 1235 (class 1259 OID 246301118)
-- Dependencies: 5 1236
-- Name: TH001_Roles_id_Roles_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TH001_Roles_id_Roles_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TH001_Roles_id_Roles_seq" OWNER TO sislub_adm;

--
-- TOC entry 1704 (class 0 OID 0)
-- Dependencies: 1235
-- Name: TH001_Roles_id_Roles_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TH001_Roles_id_Roles_seq" OWNED BY "TH001_Roles"."id_Roles";


--
-- TOC entry 1705 (class 0 OID 0)
-- Dependencies: 1235
-- Name: TH001_Roles_id_Roles_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TH001_Roles_id_Roles_seq"', 389, true);


--
-- TOC entry 1238 (class 1259 OID 246301125)
-- Dependencies: 5
-- Name: TR001_Accion; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Accion" (
    "id_Accion" integer NOT NULL,
    "Tipo_Accion" character varying NOT NULL
);


ALTER TABLE public."TR001_Accion" OWNER TO sislub_adm;

--
-- TOC entry 1237 (class 1259 OID 246301123)
-- Dependencies: 5 1238
-- Name: TR001_Accion_id_Accion_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Accion_id_Accion_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Accion_id_Accion_seq" OWNER TO sislub_adm;

--
-- TOC entry 1708 (class 0 OID 0)
-- Dependencies: 1237
-- Name: TR001_Accion_id_Accion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Accion_id_Accion_seq" OWNED BY "TR001_Accion"."id_Accion";


--
-- TOC entry 1709 (class 0 OID 0)
-- Dependencies: 1237
-- Name: TR001_Accion_id_Accion_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Accion_id_Accion_seq"', 54, true);


--
-- TOC entry 1240 (class 1259 OID 246301133)
-- Dependencies: 5
-- Name: TR001_Cargos; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Cargos" (
    id_cargo integer NOT NULL,
    nombre_cargo character varying(40) NOT NULL
);


ALTER TABLE public."TR001_Cargos" OWNER TO sislub_adm;

--
-- TOC entry 1239 (class 1259 OID 246301131)
-- Dependencies: 5 1240
-- Name: TR001_Cargos_id_cargo_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Cargos_id_cargo_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Cargos_id_cargo_seq" OWNER TO sislub_adm;

--
-- TOC entry 1712 (class 0 OID 0)
-- Dependencies: 1239
-- Name: TR001_Cargos_id_cargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Cargos_id_cargo_seq" OWNED BY "TR001_Cargos".id_cargo;


--
-- TOC entry 1713 (class 0 OID 0)
-- Dependencies: 1239
-- Name: TR001_Cargos_id_cargo_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Cargos_id_cargo_seq"', 6, true);


--
-- TOC entry 1242 (class 1259 OID 246301138)
-- Dependencies: 5
-- Name: TR001_Certificado; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Certificado" (
    id_certificado integer NOT NULL,
    laboratorio character varying(250),
    cliente character varying(250),
    representante character varying(250),
    contacto character varying(250),
    direccion text,
    fecha_recepcion date,
    numero_informe character varying(25),
    fecha_emision date,
    numero_solicitud character varying(25),
    codigo_muestra character varying(25),
    muestra character varying(250),
    fecha_ingreso_bd date,
    cod_muestra_lubrialerta character varying NOT NULL
);


ALTER TABLE public."TR001_Certificado" OWNER TO sislub_adm;

--
-- TOC entry 1715 (class 0 OID 0)
-- Dependencies: 1242
-- Name: TABLE "TR001_Certificado"; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON TABLE "TR001_Certificado" IS 'Almacena el encabezado del certificado de las muestras';


--
-- TOC entry 1716 (class 0 OID 0)
-- Dependencies: 1242
-- Name: COLUMN "TR001_Certificado".id_certificado; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Certificado".id_certificado IS 'Id del sistema lubrialertas
';


--
-- TOC entry 1717 (class 0 OID 0)
-- Dependencies: 1242
-- Name: COLUMN "TR001_Certificado".laboratorio; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Certificado".laboratorio IS 'Nombre del Laboratorio de Intevep';


--
-- TOC entry 1718 (class 0 OID 0)
-- Dependencies: 1242
-- Name: COLUMN "TR001_Certificado".cliente; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Certificado".cliente IS 'Nombre del Cliente segun Sigelab';


--
-- TOC entry 1719 (class 0 OID 0)
-- Dependencies: 1242
-- Name: COLUMN "TR001_Certificado".numero_informe; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Certificado".numero_informe IS 'numero del certificado que emite Intevep';


--
-- TOC entry 1720 (class 0 OID 0)
-- Dependencies: 1242
-- Name: COLUMN "TR001_Certificado".numero_solicitud; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Certificado".numero_solicitud IS 'numero de solicitud en SIGELAB';


--
-- TOC entry 1721 (class 0 OID 0)
-- Dependencies: 1242
-- Name: COLUMN "TR001_Certificado".codigo_muestra; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Certificado".codigo_muestra IS 'codigo de muestra en SIGELAB';


--
-- TOC entry 1722 (class 0 OID 0)
-- Dependencies: 1242
-- Name: COLUMN "TR001_Certificado".muestra; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Certificado".muestra IS 'descripcion de la muestra en sigelab';


--
-- TOC entry 1723 (class 0 OID 0)
-- Dependencies: 1242
-- Name: COLUMN "TR001_Certificado".fecha_ingreso_bd; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Certificado".fecha_ingreso_bd IS 'Fecha en la cual se registro en la Base de Datos de Lubrialertas';


--
-- TOC entry 1724 (class 0 OID 0)
-- Dependencies: 1242
-- Name: COLUMN "TR001_Certificado".cod_muestra_lubrialerta; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Certificado".cod_muestra_lubrialerta IS 'Se almacena el codigo de muestra perteneciente a lubrialertas';


--
-- TOC entry 1241 (class 1259 OID 246301136)
-- Dependencies: 5 1242
-- Name: TR001_Certificado_id_certificado_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Certificado_id_certificado_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Certificado_id_certificado_seq" OWNER TO sislub_adm;

--
-- TOC entry 1726 (class 0 OID 0)
-- Dependencies: 1241
-- Name: TR001_Certificado_id_certificado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Certificado_id_certificado_seq" OWNED BY "TR001_Certificado".id_certificado;


--
-- TOC entry 1727 (class 0 OID 0)
-- Dependencies: 1241
-- Name: TR001_Certificado_id_certificado_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Certificado_id_certificado_seq"', 70, true);


--
-- TOC entry 1244 (class 1259 OID 246301146)
-- Dependencies: 1603 1604 1605 1606 1607 5
-- Name: TR001_Cliente; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Cliente" (
    "id_Cliente" integer NOT NULL,
    "Nombre_Cliente" character varying(75) NOT NULL,
    "Direccion_Cliente" text NOT NULL,
    "Telefono_Oficina_Cliente" character varying(25),
    "Persona_Contacto1" character varying(50) NOT NULL,
    "Telefono_Celular_Contacto1" character varying(25),
    "Persona_Contacto2" character varying(50),
    "Telefono_Celular_Contacto2" character varying(25),
    "Fax" character varying(15),
    "Email" character varying(75) NOT NULL,
    "Rif" character varying(20),
    "Volumen_Vendido" character varying(75),
    "id_Cuenta_Acceso" integer NOT NULL,
    "Distribuidor" integer DEFAULT 0,
    "Asesor_Comercial" integer DEFAULT 0,
    "Muestras_Realizadas" integer DEFAULT 0,
    "Muestras_Mensuales" integer DEFAULT 40,
    "Zona" integer DEFAULT 0 NOT NULL,
    "Codigo_Empresa" character varying(25),
    "Actividad_Empresa" character varying(50)
);


ALTER TABLE public."TR001_Cliente" OWNER TO sislub_adm;

--
-- TOC entry 1243 (class 1259 OID 246301144)
-- Dependencies: 5 1244
-- Name: TR001_Cliente_id_Cliente_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Cliente_id_Cliente_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Cliente_id_Cliente_seq" OWNER TO sislub_adm;

--
-- TOC entry 1730 (class 0 OID 0)
-- Dependencies: 1243
-- Name: TR001_Cliente_id_Cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Cliente_id_Cliente_seq" OWNED BY "TR001_Cliente"."id_Cliente";


--
-- TOC entry 1731 (class 0 OID 0)
-- Dependencies: 1243
-- Name: TR001_Cliente_id_Cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Cliente_id_Cliente_seq"', 35, true);


--
-- TOC entry 1246 (class 1259 OID 246301159)
-- Dependencies: 1609 1610 1611 5
-- Name: TR001_Cuenta_Acceso; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Cuenta_Acceso" (
    "id_Cuenta_Acceso" integer NOT NULL,
    "Nombre" character varying(75) NOT NULL,
    "Password" character varying(40) NOT NULL,
    "Indicador_PDVSA" character varying(50) NOT NULL,
    "Perfil" integer NOT NULL,
    "Conectado" integer NOT NULL,
    "Tipo_Usuario" character(1),
    "Cuenta_Eliminada" integer DEFAULT 0 NOT NULL,
    "Primer_Acceso" integer DEFAULT 0 NOT NULL,
    "Bloqueado" integer DEFAULT 0 NOT NULL,
    "PasswordA" character varying(40),
    "PasswordB" character varying(40)
);


ALTER TABLE public."TR001_Cuenta_Acceso" OWNER TO sislub_adm;

--
-- TOC entry 1733 (class 0 OID 0)
-- Dependencies: 1246
-- Name: COLUMN "TR001_Cuenta_Acceso"."Conectado"; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Cuenta_Acceso"."Conectado" IS '0= No Conectado; 1=Conectado';


--
-- TOC entry 1734 (class 0 OID 0)
-- Dependencies: 1246
-- Name: COLUMN "TR001_Cuenta_Acceso"."Cuenta_Eliminada"; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Cuenta_Acceso"."Cuenta_Eliminada" IS '0= Activa; 1= Eliminada';


--
-- TOC entry 1735 (class 0 OID 0)
-- Dependencies: 1246
-- Name: COLUMN "TR001_Cuenta_Acceso"."Primer_Acceso"; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Cuenta_Acceso"."Primer_Acceso" IS '0= Normal, 1=Primer Acceso';


--
-- TOC entry 1736 (class 0 OID 0)
-- Dependencies: 1246
-- Name: COLUMN "TR001_Cuenta_Acceso"."Bloqueado"; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Cuenta_Acceso"."Bloqueado" IS '0= Normal; 1= Bloqueado';


--
-- TOC entry 1737 (class 0 OID 0)
-- Dependencies: 1246
-- Name: COLUMN "TR001_Cuenta_Acceso"."PasswordA"; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Cuenta_Acceso"."PasswordA" IS 'Guarda el valor anterior del campo password';


--
-- TOC entry 1738 (class 0 OID 0)
-- Dependencies: 1246
-- Name: COLUMN "TR001_Cuenta_Acceso"."PasswordB"; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Cuenta_Acceso"."PasswordB" IS 'Guarda el valor anterior del campo passwordA';


--
-- TOC entry 1245 (class 1259 OID 246301157)
-- Dependencies: 5 1246
-- Name: TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq" OWNER TO sislub_adm;

--
-- TOC entry 1740 (class 0 OID 0)
-- Dependencies: 1245
-- Name: TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq" OWNED BY "TR001_Cuenta_Acceso"."id_Cuenta_Acceso";


--
-- TOC entry 1741 (class 0 OID 0)
-- Dependencies: 1245
-- Name: TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq"', 104, true);


--
-- TOC entry 1248 (class 1259 OID 246301167)
-- Dependencies: 1613 5
-- Name: TR001_Distribuidores; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Distribuidores" (
    "id_Distribuidor" integer NOT NULL,
    "Nombres_Apellidos" character varying(70) NOT NULL,
    "Rif" character varying(20) NOT NULL,
    "Telefono_Oficina" character varying(25),
    "Telefono_Celular" character varying(25),
    "Direccion" text NOT NULL,
    "Persona_Contacto" character varying(50) NOT NULL,
    "id_Cuenta_Acceso" integer NOT NULL,
    "Email" character varying(75) NOT NULL,
    "Zona" integer DEFAULT 0 NOT NULL,
    "Fax" character varying(25)
);


ALTER TABLE public."TR001_Distribuidores" OWNER TO sislub_adm;

--
-- TOC entry 1247 (class 1259 OID 246301165)
-- Dependencies: 5 1248
-- Name: TR001_Distribuidores_id_Distribuidor_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Distribuidores_id_Distribuidor_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Distribuidores_id_Distribuidor_seq" OWNER TO sislub_adm;

--
-- TOC entry 1744 (class 0 OID 0)
-- Dependencies: 1247
-- Name: TR001_Distribuidores_id_Distribuidor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Distribuidores_id_Distribuidor_seq" OWNED BY "TR001_Distribuidores"."id_Distribuidor";


--
-- TOC entry 1745 (class 0 OID 0)
-- Dependencies: 1247
-- Name: TR001_Distribuidores_id_Distribuidor_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Distribuidores_id_Distribuidor_seq"', 14, true);


--
-- TOC entry 1250 (class 1259 OID 246301176)
-- Dependencies: 5
-- Name: TR001_Empresa_Transporte; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Empresa_Transporte" (
    "id_Empresa_Transporte" integer NOT NULL,
    "Nombre_Empresa" character varying(75) NOT NULL,
    "Rif" character varying(20) NOT NULL,
    "Persona_Contacto" character varying(50) NOT NULL,
    "Telefono_Celular" character varying(20),
    "Telefono_Oficina" character varying(20) NOT NULL,
    "Fax" character varying(20),
    "Email" character varying,
    "Eliminado" integer NOT NULL
);


ALTER TABLE public."TR001_Empresa_Transporte" OWNER TO sislub_adm;

--
-- TOC entry 1249 (class 1259 OID 246301174)
-- Dependencies: 5 1250
-- Name: TR001_Empresa_Transporte_id_Empresa_Transporte_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Empresa_Transporte_id_Empresa_Transporte_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Empresa_Transporte_id_Empresa_Transporte_seq" OWNER TO sislub_adm;

--
-- TOC entry 1748 (class 0 OID 0)
-- Dependencies: 1249
-- Name: TR001_Empresa_Transporte_id_Empresa_Transporte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Empresa_Transporte_id_Empresa_Transporte_seq" OWNED BY "TR001_Empresa_Transporte"."id_Empresa_Transporte";


--
-- TOC entry 1749 (class 0 OID 0)
-- Dependencies: 1249
-- Name: TR001_Empresa_Transporte_id_Empresa_Transporte_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Empresa_Transporte_id_Empresa_Transporte_seq"', 1, true);


--
-- TOC entry 1252 (class 1259 OID 246301184)
-- Dependencies: 1616 5
-- Name: TR001_Equipo; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Equipo" (
    "id_Equipo" integer NOT NULL,
    "Tipo" character varying(50) NOT NULL,
    "Marca" character varying(50) NOT NULL,
    "Numero_Planta" character varying(20),
    "Eliminado" integer NOT NULL,
    "id_Cliente" integer,
    "Descripcion" text NOT NULL,
    "Codigo_Equipo" character varying(20) NOT NULL,
    "Modelo" character varying(50),
    "Capacidad_Sistema" double precision DEFAULT 0 NOT NULL,
    "Nombre_Equipo" character varying(30)
);


ALTER TABLE public."TR001_Equipo" OWNER TO sislub_adm;

--
-- TOC entry 1251 (class 1259 OID 246301182)
-- Dependencies: 5 1252
-- Name: TR001_Equipo_id_Equipo_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Equipo_id_Equipo_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Equipo_id_Equipo_seq" OWNER TO sislub_adm;

--
-- TOC entry 1752 (class 0 OID 0)
-- Dependencies: 1251
-- Name: TR001_Equipo_id_Equipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Equipo_id_Equipo_seq" OWNED BY "TR001_Equipo"."id_Equipo";


--
-- TOC entry 1753 (class 0 OID 0)
-- Dependencies: 1251
-- Name: TR001_Equipo_id_Equipo_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Equipo_id_Equipo_seq"', 41, true);


--
-- TOC entry 1254 (class 1259 OID 246301193)
-- Dependencies: 5
-- Name: TR001_Historial; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Historial" (
    "id_Historial" integer NOT NULL,
    "IP" character varying,
    "Fecha" date,
    "Hora" time without time zone,
    "id_Accion" integer,
    "id_Cuenta_Acceso" integer,
    detalle_accion character varying(250)
);


ALTER TABLE public."TR001_Historial" OWNER TO sislub_adm;

--
-- TOC entry 1755 (class 0 OID 0)
-- Dependencies: 1254
-- Name: COLUMN "TR001_Historial".detalle_accion; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Historial".detalle_accion IS 'detalle del usuario u objeto a cambiar';


--
-- TOC entry 1253 (class 1259 OID 246301191)
-- Dependencies: 5 1254
-- Name: TR001_Historial_id_Historial_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Historial_id_Historial_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Historial_id_Historial_seq" OWNER TO sislub_adm;

--
-- TOC entry 1757 (class 0 OID 0)
-- Dependencies: 1253
-- Name: TR001_Historial_id_Historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Historial_id_Historial_seq" OWNED BY "TR001_Historial"."id_Historial";


--
-- TOC entry 1758 (class 0 OID 0)
-- Dependencies: 1253
-- Name: TR001_Historial_id_Historial_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Historial_id_Historial_seq"', 13403, true);


--
-- TOC entry 1256 (class 1259 OID 246301201)
-- Dependencies: 5
-- Name: TR001_Metodo; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Metodo" (
    id_metodo integer NOT NULL,
    id_certificado integer,
    codigo_metodo character varying(75),
    nombre text,
    aprobado character varying(100)
);


ALTER TABLE public."TR001_Metodo" OWNER TO sislub_adm;

--
-- TOC entry 1760 (class 0 OID 0)
-- Dependencies: 1256
-- Name: TABLE "TR001_Metodo"; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON TABLE "TR001_Metodo" IS 'Almacena los metodos de un certificado en especifico.';


--
-- TOC entry 1761 (class 0 OID 0)
-- Dependencies: 1256
-- Name: COLUMN "TR001_Metodo".id_certificado; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Metodo".id_certificado IS 'especifica el ID del certificado';


--
-- TOC entry 1255 (class 1259 OID 246301199)
-- Dependencies: 5 1256
-- Name: TR001_Metodo_id_metodo_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Metodo_id_metodo_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Metodo_id_metodo_seq" OWNER TO sislub_adm;

--
-- TOC entry 1763 (class 0 OID 0)
-- Dependencies: 1255
-- Name: TR001_Metodo_id_metodo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Metodo_id_metodo_seq" OWNED BY "TR001_Metodo".id_metodo;


--
-- TOC entry 1764 (class 0 OID 0)
-- Dependencies: 1255
-- Name: TR001_Metodo_id_metodo_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Metodo_id_metodo_seq"', 149, true);


--
-- TOC entry 1258 (class 1259 OID 246301209)
-- Dependencies: 5
-- Name: TR001_Modulos; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Modulos" (
    "id_Modulos" integer NOT NULL,
    "Nombre_Modulos" character varying(50) NOT NULL,
    "Referencia_Modulos" character varying(12),
    "Modulo_Padre" integer
);


ALTER TABLE public."TR001_Modulos" OWNER TO sislub_adm;

--
-- TOC entry 1257 (class 1259 OID 246301207)
-- Dependencies: 5 1258
-- Name: TR001_Modulos_id_Modulos_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Modulos_id_Modulos_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Modulos_id_Modulos_seq" OWNER TO sislub_adm;

--
-- TOC entry 1767 (class 0 OID 0)
-- Dependencies: 1257
-- Name: TR001_Modulos_id_Modulos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Modulos_id_Modulos_seq" OWNED BY "TR001_Modulos"."id_Modulos";


--
-- TOC entry 1768 (class 0 OID 0)
-- Dependencies: 1257
-- Name: TR001_Modulos_id_Modulos_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Modulos_id_Modulos_seq"', 20, true);


--
-- TOC entry 1260 (class 1259 OID 246301214)
-- Dependencies: 5
-- Name: TR001_Muestra; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Muestra" (
    "id_Muestra" integer NOT NULL,
    "Producto_Grado" character varying(45) NOT NULL,
    "Horas" character varying(255),
    km character varying,
    "id_Equipo" integer,
    "id_Solicitud" integer NOT NULL,
    "Recomendacion" text,
    "Status_Muestra" integer,
    "Cod_Muestra" character varying NOT NULL,
    "Carga_Parametros" integer,
    "id_Cuenta_Acceso" integer
);


ALTER TABLE public."TR001_Muestra" OWNER TO sislub_adm;

--
-- TOC entry 1770 (class 0 OID 0)
-- Dependencies: 1260
-- Name: COLUMN "TR001_Muestra"."id_Cuenta_Acceso"; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Muestra"."id_Cuenta_Acceso" IS 'Guarda el id de Cuenta de Acceso de la persona que recomienda la muestra';


--
-- TOC entry 1259 (class 1259 OID 246301212)
-- Dependencies: 5 1260
-- Name: TR001_Muestra_id_Muestra_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Muestra_id_Muestra_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Muestra_id_Muestra_seq" OWNER TO sislub_adm;

--
-- TOC entry 1772 (class 0 OID 0)
-- Dependencies: 1259
-- Name: TR001_Muestra_id_Muestra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Muestra_id_Muestra_seq" OWNED BY "TR001_Muestra"."id_Muestra";


--
-- TOC entry 1773 (class 0 OID 0)
-- Dependencies: 1259
-- Name: TR001_Muestra_id_Muestra_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Muestra_id_Muestra_seq"', 66, true);


--
-- TOC entry 1262 (class 1259 OID 246301222)
-- Dependencies: 5
-- Name: TR001_Parametros; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Parametros" (
    "id_Parametros" integer NOT NULL,
    "id_Muestra" integer NOT NULL,
    "C" character(1),
    "FE" integer,
    "CR" integer,
    "PB" integer,
    "CU" integer,
    "SN" integer,
    "AL" integer,
    "NI" integer,
    "AG" integer,
    "MN" integer,
    "SI" integer,
    "B" integer,
    "NA" integer,
    "K" integer,
    "MG" integer,
    "CA" integer,
    "BA" integer,
    "P" integer,
    "ZN" integer,
    "MO" integer,
    "TI" integer,
    "V" integer,
    "GLYCOL" character varying,
    "VISC100" character varying,
    "SOOT" character varying,
    "TAN" character varying,
    "WATER" character varying
);


ALTER TABLE public."TR001_Parametros" OWNER TO sislub_adm;

--
-- TOC entry 1261 (class 1259 OID 246301220)
-- Dependencies: 5 1262
-- Name: TR001_Parametros_id_Parametros_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Parametros_id_Parametros_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Parametros_id_Parametros_seq" OWNER TO sislub_adm;

--
-- TOC entry 1776 (class 0 OID 0)
-- Dependencies: 1261
-- Name: TR001_Parametros_id_Parametros_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Parametros_id_Parametros_seq" OWNED BY "TR001_Parametros"."id_Parametros";


--
-- TOC entry 1777 (class 0 OID 0)
-- Dependencies: 1261
-- Name: TR001_Parametros_id_Parametros_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Parametros_id_Parametros_seq"', 4, true);


--
-- TOC entry 1264 (class 1259 OID 246301230)
-- Dependencies: 1623 1624 5
-- Name: TR001_Perfiles; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Perfiles" (
    "id_Perfil" integer NOT NULL,
    "Nombre_Perfil" character varying(50) NOT NULL,
    "Perfil_Eliminado" integer,
    "tipo_Cliente" boolean DEFAULT false,
    "tipo_Personal" boolean DEFAULT false
);


ALTER TABLE public."TR001_Perfiles" OWNER TO sislub_adm;

--
-- TOC entry 1263 (class 1259 OID 246301228)
-- Dependencies: 5 1264
-- Name: TR001_Perfiles_id_Perfil_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Perfiles_id_Perfil_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Perfiles_id_Perfil_seq" OWNER TO sislub_adm;

--
-- TOC entry 1780 (class 0 OID 0)
-- Dependencies: 1263
-- Name: TR001_Perfiles_id_Perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Perfiles_id_Perfil_seq" OWNED BY "TR001_Perfiles"."id_Perfil";


--
-- TOC entry 1781 (class 0 OID 0)
-- Dependencies: 1263
-- Name: TR001_Perfiles_id_Perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Perfiles_id_Perfil_seq"', 9, true);


--
-- TOC entry 1266 (class 1259 OID 246301235)
-- Dependencies: 1626 5
-- Name: TR001_Personal; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Personal" (
    "id_Personal" integer NOT NULL,
    "Nombres_Apellidos" character varying(50) NOT NULL,
    "Cedula_Identidad" integer NOT NULL,
    "Telefono_Oficina" character varying(25),
    "Telefono_Celular" character varying(25),
    "Direccion" text NOT NULL,
    "Cargo" character varying(1),
    "Supervisor" character varying(50) NOT NULL,
    "Email" character varying(75) NOT NULL,
    "id_Cuenta_Acceso" integer NOT NULL,
    "Zona" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."TR001_Personal" OWNER TO sislub_adm;

--
-- TOC entry 1265 (class 1259 OID 246301233)
-- Dependencies: 5 1266
-- Name: TR001_Personal_id_Personal_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Personal_id_Personal_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Personal_id_Personal_seq" OWNER TO sislub_adm;

--
-- TOC entry 1784 (class 0 OID 0)
-- Dependencies: 1265
-- Name: TR001_Personal_id_Personal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Personal_id_Personal_seq" OWNED BY "TR001_Personal"."id_Personal";


--
-- TOC entry 1785 (class 0 OID 0)
-- Dependencies: 1265
-- Name: TR001_Personal_id_Personal_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Personal_id_Personal_seq"', 39, true);


--
-- TOC entry 1268 (class 1259 OID 246301244)
-- Dependencies: 5
-- Name: TR001_Productos_Deltaven; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Productos_Deltaven" (
    "id_Producto" integer NOT NULL,
    "Nombre_Producto" character varying(50) NOT NULL,
    "Descripcion_Producto" text,
    "Codigo_Producto" character varying(15) NOT NULL,
    "Eliminado" integer NOT NULL
);


ALTER TABLE public."TR001_Productos_Deltaven" OWNER TO sislub_adm;

--
-- TOC entry 1267 (class 1259 OID 246301242)
-- Dependencies: 5 1268
-- Name: TR001_Productos_Deltaven_id_Producto_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Productos_Deltaven_id_Producto_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Productos_Deltaven_id_Producto_seq" OWNER TO sislub_adm;

--
-- TOC entry 1788 (class 0 OID 0)
-- Dependencies: 1267
-- Name: TR001_Productos_Deltaven_id_Producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Productos_Deltaven_id_Producto_seq" OWNED BY "TR001_Productos_Deltaven"."id_Producto";


--
-- TOC entry 1789 (class 0 OID 0)
-- Dependencies: 1267
-- Name: TR001_Productos_Deltaven_id_Producto_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Productos_Deltaven_id_Producto_seq"', 230, true);


--
-- TOC entry 1270 (class 1259 OID 246301252)
-- Dependencies: 5
-- Name: TR001_Resultado; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Resultado" (
    id_resultado integer NOT NULL,
    id_metodo integer NOT NULL,
    codigo_metodo character varying(75),
    prueba character varying(75),
    resultado character varying(75),
    incertidumbre character varying(75),
    fecha_reporte date,
    observacion text,
    idprueba integer
);


ALTER TABLE public."TR001_Resultado" OWNER TO sislub_adm;

--
-- TOC entry 1791 (class 0 OID 0)
-- Dependencies: 1270
-- Name: TABLE "TR001_Resultado"; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON TABLE "TR001_Resultado" IS 'Almacena la informacion de los resultados de cada metodo';


--
-- TOC entry 1792 (class 0 OID 0)
-- Dependencies: 1270
-- Name: COLUMN "TR001_Resultado".id_metodo; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Resultado".id_metodo IS 'Identificador del metodo';


--
-- TOC entry 1269 (class 1259 OID 246301250)
-- Dependencies: 5 1270
-- Name: TR001_Resultado_id_resultado_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Resultado_id_resultado_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Resultado_id_resultado_seq" OWNER TO sislub_adm;

--
-- TOC entry 1794 (class 0 OID 0)
-- Dependencies: 1269
-- Name: TR001_Resultado_id_resultado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Resultado_id_resultado_seq" OWNED BY "TR001_Resultado".id_resultado;


--
-- TOC entry 1795 (class 0 OID 0)
-- Dependencies: 1269
-- Name: TR001_Resultado_id_resultado_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Resultado_id_resultado_seq"', 217, true);


--
-- TOC entry 1272 (class 1259 OID 246301260)
-- Dependencies: 1630 1631 1632 5
-- Name: TR001_Solicitud; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Solicitud" (
    "id_Solicitud" integer NOT NULL,
    "id_Cliente" integer NOT NULL,
    "Fecha" date NOT NULL,
    "Hora" character varying NOT NULL,
    "Status_Solicitud" integer NOT NULL,
    "Cod_Solicitud" character varying(15),
    "Cantidad_Muestras" integer,
    "Muestras_Listas" integer,
    pre_registro integer DEFAULT 0 NOT NULL,
    codigo_sigelab character varying(20) DEFAULT 0 NOT NULL,
    fecha_registro date,
    "Motivo_Analisis" integer DEFAULT 1 NOT NULL,
    fecha_transporte date,
    fecha_final date,
    fecha_certificado date
);


ALTER TABLE public."TR001_Solicitud" OWNER TO sislub_adm;

--
-- TOC entry 1797 (class 0 OID 0)
-- Dependencies: 1272
-- Name: COLUMN "TR001_Solicitud".pre_registro; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Solicitud".pre_registro IS '0=Sin preRegistro; 1=preRegistrado';


--
-- TOC entry 1798 (class 0 OID 0)
-- Dependencies: 1272
-- Name: COLUMN "TR001_Solicitud".codigo_sigelab; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Solicitud".codigo_sigelab IS 'codigo del laboratorio sigelab';


--
-- TOC entry 1799 (class 0 OID 0)
-- Dependencies: 1272
-- Name: COLUMN "TR001_Solicitud".fecha_registro; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Solicitud".fecha_registro IS 'Guarda la fecha en la que se entrega la muestra a SIGELAB';


--
-- TOC entry 1800 (class 0 OID 0)
-- Dependencies: 1272
-- Name: COLUMN "TR001_Solicitud".fecha_transporte; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Solicitud".fecha_transporte IS 'Guarda la fecha en la que se entrega la muestra al transportista';


--
-- TOC entry 1801 (class 0 OID 0)
-- Dependencies: 1272
-- Name: COLUMN "TR001_Solicitud".fecha_final; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Solicitud".fecha_final IS 'Guarda la fecha en la que el cliente puede ver las recomendaciones de la solicitud';


--
-- TOC entry 1802 (class 0 OID 0)
-- Dependencies: 1272
-- Name: COLUMN "TR001_Solicitud".fecha_certificado; Type: COMMENT; Schema: public; Owner: sislub_adm
--

COMMENT ON COLUMN "TR001_Solicitud".fecha_certificado IS 'Guarda la fecha en la que se leyo el certficado de una muestra';


--
-- TOC entry 1271 (class 1259 OID 246301258)
-- Dependencies: 5 1272
-- Name: TR001_Solicitud_id_Solicitud_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Solicitud_id_Solicitud_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Solicitud_id_Solicitud_seq" OWNER TO sislub_adm;

--
-- TOC entry 1804 (class 0 OID 0)
-- Dependencies: 1271
-- Name: TR001_Solicitud_id_Solicitud_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Solicitud_id_Solicitud_seq" OWNED BY "TR001_Solicitud"."id_Solicitud";


--
-- TOC entry 1805 (class 0 OID 0)
-- Dependencies: 1271
-- Name: TR001_Solicitud_id_Solicitud_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Solicitud_id_Solicitud_seq"', 41, true);


--
-- TOC entry 1274 (class 1259 OID 246301271)
-- Dependencies: 5
-- Name: TR001_Status; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Status" (
    "id_Status" integer NOT NULL,
    "Nombre_Status" character varying(75) NOT NULL
);


ALTER TABLE public."TR001_Status" OWNER TO sislub_adm;

--
-- TOC entry 1273 (class 1259 OID 246301269)
-- Dependencies: 5 1274
-- Name: TR001_Status_id_Status_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Status_id_Status_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Status_id_Status_seq" OWNER TO sislub_adm;

--
-- TOC entry 1808 (class 0 OID 0)
-- Dependencies: 1273
-- Name: TR001_Status_id_Status_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Status_id_Status_seq" OWNED BY "TR001_Status"."id_Status";


--
-- TOC entry 1809 (class 0 OID 0)
-- Dependencies: 1273
-- Name: TR001_Status_id_Status_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Status_id_Status_seq"', 6, true);


--
-- TOC entry 1276 (class 1259 OID 246301276)
-- Dependencies: 5
-- Name: TR001_Zona; Type: TABLE; Schema: public; Owner: sislub_adm; Tablespace: 
--

CREATE TABLE "TR001_Zona" (
    id_zona integer NOT NULL,
    nombre_zona character varying(75) NOT NULL
);


ALTER TABLE public."TR001_Zona" OWNER TO sislub_adm;

--
-- TOC entry 1275 (class 1259 OID 246301274)
-- Dependencies: 5 1276
-- Name: TR001_Zona_id_zona_seq; Type: SEQUENCE; Schema: public; Owner: sislub_adm
--

CREATE SEQUENCE "TR001_Zona_id_zona_seq"
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."TR001_Zona_id_zona_seq" OWNER TO sislub_adm;

--
-- TOC entry 1812 (class 0 OID 0)
-- Dependencies: 1275
-- Name: TR001_Zona_id_zona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sislub_adm
--

ALTER SEQUENCE "TR001_Zona_id_zona_seq" OWNED BY "TR001_Zona".id_zona;


--
-- TOC entry 1813 (class 0 OID 0)
-- Dependencies: 1275
-- Name: TR001_Zona_id_zona_seq; Type: SEQUENCE SET; Schema: public; Owner: sislub_adm
--

SELECT pg_catalog.setval('"TR001_Zona_id_zona_seq"', 6, true);


--
-- TOC entry 1598 (class 2604 OID 246301122)
-- Dependencies: 1236 1235 1236
-- Name: id_Roles; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TH001_Roles" ALTER COLUMN "id_Roles" SET DEFAULT nextval('"TH001_Roles_id_Roles_seq"'::regclass);


--
-- TOC entry 1599 (class 2604 OID 246301127)
-- Dependencies: 1238 1237 1238
-- Name: id_Accion; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Accion" ALTER COLUMN "id_Accion" SET DEFAULT nextval('"TR001_Accion_id_Accion_seq"'::regclass);


--
-- TOC entry 1600 (class 2604 OID 246301135)
-- Dependencies: 1240 1239 1240
-- Name: id_cargo; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Cargos" ALTER COLUMN id_cargo SET DEFAULT nextval('"TR001_Cargos_id_cargo_seq"'::regclass);


--
-- TOC entry 1601 (class 2604 OID 246301140)
-- Dependencies: 1242 1241 1242
-- Name: id_certificado; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Certificado" ALTER COLUMN id_certificado SET DEFAULT nextval('"TR001_Certificado_id_certificado_seq"'::regclass);


--
-- TOC entry 1602 (class 2604 OID 246301148)
-- Dependencies: 1244 1243 1244
-- Name: id_Cliente; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Cliente" ALTER COLUMN "id_Cliente" SET DEFAULT nextval('"TR001_Cliente_id_Cliente_seq"'::regclass);


--
-- TOC entry 1608 (class 2604 OID 246301161)
-- Dependencies: 1246 1245 1246
-- Name: id_Cuenta_Acceso; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Cuenta_Acceso" ALTER COLUMN "id_Cuenta_Acceso" SET DEFAULT nextval('"TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq"'::regclass);


--
-- TOC entry 1612 (class 2604 OID 246301169)
-- Dependencies: 1248 1247 1248
-- Name: id_Distribuidor; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Distribuidores" ALTER COLUMN "id_Distribuidor" SET DEFAULT nextval('"TR001_Distribuidores_id_Distribuidor_seq"'::regclass);


--
-- TOC entry 1614 (class 2604 OID 246301178)
-- Dependencies: 1250 1249 1250
-- Name: id_Empresa_Transporte; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Empresa_Transporte" ALTER COLUMN "id_Empresa_Transporte" SET DEFAULT nextval('"TR001_Empresa_Transporte_id_Empresa_Transporte_seq"'::regclass);


--
-- TOC entry 1615 (class 2604 OID 246301186)
-- Dependencies: 1252 1251 1252
-- Name: id_Equipo; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Equipo" ALTER COLUMN "id_Equipo" SET DEFAULT nextval('"TR001_Equipo_id_Equipo_seq"'::regclass);


--
-- TOC entry 1617 (class 2604 OID 246301195)
-- Dependencies: 1254 1253 1254
-- Name: id_Historial; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Historial" ALTER COLUMN "id_Historial" SET DEFAULT nextval('"TR001_Historial_id_Historial_seq"'::regclass);


--
-- TOC entry 1618 (class 2604 OID 246301203)
-- Dependencies: 1256 1255 1256
-- Name: id_metodo; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Metodo" ALTER COLUMN id_metodo SET DEFAULT nextval('"TR001_Metodo_id_metodo_seq"'::regclass);


--
-- TOC entry 1619 (class 2604 OID 246301211)
-- Dependencies: 1258 1257 1258
-- Name: id_Modulos; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Modulos" ALTER COLUMN "id_Modulos" SET DEFAULT nextval('"TR001_Modulos_id_Modulos_seq"'::regclass);


--
-- TOC entry 1620 (class 2604 OID 246301216)
-- Dependencies: 1260 1259 1260
-- Name: id_Muestra; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Muestra" ALTER COLUMN "id_Muestra" SET DEFAULT nextval('"TR001_Muestra_id_Muestra_seq"'::regclass);


--
-- TOC entry 1621 (class 2604 OID 246301224)
-- Dependencies: 1262 1261 1262
-- Name: id_Parametros; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Parametros" ALTER COLUMN "id_Parametros" SET DEFAULT nextval('"TR001_Parametros_id_Parametros_seq"'::regclass);


--
-- TOC entry 1622 (class 2604 OID 246301232)
-- Dependencies: 1264 1263 1264
-- Name: id_Perfil; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Perfiles" ALTER COLUMN "id_Perfil" SET DEFAULT nextval('"TR001_Perfiles_id_Perfil_seq"'::regclass);


--
-- TOC entry 1625 (class 2604 OID 246301237)
-- Dependencies: 1266 1265 1266
-- Name: id_Personal; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Personal" ALTER COLUMN "id_Personal" SET DEFAULT nextval('"TR001_Personal_id_Personal_seq"'::regclass);


--
-- TOC entry 1627 (class 2604 OID 246301246)
-- Dependencies: 1268 1267 1268
-- Name: id_Producto; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Productos_Deltaven" ALTER COLUMN "id_Producto" SET DEFAULT nextval('"TR001_Productos_Deltaven_id_Producto_seq"'::regclass);


--
-- TOC entry 1628 (class 2604 OID 246301254)
-- Dependencies: 1270 1269 1270
-- Name: id_resultado; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Resultado" ALTER COLUMN id_resultado SET DEFAULT nextval('"TR001_Resultado_id_resultado_seq"'::regclass);


--
-- TOC entry 1629 (class 2604 OID 246301262)
-- Dependencies: 1272 1271 1272
-- Name: id_Solicitud; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Solicitud" ALTER COLUMN "id_Solicitud" SET DEFAULT nextval('"TR001_Solicitud_id_Solicitud_seq"'::regclass);


--
-- TOC entry 1633 (class 2604 OID 246301273)
-- Dependencies: 1274 1273 1274
-- Name: id_Status; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Status" ALTER COLUMN "id_Status" SET DEFAULT nextval('"TR001_Status_id_Status_seq"'::regclass);


--
-- TOC entry 1634 (class 2604 OID 246301278)
-- Dependencies: 1276 1275 1276
-- Name: id_zona; Type: DEFAULT; Schema: public; Owner: sislub_adm
--

ALTER TABLE "TR001_Zona" ALTER COLUMN id_zona SET DEFAULT nextval('"TR001_Zona_id_zona_seq"'::regclass);


--
-- TOC entry 1677 (class 0 OID 246301120)
-- Dependencies: 1236
-- Data for Name: TH001_Roles; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (29, 2, 1, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (30, 2, 4, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (31, 2, 8, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (32, 2, 9, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (33, 2, 10, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (34, 2, 11, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (82, 1, 1, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (83, 1, 2, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (84, 1, 3, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (85, 1, 4, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (86, 1, 5, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (87, 1, 6, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (88, 1, 7, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (89, 1, 14, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (90, 1, 15, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (91, 1, 16, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (92, 1, 17, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (93, 1, 18, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (94, 1, 19, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (128, 7, 1, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (129, 7, 3, 0, 1, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (130, 7, 17, 0, 1, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (369, 4, 1, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (370, 4, 3, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (371, 4, 5, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (372, 4, 7, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (373, 4, 8, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (374, 4, 9, 1, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (375, 4, 10, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (376, 4, 11, 0, 1, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (377, 4, 20, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (378, 4, 17, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (379, 6, 1, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (380, 6, 2, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (287, 5, 1, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (288, 5, 2, 1, 1, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (289, 5, 3, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (290, 5, 4, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (291, 5, 5, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (292, 5, 6, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (293, 5, 7, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (294, 5, 8, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (295, 5, 10, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (296, 5, 11, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (297, 5, 20, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (298, 5, 17, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (381, 6, 3, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (382, 6, 5, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (204, 8, 1, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (205, 8, 2, 0, 1, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (206, 8, 4, 0, 1, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (383, 6, 7, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (384, 6, 8, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (385, 6, 10, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (386, 6, 11, 1, 0, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (387, 6, 12, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (388, 6, 20, 1, 1, 1);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (389, 6, 17, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (267, 3, 1, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (268, 3, 2, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (269, 3, 3, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (270, 3, 5, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (271, 3, 8, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (272, 3, 10, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (273, 3, 11, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (274, 3, 20, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (359, 9, 1, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (360, 9, 2, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (361, 9, 3, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (362, 9, 5, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (363, 9, 7, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (364, 9, 8, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (365, 9, 10, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (366, 9, 11, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (367, 9, 20, 0, 0, 0);
INSERT INTO "TH001_Roles" ("id_Roles", "id_Perfiles", "id_Modulos", "Acceso_Agregar", "Acceso_Modificar", "Acceso_Eliminar") VALUES (368, 9, 17, 0, 0, 0);


--
-- TOC entry 1678 (class 0 OID 246301125)
-- Dependencies: 1238
-- Data for Name: TR001_Accion; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (7, 'Ver propiedades de la muestra :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (31, 'Inclusi&oacute;n del Equipo :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (33, 'Inclusi&oacute;n del Personal :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (38, 'Inclusi&oacute;n del Distribuidor :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (43, 'Inclusi&oacute;n de Producto :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (47, 'Inclusi&oacute;n de Transportista :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (4, 'M&oacute;dulo Listado de Solicitudes
');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (9, 'M&oacute;dulo Agregar Recomendaci&oacute;n');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (10, 'M&oacute;dulo Listado de Solicitudes');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (11, 'M&oacute;dulo de Auditoria');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (12, 'Busqueda Avanzada');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (14, 'Modificaci&oacute;n de Recomendaci&oacute;n  de la Muestra:');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (23, 'M&oacute;dulo de Clientes Deltaven');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (28, 'M&oacute;dulo de Equipos');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (32, 'M&oacute;dulo de Personal');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (37, 'M&oacute;dulo de Distribuidores');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (42, 'M&oacute;dulo de Productos');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (46, 'M&oacute;dulo de Transportista');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (27, 'Inclusi&oacute;n del Cliente :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (17, 'Reportes');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (3, 'Ingreso al M&oacute;dulo Perfiles');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (18, 'Reporte Cantidad de Muestras por Equipo');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (19, 'Reporte Cantidad de Muestras por Cliente');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (20, 'Reporte Frecuencia de Tiempo de Muestras por Equipo');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (21, 'Reporte Solicitudes Realizadas por Cliente');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (22, 'Reporte Comportamiento en el Tiempo de los Equipos');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (40, 'Generaci&oacute;n Clave Distribuidor');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (53, 'Retransmitir Datos de Solicitudes');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (54, 'Retransmitir Resultados de An&aacute;lisis');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (1, 'Ingreso al Sistema Lubrialertas');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (2, 'Salio del Sistema Lubrialertas');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (6, 'Realiz&oacute; una recomendaci&oacute;n :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (16, 'Creo una Solicitud de An&aacute;lisis :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (24, 'Generaci&oacute;n Clave Cliente :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (25, 'Modificaci&oacute;n Datos Del Cliente :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (26, 'Eliminaci&oacute;n Datos del Cliente :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (29, 'Eliminaci&oacute;n de Equipo :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (30, 'Actualizaci&oacute;n de Equipo :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (34, 'Actualizaci&oacute;n de Datos de Personal :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (35, 'Generaci&oacute;n Clave de Personal :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (36, 'Eliminaci&oacute;n de Personal :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (39, 'Actualizaci&oacute;n de Datos del Distribuidor :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (41, 'Eliminaci&oacute;n de Distribuidor :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (44, 'Actualizaci&oacute;n de Datos de Producto :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (45, 'Eliminaci&oacute;n de Producto :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (52, 'Eliminaci&oacute;n de Perfil :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (51, 'Actualizaci&oacute;n de Perfil :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (50, 'Creacioacute;n de Perfil :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (48, 'Actualizaci&oacute;n de Datos de Transportista :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (49, 'Eliminaci&oacute;n de Transportista :');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (13, 'M&oacute;dulo Resultados Solicitudes');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (5, 'Modificaci&oacute;n del estatus a Entrega de Muestra a Empresa Transportista');
INSERT INTO "TR001_Accion" ("id_Accion", "Tipo_Accion") VALUES (8, 'Bloqueo de Cuenta');


--
-- TOC entry 1679 (class 0 OID 246301133)
-- Dependencies: 1240
-- Data for Name: TR001_Cargos; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Cargos" (id_cargo, nombre_cargo) VALUES (1, 'Asesor Comercial');
INSERT INTO "TR001_Cargos" (id_cargo, nombre_cargo) VALUES (2, 'Asesor T&eacute;cnico');
INSERT INTO "TR001_Cargos" (id_cargo, nombre_cargo) VALUES (3, 'Gerente de Comercializaci&oacute;n');
INSERT INTO "TR001_Cargos" (id_cargo, nombre_cargo) VALUES (4, 'Supervisor de Aplicaciones');
INSERT INTO "TR001_Cargos" (id_cargo, nombre_cargo) VALUES (5, 'Administrador Funcional');
INSERT INTO "TR001_Cargos" (id_cargo, nombre_cargo) VALUES (6, 'Administrador AIT');
INSERT INTO "TR001_Cargos" (id_cargo, nombre_cargo) VALUES (7, 'Personal de Laboratorio');


--
-- TOC entry 1680 (class 0 OID 246301138)
-- Dependencies: 1242
-- Data for Name: TR001_Certificado; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (64, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Umberto Anzalone', 'Umberto Anzalone', 'PDVSA-Intevep, Norte 3, piso 3', '2009-04-06', '16996-09', '2009-04-06', '86
', 'M118', '2009-00038L', '2009-04-06', '2009-00038L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (1, 'Ejemplo de Prueba', 'Lubrialerta', 'Deltaven', 'Deltaven', 'Valencia Edo. Carabobo', '2008-11-11', '1067-08', '2008-11-28', '20315', 'M13353', 'OCN-ZS 14 RESIDUO 461', '2008-11-28', '2008-00003L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (70, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', 'PDVSA-Intevep, Norte 3, piso 3
', '2009-06-18', '16990-30', '2009-06-18', '99', 'M6', 'Muestra aceite', '2009-06-18', '2009-00064L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (2, 'Desarrollo y evaluaci&oacute;n de lubricantes de ...', 'Gerencia T&eacute;cnica', 'Calidad de Productos', 'Edgar Alexander Rivero Carrillo', 'Valencia Edo. Carabobo', '2008-11-11', '1067-08', '2008-11-30', '90', 'M13353', '2008-00008L', '2009-03-05', '2008-00008L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (65, 'Desarrollo y evaluaciÃ³n de lubricantes de motor y aplicaciones industriales.', 'Gerencia TÃ©cnica  Calidad de Productos', 'Umberto Anzalone', 'Umberto Anzalone', 'PDVSA-Intevep, Norte 3, piso 3', '2009-04-16', '16996-09', '2009-04-16', '91
', 'M119', '2009-00004L', '2009-04-16', '2009-00004L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (40, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', '', '2009-03-02', '16990-09', '2009-03-05', '20341
', 'M6', '2008-00020L', '2009-03-24', '2008-00020L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (39, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Edgar Alexander Rivero Carrillo', 'Edgar Alexander Rivero Carrillo', '', '2009-01-23', '16986-09', '2009-01-26', '20340
', 'M1', 'lubricante automotriz', '2009-03-24', '2008-00018L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (41, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', '', '2009-03-02', '16988-09', '2009-03-03', '20341
', 'M7', '2009-00027L
', '2009-03-24', '2009-00027L
');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (56, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', 'PDVSA-Intevep, Norte 3, piso 3', '2009-04-06', '16990-09', '2009-04-06', '80', 'M6', '2009-00039L', '2009-04-06', '2009-00039L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (59, 'Laboratorio de ensayos fisicoquímicos y reológicos de asfaltos.', 'Gerencia Técnica  Calidad de Productos', 'Lourdes Josefina Arias Duque', 'Lourdes Josefina Arias Duque', 'PDVSA-Intevep, Norte 3, piso 3', '2009-03-30', '16991-09', '2009-03-30', '27', 'M22', 'Residuo 402C+ Boscán', '2009-04-01', 'Residuo 402C+ Boscán');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (66, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', 'PDVSA-Intevep, Norte 3, piso 3
', '2009-04-29', '16990-29', '2009-04-29', '99', 'M40', 'Muestra aceite', '2009-04-29', '2009-00041L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (60, 'Laboratorio de ensayos fisicoquímicos y reológicos de asfaltos.', 'Gerencia Técnica  Calidad de Productos', 'Lourdes Josefina Arias Duque', 'Lourdes Josefina Arias Duque', 'PDVSA-Intevep, Norte 3, piso 3', '2009-03-30', '16992-09', '2009-03-30', '27', 'M23', 'Residuo 343C+ Boscán', '2009-04-01', 'Residuo 343C+ Boscán');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (61, 'Laboratorio de ensayos fisicoquímicos y reológicos de asfaltos.', 'Gerencia Técnica  Calidad de Productos', 'Lourdes Josefina Arias Duque', 'Lourdes Josefina Arias Duque', 'PDVSA-Intevep, Norte 3, piso 3', '2009-03-30', '16993-09', '2009-03-30', '27', 'M24', 'Residuo 450C+ Boscán', '2009-04-01', 'Residuo 450C+ Boscán');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (62, 'Desarrollo y Evaluación de Combustibles', 'Gerencia Técnica  Calidad de Productos', 'Luis Alvarez', 'Lenny Salas', 'PDVSA-Intevep, Norte 3, piso 3', '2009-03-31', '16994-09', '2009-03-31', '30', 'M28', 'Gasolina 95 P/D CLM,TK21,27/03/09', '2009-04-01', 'Gasolina 95 P/D CLM,TK21,27/03/09');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (63, 'Desarrollo y Evaluación de Combustibles', 'Gerencia Técnica  Calidad de Productos', 'Luis Alvarez', 'Lenny Salas', 'PDVSA-Intevep, Norte 3, piso 3', '2009-03-31', '16995-09', '2009-03-31', '30', 'M29', 'TRES', '2009-04-01', 'TRES');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (57, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', 'PDVSA-Intevep, Norte 3, piso 3', '2009-03-02', '16988-09', '2009-03-03', '26', 'M7', 'LOTE:20901688', '2009-04-01', 'LOTE:20901688');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (58, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', 'PDVSA-Intevep, Norte 3, piso 3', '2009-03-02', '16989-09', '2009-03-03', '26', 'M8', 'LOTE:20901581', '2009-04-01', 'LOTE:20901581');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (42, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', '', '2009-03-02', '16989-09', '2009-03-03', '87', 'M8', '2009-00028L', '2009-03-24', '2009-00028L
');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (47, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Edgar Alexander Rivero Carrillo', 'Edgar Alexander Rivero Carrillo', '', '2009-01-23', '16986-09', '2009-01-26', '87', 'M1', '2009-00029L', '2009-03-26', '2009-00029L
');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (67, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', 'PDVSA-Intevep, Norte 3, piso 3
', '2009-04-29', '16990-30', '2009-04-29', '99', 'M41', 'Muestra aceite', '2009-04-29', '2009-00042L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (68, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', 'PDVSA-Intevep, Norte 3, piso 3
', '2009-05-20', '16997-09', '2009-05-20', '100', 'M7', 'Muestra Lubricante', '2009-05-20', '2009-00049L');
INSERT INTO "TR001_Certificado" (id_certificado, laboratorio, cliente, representante, contacto, direccion, fecha_recepcion, numero_informe, fecha_emision, numero_solicitud, codigo_muestra, muestra, fecha_ingreso_bd, cod_muestra_lubrialerta) VALUES (69, 'Desarrollo y evaluación de lubricantes de motor y aplicaciones industriales.', 'Gerencia Técnica  Calidad de Productos', 'Elba Manrique', 'Marilia Dominguez', 'PDVSA-Intevep, Norte 3, piso 3
', '2009-05-20', '16998-09', '2009-05-20', '101', 'M8', 'Muestra Lubricante', '2009-05-20', '2009-00050L');


--
-- TOC entry 1681 (class 0 OID 246301146)
-- Dependencies: 1244
-- Data for Name: TR001_Cliente; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (31, 'Jessica', 'ccs', '', 'Jessica pe&ntilde;a', '', '', '', '', 'pjessik20@gmail.com', '', '', 92, 0, 0, 0, 15, 0, '', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (25, 'NUEVO CLIENTE', 'la urbina', '', 'yo', '', '', '', '', 'johannasuarez@gmail.com', '', '', 83, 13, 29, 0, 8000, 5, '', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (24, 'Cliente Prueba 3', 'd', '', 'yo', '', '', '', '', 'suarezjcg56@pdvsa.com', '', '8000', 79, 12, 0, 1, 10, 6, '2009-0005', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (22, 'Cliente Prueba', 'Deltaven', '', 'Johanna suarez', '34542', '', '', '', 'velasquezyb@pdvsa.com', 'J-5555', '20000 lts', 69, 12, 21, 1, 10, 1, 'PRUEBA-055', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (21, 'L&oacute;pez Investments', 'Torre Olimpia', '', 'Johanna suarez', '', '', '', '', 'lopezfkx@pdvsa.com', 'J-1111111', '1000', 65, 12, 18, 0, 15, 1, '5426', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (16, 'Wilpro Energy Services', 'Carretera Nacional Matur&iacute;n Punta de Mata a 300 mts. E/S El Taladro, El Furrial - Edo. Monagas.', '0291 6603522-3500', 'Cristina Gonzalez', '', 'Luis Rojas', '', '0291-6603542', 'cristina.--gonzalez@williams.com.ve', '-', '300.000 Lts/a&ntilde;o.', 48, 0, 15, 0, 12, 4, 'ON-MO-09-001-IN', 'Compresora De Gas');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (17, 'DP World Boulton - Pto. Cabello', 'Instituto Puerto Aut&oacute;nomo de Puerto Cabello - &ntilde;rea IV.', '0412-4834761 0412-4800408', 'Edgar Ram&iacute;rez', '', 'Aristides Morales', '', '', 'edgar.--ramirez@dpworld.com', 'J-00000001-0', '30 tambores: 6240 Lts.', 49, 0, 14, 0, 20, 6, 'CE-CA-01-001-IN', 'Operaciopnes Portuarias');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (28, 'penajah', 'pdvsa', '', 'Jessica Pe&ntilde;a', '', '', '', '', 'penajah@pdvsa.com', '', '', 89, 0, 0, 0, 15, 0, '', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (23, 'Cliente Prueba 2', 'barquisimeto', '', 'Johanna suarez', '34542', '', '', '', 'salazarjka@pdvsa.com', '', '50000lts', 71, 9, 22, 0, 15, 3, 'PRUEBA-077', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (29, 'Borrame', 'Cerca de eso y lejos de aquello.', '', 'Thor', '', '', '', '', 'borrame@borrame.com', '', '', 90, 0, 0, 0, 20, 0, '123', 'Testeo');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (33, 'Cliente Prueba 3', 'no se', '', 'yo', '', '', '', '', 'suarezjcg@pdvsa.com', '', '', 97, 12, 29, 0, 8, 2, '888', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (18, 'OXICAR', 'Urb. Industrial Carabobo, transversal nï¿½ 09, calle 87-a nï¿½ 86-141, Valencia - Edo. Carabobo, Codigo Postal 2003', '0241-8322580 0414-4186457', 'Ingeniero Iv&aacute;n Inciarte', '', 'Licenciado Luis P&eacute;rez', '', '0241-8343266', 'mantenimiento--@oxicar.net', '-', '3 tambores (visga 32) y 3 tambores (compresolub 100)', 50, 0, 19, 2, 20, 2, 'CEN-036-1', 'Gases Industriales Y Medicinales');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (30, 'penajah', 'prueba', '', 'Jessica Pe&ntilde;a', '', '', '', '', 'pjessik@gmail.com', '', '', 91, 0, 0, 0, 20, 0, '', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (27, 'NUEVO CLIENTE 3', 'sss', '', 'yo', '', '', '', '', 'suarezjcg@pdvsa.com', '', '', 85, 13, 29, 0, 10, 5, '', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (26, 'NUEVO CLIENTE 2', 'dd', '', 'Cristina Gonzalez', '', '', '', '', 'suarezjcg8@pdvsa.com', '', '', 84, 13, 29, 0, 8, 6, '', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (1, 'S&aacute;las Asociados', 'Berlin Alemania', '4162858797', 'Gerzahim Salas', '4162858797', 'Rasce Salas', '4162858797', '4162858797', 'ocampoa@pdvsa.com', 'J-35484684-7', '87948', 3, 13, 29, 1, 18, 1, '', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (34, 'CP2', 'dd', '', 'yo', '', '', '', '', 'prueba@gmail.com', '', '', 100, 12, 29, 0, 10, 5, '', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (32, 'Jessica', 'caracas', '', 'Jessica peña', '4125889966', '', '', '', 'pjessik1@gmail.com', '', '', 93, 0, 21, 0, 15, 0, '', '');
INSERT INTO "TR001_Cliente" ("id_Cliente", "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Realizadas", "Muestras_Mensuales", "Zona", "Codigo_Empresa", "Actividad_Empresa") VALUES (35, 'Peña Jessica', 'ccs', '', 'Jessica peña', '', '', '', '', 'pjessik1@gmail.com', '', '', 104, 0, 0, 0, 5, 0, '', '');


--
-- TOC entry 1682 (class 0 OID 246301159)
-- Dependencies: 1246
-- Data for Name: TR001_Cuenta_Acceso; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (43, 'Distribuidora WIM C.A.', '6a36a7c37e84fea02a8966a7847e2fed', 'distribuidora_wim', 3, 0, 'd', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (71, 'Cliente Prueba 2', '6a36a7c37e84fea02a8966a7847e2fed
', 'salazarjka', 4, 0, 'c', 0, 0, 0, '3e315d28c12c85cc07e612b9388cff4c', '');
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (55, 'DILUSPESCA', 'e807f1fcf82d132f9bb018ca6738a19f', 'puntopesca', 3, 0, 'd', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (48, 'Wilpro Energy Services', '6a36a7c37e84fea02a8966a7847e2fed', 'cristina.gonzalez', 4, 0, 'c', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (87, 'Nohemy Dominguez', '56bc71d1f8b1768638efa099ed06b7b5', 'dominguezna', 9, 0, 'p', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (49, 'DP World Boulton - Pto. Cabello', '6a36a7c37e84fea02a8966a7847e2fed', 'edgar.ramirez', 4, 0, 'c', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (91, 'penajah', '2d8fe3432fa1fd2168e4b50390ef7f87', 'penajah', 5, 0, 'c', 1, 1, 1, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (79, 'Cliente Prueba 3', '4b6f464c2c22ef46f6ceede427d5153f
', 'suarezjcg56', 4, 0, 'c', 1, 0, 1, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (74, 'SOPORTE AIT', '6a36a7c37e84fea02a8966a7847e2fed', 'soporte_lubrialertas', 8, 0, 'p', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (98, 'Prueba asesor tecnico', '0c1e25954820792ef09a85b0f1ce0e81', 'suarezjcg2', 6, 0, 'p', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (50, 'OXICAR', '6a36a7c37e84fea02a8966a7847e2fed', 'oxicar', 4, 0, 'c', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (88, 'laboratorio', '6a36a7c37e84fea02a8966a7847e2fed', 'personal_laboratorio', 9, 0, 'p', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (103, 'prueba 2', 'e3d11e9c228b50ce020d9f919c0784e5', 'e', 5, 0, 'p', 1, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (82, 'ASESOR COMERCIAL DE PRUEBA', '6a36a7c37e84fea02a8966a7847e2fed', 'suarezjcg57', 5, 0, 'p', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (84, 'NUEVO CLIENTE 2', 'a7a6a99df7b3e178d901159c5fd32d74', 'nuevo_cliente_2', 4, 0, 'c', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (99, 'Alex Ocampo', '03679d24d5613f82629e8780f03e71d7', 'ocampoa', 5, 0, 'p', 1, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (95, 'julio diaz', 'e807f1fcf82d132f9bb018ca6738a19f', 'diazjcx', 5, 0, 'p', 0, 0, 0, '44da01eb805afb2fc45aa1ea970667be', '208b88b93d4b1b9c8f78900bbcfba8ae');
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (104, 'Peña Jessica', 'f678e38e04c348736d30c947955d80c6', 'pjessik2', 4, 0, 'c', 1, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (69, 'Cliente Prueba', '183e64deff6da1190ac43d59c248cf1e', 'velasquezyb', 4, 0, 'c', 0, 0, 0, 'e5105da87a290d8801f28f73aef7973c', '');
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (89, 'penajah', '2d325fd1fd569e29afc267527dad48b3', 'penajah', 6, 0, 'c', 1, 1, 1, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (68, 'Alex Aguado', 'e807f1fcf82d132f9bb018ca6738a19f', 'aguadoae', 5, 0, 'p', 0, 0, 0, '85b527778392e115af85cf0430bd3bd3', 'e89dd480ed9fa8429bf1ecf7f92c95af');
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (92, 'Jessica', '523d0d1b1d81398a9f0c229c6bd04dd8', 'pjessik20', 4, 0, 'c', 1, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (85, 'NUEVO CLIENTE 3', 'ecaa896b07cb05130b38a0fb6f67247c', 'nuevo_cliente_3', 4, 0, 'c', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (76, 'Yexenia Moreno', '01bcfada93d7b090846ed5323507a147', 'morenoym', 6, 0, 'p', 1, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (96, 'yexenia moreno', '15fe13ae876fb7c923f14e917cb2a0ec', 'morenoym', 5, 0, 'p', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (73, 'Asesor T&eacute;cnico', '6a36a7c37e84fea02a8966a7847e2fed', 'suarezjcg55', 6, 0, 'p', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (97, 'Cliente Prueba 3', 'e807f1fcf82d132f9bb018ca6738a19f', 'suarezjcg56', 4, 0, 'c', 0, 0, 0, '6a36a7c37e84fea02a8966a7847e2fed', '6a36a7c37e84fea02a8966a7847e2fed');
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (94, 'Jessica Peña', '4a492c4b152e05bd76349e986c652347', 'penajah', 4, 0, 'p', 0, 1, 0, '418ade03ba0d7e7ba1d9f8549da06952', '23545719c14191000acc7f3345c44129');
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (93, 'Jessica', '79a0ffbcb707d79a1da6e409e6abacad', 'pjessik1', 4, 0, 'c', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (90, 'Borrame', '4b6f464c2c22ef46f6ceede427d5153f', 'borrame', 4, 0, 'c', 1, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (83, 'NUEVO CLIENTE', '34f65c4b854e3ce1fbb01b97b9afa777', 'nuevo_cliente', 4, 0, 'c', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (67, 'Raul Felipe', 'eb29af6e2c52e339192750d58c588760', 'feliper', 6, 0, 'p', 0, 0, 0, '2c616ec9a08999dbdbb4965b5dd0f12e', '');
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (77, 'JCSS', '6a36a7c37e84fea02a8966a7847e2fed', 'johannasuarez', 5, 0, 'p', 1, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (81, 'Distrubuidor de prueba', '6a36a7c37e84fea02a8966a7847e2fed', 'distribuidor.prueba', 3, 0, 'd', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (86, 'Katherine Urbina', 'b48b8dc71b052d5709bbffe543d5baaa', 'urbinaks', 5, 0, 'p', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (3, 'S&aacute;las Asociados', '6a36a7c37e84fea02a8966a7847e2fed', 'gsalas', 4, 0, 'c', 0, 0, 0, '3186167176f5837775b4be03bd8a1948', '60be5a7521ad973f6d7cfa1eeef9d74f');
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (100, 'CP2', '46386afd55de877b91a8af88d32d832d', 'prueba', 4, 0, 'c', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (101, 'PERSONAL PRUEBA', '629cec93f2765aa7b5ef1ec5b2727bce', 'pruebapersonal', 6, 0, 'p', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (102, 'dp', '2800a5d1c0868a8e80b46ad1e58fa97c', 'dp', 3, 0, 'd', 0, 1, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (1, 'Administrador AIT', '6a36a7c37e84fea02a8966a7847e2fed', 'admin', 1, 0, 'p', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (78, 'Administrador Funcional', '6a36a7c37e84fea02a8966a7847e2fed', 'admin_funcional', 1, 0, 'p', 0, 0, 0, NULL, NULL);
INSERT INTO "TR001_Cuenta_Acceso" ("id_Cuenta_Acceso", "Nombre", "Password", "Indicador_PDVSA", "Perfil", "Conectado", "Tipo_Usuario", "Cuenta_Eliminada", "Primer_Acceso", "Bloqueado", "PasswordA", "PasswordB") VALUES (80, 'ASESOR TECNICO DE PRUEBA', '6a36a7c37e84fea02a8966a7847e2fed', 'asesor.tecnico.prueba', 6, 0, 'p', 0, 0, 0, NULL, NULL);


--
-- TOC entry 1683 (class 0 OID 246301167)
-- Dependencies: 1248
-- Data for Name: TR001_Distribuidores; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Distribuidores" ("id_Distribuidor", "Nombres_Apellidos", "Rif", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Persona_Contacto", "id_Cuenta_Acceso", "Email", "Zona", "Fax") VALUES (9, 'Distribuidora WIM C.A.', 'J-15489645-4', '0241-5717243', '0414-4970791 0426-541710', 'Valencia - Edo. Carabobo. C&oacute;digo Postal: 2003.', 'William Izarra', 43, 'distribuidora_wim@cantv.net', 2, '0245-5717243');
INSERT INTO "TR001_Distribuidores" ("id_Distribuidor", "Nombres_Apellidos", "Rif", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Persona_Contacto", "id_Cuenta_Acceso", "Email", "Zona", "Fax") VALUES (12, 'DILUSPESCA', 'J-00000000-4', '0242-3616155', '', 'Pto Cabello-Edo Carabobo. C&oacute;digo postal 2050', 'Yuleiza Peroso', 55, 'puntopesca@cantv.net', 2, '');
INSERT INTO "TR001_Distribuidores" ("id_Distribuidor", "Nombres_Apellidos", "Rif", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Persona_Contacto", "id_Cuenta_Acceso", "Email", "Zona", "Fax") VALUES (13, 'Distrubuidor de prueba', 'J-565555', '', '', 'ddd', 'Yuleiza Peroso', 81, 'distribuidor.prueba@cantv.net', 2, '');
INSERT INTO "TR001_Distribuidores" ("id_Distribuidor", "Nombres_Apellidos", "Rif", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Persona_Contacto", "id_Cuenta_Acceso", "Email", "Zona", "Fax") VALUES (14, 'dp', '1', '', '', 's', 'yo', 102, 'dp@otro.net', 5, '');


--
-- TOC entry 1684 (class 0 OID 246301176)
-- Dependencies: 1250
-- Data for Name: TR001_Empresa_Transporte; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Empresa_Transporte" ("id_Empresa_Transporte", "Nombre_Empresa", "Rif", "Persona_Contacto", "Telefono_Celular", "Telefono_Oficina", "Fax", "Email", "Eliminado") VALUES (1, 'Transportes Felipe C.A', 'J-15345126-9', 'Raul Felipe J.', '0412 - 0458963', '0212 6658963', '57411141', 'feliper@pdvsa.com', 0);


--
-- TOC entry 1685 (class 0 OID 246301184)
-- Dependencies: 1252
-- Data for Name: TR001_Equipo; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (19, 'ROTO FLOW', 'ROTO FLOW', 'P1', 0, 18, 'Turbo Expansor Compresor', 'T1', '20-5E5C', 270, 'Turbo Expansor Compresor');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (20, 'SIAD', 'SIAD', '', 0, 18, 'Compresor de Arg&oacute;n. Cambio de lubricante cada 9600 horas', 'PAR-C', 'TS2/220-B2', 12, 'Compresor De Arg&oacute;n');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (21, 'NORWALK', 'NORWALK', '', 0, 18, 'Compresor de Hidrogeno, cambio de lubricante cada 2880 horas.', 'COM-NOR', 'TR-S3T', 14, 'Compresor De Hidrogeno');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (22, 'SIAD', 'SIAD', '', 0, 18, 'Compresor para oxido nitroso, se cambia el lubricante cada 3600 horas.', 'COM-OXI-01', 'T101/60-2', 12, 'Compresor');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (27, 'Turbocompresor', 'General Electric', '', 0, 16, 'Turbina a gas y compresor centr&iacute;fugo, presentan 12 partes a lubricar las cuales cada 3 meses se toman muestras mensuales para analizar. Cuando se presenta alguna anomal&iacute;a toman muestras en todos los puntos.', '03-KT-1301A', 'MS50002C', 22000, 'Turbocompresor');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (28, 'Turbocompresor', 'Nuevo Pignone', '', 0, 16, 'Turbina a gas y compresor centr&iacute;fugo, presentan 12 partes a lubricar las cuales cada 3 meses se toman muestras mensuales para analizar. Cuando se presenta alguna anomal&iacute;a toman muestras en todos los puntos.', '03-KT-1301B', 'BCL406B/BCL306C/BCL306D', 22000, 'Turbocompresor');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (24, 'Montacargas', 'Clark', '', 0, 17, 'Presentan 4 partes a lubricar: Motor Diesel, Sistema Hidr&aacute;ulico, Diferencial, Caja Reductora. El sistema para el monitoreo ser&aacute; el motor diesel al cual se le hace un cambio de lubricante cada 400 horas', 'MC-05', '9533', 9, 'Montacargas Clark');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (25, 'Liebherr', 'Mercedes', '', 0, 17, 'Presentan 18 partes a lubricar: Motor Diesel, Sistema Hidr&aacute;ulico, Diferencial, Caja Reductora. El sistema para el monitoreo ser&aacute; el motor diesel al cual se le hace un cambio de lubricante cada 400 horas.', 'LIEBHERR', 'OM444LA', 41.5, 'Liebherr');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (23, 'Kalmar', 'Kalmar', '', 0, 17, 'Presentan 4 partes a lubricar: Motor Diesel, Sistema Hidr&aacute;ulico, Diferencial, Caja Reductora. El sistema para el monitoreo ser&aacute; el motor diesel al cual se le hace un cambio de lubricante cada 400 horas.', 'KALMAR-03', '1231VE', 60, 'Reach Stacker Kalmar');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (26, 'RTG', 'RTG', '', 0, 17, 'Presentan 13 partes a lubricar: Motor Diesel, Sistema Hidr&aacute;ulico, Diferencial, Caja Reductora. El sistema para el monitoreo ser&aacute; el motor diesel al cual se le hace un cambio de lubricante cada 400 horas.', 'KTA19-G3', '1461', 81, 'Rtg');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (36, 'Motor Diesel', 'Caterpillar', '', 0, 22, 'Motor Diesel de retroexcavadora', '1405W', '2412', 20, 'Pime');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (35, '444', 'pdvsa', '', 1, 21, 'jmmm', 'AIT-DDD', 'PDSVA SS', 5000, 'Prueba Equipo');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (37, 'Motor Diesel', 'Caterpillar', '', 0, 22, 'Motor Diesel', '1405', '1405', 20, 'Pome');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (40, 'Compresor', 'E001-C', '', 0, 0, 'Prueba', 'E001', 'E001-CC', 15000, 'Compresor E001');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (41, 'H', 'H', '', 1, 34, 'J', 'PRUEBA', 'H', 6000, 'J');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (38, 'Valvulas', 'Marca prueba', '', 1, 1, 'sss', 'E005', 'PRUEBAS', 78, 'Valvulas');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (33, 'Montacargas', 'Clark', 'PII', 0, 1, 'Presenta 4 partes a lubricar: Motor Diesel, Sist. Hidr&aacute;ulico, Diferencial, Caja Reductora. El sistema para el monitoreo ser&aacute; el motor diesel al cual se le hace un cambio de lubricante cada 400 horas.', 'MC1385', '8745', 10, 'Montaclark');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (39, 'V&aacute;lvulas', 'Champion', '', 1, 24, 'ukfuhfjh', 'EQ-3009', 'MODELO IIIIIII', 8000, 'V&aacute;lvulas Champion');
INSERT INTO "TR001_Equipo" ("id_Equipo", "Tipo", "Marca", "Numero_Planta", "Eliminado", "id_Cliente", "Descripcion", "Codigo_Equipo", "Modelo", "Capacidad_Sistema", "Nombre_Equipo") VALUES (34, 'Compresor', 'RotoFlow', 'PI01', 0, 1, 'Turbo Expansor Compresor. El lubricante se cambia cada 9600 horas.', 'TEC-01', '30-5F5D', 250, 'Compresor Expansor');


--
-- TOC entry 1686 (class 0 OID 246301193)
-- Dependencies: 1254
-- Data for Name: TR001_Historial; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13372, '167.134.241.62', '2009-07-10', '10:53:18', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12860, '167.134.5.76', '2009-07-06', '15:25:59', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13212, '167.134.5.76', '2009-07-07', '11:42:18', 33, 1, 'prueba 2');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13244, '167.134.4.108', '2009-07-07', '15:01:11', 25, 78, 'Jessica');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13276, '167.134.4.108', '2009-07-07', '15:09:27', 1, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13308, '167.134.4.108', '2009-07-07', '15:15:31', 45, 78, '82');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13340, '167.134.4.108', '2009-07-07', '15:29:13', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13373, '167.134.241.62', '2009-07-10', '10:53:30', 2, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12861, '167.134.5.76', '2009-07-06', '15:27:59', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13213, '167.134.5.76', '2009-07-07', '11:42:18', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13245, '167.134.4.108', '2009-07-07', '15:01:11', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13277, '167.134.4.108', '2009-07-07', '15:09:34', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13309, '167.134.4.108', '2009-07-07', '15:15:32', 42, 78, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13341, '167.134.4.108', '2009-07-07', '15:29:16', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13374, '167.134.4.108', '2009-07-10', '11:42:30', 1, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12892, '167.134.5.76', '2009-07-06', '16:46:45', 28, 3, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12924, '167.134.5.76', '2009-07-06', '16:51:14', 35, 1, 'Jessica Peña');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12956, '167.134.5.76', '2009-07-06', '16:55:50', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12988, '167.134.5.76', '2009-07-06', '17:03:32', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13020, '167.134.5.76', '2009-07-06', '17:26:49', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13052, '167.134.5.76', '2009-07-06', '17:32:27', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13084, '167.134.5.76', '2009-07-06', '17:35:10', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13116, '167.134.5.76', '2009-07-06', '18:55:08', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13148, '167.134.5.76', '2009-07-06', '19:24:28', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13180, '167.134.5.76', '2009-07-06', '20:00:49', 21, 80, 'Cliente: ');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13375, '167.134.4.108', '2009-07-10', '11:44:25', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12862, '167.134.5.76', '2009-07-06', '15:27:59', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13214, '167.134.5.76', '2009-07-07', '11:42:23', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13246, '167.134.4.108', '2009-07-07', '15:01:12', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13278, '167.134.4.108', '2009-07-07', '15:09:35', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13310, '167.134.4.108', '2009-07-07', '15:15:32', 42, 78, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13342, '167.134.4.108', '2009-07-07', '15:29:17', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12863, '167.134.5.76', '2009-07-06', '15:28:01', 2, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12893, '167.134.5.76', '2009-07-06', '16:46:46', 10, 3, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12925, '167.134.5.76', '2009-07-06', '16:51:17', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12957, '167.134.5.76', '2009-07-06', '16:55:51', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12989, '167.134.5.76', '2009-07-06', '17:03:32', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13021, '167.134.5.76', '2009-07-06', '17:26:50', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13053, '167.134.5.76', '2009-07-06', '17:32:27', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13085, '167.134.5.76', '2009-07-06', '17:35:11', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13117, '167.134.5.76', '2009-07-06', '18:55:12', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13149, '167.134.5.76', '2009-07-06', '19:24:31', 2, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13181, '167.134.5.76', '2009-07-06', '20:00:53', 21, 80, 'Cliente: S&aacute;las Asociados');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13215, '167.134.5.76', '2009-07-07', '11:42:26', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13247, '167.134.4.108', '2009-07-07', '15:01:29', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13279, '167.134.4.108', '2009-07-07', '15:09:44', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13311, '167.134.4.108', '2009-07-07', '15:17:43', 42, 78, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13343, '167.134.4.108', '2009-07-07', '15:29:27', 30, 82, 'Compresor Expansor');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12894, '167.134.5.76', '2009-07-06', '16:46:47', 10, 3, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12926, '167.134.5.76', '2009-07-06', '16:51:18', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12958, '167.134.5.76', '2009-07-06', '16:55:54', 21, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12990, '167.134.5.76', '2009-07-06', '17:03:33', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13022, '167.134.5.76', '2009-07-06', '17:26:51', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13054, '167.134.5.76', '2009-07-06', '17:33:31', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13086, '167.134.5.76', '2009-07-06', '17:35:18', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13118, '167.134.5.76', '2009-07-06', '18:55:31', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13150, '167.134.5.76', '2009-07-06', '19:25:25', 1, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13182, '167.134.5.76', '2009-07-06', '20:00:54', 21, 80, 'Cliente: S&aacute;las Asociados');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13216, '167.134.5.76', '2009-07-07', '11:42:27', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13248, '167.134.4.108', '2009-07-07', '15:01:33', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13280, '167.134.4.108', '2009-07-07', '15:09:47', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13312, '167.134.4.108', '2009-07-07', '15:17:44', 42, 78, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13344, '167.134.4.108', '2009-07-07', '15:29:28', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13376, '167.134.4.108', '2009-07-10', '11:44:26', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12895, '167.134.5.76', '2009-07-06', '16:46:50', 10, 3, 'Consult&oacute;Estatus de Solicitud: SL00032');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12927, '167.134.5.76', '2009-07-06', '16:52:18', 33, 1, 'PERSONAL PRUEBA');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12959, '167.134.5.76', '2009-07-06', '16:55:54', 21, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12991, '167.134.5.76', '2009-07-06', '17:03:34', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13023, '167.134.5.76', '2009-07-06', '17:26:52', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13055, '167.134.5.76', '2009-07-06', '17:33:32', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13087, '167.134.5.76', '2009-07-06', '17:35:19', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13119, '167.134.5.76', '2009-07-06', '18:55:32', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13151, '167.134.5.76', '2009-07-06', '19:25:28', 10, 3, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13183, '167.134.5.76', '2009-07-06', '20:00:57', 17, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12864, '167.134.5.76', '2009-07-06', '15:52:50', 1, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12896, '167.134.5.76', '2009-07-06', '16:46:51', 10, 3, 'Consult&oacute;Estatus de Solicitud: SL00032');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12928, '167.134.5.76', '2009-07-06', '16:52:18', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12960, '167.134.5.76', '2009-07-06', '16:57:13', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12992, '167.134.5.76', '2009-07-06', '17:03:36', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13024, '167.134.5.76', '2009-07-06', '17:26:57', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13056, '167.134.5.76', '2009-07-06', '17:33:34', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13088, '167.134.5.76', '2009-07-06', '17:35:25', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13120, '167.134.5.76', '2009-07-06', '18:55:46', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13152, '167.134.5.76', '2009-07-06', '19:25:29', 10, 3, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13184, '167.134.5.76', '2009-07-06', '20:00:57', 17, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12865, '167.134.5.76', '2009-07-06', '15:52:55', 17, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12897, '167.134.5.76', '2009-07-06', '16:46:54', 10, 3, 'Modificaci&oacute;n del estatus de la Solicitud :SL00032 a: Entrega de Muestra a Empresa Transportista.');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12929, '167.134.5.76', '2009-07-06', '16:52:18', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12961, '167.134.5.76', '2009-07-06', '16:57:13', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12993, '167.134.5.76', '2009-07-06', '17:03:37', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13025, '167.134.5.76', '2009-07-06', '17:26:57', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13057, '167.134.5.76', '2009-07-06', '17:33:34', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13089, '167.134.5.76', '2009-07-06', '17:35:25', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13121, '167.134.5.76', '2009-07-06', '18:55:47', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13153, '167.134.5.76', '2009-07-06', '19:26:24', 13, 3, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13185, '167.134.5.76', '2009-07-06', '20:00:59', 22, 80, 'Cliente :Cliente Prueba');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12866, '167.134.5.76', '2009-07-06', '15:52:55', 17, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12898, '167.134.5.76', '2009-07-06', '16:46:54', 10, 3, 'Consult&oacute;Estatus de Solicitud: SL00032');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12930, '167.134.5.76', '2009-07-06', '16:52:21', 42, 1, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12962, '167.134.5.76', '2009-07-06', '16:57:17', 21, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12994, '167.134.5.76', '2009-07-06', '17:03:38', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13026, '167.134.5.76', '2009-07-06', '17:26:59', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13058, '167.134.5.76', '2009-07-06', '17:33:38', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13090, '167.134.5.76', '2009-07-06', '17:35:27', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13122, '167.134.5.76', '2009-07-06', '18:55:51', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13154, '167.134.5.76', '2009-07-06', '19:26:25', 13, 3, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13186, '167.134.5.76', '2009-07-06', '20:01:00', 22, 80, 'Cliente :Cliente Prueba');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13217, '167.134.5.76', '2009-07-07', '11:42:37', 36, 1, 'prueba 2');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13249, '167.134.4.108', '2009-07-07', '15:02:13', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13281, '167.134.4.108', '2009-07-07', '15:09:54', 30, 78, 'Compresor Expansor');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13313, '167.134.4.108', '2009-07-07', '15:18:48', 37, 78, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13345, '167.134.4.108', '2009-07-07', '15:29:28', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12867, '167.134.5.76', '2009-07-06', '15:52:58', 9, 80, 'Consult&oacute; listado de solicitudes por recomendar');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12899, '167.134.5.76', '2009-07-06', '16:46:54', 10, 3, 'Consult&oacute;Estatus de Solicitud: SL00032');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12931, '167.134.5.76', '2009-07-06', '16:52:21', 42, 1, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12963, '167.134.5.76', '2009-07-06', '16:57:17', 21, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12995, '167.134.5.76', '2009-07-06', '17:03:39', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13027, '167.134.5.76', '2009-07-06', '17:27:00', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13059, '167.134.5.76', '2009-07-06', '17:33:39', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13091, '167.134.5.76', '2009-07-06', '17:35:28', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13123, '167.134.5.76', '2009-07-06', '18:55:52', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13155, '167.134.5.76', '2009-07-06', '19:26:29', 10, 3, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13187, '167.134.5.76', '2009-07-06', '20:01:17', 13, 80, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13377, '167.134.4.108', '2009-07-10', '11:44:27', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12868, '167.134.5.76', '2009-07-06', '15:52:59', 9, 80, 'Consult&oacute; listado de solicitudes por recomendar');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12900, '167.134.5.76', '2009-07-06', '16:46:55', 17, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12932, '167.134.5.76', '2009-07-06', '16:52:28', 43, 1, 'Z');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12964, '167.134.5.76', '2009-07-06', '16:57:27', 21, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12996, '167.134.5.76', '2009-07-06', '17:03:44', 2, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13028, '167.134.5.76', '2009-07-06', '17:31:35', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13060, '167.134.5.76', '2009-07-06', '17:33:54', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13092, '167.134.5.76', '2009-07-06', '17:35:30', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13124, '167.134.5.76', '2009-07-06', '18:56:18', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13156, '167.134.5.76', '2009-07-06', '19:26:30', 10, 3, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13188, '167.134.5.76', '2009-07-06', '20:01:18', 13, 80, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13378, '167.134.4.108', '2009-07-10', '11:44:30', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13218, '167.134.5.76', '2009-07-07', '11:42:37', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13250, '167.134.4.108', '2009-07-07', '15:02:13', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13282, '167.134.4.108', '2009-07-07', '15:09:55', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13314, '167.134.4.108', '2009-07-07', '15:18:48', 37, 78, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13346, '167.134.4.108', '2009-07-07', '15:30:46', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13379, '167.134.4.108', '2009-07-10', '11:44:30', 42, 78, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12833, '167.134.5.76', '2009-07-06', '15:24:30', 1, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12869, '167.134.5.76', '2009-07-06', '15:53:01', 9, 80, 'Consult&oacute; propiedades de la muestra :2009-00064L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12901, '167.134.5.76', '2009-07-06', '16:46:56', 17, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12933, '167.134.5.76', '2009-07-06', '16:52:28', 42, 1, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12965, '167.134.5.76', '2009-07-06', '16:57:28', 21, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12997, '167.134.5.76', '2009-07-06', '17:25:28', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13029, '167.134.5.76', '2009-07-06', '17:31:35', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13061, '167.134.5.76', '2009-07-06', '17:33:54', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13093, '167.134.5.76', '2009-07-06', '17:35:31', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13125, '167.134.5.76', '2009-07-06', '18:56:19', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13157, '167.134.5.76', '2009-07-06', '19:26:46', 2, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13189, '167.134.5.76', '2009-07-06', '20:01:19', 2, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12834, '167.134.5.76', '2009-07-06', '15:24:32', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12870, '167.134.5.76', '2009-07-06', '15:53:01', 9, 80, 'Consult&oacute; propiedades de la muestra :2009-00064L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12902, '167.134.5.76', '2009-07-06', '16:46:59', 18, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12934, '167.134.5.76', '2009-07-06', '16:52:29', 42, 1, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12966, '167.134.5.76', '2009-07-06', '16:57:34', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12998, '167.134.5.76', '2009-07-06', '17:25:31', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13030, '167.134.5.76', '2009-07-06', '17:31:38', 21, 1, 'Cliente: ');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13062, '167.134.5.76', '2009-07-06', '17:33:57', 18, 1, 'Cliente: S&aacute;las Asociados');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13094, '167.134.5.76', '2009-07-06', '17:35:35', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13126, '167.134.5.76', '2009-07-06', '18:56:36', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13158, '167.134.5.76', '2009-07-06', '19:26:56', 1, 82, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13380, '167.134.4.108', '2009-07-10', '11:44:32', 42, 78, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12871, '167.134.5.76', '2009-07-06', '15:53:17', 9, 80, 'Realiz&oacute; recomendaci&oacute;n a la muestra: 2009-00064L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12903, '167.134.5.76', '2009-07-06', '16:47:00', 18, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12935, '167.134.5.76', '2009-07-06', '16:52:32', 37, 1, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12967, '167.134.5.76', '2009-07-06', '16:57:34', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12999, '167.134.5.76', '2009-07-06', '17:25:32', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13031, '167.134.5.76', '2009-07-06', '17:31:39', 21, 1, 'Cliente: ');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13063, '167.134.5.76', '2009-07-06', '17:33:57', 18, 1, 'Cliente: S&aacute;las Asociados');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13095, '167.134.5.76', '2009-07-06', '17:35:38', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13127, '167.134.5.76', '2009-07-06', '18:56:37', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13159, '167.134.5.76', '2009-07-06', '19:27:20', 10, 82, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13381, '167.134.4.108', '2009-07-10', '11:44:52', 46, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12835, '167.134.5.76', '2009-07-06', '15:24:33', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12872, '167.134.5.76', '2009-07-06', '15:53:25', 2, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12904, '167.134.5.76', '2009-07-06', '16:47:05', 2, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12936, '167.134.5.76', '2009-07-06', '16:52:34', 37, 1, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12968, '167.134.5.76', '2009-07-06', '16:57:37', 22, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13000, '167.134.5.76', '2009-07-06', '17:25:35', 21, 1, 'Cliente: ');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13032, '167.134.5.76', '2009-07-06', '17:31:43', 21, 1, 'Cliente: S&aacute;las Asociados');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13064, '167.134.5.76', '2009-07-06', '17:34:03', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13096, '167.134.5.76', '2009-07-06', '17:35:50', 2, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13128, '167.134.5.76', '2009-07-06', '19:21:36', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13160, '167.134.5.76', '2009-07-06', '19:27:20', 10, 82, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13382, '167.134.4.108', '2009-07-10', '11:44:53', 46, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12836, '167.134.5.76', '2009-07-06', '15:24:37', 10, 80, 'Imprimir Listado  Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12873, '167.134.5.76', '2009-07-06', '15:53:33', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12905, '167.134.5.76', '2009-07-06', '16:47:14', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12937, '167.134.5.76', '2009-07-06', '16:53:00', 38, 1, 'dp');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12969, '167.134.5.76', '2009-07-06', '16:57:39', 22, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13001, '167.134.5.76', '2009-07-06', '17:25:36', 21, 1, 'Cliente: ');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13033, '167.134.5.76', '2009-07-06', '17:31:43', 21, 1, 'Cliente: S&aacute;las Asociados');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13065, '167.134.5.76', '2009-07-06', '17:34:03', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13097, '167.134.5.76', '2009-07-06', '18:07:52', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13129, '167.134.5.76', '2009-07-06', '19:21:43', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13161, '167.134.5.76', '2009-07-06', '19:27:36', 10, 82, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12837, '167.134.5.76', '2009-07-06', '15:24:37', 10, 80, 'Imprimir Listado  Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12874, '167.134.5.76', '2009-07-06', '15:53:35', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12906, '167.134.5.76', '2009-07-06', '16:47:16', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12938, '167.134.5.76', '2009-07-06', '16:53:01', 37, 1, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12970, '167.134.5.76', '2009-07-06', '16:57:51', 2, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13002, '167.134.5.76', '2009-07-06', '17:25:40', 21, 1, 'Cliente: Array');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13034, '167.134.5.76', '2009-07-06', '17:31:46', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13066, '167.134.5.76', '2009-07-06', '17:34:07', 19, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13098, '167.134.5.76', '2009-07-06', '18:09:10', 23, 1, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13130, '167.134.5.76', '2009-07-06', '19:21:58', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13162, '167.134.5.76', '2009-07-06', '19:27:37', 10, 82, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12838, '167.134.5.76', '2009-07-06', '15:24:40', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12875, '167.134.5.76', '2009-07-06', '15:53:48', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12907, '167.134.5.76', '2009-07-06', '16:47:17', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12939, '167.134.5.76', '2009-07-06', '16:53:01', 37, 1, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12971, '167.134.5.76', '2009-07-06', '17:02:15', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13003, '167.134.5.76', '2009-07-06', '17:25:41', 21, 1, 'Cliente: Array');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13035, '167.134.5.76', '2009-07-06', '17:31:46', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13067, '167.134.5.76', '2009-07-06', '17:34:08', 19, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13099, '167.134.5.76', '2009-07-06', '18:09:11', 23, 1, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13131, '167.134.5.76', '2009-07-06', '19:21:58', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13163, '167.134.5.76', '2009-07-06', '19:27:49', 2, 82, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13219, '167.134.5.76', '2009-07-07', '11:42:38', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13251, '167.134.4.108', '2009-07-07', '15:05:16', 27, 78, 'Peña Jessica');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13283, '167.134.4.108', '2009-07-07', '15:09:55', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13315, '167.134.4.108', '2009-07-07', '15:19:12', 37, 78, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13347, '167.134.4.108', '2009-07-07', '15:30:47', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13383, '167.134.4.108', '2009-07-10', '11:45:27', 17, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13220, '167.134.5.76', '2009-07-07', '11:42:45', 42, 1, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13252, '167.134.4.108', '2009-07-07', '15:05:17', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13284, '167.134.4.108', '2009-07-07', '15:10:03', 30, 78, 'Compresor Expansor');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13316, '167.134.4.108', '2009-07-07', '15:19:13', 37, 78, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13348, '167.134.4.108', '2009-07-07', '15:30:49', 10, 82, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13384, '167.134.4.108', '2009-07-10', '11:45:28', 17, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12839, '167.134.5.76', '2009-07-06', '15:24:41', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13221, '167.134.5.76', '2009-07-07', '11:42:46', 42, 1, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13253, '167.134.4.108', '2009-07-07', '15:05:18', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13285, '167.134.4.108', '2009-07-07', '15:10:03', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13317, '167.134.4.108', '2009-07-07', '15:19:22', 37, 78, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13349, '167.134.4.108', '2009-07-07', '15:30:50', 10, 82, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12876, '167.134.5.76', '2009-07-06', '15:53:49', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12908, '167.134.5.76', '2009-07-06', '16:47:27', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12940, '167.134.5.76', '2009-07-06', '16:53:06', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12972, '167.134.5.76', '2009-07-06', '17:02:16', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13004, '167.134.5.76', '2009-07-06', '17:25:47', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13036, '167.134.5.76', '2009-07-06', '17:31:48', 22, 1, 'Cliente :Cliente Prueba');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13068, '167.134.5.76', '2009-07-06', '17:34:11', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13100, '167.134.5.76', '2009-07-06', '18:09:21', 2, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13132, '167.134.5.76', '2009-07-06', '19:22:15', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13164, '167.134.5.76', '2009-07-06', '19:54:16', 1, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13190, '167.134.241.62', '2009-07-07', '10:36:49', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13222, '167.134.5.76', '2009-07-07', '11:54:57', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13254, '167.134.4.108', '2009-07-07', '15:05:51', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13286, '167.134.4.108', '2009-07-07', '15:10:04', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13318, '167.134.4.108', '2009-07-07', '15:19:23', 37, 78, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13350, '167.134.4.108', '2009-07-07', '15:32:53', 13, 82, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13385, '167.134.4.108', '2009-07-10', '11:45:31', 18, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13191, '167.134.241.62', '2009-07-07', '10:40:13', 11, 1, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13223, '167.134.5.76', '2009-07-07', '11:55:02', 37, 1, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13255, '167.134.4.108', '2009-07-07', '15:05:52', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13287, '167.134.4.108', '2009-07-07', '15:12:09', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13319, '167.134.4.108', '2009-07-07', '15:19:53', 46, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13351, '167.134.4.108', '2009-07-07', '15:32:54', 13, 82, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12840, '167.134.5.76', '2009-07-06', '15:24:41', 10, 80, 'Consult&oacute;Estatus de Solicitud: SL00035');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12877, '167.134.5.76', '2009-07-06', '15:53:52', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12909, '167.134.5.76', '2009-07-06', '16:47:28', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12941, '167.134.5.76', '2009-07-06', '16:53:07', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12973, '167.134.5.76', '2009-07-06', '17:02:17', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13005, '167.134.5.76', '2009-07-06', '17:25:47', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13037, '167.134.5.76', '2009-07-06', '17:31:49', 22, 1, 'Cliente :Cliente Prueba');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13069, '167.134.5.76', '2009-07-06', '17:34:12', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13101, '167.134.5.76', '2009-07-06', '18:20:43', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13133, '167.134.5.76', '2009-07-06', '19:22:15', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13165, '167.134.5.76', '2009-07-06', '19:54:21', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13192, '167.134.241.62', '2009-07-07', '10:40:29', 11, 1, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13224, '167.134.5.76', '2009-07-07', '11:55:03', 37, 1, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13256, '167.134.4.108', '2009-07-07', '15:06:04', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13288, '167.134.4.108', '2009-07-07', '15:12:10', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13320, '167.134.4.108', '2009-07-07', '15:19:54', 46, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13352, '167.134.4.108', '2009-07-07', '15:34:51', 2, 82, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12841, '167.134.5.76', '2009-07-06', '15:24:42', 10, 80, 'Consult&oacute;Estatus de Solicitud: SL00035');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12878, '167.134.5.76', '2009-07-06', '15:53:53', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12910, '167.134.5.76', '2009-07-06', '16:47:55', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12942, '167.134.5.76', '2009-07-06', '16:53:11', 18, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12974, '167.134.5.76', '2009-07-06', '17:02:37', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13006, '167.134.5.76', '2009-07-06', '17:25:51', 22, 1, 'Cliente :Array');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13038, '167.134.5.76', '2009-07-06', '17:31:53', 22, 1, 'Cliente :Cliente Prueba');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13070, '167.134.5.76', '2009-07-06', '17:34:16', 20, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13102, '167.134.5.76', '2009-07-06', '18:22:45', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13134, '167.134.5.76', '2009-07-06', '19:22:26', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13166, '167.134.5.76', '2009-07-06', '19:54:22', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13193, '167.134.241.62', '2009-07-07', '10:40:53', 11, 1, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13225, '167.134.5.76', '2009-07-07', '11:55:12', 37, 1, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13257, '167.134.4.108', '2009-07-07', '15:06:05', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13289, '167.134.4.108', '2009-07-07', '15:12:22', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13321, '167.134.4.108', '2009-07-07', '15:19:58', 46, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13353, '167.134.4.108', '2009-07-07', '15:35:01', 1, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13386, '167.134.4.108', '2009-07-10', '11:45:32', 18, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12842, '167.134.5.76', '2009-07-06', '15:24:44', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13194, '167.134.241.62', '2009-07-07', '10:42:11', 11, 1, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13226, '167.134.5.76', '2009-07-07', '11:55:12', 37, 1, 'Consulta de Lista de Distribuidores');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13258, '167.134.4.108', '2009-07-07', '15:06:10', 29, 78, 'Peña Jessica');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13290, '167.134.4.108', '2009-07-07', '15:12:23', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13322, '167.134.4.108', '2009-07-07', '15:19:59', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13354, '167.134.4.108', '2009-07-07', '15:35:05', 11, 78, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13387, '167.134.4.108', '2009-07-10', '11:45:35', 18, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12843, '167.134.5.76', '2009-07-06', '15:24:45', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13195, '167.134.5.76', '2009-07-07', '11:37:03', 1, 82, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13227, '167.134.5.76', '2009-07-07', '11:59:55', 2, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13259, '167.134.4.108', '2009-07-07', '15:06:10', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13291, '167.134.4.108', '2009-07-07', '15:12:23', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13323, '167.134.4.108', '2009-07-07', '15:19:59', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13355, '167.134.4.108', '2009-07-07', '15:35:07', 11, 78, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13388, '167.134.4.108', '2009-07-10', '11:45:35', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12844, '167.134.5.76', '2009-07-06', '15:24:47', 13, 80, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13196, '167.134.5.76', '2009-07-07', '11:37:28', 23, 82, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13228, '167.134.4.108', '2009-07-07', '14:57:50', 1, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13260, '167.134.4.108', '2009-07-07', '15:06:11', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13292, '167.134.4.108', '2009-07-07', '15:12:27', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13324, '167.134.4.108', '2009-07-07', '15:21:28', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13356, '167.134.4.108', '2009-07-07', '15:35:33', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12879, '167.134.5.76', '2009-07-06', '15:53:55', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12911, '167.134.5.76', '2009-07-06', '16:47:55', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12943, '167.134.5.76', '2009-07-06', '16:53:11', 18, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12975, '167.134.5.76', '2009-07-06', '17:02:38', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13007, '167.134.5.76', '2009-07-06', '17:25:51', 22, 1, 'Cliente :Array');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13039, '167.134.5.76', '2009-07-06', '17:31:54', 22, 1, 'Cliente :Cliente Prueba');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13071, '167.134.5.76', '2009-07-06', '17:34:16', 20, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13103, '167.134.5.76', '2009-07-06', '18:22:45', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13135, '167.134.5.76', '2009-07-06', '19:22:28', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13167, '167.134.5.76', '2009-07-06', '19:54:31', 2, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13197, '167.134.5.76', '2009-07-07', '11:37:29', 23, 82, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13229, '167.134.4.108', '2009-07-07', '14:57:57', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13261, '167.134.4.108', '2009-07-07', '15:06:49', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13293, '167.134.4.108', '2009-07-07', '15:12:28', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13325, '167.134.4.108', '2009-07-07', '15:21:31', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13357, '167.134.4.108', '2009-07-07', '15:35:34', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12845, '167.134.5.76', '2009-07-06', '15:24:47', 13, 80, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12880, '167.134.5.76', '2009-07-06', '15:53:55', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12912, '167.134.5.76', '2009-07-06', '16:48:55', 23, 1, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12944, '167.134.5.76', '2009-07-06', '16:53:19', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12976, '167.134.5.76', '2009-07-06', '17:02:49', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13008, '167.134.5.76', '2009-07-06', '17:26:01', 22, 1, 'Cliente :Array');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13040, '167.134.5.76', '2009-07-06', '17:31:55', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13072, '167.134.5.76', '2009-07-06', '17:34:51', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13104, '167.134.5.76', '2009-07-06', '18:22:57', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13136, '167.134.5.76', '2009-07-06', '19:23:52', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13168, '167.134.5.76', '2009-07-06', '19:55:41', 1, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13198, '167.134.5.76', '2009-07-07', '11:40:24', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13230, '167.134.4.108', '2009-07-07', '14:57:58', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13262, '167.134.4.108', '2009-07-07', '15:06:50', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13294, '167.134.4.108', '2009-07-07', '15:12:31', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13326, '167.134.4.108', '2009-07-07', '15:21:33', 2, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13358, '167.134.4.108', '2009-07-07', '15:35:42', 36, 78, 'Alex Ocampo');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13389, '167.134.4.108', '2009-07-10', '11:45:36', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12846, '167.134.5.76', '2009-07-06', '15:25:00', 13, 80, 'Consult&oacute; propiedades de la muestra : 2009-00026L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12847, '167.134.5.76', '2009-07-06', '15:25:01', 13, 80, 'Consult&oacute; Recomendaciones de la Muestra: 2009-00026L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13199, '167.134.5.76', '2009-07-07', '11:40:24', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13231, '167.134.4.108', '2009-07-07', '14:58:27', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13263, '167.134.4.108', '2009-07-07', '15:07:03', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13295, '167.134.4.108', '2009-07-07', '15:12:32', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13327, '167.134.4.108', '2009-07-07', '15:26:23', 1, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13359, '167.134.4.108', '2009-07-07', '15:35:42', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12881, '167.134.5.76', '2009-07-06', '15:54:09', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12913, '167.134.5.76', '2009-07-06', '16:48:55', 23, 1, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12945, '167.134.5.76', '2009-07-06', '16:53:20', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12977, '167.134.5.76', '2009-07-06', '17:02:49', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13009, '167.134.5.76', '2009-07-06', '17:26:02', 22, 1, 'Cliente :Array');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13041, '167.134.5.76', '2009-07-06', '17:31:56', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13073, '167.134.5.76', '2009-07-06', '17:34:52', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13105, '167.134.5.76', '2009-07-06', '18:22:58', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13137, '167.134.5.76', '2009-07-06', '19:23:53', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13169, '167.134.5.76', '2009-07-06', '19:55:45', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13200, '167.134.5.76', '2009-07-07', '11:40:45', 32, 82, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13232, '167.134.4.108', '2009-07-07', '14:58:28', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13264, '167.134.4.108', '2009-07-07', '15:07:04', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13296, '167.134.4.108', '2009-07-07', '15:14:12', 30, 78, 'Compresor Expansor');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13328, '167.134.4.108', '2009-07-07', '15:26:39', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13360, '167.134.4.108', '2009-07-07', '15:35:46', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13390, '167.134.4.108', '2009-07-10', '11:45:37', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12848, '167.134.5.76', '2009-07-06', '15:25:01', 13, 80, 'Consult&oacute; propiedades de la muestra : 2009-00026L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12849, '167.134.5.76', '2009-07-06', '15:25:01', 13, 80, 'Consult&oacute; Recomendaciones de la Muestra: 2009-00026L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13201, '167.134.5.76', '2009-07-07', '11:40:46', 32, 82, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13233, '167.134.4.108', '2009-07-07', '14:58:29', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13265, '167.134.4.108', '2009-07-07', '15:07:23', 2, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13297, '167.134.4.108', '2009-07-07', '15:14:13', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13329, '167.134.4.108', '2009-07-07', '15:26:40', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13361, '167.134.4.108', '2009-07-07', '15:35:47', 11, 78, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12850, '167.134.5.76', '2009-07-06', '15:25:16', 13, 80, 'Modific&oacute; Recomendacion de la muestra: 2009-00026L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12882, '167.134.5.76', '2009-07-06', '15:54:10', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12914, '167.134.5.76', '2009-07-06', '16:49:57', 27, 1, 'CP2');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12946, '167.134.5.76', '2009-07-06', '16:53:23', 19, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12978, '167.134.5.76', '2009-07-06', '17:02:52', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13010, '167.134.5.76', '2009-07-06', '17:26:13', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13042, '167.134.5.76', '2009-07-06', '17:32:06', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13074, '167.134.5.76', '2009-07-06', '17:34:54', 22, 1, 'Cliente :Cliente Prueba');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13106, '167.134.5.76', '2009-07-06', '18:25:25', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13138, '167.134.5.76', '2009-07-06', '19:24:07', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13170, '167.134.5.76', '2009-07-06', '19:55:46', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13391, '167.134.4.108', '2009-07-10', '11:45:37', 11, 78, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12851, '167.134.5.76', '2009-07-06', '15:25:17', 13, 80, 'Consult&oacute; propiedades de la muestra : 2009-00026L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12852, '167.134.5.76', '2009-07-06', '15:25:17', 13, 80, 'Consult&oacute; Recomendaciones de la Muestra: 2009-00026L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13202, '167.134.5.76', '2009-07-07', '11:40:52', 32, 82, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13234, '167.134.4.108', '2009-07-07', '14:58:31', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13266, '167.134.4.108', '2009-07-07', '15:08:07', 1, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13298, '167.134.4.108', '2009-07-07', '15:14:13', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13330, '167.134.4.108', '2009-07-07', '15:26:58', 2, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13362, '167.134.4.108', '2009-07-07', '15:35:49', 11, 78, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13392, '167.134.4.108', '2009-07-10', '11:45:39', 11, 78, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12853, '167.134.5.76', '2009-07-06', '15:25:17', 13, 80, 'Consult&oacute; propiedades de la muestra : 2009-00026L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12854, '167.134.5.76', '2009-07-06', '15:25:17', 13, 80, 'Consult&oacute; Recomendaciones de la Muestra: 2009-00026L');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13203, '167.134.5.76', '2009-07-07', '11:40:53', 32, 82, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13235, '167.134.4.108', '2009-07-07', '14:59:31', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13267, '167.134.4.108', '2009-07-07', '15:08:11', 28, 80, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13299, '167.134.4.108', '2009-07-07', '15:14:21', 30, 78, 'Compresor Expansor');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13331, '167.134.4.108', '2009-07-07', '15:27:56', 1, 82, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13363, '167.134.4.108', '2009-07-07', '15:39:59', 2, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13393, '167.134.4.108', '2009-07-10', '11:45:41', 11, 78, 'Consulta del listado de acciones');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12883, '167.134.5.76', '2009-07-06', '15:54:16', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12915, '167.134.5.76', '2009-07-06', '16:49:58', 23, 1, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12947, '167.134.5.76', '2009-07-06', '16:53:23', 19, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12979, '167.134.5.76', '2009-07-06', '17:02:53', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13011, '167.134.5.76', '2009-07-06', '17:26:13', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13043, '167.134.5.76', '2009-07-06', '17:32:06', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13075, '167.134.5.76', '2009-07-06', '17:34:56', 22, 1, 'Cliente :Cliente Prueba');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13107, '167.134.5.76', '2009-07-06', '18:25:25', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13139, '167.134.5.76', '2009-07-06', '19:24:07', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13171, '167.134.5.76', '2009-07-06', '19:56:24', 13, 80, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12884, '167.134.5.76', '2009-07-06', '15:54:17', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12916, '167.134.5.76', '2009-07-06', '16:49:58', 23, 1, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12948, '167.134.5.76', '2009-07-06', '16:53:27', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12980, '167.134.5.76', '2009-07-06', '17:03:00', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13012, '167.134.5.76', '2009-07-06', '17:26:26', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13044, '167.134.5.76', '2009-07-06', '17:32:11', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13076, '167.134.5.76', '2009-07-06', '17:34:58', 22, 1, 'Cliente :');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13108, '167.134.5.76', '2009-07-06', '18:25:37', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13140, '167.134.5.76', '2009-07-06', '19:24:13', 29, 1, 'J');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13172, '167.134.5.76', '2009-07-06', '19:56:25', 13, 80, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12855, '167.134.5.76', '2009-07-06', '15:25:20', 2, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12885, '167.134.5.76', '2009-07-06', '16:46:00', 1, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12917, '167.134.5.76', '2009-07-06', '16:50:00', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12949, '167.134.5.76', '2009-07-06', '16:53:27', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12981, '167.134.5.76', '2009-07-06', '17:03:01', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13013, '167.134.5.76', '2009-07-06', '17:26:27', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13045, '167.134.5.76', '2009-07-06', '17:32:12', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13077, '167.134.5.76', '2009-07-06', '17:34:59', 22, 1, 'Cliente :');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13109, '167.134.5.76', '2009-07-06', '18:25:38', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13141, '167.134.5.76', '2009-07-06', '19:24:13', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13173, '167.134.5.76', '2009-07-06', '20:00:24', 13, 80, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13394, '167.134.4.108', '2009-07-10', '11:45:41', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12886, '167.134.5.76', '2009-07-06', '16:46:22', 16, 3, 'SL00040');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12918, '167.134.5.76', '2009-07-06', '16:50:00', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12950, '167.134.5.76', '2009-07-06', '16:53:30', 21, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12982, '167.134.5.76', '2009-07-06', '17:03:06', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13014, '167.134.5.76', '2009-07-06', '17:26:29', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13046, '167.134.5.76', '2009-07-06', '17:32:13', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13078, '167.134.5.76', '2009-07-06', '17:35:01', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13110, '167.134.5.76', '2009-07-06', '18:26:37', 2, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13142, '167.134.5.76', '2009-07-06', '19:24:13', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13174, '167.134.5.76', '2009-07-06', '20:00:24', 13, 80, 'Consult&oacute; lista de resultado de solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12856, '167.134.5.76', '2009-07-06', '15:25:28', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12887, '167.134.5.76', '2009-07-06', '16:46:25', 10, 3, 'Imprimir Listado  Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12919, '167.134.5.76', '2009-07-06', '16:50:51', 31, 1, 'J');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12951, '167.134.5.76', '2009-07-06', '16:53:31', 21, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12983, '167.134.5.76', '2009-07-06', '17:03:07', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13015, '167.134.5.76', '2009-07-06', '17:26:30', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13047, '167.134.5.76', '2009-07-06', '17:32:13', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13079, '167.134.5.76', '2009-07-06', '17:35:01', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13111, '167.134.5.76', '2009-07-06', '18:53:23', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13143, '167.134.5.76', '2009-07-06', '19:24:17', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13175, '167.134.5.76', '2009-07-06', '20:00:43', 9, 80, 'Consult&oacute; listado de solicitudes por recomendar');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12857, '167.134.5.76', '2009-07-06', '15:25:33', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12888, '167.134.5.76', '2009-07-06', '16:46:26', 10, 3, 'Imprimir Listado  Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12920, '167.134.5.76', '2009-07-06', '16:50:51', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12952, '167.134.5.76', '2009-07-06', '16:53:48', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12984, '167.134.5.76', '2009-07-06', '17:03:13', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13016, '167.134.5.76', '2009-07-06', '17:26:34', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13048, '167.134.5.76', '2009-07-06', '17:32:14', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13080, '167.134.5.76', '2009-07-06', '17:35:02', 21, 1, 'Cliente: ');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13112, '167.134.5.76', '2009-07-06', '18:53:26', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13144, '167.134.5.76', '2009-07-06', '19:24:18', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13176, '167.134.5.76', '2009-07-06', '20:00:43', 9, 80, 'Consult&oacute; listado de solicitudes por recomendar');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12858, '167.134.5.76', '2009-07-06', '15:25:34', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12889, '167.134.5.76', '2009-07-06', '16:46:32', 28, 3, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12921, '167.134.5.76', '2009-07-06', '16:50:51', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12953, '167.134.5.76', '2009-07-06', '16:53:48', 17, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12985, '167.134.5.76', '2009-07-06', '17:03:14', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13017, '167.134.5.76', '2009-07-06', '17:26:35', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13049, '167.134.5.76', '2009-07-06', '17:32:15', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13081, '167.134.5.76', '2009-07-06', '17:35:03', 21, 1, 'Cliente: ');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13113, '167.134.5.76', '2009-07-06', '18:53:27', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13145, '167.134.5.76', '2009-07-06', '19:24:22', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13177, '167.134.5.76', '2009-07-06', '20:00:45', 17, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12859, '167.134.5.76', '2009-07-06', '15:25:59', 11, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12890, '167.134.5.76', '2009-07-06', '16:46:33', 28, 3, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12922, '167.134.5.76', '2009-07-06', '16:50:54', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12954, '167.134.5.76', '2009-07-06', '16:53:50', 22, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12986, '167.134.5.76', '2009-07-06', '17:03:26', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13018, '167.134.5.76', '2009-07-06', '17:26:46', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13050, '167.134.5.76', '2009-07-06', '17:32:18', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13082, '167.134.5.76', '2009-07-06', '17:35:07', 21, 1, 'Cliente: DP World Boulton - Pto. Cabello');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13114, '167.134.5.76', '2009-07-06', '18:54:11', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13146, '167.134.5.76', '2009-07-06', '19:24:23', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13178, '167.134.5.76', '2009-07-06', '20:00:46', 17, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13395, '167.134.4.108', '2009-07-10', '11:45:43', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13204, '167.134.5.76', '2009-07-07', '11:41:25', 32, 82, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13236, '167.134.4.108', '2009-07-07', '14:59:32', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13268, '167.134.4.108', '2009-07-07', '15:08:12', 28, 80, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13300, '167.134.4.108', '2009-07-07', '15:14:22', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13332, '167.134.4.108', '2009-07-07', '15:28:06', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13364, '167.134.5.76', '2009-07-10', '09:47:40', 1, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13396, '167.134.4.108', '2009-07-10', '11:47:19', 2, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13205, '167.134.5.76', '2009-07-07', '11:41:25', 32, 82, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13237, '167.134.4.108', '2009-07-07', '15:00:03', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13269, '167.134.4.108', '2009-07-07', '15:08:13', 28, 80, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13301, '167.134.4.108', '2009-07-07', '15:14:23', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13333, '167.134.4.108', '2009-07-07', '15:28:10', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13365, '167.134.5.76', '2009-07-10', '09:47:59', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13397, '167.134.4.108', '2009-07-10', '11:47:31', 1, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13206, '167.134.5.76', '2009-07-07', '11:41:29', 32, 82, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13238, '167.134.4.108', '2009-07-07', '15:00:04', 32, 78, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13270, '167.134.4.108', '2009-07-07', '15:08:18', 28, 80, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13302, '167.134.4.108', '2009-07-07', '15:14:27', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13334, '167.134.4.108', '2009-07-07', '15:28:44', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13366, '167.134.5.76', '2009-07-10', '09:48:22', 23, 1, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13398, '167.134.4.108', '2009-07-10', '11:50:46', 2, 78, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13207, '167.134.5.76', '2009-07-07', '11:41:29', 32, 82, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13239, '167.134.4.108', '2009-07-07', '15:00:34', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13271, '167.134.4.108', '2009-07-07', '15:08:18', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13303, '167.134.4.108', '2009-07-07', '15:14:28', 28, 78, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13335, '167.134.4.108', '2009-07-07', '15:28:44', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13367, '167.134.5.76', '2009-07-10', '09:48:29', 42, 3, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13399, '167.134.5.76', '2009-07-14', '13:33:04', 1, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13208, '167.134.5.76', '2009-07-07', '11:41:31', 2, 82, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13240, '167.134.4.108', '2009-07-07', '15:00:35', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13272, '167.134.4.108', '2009-07-07', '15:08:19', 10, 80, 'Consult&oacute; Listado de Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13304, '167.134.4.108', '2009-07-07', '15:15:13', 42, 78, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13336, '167.134.4.108', '2009-07-07', '15:28:53', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13368, '167.134.241.62', '2009-07-10', '10:34:37', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13400, '167.134.5.76', '2009-07-14', '13:33:20', 17, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13209, '167.134.5.76', '2009-07-07', '11:41:39', 1, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13241, '167.134.4.108', '2009-07-07', '15:00:51', 25, 78, 'Jessica');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13273, '167.134.4.108', '2009-07-07', '15:08:24', 10, 80, 'Imprimir Listado  Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13305, '167.134.4.108', '2009-07-07', '15:15:13', 42, 78, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13337, '167.134.4.108', '2009-07-07', '15:28:54', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13369, '167.134.241.62', '2009-07-10', '10:34:42', 2, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13401, '167.134.5.76', '2009-07-14', '13:33:21', 17, 3, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13210, '167.134.5.76', '2009-07-07', '11:41:40', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13242, '167.134.4.108', '2009-07-07', '15:00:51', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13274, '167.134.4.108', '2009-07-07', '15:08:25', 10, 80, 'Imprimir Listado  Solicitudes');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13306, '167.134.4.108', '2009-07-07', '15:15:25', 42, 78, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13338, '167.134.4.108', '2009-07-07', '15:29:12', 30, 82, 'Compresor Expansor');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13370, '170.179.240.30', '2009-07-10', '10:46:58', 1, 68, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13402, '167.134.5.76', '2009-07-14', '13:33:24', 22, 3, 'Cliente :S&aacute;las Asociados');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13211, '167.134.5.76', '2009-07-07', '11:41:41', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13243, '167.134.4.108', '2009-07-07', '15:00:52', 23, 78, 'Consult&oacute; Listado de Clientes del Sistema');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13275, '167.134.4.108', '2009-07-07', '15:09:14', 2, 80, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13307, '167.134.4.108', '2009-07-07', '15:15:26', 42, 78, 'Consulta del Listado de Productos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13339, '167.134.4.108', '2009-07-07', '15:29:12', 28, 82, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13371, '170.179.240.30', '2009-07-10', '10:47:10', 2, 68, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13403, '167.134.5.76', '2009-07-14', '13:33:24', 22, 3, 'Cliente :S&aacute;las Asociados');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12891, '167.134.5.76', '2009-07-06', '16:46:44', 28, 3, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12923, '167.134.5.76', '2009-07-06', '16:50:54', 32, 1, 'Consulta del listado del Personal');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12955, '167.134.5.76', '2009-07-06', '16:53:51', 22, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (12987, '167.134.5.76', '2009-07-06', '17:03:27', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13019, '167.134.5.76', '2009-07-06', '17:26:46', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13051, '167.134.5.76', '2009-07-06', '17:32:19', 11, 1, 'Busqueda Avanzada');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13083, '167.134.5.76', '2009-07-06', '17:35:08', 21, 1, 'Cliente: DP World Boulton - Pto. Cabello');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13115, '167.134.5.76', '2009-07-06', '18:54:12', 3, 1, NULL);
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13147, '167.134.5.76', '2009-07-06', '19:24:27', 28, 1, 'Consulta de listado de equipos');
INSERT INTO "TR001_Historial" ("id_Historial", "IP", "Fecha", "Hora", "id_Accion", "id_Cuenta_Acceso", detalle_accion) VALUES (13179, '167.134.5.76', '2009-07-06', '20:00:49', 21, 80, 'Cliente: ');


--
-- TOC entry 1687 (class 0 OID 246301201)
-- Dependencies: 1256
-- Data for Name: TR001_Metodo; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (1, 1, 'SGLG-IT-078/ASTM-D5762', 'Determinaci&oacute;n de valores de los componentes del lubricantes', 'Margarita Navas de Masciangioli');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (105, 51, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (106, 51, 'LUB-014/ASTM-D 4928', 'Determianción de agua en lubricantes por titulación Karl Fisher', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (107, 51, 'LUB-015/Laboratorio-Sin número', 'Crepitación', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (108, 51, 'LUB-017/ASTM-D 6595', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (109, 51, 'LUB-019/ASTM-D 974', 'Número ácido colorimétrico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (110, 52, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (111, 52, 'LUB-010/ASTM-D 1500', 'Color ASTM', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (112, 52, 'LUB-020/COVENIN-361', 'Punto de ebullición seco', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (113, 52, 'LUB-021/COVENIN-361', 'Determinación de pH en fluidos para frenos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (114, 53, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (2, 1, 'LUB-001/ASTM-D445-06', 'Viscosidad cinem&aacute;tica para l&iacute;quidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (20, 2, 'LUB-001/ASTM-D445-06', 'Viscosidad cinem&aacute;tica para l&iacute;quidos...', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (150, 66, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para láquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (115, 54, 'LUB-001/ASTM-D445-06', 'Determinación de pH en fluidos para frenos
', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (151, 66, 'LUB-017/ASTM-D 6595', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (152, 66, 'LUB-018/ASTM-D 664', 'Número Básico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (153, 66, 'LUB-014/ASTM-D 4928', 'Determinación de agua en lubricantes por titulación Karl Fisher', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (154, 66, 'LUB-014/ASTM-D 4928', 'Prueba de Hollín', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (155, 66, 'LUB-015/Laboratorio-Sin número', 'Crepitación', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (174, 70, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para láquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (175, 70, 'LUB-017/ASTM-D 6595', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (176, 70, 'LUB-018/ASTM-D 664', 'Número Básico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (177, 70, 'LUB-014/ASTM-D 4928', 'Determinación de agua en lubricantes por titulación Karl Fisher', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (156, 67, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para láquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (157, 67, 'LUB-017/ASTM-D 6595', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (158, 67, 'LUB-018/ASTM-D 664', 'Número Básico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (159, 67, 'LUB-014/ASTM-D 4928', 'Determinación de agua en lubricantes por titulación Karl Fisher', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (160, 67, 'LUB-014/ASTM-D 4928', 'Prueba de Hollín', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (161, 67, 'LUB-015/Laboratorio-Sin número', 'Crepitación', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (178, 70, 'LUB-014/ASTM-D 4928', 'Prueba de Hollín', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (179, 70, 'LUB-015/Laboratorio-Sin número', 'Crepitación', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (83, 43, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (84, 43, 'LUB-014/ASTM-D 4928', 'Determianción de agua en lubricantes por titulación Karl Fisher', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (85, 43, 'LUB-015/Laboratorio-Sin número', 'Crepitación', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (86, 43, 'LUB-017/ASTM-D 6595', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (87, 43, 'LUB-019/ASTM-D 974', 'Número ácido colorimétrico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (88, 44, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (89, 44, 'LUB-010/ASTM-D 1500', 'Color ASTM', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (90, 44, 'LUB-020/COVENIN-361', 'Punto de ebullición seco', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (91, 44, 'LUB-021/COVENIN-361', 'Determinación de pH en fluidos para frenos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (92, 45, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (93, 46, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (116, 56, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (117, 56, 'LUB-010/ASTM-D 1500', 'Color ASTM', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (124, 59, 'Asfalto-005/ASTM-D5', 'Penetración de materiales asfálticos', 'Carlos Andres Villegas Rojas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (125, 60, 'Asfalto-002/ASTM-D2171', 'Viscosidad de asfaltos por viscosímetro capilar de vacío (Viscosidad Absoluta)', 'Carlos Andres Villegas Rojas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (126, 60, 'Asfalto-004/ASTM-D36', 'Punto de ablandamiento de asfaltos', 'Carlos Andres Villegas Rojas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (127, 60, 'Asfalto-005/ASTM-D5', 'Penetración de materiales asfálticos', 'Carlos Andres Villegas Rojas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (128, 61, 'Asfalto-002/ASTM-D2171', 'Viscosidad de asfaltos por viscosímetro capilar de vacío (Viscosidad Absoluta)', 'Carlos Andres Villegas Rojas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (129, 61, 'Asfalto-004/ASTM-D36', 'Punto de ablandamiento de asfaltos', 'Carlos Andres Villegas Rojas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (130, 61, 'Asfalto-005/ASTM-D5', 'Penetración de materiales asfálticos', 'Carlos Andres Villegas Rojas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (131, 62, 'Labco-005/ASTM-D 5191', 'Determinación de la presión de vapor en productos del petróleo', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (132, 62, 'Labco-006/ASTM-D 86', 'Destilación de productos del petróleo a presión atmosférica', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (133, 62, 'Labco-009/ASTM-D 525', 'Estabilidad a la oxidación para gasolinas', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (134, 62, 'Labco-016/ASTM-D 381', 'Determinacion del contenido de gomas en combustibles por evaporación Jet', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (135, 62, 'Labco-023/INT-COM-01', 'Determinación de adulteración en gasolinas de 95 octanos', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (136, 62, 'LabCFR-001/ASTM-2699', 'Determinación del RON', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (137, 62, 'LabCFR-002/ASTM-2700', 'Determinación del número octano motor de motores de ignición por chispa', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (138, 63, 'Labco-005/ASTM-D 5191', 'Determinación de la presión de vapor en productos del petróleo', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (139, 63, 'Labco-006/ASTM-D 86', 'Destilación de productos del petróleo a presión atmosférica', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (140, 63, 'Labco-009/ASTM-D 525', 'Estabilidad a la oxidación para gasolinas', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (141, 63, 'Labco-016/ASTM-D 381', 'Determinacion del contenido de gomas en combustibles por evaporación Jet', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (142, 63, 'Labco-023/INT-COM-01', 'Determinación de adulteración en gasolinas de 95 octanos', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (143, 63, 'LabCFR-001/ASTM-2699', 'Determinación del RON', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (144, 63, 'LabCFR-002/ASTM-2700', 'Determinación del número octano motor de motores de ignición por chispa', 'Luis Oberto Jimenez Armas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (118, 56, 'LUB-020/COVENIN-361', 'Determinación de agua en lubricantes por titulación Karl Fisher
', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (119, 56, 'LUB-021/COVENIN-361', 'Crepitación
', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (120, 56, 'LUB-001/ASTM-D445-06', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica
', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (121, 56, 'LUB-001/ASTM-D445-06', 'Número ácido colorimétrico
', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (122, 56, 'LUB-001/ASTM-D445-07
', 'Número Básico', 'Umberto Anzalone
');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (123, 56, 'LUB-001/ASTM-D445-08
', 'Prueba de Hollín', 'Carlos Andres Villegas Rojas');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (94, 47, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (95, 47, 'LUB-014/ASTM-D 4928', 'Determianción de agua en lubricantes por titulación Karl Fisher', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (96, 47, 'LUB-015/Laboratorio-Sin número', 'Crepitación', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (97, 47, 'LUB-017/ASTM-D 6595', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (98, 47, 'LUB-019/ASTM-D 974', 'Número ácido colorimétrico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (99, 48, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (100, 48, 'LUB-010/ASTM-D 1500', 'Color ASTM', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (101, 48, 'LUB-020/COVENIN-361', 'Punto de ebullición seco', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (102, 48, 'LUB-021/COVENIN-361', 'Determinación de pH en fluidos para frenos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (103, 49, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (104, 50, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (73, 39, 'LUB-014/ASTM-D 4928', 'Determinación de agua en lubricantes por titulación Karl Fisher', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (145, 64, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (162, 68, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para láquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (147, 64, 'LUB-017/ASTM-D 6595', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (148, 64, 'LUB-018/ASTM-D 664', 'Número ácido potenciométrico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (72, 39, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (163, 68, 'LUB-017/ASTM-D 6595', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (74, 39, 'LUB-015/Laboratorio-Sin número', 'Crepitación', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (75, 39, 'LUB-017/ASTM-D 6595', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (76, 39, 'LUB-019/ASTM-D 974', 'Número ácido colorimétrico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (77, 40, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (78, 40, 'LUB-010/ASTM-D 1500', 'Color ASTM', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (79, 40, 'LUB-020/COVENIN-361', 'Punto de ebullición seco', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (80, 40, 'LUB-021/COVENIN-361', 'Determinación de pH en fluidos para frenos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (81, 41, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (82, 42, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para líquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (149, 64, 'LUB-019/ASTM-D 974', 'Número ácido colorimétrico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (146, 64, 'LUB-014/ASTM-D 4928', 'Determinación de agua en lubricantes por titulación Karl Fisher', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (164, 68, 'LUB-018/ASTM-D 664', 'Número Básico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (165, 68, 'LUB-014/ASTM-D 4928', 'Determinación de agua en lubricantes por titulación Karl Fisher', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (166, 68, 'LUB-014/ASTM-D 4928', 'Prueba de Hollín', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (167, 68, 'LUB-015/Laboratorio-Sin número', 'Crepitación', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (168, 69, 'LUB-001/ASTM-D445-06', 'Viscosidad cinemática para láquidos transparentes y opacos', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (169, 69, 'LUB-017/ASTM-D 6595', 'Determinación de metales de desgaste y contaminantes en lubricantes usados por espectrometría de emisión atómica', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (170, 69, 'LUB-018/ASTM-D 664', 'Número Básico', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (171, 69, 'LUB-014/ASTM-D 4928', 'Determinación de agua en lubricantes por titulación Karl Fisher', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (172, 69, 'LUB-014/ASTM-D 4928', 'Prueba de Hollín', 'Umberto Anzalone');
INSERT INTO "TR001_Metodo" (id_metodo, id_certificado, codigo_metodo, nombre, aprobado) VALUES (173, 69, 'LUB-015/Laboratorio-Sin número', 'Crepitación', 'Umberto Anzalone');


--
-- TOC entry 1688 (class 0 OID 246301209)
-- Dependencies: 1258
-- Data for Name: TR001_Modulos; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (1, 'Administraci&oacute;n de Datos', NULL, 0);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (2, 'Clientes Deltaven', 'cliente', 1);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (3, 'Equipos', 'equipo', 1);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (4, 'Personal', 'personal', 1);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (5, 'Productos', 'producto', 1);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (6, 'Distribuidores', 'distribuidor', 1);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (7, 'Transportistas', 'transporte', 1);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (8, 'Solicitudes', NULL, 0);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (9, 'Crear Solicitud', 'solicitud', 8);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (10, 'Consultar Solicitud', NULL, 8);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (11, 'Listado Solicitudes', 'listsol', 10);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (12, 'Agregar Recomendaci&oacute;n', 'agrecoment', 10);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (14, 'Retransmitir Datos', NULL, 0);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (15, 'Datos de Solicitudes', 'datsol', 14);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (16, 'Resultados de an&aacute;lisis', 'resultado', 14);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (17, 'Reportes', 'reporte', 0);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (18, 'Perfiles', 'perfil', 0);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (19, 'Auditoria', 'auditoria', 0);
INSERT INTO "TR001_Modulos" ("id_Modulos", "Nombre_Modulos", "Referencia_Modulos", "Modulo_Padre") VALUES (20, 'Resultados Solicitudes', 'resultsol', 10);


--
-- TOC entry 1689 (class 0 OID 246301214)
-- Dependencies: 1260
-- Data for Name: TR001_Muestra; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (2, '10', '3600', '---', 33, 2, NULL, 0, '2008-00001L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (9, '181', '1456', '---', 33, 6, NULL, 0, '2008-00008L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (10, '182', '---', '123', 34, 6, NULL, 0, '2008-00009L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (11, '163', '789', '---', 33, 6, NULL, 0, '2008-00010L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (12, '70', '---', '1245', 34, 6, NULL, 0, '2008-00011L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (14, '184', '6789', '---', 34, 6, NULL, 0, '2008-00013L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (15, '180', '7890', '---', 33, 6, NULL, 0, '2008-00014L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (16, '13', '8907', '---', 34, 6, NULL, 0, '2008-00015L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (41, '6', '8000', '---', 33, 19, NULL, 0, '2009-00040L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (18, '203', '3455', '---', 34, 6, NULL, 0, '2008-00017L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (55, '62', '200', '---', 33, 30, NULL, 0, '2009-00054L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (20, '181', '36500', '---', 33, 8, NULL, 0, '2008-00019L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (40, '26', '10000', '---', 34, 18, 'De los resultados obtenidos se pueden emitir las siguientes recomendaciones: Numero b&aacute;sico muy bajo', 1, '2009-00039L', 1, 67);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (22, '182', '456', '---', 33, 10, NULL, 0, '2009-00021L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (23, '180', '456', '---', 33, 11, NULL, 0, '2009-00022L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (3, '42', '9600', '---', 34, 2, 'Es bueno saber que voy a recomendar', 1, '2008-00002L', 1, 53);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (4, '42', '3600', '---', 33, 3, 'Presento sus propiedades medidas dentro de los limites establecidos, aunque se noto presencia de Cobre (Cu).', 1, '2008-00003L', 1, 53);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (44, '82', '5000', '---', 33, 21, NULL, 0, '2009-00043L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (5, '42', '---', '12000', 34, 4, 'sfsdfsdf', 1, '2008-00004L', 1, 53);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (7, '10', '9600', '---', 34, 5, 'gerzahim salas', 1, '2008-00006L', 1, 53);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (45, '82', '8200', '---', 33, 22, NULL, 0, '2009-00044L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (21, '193', '7854', '---', 33, 7, 'Muestra contaminada con un alto contenido de agua(m&aacute;x 0.2% motores de combusti&oacute;n interna), la aditivacion del producto corresponde a la identificacion de la muestra
', 1, '2008-00020L', 1, 73);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (24, '187', '87', '---', 33, 12, NULL, 0, '2009-00023L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (25, '181', '7844', '---', 33, 13, NULL, 0, '2009-00024L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (26, '126', '---', '4200', 34, 14, NULL, 0, '2009-00025L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (46, '70', '80', '---', 33, 23, NULL, 0, '2009-00045L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (28, '82', '55555', '---', 34, 15, 'Muestra contaminada con un alto contenido de agua(m&aacute;x 0.2% motores de combusti&oacute;n interna), la aditivacion del producto corresponde a la identificacion de la muestra
', 1, '2009-00027L', 1, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (47, '82', '950', '---', 33, 24, NULL, 0, '2009-00046L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (48, '71', '955', '---', 33, 25, NULL, 0, '2009-00047L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (49, '82', '785', '---', 33, 26, NULL, 0, '2009-00048L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (6, '10', '9600', '---', 33, 4, 'Hola esto es una prueba', 1, '2008-00005L', 1, 53);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (8, '42', '1500', '---', 33, 5, 'Presento sus propiedades medidas dentro de los li...', 0, '2008-00007L', 0, 53);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (13, '65', '5678', '---', 34, 6, 'Vamos a ver si me recomienda el asesor', 0, '2008-00012L', 0, 53);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (29, '181', '1000', '---', 33, 16, 'Muestra contaminada con un alto contenido de agua(m&aacute;x 0.2% motores de combusti&oacute;n interna), la aditivacion del producto corresponde a la identificacion de la muestra
', 1, '2009-00028L', 1, 73);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (30, '102', '2000', '---', 34, 16, 'Muestra contaminada con un alto contenido de agua(m&aacute;x 0.2% motores de combusti&oacute;n interna), la aditivacion del producto corresponde a la identificacion de la muestra
', 1, '2009-00029L', 1, 73);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (51, '10', '700', '---', 37, 27, 'condiciones normales', 1, '2009-00050L', 1, 67);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (52, '54', '200', '---', 38, 28, NULL, 0, '2009-00051L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (53, '120', '300', '---', 34, 28, NULL, 0, '2009-00052L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (50, '16', '500', '---', 36, 27, 'condiciones normales, cambio', 1, '2009-00049L', 1, 67);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (56, '69', '---', '200', 34, 31, NULL, 0, '2009-00055L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (39, '11', '5500', '---', 34, 17, 'recomendacion 78954. johanna suarez', 1, '2009-00038L', 1, 73);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (54, '213', '700', '---', 39, 29, NULL, 0, '2009-00053L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (57, '71', '200', '---', 33, 32, NULL, 0, '2009-00056L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (58, '32', '500', '---', 34, 33, NULL, 0, '2009-00057L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (59, '82', '100', '---', 38, 34, NULL, 0, '2009-00058L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (17, '209', '4356', '---', 34, 6, 'Muestra contaminada con un alto contenido de agua(m&aacute;x 0.2% motores de combusti&oacute;n interna), la aditivacion del producto corresponde a la identificacion de la muestra
', 1, '2008-00016L', 1, 67);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (60, '71', '---', '5000', 33, 35, NULL, 0, '2009-00059L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (61, '83', '500', '---', 33, 36, NULL, 0, '2009-00060L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (62, '70', '5000', '---', 36, 37, NULL, 0, '2009-00061L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (63, '82', '---', '10000', 33, 38, NULL, 0, '2009-00062L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (19, '179', '96510', '---', 34, 9, 'eeeeeeeeeepa...', 1, '2008-00018L', 1, 80);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (27, '88', '44444', '---', 34, 15, 'no se ven los resultados', 1, '2009-00026L', 1, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (43, '11', '10000', '---', 36, 20, 'Ok', 1, '2009-00042L', 1, 67);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (64, '82', '---', '5250', 33, 39, NULL, 0, '2009-00063L', 0, NULL);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (42, '10', '15000', '---', 37, 20, 'Ok ok.', 1, '2009-00041L', 1, 67);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (65, '20', '---', '5200', 34, 40, 'recomendacion de prueba', 1, '2009-00064L', 1, 80);
INSERT INTO "TR001_Muestra" ("id_Muestra", "Producto_Grado", "Horas", km, "id_Equipo", "id_Solicitud", "Recomendacion", "Status_Muestra", "Cod_Muestra", "Carga_Parametros", "id_Cuenta_Acceso") VALUES (66, '82', '8000', '---', 34, 41, NULL, 0, '2009-00065L', 0, NULL);


--
-- TOC entry 1690 (class 0 OID 246301222)
-- Dependencies: 1262
-- Data for Name: TR001_Parametros; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Parametros" ("id_Parametros", "id_Muestra", "C", "FE", "CR", "PB", "CU", "SN", "AL", "NI", "AG", "MN", "SI", "B", "NA", "K", "MG", "CA", "BA", "P", "ZN", "MO", "TI", "V", "GLYCOL", "VISC100", "SOOT", "TAN", "WATER") VALUES (1, 4, 'N', 11, 1, 2, 21, 0, 2, 0, 0, 0, 10, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NEG', '13.19', NULL, NULL, NULL);
INSERT INTO "TR001_Parametros" ("id_Parametros", "id_Muestra", "C", "FE", "CR", "PB", "CU", "SN", "AL", "NI", "AG", "MN", "SI", "B", "NA", "K", "MG", "CA", "BA", "P", "ZN", "MO", "TI", "V", "GLYCOL", "VISC100", "SOOT", "TAN", "WATER") VALUES (2, 3, 'N', 8, 4, 4, 12, 1, 1, 4, 1, 0, 5, 10, 3, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'NEG', '12.19', '', '', '');
INSERT INTO "TR001_Parametros" ("id_Parametros", "id_Muestra", "C", "FE", "CR", "PB", "CU", "SN", "AL", "NI", "AG", "MN", "SI", "B", "NA", "K", "MG", "CA", "BA", "P", "ZN", "MO", "TI", "V", "GLYCOL", "VISC100", "SOOT", "TAN", "WATER") VALUES (3, 5, 'C', 12, 3, 2, 5, 3, 3, 4, 0, 0, 8, 136, 9, 0, 1235, 909, 0, 1211, 1401, 1, 0, 0, 'NEG', '15.78', '3.8', 'N/A', NULL);
INSERT INTO "TR001_Parametros" ("id_Parametros", "id_Muestra", "C", "FE", "CR", "PB", "CU", "SN", "AL", "NI", "AG", "MN", "SI", "B", "NA", "K", "MG", "CA", "BA", "P", "ZN", "MO", "TI", "V", "GLYCOL", "VISC100", "SOOT", "TAN", "WATER") VALUES (4, 7, 'N', 10, 0, 1, 5, 0, 2, 0, 0, 0, 7, 123, 2, 0, 1025, 678, 0, 1258, 1254, 1, 0, 0, 'NGE', '15.19', '4.4', '7.0', NULL);


--
-- TOC entry 1691 (class 0 OID 246301230)
-- Dependencies: 1264
-- Data for Name: TR001_Perfiles; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Perfiles" ("id_Perfil", "Nombre_Perfil", "Perfil_Eliminado", "tipo_Cliente", "tipo_Personal") VALUES (1, 'Administrador', 0, false, false);
INSERT INTO "TR001_Perfiles" ("id_Perfil", "Nombre_Perfil", "Perfil_Eliminado", "tipo_Cliente", "tipo_Personal") VALUES (4, 'Perfil Clientes', 0, false, false);
INSERT INTO "TR001_Perfiles" ("id_Perfil", "Nombre_Perfil", "Perfil_Eliminado", "tipo_Cliente", "tipo_Personal") VALUES (5, 'Perfil Asesor Comercial', 0, false, false);
INSERT INTO "TR001_Perfiles" ("id_Perfil", "Nombre_Perfil", "Perfil_Eliminado", "tipo_Cliente", "tipo_Personal") VALUES (6, 'Perfil Asesor Tecnico', 0, false, false);
INSERT INTO "TR001_Perfiles" ("id_Perfil", "Nombre_Perfil", "Perfil_Eliminado", "tipo_Cliente", "tipo_Personal") VALUES (3, 'Perfil Distribuidor', 0, false, false);
INSERT INTO "TR001_Perfiles" ("id_Perfil", "Nombre_Perfil", "Perfil_Eliminado", "tipo_Cliente", "tipo_Personal") VALUES (9, 'Laboratorio de Calidad', 0, false, false);


--
-- TOC entry 1692 (class 0 OID 246301235)
-- Dependencies: 1266
-- Data for Name: TR001_Personal; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (33, 'Jessica Peña', 1111, '', '', 'Caracas', '5', 'Mendozab', 'penajah@pkk.com', 94, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (21, 'Alex Aguado', 11222222, '40169', '', 'Deltaven. Valencia', '1', 'Rafael Escalona', 'aguadoae@pdvsa.com', 68, 2);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (35, 'yexenia moreno', 15791720, '', '', 'campi&ntilde;a', '1', 'carlos mujica', 'morenoym@pdvsa.com', 96, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (20, 'Raul Felipe', 7888888, '40102', '', 'Deltaven - Valencia - Edo. Carabobo', '2', 'Rafael Escalona', 'suarezjcg@pdvsa.com
', 67, 2);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (25, 'Yexenia Moreno', 88, '', '', 'TORRE SUR', '2', 'CARLOS MUJICA', 'morenoym@pdvsa.com', 76, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (36, 'Prueba asesor tecnico', 5, '', '', 'x', '2', '4', 'suarezjcg2@pdvsa.com', 98, 5);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (26, 'JCSS', 4444, '', '', 'torre olimpia', '1', 'william palomino', 'johannasuarez@gmail.com', 77, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (34, 'julio d&iacute;az', 12567234, '', '', 'la campi&ntilde;a', '1', 'carlos mujica', 'diazjcx@pdvsa.com', 95, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (31, 'Nohemy Dominguez', 8, '', '', 'intevep', '7', 'Elba Manrique', 'dominguezna@pdvsa.com', 87, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (32, 'laboratorio', 2, '', '', '2', '7', 'johanna suarez', 'personal_laboratorio@pdvsa.com', 88, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (23, 'Asesor T&eacute;cnico', 88888, '', '', 'ssss', '2', 's', 'suarezjcg55@pdvsa.com', 73, 5);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (38, 'PERSONAL PRUEBA', 1, '', '', '1', '2', 'YO', 'pruebapersonal@pdvsa.com', 101, 5);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (39, 'prueba 2', 5, '', '', '5', '2', 'e', 'e@otro.com', 103, 5);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (1, 'Administrador AIT', 15003191, '2122784502', '', 'La Urbina. Caracas.', '4', 'William Palomino', 'admin@pdvsa.com', 1, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (37, 'Alex Ocampo', 123456, '', '', 'ccs', '1', 'Mendozab', 'ocampoa@p.com', 99, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (27, 'Administrador Funcional', 55555555, '', '', 'f', '5', 'Rafael Escalona', 'suarezjcg@pdvsa.com', 78, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (28, 'ASESOR TECNICO DE PRUEBA', 5646464, '', '', 'LA URBINA', '2', 'WILFREDO LE&Oacute;N', 'suarezjcg@pdvsa.com', 80, 2);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (29, 'ASESOR COMERCIAL DE PRUEBA', 12345678, '', '', 'la urbina', '1', 'WILFREDO LE&Oacute;N', 'suarezjcg@pdvsa.com
', 82, 5);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (24, 'SOPORTE AIT', 4444, '', '', 'intevep', '6', 'Benjamin mendoza', 'lubrialertaspool@pdvsa.com', 74, 1);
INSERT INTO "TR001_Personal" ("id_Personal", "Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") VALUES (30, 'Katherine Urbina', 77777, '', '', 'la urbina', '1', 'WILFREDO LE&Oacute;N', 'urbinaks@pdvsa.com', 86, 2);


--
-- TOC entry 1693 (class 0 OID 246301244)
-- Dependencies: 1268
-- Data for Name: TR001_Productos_Deltaven; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (87, 'COMPRESOLUB ISO 100', 'Lubricante - Aceites para compresores de aire.', '82', 1);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (7, 'SUPRA MX SAE 15W-40', 'Lubricante - Aceite para motor a gasolina y diesel.', '2', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (8, 'SUPRA MX SAE 20W-50', 'Lubricante - Aceite para motor a gasolina y diesel.', '3', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (9, 'SUPRA PREMIUM SAE 10W-30', 'Lubricante - Aceite para motor a gasolina y diesel.', '4', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (10, 'SUPRA PREMIUM SAE 15W-40', 'Lubricante - Aceite para motor a gasolina y diesel.', '5', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (11, 'SUPRA PREMIUM SAE 20W-50', 'Lubricante - Aceite para motor a gasolina y diesel.', '6', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (12, 'EXTRA MULTIGRADO SAE 20W-50', 'Lubricante - Aceite para motor a gasolina y diesel.', '7', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (13, 'EXTRA MONOGRADO SAE 40', 'Lubricante - Aceite para motor a gasolina y diesel.', '8', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (14, 'EXTRA MONOGRADO SAE 50', 'Lubricante - Aceite para motor a gasolina y diesel.', '9', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (15, 'ULTRADIESEL SAE 15W-40', 'Lubricante - Aceite para motor a gasolina y diesel.', '10', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (16, 'MAXIDIESEL EO-K/2 SAE 40', 'Lubricante - Aceite para motor a gasolina y diesel.', '11', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (17, 'MAXIDIESEL PLUS SAE 10W', 'Lubricante - Aceite para motor a gasolina y diesel.', '12', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (18, 'MAXIDIESEL PLUS SAE 30W', 'Lubricante - Aceite para motor a gasolina y diesel.', '13', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (19, 'MAXIDIESEL PLUS SAE 40W', 'Lubricante - Aceite para motor a gasolina y diesel.', '14', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (20, 'MAXIDIESEL PLUS SAE 50W', 'Lubricante - Aceite para motor a gasolina y diesel.', '15', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (21, 'MAXIDIESEL PLUS SAE 15W-40', 'Lubricante - Aceite para motor a gasolina y diesel.', '16', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (22, 'MAXIDIESEL PLUS SAE 20W-50', 'Lubricante - Aceite para motor a gasolina y diesel.', '17', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (23, 'MAXIDIESEL PLUS SAE 25W-50', 'Lubricante - Aceite para motor a gasolina y diesel.', '18', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (24, 'MAXITREN EMD SAE 40', 'Lubricante - Aceite para motor a gasolina y diesel.', '19', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (26, 'FUERA DE BORDA TC-W3', 'Lubricante - Aceites para motores a gasolina de 2 tiempos.', '21', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (27, 'FUERA DE BORDA TC-WII', 'Lubricante - Aceites para motores a gasolina de 2 tiempos.', '22', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (28, 'MOTORGAS W SAE 40', 'Lubricante - Aceites para motores a gas natural.', '23', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (29, 'LUBRIGAS SAE 30', 'Lubricante - Aceites para motores a gas natural.', '24', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (30, 'LUBRIGAS SAE 40', 'Lubricante - Aceites para motores a gas natural.', '25', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (31, 'ATLANTA MARINE D 3005', 'Lubricante - Aceites para motores y equipos marinos.', '26', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (32, 'ATLANTA MARINE D 4005', 'Lubricante - Aceites para motores y equipos marinos.', '27', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (33, 'AURELIA XL 3030', 'Lubricante - Aceites para motores y equipos marinos.', '28', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (34, 'AURELIA XL 4030', 'Lubricante - Aceites para motores y equipos marinos.', '29', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (35, 'DISOLA M 3015', 'Lubricante - Aceites para motores y equipos marinos.', '30', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (36, 'DISOLA M 4015', 'Lubricante - Aceites para motores y equipos marinos.', '31', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (37, 'DISOLA M 5015', 'Lubricante - Aceites para motores y equipos marinos.', '32', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (38, 'DISOLA MT SAE 30', 'Lubricante - Aceites para motores y equipos marinos.', '33', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (39, 'DISOLA MT SAE 40', 'Lubricante - Aceites para motores y equipos marinos.', '34', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (40, 'TALUSIA HR 40', 'Lubricante - Aceites para motores y equipos marinos.', '35', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (41, 'TALUSIA HR 70', 'Lubricante - Aceites para motores y equipos marinos.', '36', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (42, 'TALUSIA HR 80', 'Lubricante - Aceites para motores y equipos marinos.', '37', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (43, 'TALUSIA HR 100', 'Lubricante - Aceites para motores y equipos marinos.', '38', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (44, 'TALUSIA HR 6085', 'Lubricante - Aceites para motores y equipos marinos.', '39', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (45, 'VISGA ISO 15', 'Lubricante - Aceites para motores y equipos marinos.', '40', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (46, 'VISGA ISO 22', 'Lubricante - Aceites para motores y equipos marinos.', '41', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (47, 'VISGA ISO 32', 'Lubricante - Aceites para motores y equipos marinos.', '42', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (48, 'VISGA ISO 46', 'Lubricante - Aceites para motores y equipos marinos.', '43', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (49, 'VISGA ISO 68', 'Lubricante - Aceites para motores y equipos marinos.', '44', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (50, 'VISGA ISO 100', 'Lubricante - Aceites para motores y equipos marinos.', '45', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (51, 'MARINAVE AD-40 SAE 40', 'Lubricante - Aceites para motores y equipos marinos.', '46', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (52, 'TRANSFLUIDO D VI', 'Lubricante - Aceites para transmisiones automaticas.', '47', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (53, 'TRANSFLUIDO D III', 'Lubricante - Aceites para transmisiones automaticas.', '48', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (54, 'TRANSFLUIDO D II', 'Lubricante - Aceites para transmisiones automaticas.', '49', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (55, 'TRANSFLUIDO M6', 'Lubricante - Aceites para transmisiones automaticas.', '50', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (56, 'TRANSLUB EP SAE 80W-90', 'Lubricante - Aceites para transmisiones automaticas.', '51', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (57, 'TRANSLUB EP SAE 85W-140', 'Lubricante - Aceites para transmisiones automaticas.', '52', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (58, 'AGROFLUIDO SAE 30', 'Lubricante - Aceites para transmisiones automaticas.', '53', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (59, 'HIDRATRANS SAE 10W', 'Lubricante - Aceites para transmisiones automaticas.', '54', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (60, 'HIDRATRANS SAE 30', 'Lubricante - Aceites para transmisiones automaticas.', '55', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (61, 'HIDRATRANS SAE 50', 'Lubricante - Aceites para transmisiones automaticas.', '56', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (62, 'HIDRATRANS SAE 60', 'Lubricante - Aceites para transmisiones automaticas.', '57', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (63, 'FLUIDO PARA FRENOS DOT-4', 'Lubricante - Especialidades Automotrices.', '58', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (64, 'FLUIDO PARA FRENOS DOT-3', 'Lubricante - Especialidades Automotrices.', '59', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (66, 'ENGRALUB EP ISO 68', 'Lubricante - Aceites para engranajes.', '61', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (67, 'ENGRALUB EP ISO 100', 'Lubricante - Aceites para engranajes.', '62', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (68, 'ENGRALUB EP ISO 150', 'Lubricante - Aceites para engranajes.', '63', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (69, 'ENGRALUB EP ISO 220', 'Lubricante - Aceites para engranajes.', '64', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (70, 'ENGRALUB EP ISO 320', 'Lubricante - Aceites para engranajes.', '65', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (71, 'ENGRALUB EP ISO 460', 'Lubricante - Aceites para engranajes.', '66', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (72, 'ENGRALUB EP ISO 680', 'Lubricante - Aceites para engranajes.', '67', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (73, 'ENGRALUB EP ISO 1000', 'Lubricante - Aceites para engranajes.', '68', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (74, 'CILINLUB ISO 150', 'Lubricante - Aceites para engranajes.', '69', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (75, 'CILINLUB ISO 460', 'Lubricante - Aceites para engranajes.', '70', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (76, 'CILINLUB ISO 680', 'Lubricante - Aceites para engranajes.', '71', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (77, 'ASFALUB D 800', 'Lubricante - Aceites para engranajes.', '72', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (78, 'ASFALUB D 1000CP', 'Lubricante - Aceites para engranajes.', '73', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (79, 'ASFALUB D 1000', 'Lubricante - Aceites para engranajes.', '74', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (80, 'ASFALUB D 1500', 'Lubricante - Aceites para engranajes.', '75', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (81, 'ASFALUB D 5000', 'Lubricante - Aceites para engranajes.', '76', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (82, 'ASFALUB DS 3000', 'Lubricante - Aceites para engranajes.', '77', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (83, 'ASFALUB DS 5000', 'Lubricante - Aceites para engranajes.', '78', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (84, 'ZAFRALUB 95', 'Lubricante - Aceites para engranajes.', '79', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (85, 'ZAFRALUB 96', 'Lubricante - Aceites para engranajes.', '80', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (88, 'COMPRESOLUB ISO 150', 'Lubricante - Aceites para compresores de aire.', '83', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (89, 'COMPRESOLUB ISO 220', 'Lubricante - Aceites para compresores de aire.', '84', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (98, 'HIDRALUB ISO 10', 'Lubricante - Aceites para sistemas hidraulicos.', '93', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (99, 'HIDRALUB ISO 22', 'Lubricante - Aceites para sistemas hidraulicos.', '94', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (100, 'HIDRALUB ISO 32', 'Lubricante - Aceites para sistemas hidraulicos.', '95', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (101, 'HIDRALUB ISO 46', 'Lubricante - Aceites para sistemas hidraulicos.', '96', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (102, 'HIDRALUB ISO 68', 'Lubricante - Aceites para sistemas hidraulicos.', '97', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (103, 'HIDRALUB ISO 100', 'Lubricante - Aceites para sistemas hidraulicos.', '98', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (104, 'HIDRALUB ISO 150', 'Lubricante - Aceites para sistemas hidraulicos.', '99', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (105, 'HIDRALUB ISO 220', 'Lubricante - Aceites para sistemas hidraulicos.', '100', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (106, 'HIDRALUB ISO 320', 'Lubricante - Aceites para sistemas hidraulicos.', '101', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (107, 'HIDRALUB AW ISO 22', 'Lubricante - Aceites para sistemas hidraulicos.', '102', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (108, 'HIDRALUB AW ISO 32', 'Lubricante - Aceites para sistemas hidraulicos.', '103', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (109, 'HIDRALUB AW ISO 46', 'Lubricante - Aceites para sistemas hidraulicos.', '104', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (110, 'HIDRALUB AW ISO 68', 'Lubricante - Aceites para sistemas hidraulicos.', '105', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (111, 'HIDRALUB AW ISO 100', 'Lubricante - Aceites para sistemas hidraulicos.', '106', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (65, 'ENGRALUB EP SINT&Eacute;TICO ISO 320', 'Lubricante - Aceites para engranajes.', '60', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (86, 'COMPRESOLUB SINT&Eacute;TICO AT', 'Lubricante - Aceites para compresores de aire.', '81', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (112, 'SOLUBLE S', 'Lubricante - Aceites para maquinado de metales.', '107', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (113, 'CORTALUB ISO 15', 'Lubricante - Aceites para maquinado de metales.', '108', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (114, 'CORTALUB ISO 22', 'Lubricante - Aceites para maquinado de metales.', '109', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (115, 'CORTALUB ISO 32A', 'Lubricante - Aceites para maquinado de metales.', '110', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (116, 'CORTALUB ISO 32C', 'Lubricante - Aceites para maquinado de metales.', '111', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (117, 'CORTALUB ISO 46', 'Lubricante - Aceites para maquinado de metales.', '112', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (118, 'HIDRAMORG ISO 220', 'Lubricante - Aceites para maquinado de metales.', '113', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (119, 'HIDRAMORG ISO 320', 'Lubricante - Aceites para maquinado de metales.', '114', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (120, 'HIDRAMORG ISO 680', 'Lubricante - Aceites para maquinado de metales.', '115', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (121, 'HIDRAMORG S ISO 100', 'Lubricante - Aceites para maquinado de metales.', '116', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (122, 'HIDRAMORG S ISO 320', 'Lubricante - Aceites para maquinado de metales.', '117', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (123, 'HIDRAMORG S ISO 680', 'Lubricante - Aceites para maquinado de metales.', '118', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (124, 'TREFILUB ISO 320', 'Lubricante - Aceites para trefilado y extrusi&oacute;n de metales.', '119', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (125, 'TREFILUB ISO 460', 'Lubricante - Aceites para trefilado y extrusi&oacute;n de metales.', '120', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (126, 'TREFILUB ISO 150', 'Lubricante - Aceites para trefilado y extrusi&oacute;n de metales.', '121', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (127, 'PROTECTORLUB ESPECIAL ISO 100', 'Lubricante - Aceites para protecci&oacute;n de piezas de metalicas.', '122', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (128, 'PROTECTORLUB ESPECIAL ISO 150', 'Lubricante - Aceites para protecci&oacute;n de piezas de metalicas.', '123', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (129, 'PROTECTORLUB ISO 22', 'Lubricante - Aceites para protecci&oacute;n de piezas de metalicas.', '124', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (130, 'PROTECTORLUB ISO 46', 'Lubricante - Aceites para protecci&oacute;n de piezas de metalicas.', '125', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (131, 'PROTECTORLUB ISO 68', 'Lubricante - Aceites para protecci&oacute;n de piezas de metalicas.', '126', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (132, 'PERFOLUB ISO 100', 'Lubricante - Aceites para equipos neum&aacute;ticos.', '127', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (133, 'PERFOLUB ISO 220', 'Lubricante - Aceites para equipos neum&aacute;ticos.', '128', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (134, 'PUROLUB ISO 15', 'Lubricante - Aceites para procesos.', '129', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (135, 'PUROLUB ISO 22', 'Lubricante - Aceites para procesos.', '130', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (136, 'PUROLUB ISO 32', 'Lubricante - Aceites para procesos.', '131', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (137, 'PUROLUB ISO 46', 'Lubricante - Aceites para procesos.', '132', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (138, 'PUROLUB ISO 68', 'Lubricante - Aceites para procesos.', '133', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (139, 'PUROLUB ISO 100', 'Lubricante - Aceites para procesos.', '134', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (140, 'PUROLUB ISO 150', 'Lubricante - Aceites para procesos.', '135', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (141, 'PUROLUB ISO 220', 'Lubricante - Aceites para procesos.', '136', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (142, 'PUROLUB ISO 320', 'Lubricante - Aceites para procesos.', '137', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (143, 'PUROLUB ISO 460', 'Lubricante - Aceites para procesos.', '138', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (144, 'PUROLUB ISO 680', 'Lubricante - Aceites para procesos.', '139', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (145, 'PUROLUB ISO 1000', 'Lubricante - Aceites para procesos.', '140', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (146, 'PUROLUB ESPECIAL ISO 1500', 'Lubricante - Aceites para procesos.', '141', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (147, 'PUROLUB ESPECIAL ISO 3200', 'Lubricante - Aceites para procesos.', '142', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (148, 'TEXTILUB ISO 15', 'Lubricante - Aceites para Maquinarias Textiles.', '143', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (149, 'TEXTILUB ISO 22', 'Lubricante - Aceites para Maquinarias Textiles.', '144', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (150, 'TEXTILUB ISO 68', 'Lubricante - Aceites para Maquinarias Textiles.', '145', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (151, 'TEXTILUB ISO 100', 'Lubricante - Aceites para Maquinarias Textiles.', '146', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (152, 'TEXTILUB ISO 150', 'Lubricante - Aceites para Maquinarias Textiles.', '147', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (153, 'TURBOLUB ISO 32', 'Lubricante - Aceites para Turbinas .', '148', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (154, 'TURBOLUB ISO 46', 'Lubricante - Aceites para Turbinas .', '149', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (155, 'TURBOLUB ISO 46F', 'Lubricante - Aceites para Turbinas .', '150', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (156, 'TURBOLUB ISO G-56', 'Lubricante - Aceites para Turbinas .', '151', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (157, 'TURBOLUB ISO 68', 'Lubricante - Aceites para Turbinas .', '152', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (158, 'TURBOLUB 78', 'Lubricante - Aceites para Turbinas .', '153', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (159, 'TURBOLUB ISO 100', 'Lubricante - Aceites para Turbinas .', '154', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (160, 'TURBOLUB ISO 150', 'Lubricante - Aceites para Turbinas .', '155', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (90, 'FRILUB SINTETICO ISO 68', 'Lubricante - Aceites para compresores de refrigeraci&oacute;n.', '85', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (91, 'FRILUB ISO 15', 'Lubricante - Aceites para compresores de refrigeraci&oacute;n.', '86', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (92, 'FRILUB ISO 22', 'Lubricante - Aceites para compresores de refrigeraci&oacute;n.', '87', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (93, 'FRILUB ISO 32', 'Lubricante - Aceites para compresores de refrigeraci&oacute;n.', '88', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (94, 'FRILUB ISO 46', 'Lubricante - Aceites para compresores de refrigeraci&oacute;n.', '89', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (95, 'FRILUB ISO 68', 'Lubricante - Aceites para compresores de refrigeraci&oacute;n.', '90', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (96, 'FRILUB ISO 100', 'Lubricante - Aceites para compresores de refrigeraci&oacute;n.', '91', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (97, 'FRILUB ISO 150', 'Lubricante - Aceites para compresores de refrigeraci&oacute;n.', '92', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (161, 'GRAFILUB ISO 22', 'Lubricante - Aceites para Moldes.', '156', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (162, 'GRAFILUB ISO 46', 'Lubricante - Aceites para Moldes.', '157', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (163, 'FORMALETA', 'Lubricante - Aceites para Moldes.', '158', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (164, 'GUIALUB ISO 68', 'Lubricante - Aceites para m&aacute;quinas herramientas.', '159', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (165, 'GUIALUB ISO 220', 'Lubricante - Aceites para m&aacute;quinas herramientas.', '160', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (166, 'AMORTILUB M', 'Lubricante - Aceites para amortiguadores.', '161', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (167, 'AMORTILUB G', 'Lubricante - Aceites para amortiguadores.', '162', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (168, 'CHASIS', 'Lubricante - Grasas.', '163', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (169, 'MULTIPLE', 'Lubricante - Grasas.', '164', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (170, 'GRAFITADA', 'Lubricante - Grasas.', '165', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (171, 'MOLY SP', 'Lubricante - Grasas.', '166', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (172, 'T&Eacute;RMICA', 'Lubricante - Grasas.', '167', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (173, 'INDUSTRIAL EP', 'Lubricante - Grasas.', '168', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (209, 'LUBRICANTE DE MOTOR', 'Lubricante - Otros.', '204', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (210, 'LUBRICANTE DE COMPRESOR', 'Lubricante - Otros.', '205', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (211, 'LUBRICANTE DE ENGRANAJE', 'Lubricante - Otros.', '206', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (212, 'LUBRICANTE DE TURBINA', 'Lubricante - Otros.', '207', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (213, 'LUBRICANTE HIDRAULICO', 'Lubricante - Otros.', '208', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (214, 'LUBRICANTE INDUSTRIAL', 'Lubricante - Otros.', '209', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (215, 'LUBRICANTE MARINO', 'Lubricante - Otros.', '210', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (216, 'LUBRICANTE SOLUBLE', 'Lubricante - Otros.', '211', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (217, 'LUBRICANTE NUEVO DE MOTOR DIESEL', 'Lubricante - Otros.', '212', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (218, 'LUBRICANTE NUEVO DE MOTOR', 'Lubricante - Otros.', '213', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (219, 'LUBRICANTE NUEVO INDUSTRIAL', 'Lubricante - Otros.', '214', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (25, 'DOS TIEMPOS', 'Lubricante - Aceites para motores a gasolina de 2 tiempos.', '9999', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (230, 'Z', '', 'z', 0);
INSERT INTO "TR001_Productos_Deltaven" ("id_Producto", "Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") VALUES (6, 'SUPRA SINT&Eacute;TICO RACING SAE 15W-50', 'Lubricante - Aceite para motor a gasolina y diesel.', '1', 0);


--
-- TOC entry 1694 (class 0 OID 246301252)
-- Dependencies: 1270
-- Data for Name: TR001_Resultado; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (130, 94, 'LUB-001', 'Viscosidad a 40 °C', '50 mm&amp;sup2;/s', '', '2009-01-23', '', 958);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (131, 94, 'LUB-001', 'Viscosidad a 100 °C', '90 mm&amp;sup2;/s', '', '2009-01-23', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (132, 95, 'LUB-014', 'Cotenido de agua', '2 %', '5', '2009-01-26', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (133, 96, 'LUB-015', 'Crepitación', '15 A', '', '2009-01-26', '', 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (170, 116, 'LUB-001', 'Viscosidad a 100 °C', '11.16 mm&amp;sup2;/s', '0.010', '2009-04-06', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (135, 97, 'LUB-017', 'Boro', '5 ppm', '', '2009-01-26', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (310, 174, 'LUB-001', 'Viscosidad a 100 °C', '9.16+/-0.6 cSt
', '', '2009-04-29', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (137, 97, 'LUB-017', 'Hierro', '8 ppm', '', '2009-01-26', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (138, 97, 'LUB-017', 'Plomo', '9 ppm', '', '2009-01-26', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (139, 97, 'LUB-017', 'Molibdeno', '9 ppm', '', '2009-01-26', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (140, 97, 'LUB-017', 'Silicio', '9 ppm', '', '2009-01-26', '', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (141, 97, 'LUB-017', 'Sodio', '8 ppm', '', '2009-01-26', '', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (142, 97, 'LUB-017', 'Estaño', '87 ppm', '', '2009-01-26', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (1, 2, 'SGLG-IT-078', 'Aluminio', '2', '1514', '2008-11-28', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (2, 1, 'SGLG-IT-078', 'CROMO', '1', '', '2008-11-28', '', 1043);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (3, 1, 'SGLG-IT-078', 'COBRE', '21', '', '2008-11-28', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (4, 20, 'LUB-014/ASTM-D', 'Aluminio', '3', '1514', '2008-11-28', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (143, 98, 'LUB-019', 'NA colorimétrco', '15 mg KOH/g&lt;br /&gt;', '', '2009-01-26', '', 1059);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (144, 99, 'LUB-001', 'Viscosidad a 100 °C', '1.863 mm&amp;sup2;/s', '0.010', '2009-03-05', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (145, 100, 'LUB-010', 'Color ASTM', '0.0 A', '', '2009-03-05', '', 1021);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (146, 101, 'LUB-020', 'Punto de ebullición seco', '256 &amp;deg;C', '', '2009-03-05', '', 1060);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (147, 102, 'LUB-021', 'Determinación de pH', '10.62', '', '2009-03-05', '', 1061);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (148, 103, 'LUB-001', 'Viscosidad a 100 °C', '129.74 mm&amp;sup2;/s', '0.70', '2009-03-03', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (149, 104, 'LUB-001', 'Viscosidad a 100 °C', '134.01 mm&amp;sup2;/s', '0.72', '2009-03-03', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (134, 97, 'LUB-017', 'Aluminio', '6 ppm', '', '2009-01-26', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (136, 97, 'LUB-017', 'Cobre', '17 ppm', '', '2009-01-26', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (311, 174, 'LUB-001', 'Viscosidad a 40 °C', '36.53+/-0.2 cSt
', '', '2009-04-29', '', 958);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (312, 175, 'LUB-017', 'Aluminio', '20.5 ppm', '', '2009-04-29', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (313, 175, 'LUB-017', 'Boro', '47.2 ppm', '', '2009-04-29', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (314, 175, 'LUB-017', 'Calcio', '55 ppm', '', '2009-04-29', '', 1042);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (315, 175, 'LUB-017', 'Cobre', '36 ppm', '', '2009-04-29', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (316, 175, 'LUB-017', 'Hierro', '48 ppm', '', '2009-04-29', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (317, 175, 'LUB-017', 'Plomo', '50 ppm', '', '2009-04-29', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (318, 175, 'LUB-017', 'Magnesio', '95 ppm', '', '2009-04-29', '', 1047);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (319, 175, 'LUB-017', 'Molibdeno', '63 ppm', '', '2009-04-29', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (320, 175, 'LUB-017', 'Fosforo', '88 ppm', '', '2009-04-29', '', 1051);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (321, 175, 'LUB-017', 'Silicio', '12 ppm', '', '2009-04-29', '', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (322, 175, 'LUB-017', 'Sodio', '11.9 ppm', '', '2009-04-29', '', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (323, 175, 'LUB-017', 'Estao', '16.8 ppm', '', '2009-04-29', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (324, 175, 'LUB-017', 'Zinc', '14.8 ppm', '', '2009-04-29', '', 1088);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (325, 175, 'LUB-017', 'Cromo', '18 ppm', '', '2009-04-29', '', 1089);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (326, 176, 'LUB-018', 'Número Básico', '100 mg', '', '2009-04-29', '', 999);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (327, 177, 'LUB-014', 'Contenido de agua', '7 %', '', '2009-04-29', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (328, 178, 'LUB-019
', 'Hollín', '1.5 %', NULL, '2009-04-29', NULL, 1068);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (191, 137, 'LabCFR-002', 'Determinación del MON', '65 A', '', '2009-03-31', '', 1082);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (192, 138, 'Labco-005', 'Presión de Vapor', '7.15 psi', '', '2009-03-31', '', 969);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (193, 139, 'Labco-006', 'Destilación de productos del petróleo', '50 &amp;deg;C', '', '2009-03-31', '', 1012);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (195, 141, 'Labco-016', 'Gomas Existentes', '1.2 mg/100mL', '', '2009-03-31', '', 1028);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (196, 142, 'Labco-023', 'Adulteración', 'NEGATIVA', '', '2009-03-31', '', 1077);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (197, 143, 'LabCFR-001', 'Determinación del RON', '60 A', '', '2009-03-31', '', 1081);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (198, 144, 'LabCFR-002', 'Determinación del MON', '70 A', '', '2009-03-31', '', 1082);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (329, 179, 'LUB-019
', 'Crepitación', 'Negativa', NULL, '2009-04-29', NULL, 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (172, 118, 'LUB-020', 'Contenido de Agua', '2%', '', '2009-04-06', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (110, 83, 'LUB-001', 'Viscosidad a 40 °C', '50 mm&amp;sup2;/s', '', '2009-01-23', '', 958);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (111, 83, 'LUB-001', 'Viscosidad a 100 °C', '90 mm&amp;sup2;/s', '', '2009-01-23', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (112, 84, 'LUB-014', 'Cotenido de agua', '2 %', '5', '2009-01-26', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (113, 85, 'LUB-015', 'Crepitación', '15 A', '', '2009-01-26', '', 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (220, 153, 'LUB-014', 'Contenido de agua', '2.5 %', '', '2009-04-29', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (115, 86, 'LUB-017', 'Boro', '5 ppm', '', '2009-01-26', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (221, 151, 'LUB-017', 'Aluminio', '30.5 ppm', '', '2009-04-29', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (117, 86, 'LUB-017', 'Hierro', '8 ppm', '', '2009-01-26', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (118, 86, 'LUB-017', 'Plomo', '9 ppm', '', '2009-01-26', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (119, 86, 'LUB-017', 'Molibdeno', '9 ppm', '', '2009-01-26', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (120, 86, 'LUB-017', 'Silicio', '9 ppm', '', '2009-01-26', '', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (121, 86, 'LUB-017', 'Sodio', '8 ppm', '', '2009-01-26', '', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (122, 86, 'LUB-017', 'Estaño', '87 ppm', '', '2009-01-26', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (123, 87, 'LUB-019', 'NA colorimétrco', '15 mg KOH/g&lt;br /&gt;', '', '2009-01-26', '', 1059);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (124, 88, 'LUB-001', 'Viscosidad a 100 °C', '1.863 mm&amp;sup2;/s', '0.010', '2009-03-05', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (125, 89, 'LUB-010', 'Color ASTM', '0.0 A', '', '2009-03-05', '', 1021);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (126, 90, 'LUB-020', 'Punto de ebullición seco', '256 &amp;deg;C', '', '2009-03-05', '', 1060);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (127, 91, 'LUB-021', 'Determinación de pH', '10.62', '', '2009-03-05', '', 1061);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (128, 92, 'LUB-001', 'Viscosidad a 100 °C', '129.74 mm&amp;sup2;/s', '0.70', '2009-03-03', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (129, 93, 'LUB-001', 'Viscosidad a 100 °C', '134.01 mm&amp;sup2;/s', '0.72', '2009-03-03', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (150, 105, 'LUB-001', 'Viscosidad a 40 °C', '50 mm&amp;sup2;/s', '', '2009-01-23', '', 958);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (151, 105, 'LUB-001', 'Viscosidad a 100 °C', '90 mm&amp;sup2;/s', '', '2009-01-23', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (152, 106, 'LUB-014', 'Cotenido de agua', '2 %', '5', '2009-01-26', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (153, 107, 'LUB-015', 'Crepitación', '15 A', '', '2009-01-26', '', 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (222, 151, 'LUB-017', 'Boro', '37.2 ppm', '', '2009-04-29', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (155, 108, 'LUB-017', 'Boro', '5 ppm', '', '2009-01-26', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (103, 76, 'LUB-019', 'NA colorimétrco', '15 mg KOH/g', '', '2009-01-26', '', 1059);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (92, 73, 'LUB-014', 'Cotenido de agua', '2 %', '5', '2009-01-26', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (93, 74, 'LUB-015', 'Crepitación', '15 A', '', '2009-01-26', '', 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (94, 75, 'LUB-017', 'Aluminio', '4 ppm', '', '2009-01-26', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (95, 75, 'LUB-017', 'Boro', '5 ppm', '', '2009-01-26', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (96, 75, 'LUB-017', 'Cobre', '15 ppm', '', '2009-01-26', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (97, 75, 'LUB-017', 'Hierro', '8 ppm', '', '2009-01-26', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (98, 75, 'LUB-017', 'Plomo', '9 ppm', '', '2009-01-26', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (99, 75, 'LUB-017', 'Molibdeno', '9 ppm', '', '2009-01-26', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (100, 75, 'LUB-017', 'Silicio', '9 ppm', '', '2009-01-26', '', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (101, 75, 'LUB-017', 'Sodio', '8 ppm', '', '2009-01-26', '', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (102, 75, 'LUB-017', 'Estaño', '87 ppm', '', '2009-01-26', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (104, 77, 'LUB-001', 'Viscosidad a 100 °C', '1.863 mm&amp;sup2;/s', '0.010', '2009-03-05', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (106, 79, 'LUB-020', 'Punto de ebullición seco', '256 &amp;deg;C', '', '2009-03-05', '', 1060);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (107, 80, 'LUB-021', 'Determinación de pH', '10.62', '', '2009-03-05', '', 1061);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (108, 81, 'LUB-001', 'Viscosidad a 100 °C', '129.74 mm&amp;sup2;/s', '0.70', '2009-03-03', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (109, 82, 'LUB-001', 'Viscosidad a 100 °C', '134.01 mm&amp;sup2;/s', '0.72', '2009-03-03', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (223, 151, 'LUB-017', 'Calcio', '45 ppm', '', '2009-04-29', '', 1042);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (157, 108, 'LUB-017', 'Hierro', '8 ppm', '', '2009-01-26', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (158, 108, 'LUB-017', 'Plomo', '9 ppm', '', '2009-01-26', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (159, 108, 'LUB-017', 'Molibdeno', '9 ppm', '', '2009-01-26', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (160, 108, 'LUB-017', 'Silicio', '9 ppm', '', '2009-01-26', '', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (161, 108, 'LUB-017', 'Sodio', '8 ppm', '', '2009-01-26', '', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (162, 108, 'LUB-017', 'Estaño', '87 ppm', '', '2009-01-26', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (163, 109, 'LUB-019', 'NA colorimétrco', '15 mg KOH/g&lt;br /&gt;', '', '2009-01-26', '', 1059);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (164, 110, 'LUB-001', 'Viscosidad a 100 °C', '1.863 mm&amp;sup2;/s', '0.010', '2009-03-05', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (165, 111, 'LUB-010', 'Color ASTM', '0.0 A', '', '2009-03-05', '', 1021);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (166, 112, 'LUB-020', 'Punto de ebullición seco', '256 &amp;deg;C', '', '2009-03-05', '', 1060);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (167, 113, 'LUB-021', 'Determinación de pH', '10.62', '', '2009-03-05', '', 1061);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (168, 114, 'LUB-001', 'Viscosidad a 100 °C', '129.74 mm&amp;sup2;/s', '0.70', '2009-03-03', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (114, 86, 'LUB-017', 'Aluminio', '5 ppm', '', '2009-01-26', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (154, 108, 'LUB-017', 'Aluminio', '7 ppm', '', '2009-01-26', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (116, 86, 'LUB-017', 'Cobre', '16 ppm', '', '2009-01-26', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (156, 108, 'LUB-017', 'Cobre', '18 ppm', '', '2009-01-26', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (224, 151, 'LUB-017', 'Cobre', '11 ppm', '', '2009-04-29', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (225, 151, 'LUB-017', 'Hierro', '58 ppm', '', '2009-04-29', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (226, 151, 'LUB-017', 'Plomo', '60 ppm', '', '2009-04-29', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (227, 151, 'LUB-017', 'Magnesio', '75 ppm', '', '2009-04-29', '', 1047);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (228, 151, 'LUB-017', 'Molibdeno', '83 ppm', '', '2009-04-29', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (229, 151, 'LUB-017', 'Fosforo', '98 ppm', '', '2009-04-29', '', 1051);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (230, 151, 'LUB-017', 'Silicio', '12.3 ppm', '', '2009-04-29', '', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (231, 151, 'LUB-017', 'Sodio', '11 ppm', '', '2009-04-29', '', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (232, 151, 'LUB-017', 'Estao', '13 ppm', '', '2009-04-29', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (233, 151, 'LUB-017', 'Zinc', '14 ppm', '', '2009-04-29', '', 1088);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (234, 151, 'LUB-017', 'Cromo', '15 ppm', '', '2009-04-29', '', 1089);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (90, 72, 'LUB-001', 'Viscosidad a 40 °C', '50 mm&amp;sup2;/s', '0.2', '2009-01-23', '', 958);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (236, 155, 'LUB-019
', 'Crepitación', 'Positiva', NULL, '2009-04-29', NULL, 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (237, 154, 'LUB-019

', 'Hollín', '0.5 %', NULL, '2009-04-29', NULL, 1068);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (235, 152, 'LUB-018', 'Número Básico', '125 mg KOH/g', '', '2009-04-29', '', 999);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (91, 72, 'LUB-001', 'Viscosidad a 100 °C', '90 mm&amp;sup2;/s', '0.3', '2009-01-23', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (105, 75, 'LUB-017', 'Cromo', '9 ppm
', '', '2009-03-05', '', 1089);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (174, 120, 'LUB-017
', 'Aluminio
', '2 ppm', '0.70', '2009-04-06', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (266, 158, 'LUB-018', 'Número Básico', '15 mg KOH/g', NULL, '2009-04-29', '', 999);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (242, 157, 'LUB-017', 'Aluminio', '20.5 ppm', '', '2009-04-29', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (243, 157, 'LUB-017', 'Boro', '47.2 ppm', '', '2009-04-29', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (244, 157, 'LUB-017', 'Calcio', '55 ppm', '', '2009-04-29', '', 1042);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (245, 157, 'LUB-017', 'Cobre', '36 ppm', '', '2009-04-29', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (246, 157, 'LUB-017', 'Hierro', '48 ppm', '', '2009-04-29', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (247, 157, 'LUB-017', 'Plomo', '50 ppm', '', '2009-04-29', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (248, 157, 'LUB-017', 'Magnesio', '95 ppm', '', '2009-04-29', '', 1047);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (249, 157, 'LUB-017', 'Molibdeno', '63 ppm', '', '2009-04-29', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (260, 157, 'LUB-017', 'Fosforo', '88 ppm', '', '2009-04-29', '', 1051);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (261, 157, 'LUB-017', 'Silicio', '12 ppm', '', '2009-04-29', '', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (262, 157, 'LUB-017', 'Sodio', '11.9 ppm', '', '2009-04-29', '', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (263, 157, 'LUB-017', 'Estao', '16.8 ppm', '', '2009-04-29', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (264, 157, 'LUB-017', 'Zinc', '14.8 ppm', '', '2009-04-29', '', 1088);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (265, 157, 'LUB-017', 'Cromo', '18 ppm', '', '2009-04-29', '', 1089);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (169, 115, 'LUB-001', 'Determinación de pH
', '134.01 mm&amp;sup2;/s', '0.72', '2009-03-03', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (267, 159, 'LUB-014', 'Contenido de agua', '7 %', '', '2009-04-29', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (268, 160, 'LUB-019
', 'Hollín', '1.5 %', NULL, '2009-04-29', NULL, 1068);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (269, 161, 'LUB-019
', 'Crepitación', 'Negativa', NULL, '2009-04-29', NULL, 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (240, 156, 'LUB-001', 'Viscosidad a 100 °C', '9.16 mm&amp;sup2;/s

', '0.42', '2009-04-29', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (241, 156, 'LUB-001', 'Viscosidad a 40 °C', '36.53 mm&amp;sup2;/s

', '0.59', '2009-04-29', '', 958);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (175, 120, 'LUB-017
', 'Boro
', '11 ppm', '0.72', '2009-04-06', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (176, 120, 'LUB-017
', 'Cobre
', '4 ppm', '32', '2009-04-06', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (177, 120, 'LUB-017
', 'Hierro
', '7 ppm', '1.4', '2009-04-06', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (178, 120, 'LUB-017
', 'Plomo', '0 ppm', '5', '2009-04-06', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (179, 120, 'LUB-017
', 'Molibdeno
', '34 ppm', '16', '2009-04-06', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (182, 120, 'LUB-017
', 'Estaño
', '0 ppm', '45', '2009-04-06', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (183, 120, 'LUB-017
', 'Calcio', '1876 ppm', '1.4', '2009-04-06', '', 1042);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (184, 120, 'LUB-017', 'Magnesio', '296 ppm', '2', '2009-04-06', '', 1047);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (188, 122, 'LUB-018', 'Número Básico', '0.5 mg KOH/g', '', '2009-04-06', '', 999);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (180, 120, 'LUB-017
', 'Silicio
', '3 ppm', '1.4', '2009-04-06', '''''
', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (181, 120, 'LUB-017
', 'Sodio', '5 ppm', '10', '2009-04-06', '''''
', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (202, 147, 'LUB-017', 'Aluminio', '25 ppm', '', '2009-04-06', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (203, 147, 'LUB-017', 'Boro', '35 ppm', '', '2009-04-06', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (204, 147, 'LUB-017', 'Calcio', '45 ppm', '', '2009-04-06', '', 1042);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (270, 162, 'LUB-001', 'Viscosidad a 100 °C', '1.863 mm&amp;sup2;/s', '0.010', '2009-05-20', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (171, 116, 'LUB-010', 'Viscosidad a 40 °C', '46.53 mm&amp;sup2;/s', '0.70
', '2009-04-06', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (271, 162, 'LUB-001', 'Viscosidad a 40 °C', '46.53 mm&amp;sup2;/s', '0.70', '2009-05-20', '', 958);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (200, 145, 'LUB-001', 'Viscosidad a 100 °C', '11.16 mm&amp;sup2;/s

', '0.69', '2009-04-06', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (199, 145, 'LUB-001', 'Viscosidad a 40 °C', '46 mm&amp;sup2;/s

', '0.82', '2009-04-06', '', 958);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (238, 150, 'LUB-001', 'Viscosidad a 100 °C', '15.38 mm&amp;sup2;/s

', '0.25', '2009-04-29', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (239, 150, 'LUB-001', 'Viscosidad a 40 °C', '26.9 mm&amp;sup2;/s

', '0.5', '2009-04-29', '', 958);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (205, 147, 'LUB-017', 'Cobre', '13.5 ppm', '', '2009-04-06', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (189, 123, 'LUB-019', 'Hollín', '0.5 %', '', '2009-04-06', '', 1068);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (173, 119, 'LUB-021', 'Crepitación', 'Negativa', '', '2009-04-06', '', 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (207, 147, 'LUB-017', 'Plomo', '65 ppm', '', '2009-04-06', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (206, 147, 'LUB-017', 'Hierro', '55 ppm', '', '2009-04-06', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (208, 147, 'LUB-017', 'Magnesio', '75 ppm', '', '2009-04-06', '', 1047);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (209, 147, 'LUB-017', 'Molibdeno', '85 ppm', '', '2009-04-06', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (190, 120, 'LUB-020
', 'Fosforo', '1 ppm', '', '2009-04-06', '', 1051);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (186, 120, 'LUB-017', 'Cromo', '1 ppm', '', '2009-04-06', '', 1089);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (185, 120, 'LUB-017', 'Zinc', '934 ppm', '', '2009-04-06', '', 1088);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (210, 147, 'LUB-017', 'Fosforo', '95 ppm', '', '2009-04-06', '', 1051);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (216, 148, 'LUB-018', 'Número ácido', '125 mg', '', '2009-04-06', '', 1069);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (217, 149, 'LUB-019', 'NA colorimétrco', '23 mg ', '', '2009-04-06', '', 1059);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (201, 146, 'LUB-014', 'Contenido de agua', '5 %', '', '2009-04-06', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (211, 147, 'LUB-017', 'Silicio', '15 ppm', '', '2009-04-06', '', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (218, 149, 'LUB-019
', 'Crepitación', 'Positiva', NULL, '2009-04-06', NULL, 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (212, 147, 'LUB-017', 'Sodio', '11.5 ppm', '', '2009-04-06', '', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (213, 147, 'LUB-017', 'Estaño', '12.5 ppm', '', '2009-04-06', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (219, 149, 'LUB-019

', 'Hollín', '0.5 %', NULL, '2009-04-06', NULL, 1068);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (214, 147, 'LUB-017', 'Zinc', '14.5 ppm', '', '2009-04-06', '', 1088);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (215, 147, 'LUB-017', 'Cromo', '15.55 ppm', '', '2009-04-06', '', 1089);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (272, 163, 'LUB-017', 'Aluminio', '6 ppm', '', '2009-05-20', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (273, 163, 'LUB-017', 'Boro', '5 ppm', '', '2009-05-20', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (274, 163, 'LUB-017', 'Calcio', '45 ppm', '', '2009-05-20', '', 1042);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (275, 163, 'LUB-017', 'Cobre', '18 ppm', '', '2009-05-20', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (276, 163, 'LUB-017', 'Hierro', '9 ppm', '', '2009-05-20', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (277, 163, 'LUB-017', 'Plomo', '9 ppm', '', '2009-05-20', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (278, 163, 'LUB-017', 'Magnesio', '9 ppm', '', '2009-05-20', '', 1047);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (279, 163, 'LUB-017', 'Molibdeno', '6 ppm', '', '2009-05-20', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (280, 163, 'LUB-017', 'Fosforo', '8 ppm', '', '2009-05-20', '', 1051);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (281, 163, 'LUB-017', 'Silicio', '12 ppm', '', '2009-05-20', '', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (282, 163, 'LUB-017', 'Sodio', '11 ppm', '', '2009-05-20', '', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (283, 163, 'LUB-017', 'Estaño', '87 ppm', '', '2009-05-20', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (284, 163, 'LUB-017', 'Zinc', '4 ppm', '', '2009-05-20', '', 1088);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (285, 163, 'LUB-017', 'Cromo', '12 ppm', '', '2009-05-20', '', 1089);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (286, 164, 'LUB-018', 'Número Básico', '0.5 mg KOH/g', '', '2009-05-20', '', 999);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (287, 165, 'LUB-014', 'Contenido de agua', '5 %', '', '2009-05-20', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (288, 166, 'LUB-019
', 'Hollín', '1.5 %', NULL, '2009-05-20', NULL, 1068);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (289, 167, 'LUB-019
', 'Crepitación', 'Negativa', NULL, '2009-05-20', NULL, 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (290, 168, 'LUB-001', 'Viscosidad a 100 °C', '46 mm&amp;sup2;/s', '0.82', '2009-05-20', '', 959);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (291, 169, 'LUB-001', 'Viscosidad a 40 °C', '11.16 mm&amp;sup2;/s', '0.69', '2009-05-20', '', 958);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (292, 169, 'LUB-017', 'Aluminio', '7 ppm', '', '2009-05-20', '', 1039);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (293, 169, 'LUB-017', 'Boro', '4 ppm', '', '2009-05-20', '', 1041);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (294, 169, 'LUB-017', 'Calcio', '46 ppm', '', '2009-05-20', '', 1042);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (295, 169, 'LUB-017', 'Cobre', '17 ppm', '', '2009-05-20', '', 1044);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (296, 169, 'LUB-017', 'Hierro', '8 ppm', '', '2009-05-20', '', 1045);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (297, 169, 'LUB-017', 'Plomo', '8 ppm', '', '2009-05-20', '', 1046);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (298, 169, 'LUB-017', 'Magnesio', '8 ppm', '', '2009-05-20', '', 1047);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (299, 169, 'LUB-017', 'Molibdeno', '7 ppm', '', '2009-05-20', '', 1049);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (300, 169, 'LUB-017', 'Fosforo', '9 ppm', '', '2009-05-20', '', 1051);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (301, 169, 'LUB-017', 'Silicio', '13 ppm', '', '2009-05-20', '', 1053);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (302, 169, 'LUB-017', 'Sodio', '10 ppm', '', '2009-05-20', '', 1055);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (303, 169, 'LUB-017', 'Estaño', '88 ppm', '', '2009-05-20', '', 1056);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (304, 169, 'LUB-017', 'Zinc', '5 ppm', '', '2009-05-20', '', 1088);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (305, 169, 'LUB-017', 'Cromo', '11 ppm', '', '2009-05-20', '', 1089);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (307, 171, 'LUB-014', 'Contenido de agua', '2 %', '', '2009-05-20', '', 1034);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (308, 172, 'LUB-019
', 'Hollín', '1.5 %', NULL, '2009-05-20', NULL, 1068);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (309, 173, 'LUB-019
', 'Crepitación', 'Negativa', NULL, '2009-05-20', NULL, 1037);
INSERT INTO "TR001_Resultado" (id_resultado, id_metodo, codigo_metodo, prueba, resultado, incertidumbre, fecha_reporte, observacion, idprueba) VALUES (306, 170, 'LUB-018', 'Número Básico', '10 mg KOH/g', '', '2009-05-20', '', 999);


--
-- TOC entry 1695 (class 0 OID 246301260)
-- Dependencies: 1272
-- Data for Name: TR001_Solicitud; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (3, 1, '2008-11-09', '14:25:49', 6, 'SL00002', 1, 1, 1, '20315', '2008-11-11', 1, '2008-11-10', '2008-12-09', '2008-11-28');
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (19, 1, '2009-04-14', '11:52:48', 5, 'SL00018', 1, 0, 1, '94', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (21, 1, '2009-05-05', '14:53:41', 1, 'SL00020', 1, 0, 1, '104', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (7, 1, '2008-12-18', '13:05:29', 6, 'SL00008', 1, 1, 1, '20309', '2009-04-16', 1, '2009-04-16', '2009-04-16', NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (36, 1, '2009-06-15', '15:53:14', 2, 'SL00035', 1, 0, 1, '151', NULL, 1, '2009-07-06', NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (16, 18, '2009-03-26', '10:54:08', 6, 'SL00015', 2, 2, 1, '87', '2009-04-16', 1, '2009-04-16', '2009-04-16', NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (27, 22, '2009-05-20', '09:49:20', 6, 'SL00026', 2, 2, 1, '118', '2009-05-20', 1, '2009-05-20', '2009-05-21', NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (5, 1, '2008-11-28', '12:12:33', 6, 'SL00004', 2, 2, 1, '20387', '2008-12-03', 1, NULL, NULL, '2008-12-10');
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (13, 1, '2009-03-24', '10:31:51', 1, 'SL00012', 1, 0, 1, '101', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (2, 1, '2008-11-10', '13:10:10', 6, 'SL00001', 2, 3, 1, '20310', '2008-11-11', 1, NULL, '2009-03-09', NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (28, 1, '2009-05-28', '17:02:10', 1, 'SL00027', 2, 0, 1, '125', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (14, 1, '2009-03-24', '10:32:42', 1, 'SL00013', 1, 0, 1, '102', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (29, 24, '2009-06-05', '12:06:01', 1, 'SL00028', 1, 0, 1, '129', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (34, 1, '2009-06-12', '15:46:35', 2, 'SL00033', 1, 0, 1, '146', NULL, 1, '2009-07-06', NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (26, 1, '2009-05-15', '16:46:02', 1, 'SL00025', 1, 0, 1, '117', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (30, 1, '2009-06-11', '16:25:07', 1, 'SL00029', 1, 0, 1, '140', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (31, 1, '2009-06-12', '14:35:09', 1, 'SL00030', 1, 0, 1, '143', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (22, 1, '2009-05-05', '14:55:06', 1, 'SL00021', 1, 0, 1, '120', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (23, 1, '2009-05-05', '14:58:55', 1, 'SL00022', 1, 0, 1, '121', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (24, 1, '2009-05-05', '15:41:41', 1, 'SL00023', 1, 0, 1, '122', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (32, 1, '2009-06-12', '14:44:56', 2, 'SL00031', 1, 0, 1, '144', NULL, 1, '2009-07-06', NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (25, 1, '2009-05-05', '16:45:32', 1, 'SL00024', 1, 0, 1, '123', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (15, 18, '2009-03-25', '17:27:34', 6, 'SL00014', 2, 2, 1, '103', '2008-03-25', 1, '2008-03-25', '2008-03-25', NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (39, 1, '2009-06-16', '17:55:29', 2, 'SL00038', 1, 0, 1, '154', NULL, 1, '2009-06-17', NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (38, 1, '2009-06-16', '17:14:36', 2, 'SL00037', 1, 0, 1, '153', NULL, 1, '2009-06-17', NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (8, 1, '2008-12-18', '12:51:05', 1, 'SL00007', 1, 0, 1, '88', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (10, 1, '2009-01-13', '20:20:49', 1, 'SL00009', 1, 0, 1, '89', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (11, 1, '2009-01-28', '16:32:35', 2, 'SL00010', 1, 0, 1, '90', NULL, 1, '2009-03-04', NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (4, 1, '2008-12-09', '14:27:19', 6, 'SL00003', 2, 4, 1, '91', NULL, 1, NULL, '2009-03-09', NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (6, 1, '2008-12-15', '17:47:28', 6, 'SL00005', 10, 10, 1, '92', '2008-12-03', 1, '2009-03-04', '2009-03-04', '2009-03-04');
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (12, 1, '2009-03-23', '17:16:35', 1, 'SL00011', 1, 0, 1, '93', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (37, 22, '2009-06-16', '10:39:19', 2, 'SL00036', 1, 0, 1, '152', NULL, 1, '2009-06-16', NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (35, 1, '2009-06-12', '15:51:15', 2, 'SL00034', 1, 0, 1, '147', NULL, 1, '2009-06-16', NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (18, 22, '2009-04-06', '15:45:49', 6, 'SL00017', 1, 1, 1, '80', '2009-04-06', 1, '2009-04-06', '2009-04-06', NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (9, 1, '2008-12-18', '12:47:16', 6, 'SL00006', 1, 2, 1, '20340', '2008-12-18', 1, '2008-12-19', '2009-03-25', NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (40, 1, '2009-06-17', '09:37:00', 6, 'SL00039', 1, 1, 1, '155', '2009-06-17', 1, '2009-06-17', '2009-07-06', '2009-06-18');
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (20, 22, '2009-04-29', '11:00:51', 6, 'SL00019', 2, 2, 1, '99', '2009-04-29', 1, '2009-04-29', '2009-04-29', NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (41, 1, '2009-07-06', '16:46:16', 1, 'SL00040', 1, 0, 1, '168', NULL, 1, NULL, NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (33, 1, '2009-06-12', '15:15:51', 2, 'SL00032', 1, 0, 1, '145', NULL, 1, '2009-07-06', NULL, NULL);
INSERT INTO "TR001_Solicitud" ("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", pre_registro, codigo_sigelab, fecha_registro, "Motivo_Analisis", fecha_transporte, fecha_final, fecha_certificado) VALUES (17, 22, '2009-04-03', '11:22:17', 6, 'SL00016', 1, 1, 1, '86', '2009-04-03', 1, '2009-04-04', '2009-04-08', NULL);


--
-- TOC entry 1696 (class 0 OID 246301271)
-- Dependencies: 1274
-- Data for Name: TR001_Status; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Status" ("id_Status", "Nombre_Status") VALUES (1, 'Solicitud Creada');
INSERT INTO "TR001_Status" ("id_Status", "Nombre_Status") VALUES (2, 'Muestra Entregada a Transportista');
INSERT INTO "TR001_Status" ("id_Status", "Nombre_Status") VALUES (3, 'Muestra Recibida por el Laboratorio de Lubricantes');
INSERT INTO "TR001_Status" ("id_Status", "Nombre_Status") VALUES (4, 'Muestra en Proceso de An&aacute;lisis por el Laboratorio');
INSERT INTO "TR001_Status" ("id_Status", "Nombre_Status") VALUES (5, 'Resultados Enviados a Deltaven');
INSERT INTO "TR001_Status" ("id_Status", "Nombre_Status") VALUES (6, 'Resultados Enviados a Cliente');


--
-- TOC entry 1697 (class 0 OID 246301276)
-- Dependencies: 1276
-- Data for Name: TR001_Zona; Type: TABLE DATA; Schema: public; Owner: sislub_adm
--

INSERT INTO "TR001_Zona" (id_zona, nombre_zona) VALUES (1, 'Metropolitano');
INSERT INTO "TR001_Zona" (id_zona, nombre_zona) VALUES (2, 'Centro');
INSERT INTO "TR001_Zona" (id_zona, nombre_zona) VALUES (3, 'Occidente');
INSERT INTO "TR001_Zona" (id_zona, nombre_zona) VALUES (4, 'Oriente');
INSERT INTO "TR001_Zona" (id_zona, nombre_zona) VALUES (5, 'Internacional');
INSERT INTO "TR001_Zona" (id_zona, nombre_zona) VALUES (6, 'Marinos');


--
-- TOC entry 1636 (class 2606 OID 246301280)
-- Dependencies: 1236 1236
-- Name: TH001_Roles_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TH001_Roles"
    ADD CONSTRAINT "TH001_Roles_pkey" PRIMARY KEY ("id_Roles");

ALTER TABLE "TH001_Roles" CLUSTER ON "TH001_Roles_pkey";


--
-- TOC entry 1638 (class 2606 OID 246301282)
-- Dependencies: 1238 1238
-- Name: TR001_Accion_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Accion"
    ADD CONSTRAINT "TR001_Accion_pkey" PRIMARY KEY ("id_Accion");

ALTER TABLE "TR001_Accion" CLUSTER ON "TR001_Accion_pkey";


--
-- TOC entry 1640 (class 2606 OID 246301284)
-- Dependencies: 1240 1240
-- Name: TR001_Cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Cargos"
    ADD CONSTRAINT "TR001_Cargos_pkey" PRIMARY KEY (id_cargo);

ALTER TABLE "TR001_Cargos" CLUSTER ON "TR001_Cargos_pkey";


--
-- TOC entry 1642 (class 2606 OID 246301286)
-- Dependencies: 1242 1242
-- Name: TR001_Certificado_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Certificado"
    ADD CONSTRAINT "TR001_Certificado_pkey" PRIMARY KEY (id_certificado);


--
-- TOC entry 1644 (class 2606 OID 246301288)
-- Dependencies: 1244 1244
-- Name: TR001_Cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Cliente"
    ADD CONSTRAINT "TR001_Cliente_pkey" PRIMARY KEY ("id_Cliente");

ALTER TABLE "TR001_Cliente" CLUSTER ON "TR001_Cliente_pkey";


--
-- TOC entry 1646 (class 2606 OID 246301290)
-- Dependencies: 1246 1246
-- Name: TR001_Cuenta_Acceso_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Cuenta_Acceso"
    ADD CONSTRAINT "TR001_Cuenta_Acceso_pkey" PRIMARY KEY ("id_Cuenta_Acceso");

ALTER TABLE "TR001_Cuenta_Acceso" CLUSTER ON "TR001_Cuenta_Acceso_pkey";


--
-- TOC entry 1648 (class 2606 OID 246301292)
-- Dependencies: 1248 1248
-- Name: TR001_Distribuidores_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Distribuidores"
    ADD CONSTRAINT "TR001_Distribuidores_pkey" PRIMARY KEY ("id_Distribuidor");

ALTER TABLE "TR001_Distribuidores" CLUSTER ON "TR001_Distribuidores_pkey";


--
-- TOC entry 1650 (class 2606 OID 246301294)
-- Dependencies: 1250 1250
-- Name: TR001_Empresa_Transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Empresa_Transporte"
    ADD CONSTRAINT "TR001_Empresa_Transporte_pkey" PRIMARY KEY ("id_Empresa_Transporte");

ALTER TABLE "TR001_Empresa_Transporte" CLUSTER ON "TR001_Empresa_Transporte_pkey";


--
-- TOC entry 1652 (class 2606 OID 246301296)
-- Dependencies: 1252 1252
-- Name: TR001_Equipo_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Equipo"
    ADD CONSTRAINT "TR001_Equipo_pkey" PRIMARY KEY ("id_Equipo");

ALTER TABLE "TR001_Equipo" CLUSTER ON "TR001_Equipo_pkey";


--
-- TOC entry 1654 (class 2606 OID 246301298)
-- Dependencies: 1254 1254
-- Name: TR001_Historial_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Historial"
    ADD CONSTRAINT "TR001_Historial_pkey" PRIMARY KEY ("id_Historial");

ALTER TABLE "TR001_Historial" CLUSTER ON "TR001_Historial_pkey";


--
-- TOC entry 1656 (class 2606 OID 246301300)
-- Dependencies: 1256 1256
-- Name: TR001_Metodo_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Metodo"
    ADD CONSTRAINT "TR001_Metodo_pkey" PRIMARY KEY (id_metodo);


--
-- TOC entry 1658 (class 2606 OID 246301302)
-- Dependencies: 1258 1258
-- Name: TR001_Modulos_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Modulos"
    ADD CONSTRAINT "TR001_Modulos_pkey" PRIMARY KEY ("id_Modulos");

ALTER TABLE "TR001_Modulos" CLUSTER ON "TR001_Modulos_pkey";


--
-- TOC entry 1660 (class 2606 OID 246301304)
-- Dependencies: 1260 1260
-- Name: TR001_Muestra_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Muestra"
    ADD CONSTRAINT "TR001_Muestra_pkey" PRIMARY KEY ("id_Muestra");

ALTER TABLE "TR001_Muestra" CLUSTER ON "TR001_Muestra_pkey";


--
-- TOC entry 1662 (class 2606 OID 246301306)
-- Dependencies: 1262 1262
-- Name: TR001_Parametros_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Parametros"
    ADD CONSTRAINT "TR001_Parametros_pkey" PRIMARY KEY ("id_Parametros");

ALTER TABLE "TR001_Parametros" CLUSTER ON "TR001_Parametros_pkey";


--
-- TOC entry 1664 (class 2606 OID 246301308)
-- Dependencies: 1264 1264
-- Name: TR001_Perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Perfiles"
    ADD CONSTRAINT "TR001_Perfiles_pkey" PRIMARY KEY ("id_Perfil");

ALTER TABLE "TR001_Perfiles" CLUSTER ON "TR001_Perfiles_pkey";


--
-- TOC entry 1666 (class 2606 OID 246301310)
-- Dependencies: 1266 1266
-- Name: TR001_Personal_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Personal"
    ADD CONSTRAINT "TR001_Personal_pkey" PRIMARY KEY ("id_Personal");

ALTER TABLE "TR001_Personal" CLUSTER ON "TR001_Personal_pkey";


--
-- TOC entry 1668 (class 2606 OID 246301312)
-- Dependencies: 1268 1268
-- Name: TR001_Productos_Deltaven_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Productos_Deltaven"
    ADD CONSTRAINT "TR001_Productos_Deltaven_pkey" PRIMARY KEY ("id_Producto");

ALTER TABLE "TR001_Productos_Deltaven" CLUSTER ON "TR001_Productos_Deltaven_pkey";


--
-- TOC entry 1670 (class 2606 OID 246301314)
-- Dependencies: 1270 1270
-- Name: TR001_Resultado_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Resultado"
    ADD CONSTRAINT "TR001_Resultado_pkey" PRIMARY KEY (id_resultado);


--
-- TOC entry 1672 (class 2606 OID 246301316)
-- Dependencies: 1272 1272
-- Name: TR001_Solicitud_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Solicitud"
    ADD CONSTRAINT "TR001_Solicitud_pkey" PRIMARY KEY ("id_Solicitud");

ALTER TABLE "TR001_Solicitud" CLUSTER ON "TR001_Solicitud_pkey";


--
-- TOC entry 1674 (class 2606 OID 246301318)
-- Dependencies: 1274 1274
-- Name: TR001_Status_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Status"
    ADD CONSTRAINT "TR001_Status_pkey" PRIMARY KEY ("id_Status");

ALTER TABLE "TR001_Status" CLUSTER ON "TR001_Status_pkey";


--
-- TOC entry 1676 (class 2606 OID 246301320)
-- Dependencies: 1276 1276
-- Name: TR001_Zona_pkey; Type: CONSTRAINT; Schema: public; Owner: sislub_adm; Tablespace: 
--

ALTER TABLE ONLY "TR001_Zona"
    ADD CONSTRAINT "TR001_Zona_pkey" PRIMARY KEY (id_zona);


--
-- TOC entry 1702 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO sislub_adm;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 1703 (class 0 OID 0)
-- Dependencies: 1236
-- Name: TH001_Roles; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TH001_Roles" FROM PUBLIC;
REVOKE ALL ON TABLE "TH001_Roles" FROM sislub_adm;
GRANT ALL ON TABLE "TH001_Roles" TO sislub_adm;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "TH001_Roles" TO sislub_usuarios;


--
-- TOC entry 1706 (class 0 OID 0)
-- Dependencies: 1235
-- Name: TH001_Roles_id_Roles_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TH001_Roles_id_Roles_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TH001_Roles_id_Roles_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TH001_Roles_id_Roles_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TH001_Roles_id_Roles_seq" TO sislub_usuarios;


--
-- TOC entry 1707 (class 0 OID 0)
-- Dependencies: 1238
-- Name: TR001_Accion; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Accion" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Accion" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Accion" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Accion" TO sislub_usuarios;


--
-- TOC entry 1710 (class 0 OID 0)
-- Dependencies: 1237
-- Name: TR001_Accion_id_Accion_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Accion_id_Accion_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Accion_id_Accion_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Accion_id_Accion_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Accion_id_Accion_seq" TO sislub_usuarios;


--
-- TOC entry 1711 (class 0 OID 0)
-- Dependencies: 1240
-- Name: TR001_Cargos; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Cargos" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Cargos" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Cargos" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Cargos" TO sislub_usuarios;


--
-- TOC entry 1714 (class 0 OID 0)
-- Dependencies: 1239
-- Name: TR001_Cargos_id_cargo_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Cargos_id_cargo_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Cargos_id_cargo_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Cargos_id_cargo_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Cargos_id_cargo_seq" TO sislub_usuarios;


--
-- TOC entry 1725 (class 0 OID 0)
-- Dependencies: 1242
-- Name: TR001_Certificado; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Certificado" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Certificado" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Certificado" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Certificado" TO sislub_usuarios;


--
-- TOC entry 1728 (class 0 OID 0)
-- Dependencies: 1241
-- Name: TR001_Certificado_id_certificado_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Certificado_id_certificado_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Certificado_id_certificado_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Certificado_id_certificado_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Certificado_id_certificado_seq" TO sislub_usuarios;


--
-- TOC entry 1729 (class 0 OID 0)
-- Dependencies: 1244
-- Name: TR001_Cliente; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Cliente" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Cliente" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Cliente" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Cliente" TO sislub_usuarios;


--
-- TOC entry 1732 (class 0 OID 0)
-- Dependencies: 1243
-- Name: TR001_Cliente_id_Cliente_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Cliente_id_Cliente_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Cliente_id_Cliente_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Cliente_id_Cliente_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Cliente_id_Cliente_seq" TO sislub_usuarios;


--
-- TOC entry 1739 (class 0 OID 0)
-- Dependencies: 1246
-- Name: TR001_Cuenta_Acceso; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Cuenta_Acceso" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Cuenta_Acceso" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Cuenta_Acceso" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Cuenta_Acceso" TO sislub_usuarios;


--
-- TOC entry 1742 (class 0 OID 0)
-- Dependencies: 1245
-- Name: TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq" TO sislub_usuarios;


--
-- TOC entry 1743 (class 0 OID 0)
-- Dependencies: 1248
-- Name: TR001_Distribuidores; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Distribuidores" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Distribuidores" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Distribuidores" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Distribuidores" TO sislub_usuarios;


--
-- TOC entry 1746 (class 0 OID 0)
-- Dependencies: 1247
-- Name: TR001_Distribuidores_id_Distribuidor_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Distribuidores_id_Distribuidor_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Distribuidores_id_Distribuidor_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Distribuidores_id_Distribuidor_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Distribuidores_id_Distribuidor_seq" TO sislub_usuarios;


--
-- TOC entry 1747 (class 0 OID 0)
-- Dependencies: 1250
-- Name: TR001_Empresa_Transporte; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Empresa_Transporte" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Empresa_Transporte" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Empresa_Transporte" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Empresa_Transporte" TO sislub_usuarios;


--
-- TOC entry 1750 (class 0 OID 0)
-- Dependencies: 1249
-- Name: TR001_Empresa_Transporte_id_Empresa_Transporte_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Empresa_Transporte_id_Empresa_Transporte_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Empresa_Transporte_id_Empresa_Transporte_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Empresa_Transporte_id_Empresa_Transporte_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Empresa_Transporte_id_Empresa_Transporte_seq" TO sislub_usuarios;


--
-- TOC entry 1751 (class 0 OID 0)
-- Dependencies: 1252
-- Name: TR001_Equipo; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Equipo" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Equipo" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Equipo" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Equipo" TO sislub_usuarios;


--
-- TOC entry 1754 (class 0 OID 0)
-- Dependencies: 1251
-- Name: TR001_Equipo_id_Equipo_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Equipo_id_Equipo_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Equipo_id_Equipo_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Equipo_id_Equipo_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Equipo_id_Equipo_seq" TO sislub_usuarios;


--
-- TOC entry 1756 (class 0 OID 0)
-- Dependencies: 1254
-- Name: TR001_Historial; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Historial" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Historial" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Historial" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Historial" TO sislub_usuarios;


--
-- TOC entry 1759 (class 0 OID 0)
-- Dependencies: 1253
-- Name: TR001_Historial_id_Historial_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Historial_id_Historial_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Historial_id_Historial_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Historial_id_Historial_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Historial_id_Historial_seq" TO sislub_usuarios;


--
-- TOC entry 1762 (class 0 OID 0)
-- Dependencies: 1256
-- Name: TR001_Metodo; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Metodo" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Metodo" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Metodo" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Metodo" TO sislub_usuarios;


--
-- TOC entry 1765 (class 0 OID 0)
-- Dependencies: 1255
-- Name: TR001_Metodo_id_metodo_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Metodo_id_metodo_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Metodo_id_metodo_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Metodo_id_metodo_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Metodo_id_metodo_seq" TO sislub_usuarios;


--
-- TOC entry 1766 (class 0 OID 0)
-- Dependencies: 1258
-- Name: TR001_Modulos; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Modulos" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Modulos" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Modulos" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Modulos" TO sislub_usuarios;


--
-- TOC entry 1769 (class 0 OID 0)
-- Dependencies: 1257
-- Name: TR001_Modulos_id_Modulos_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Modulos_id_Modulos_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Modulos_id_Modulos_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Modulos_id_Modulos_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Modulos_id_Modulos_seq" TO sislub_usuarios;


--
-- TOC entry 1771 (class 0 OID 0)
-- Dependencies: 1260
-- Name: TR001_Muestra; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Muestra" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Muestra" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Muestra" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Muestra" TO sislub_usuarios;


--
-- TOC entry 1774 (class 0 OID 0)
-- Dependencies: 1259
-- Name: TR001_Muestra_id_Muestra_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Muestra_id_Muestra_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Muestra_id_Muestra_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Muestra_id_Muestra_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Muestra_id_Muestra_seq" TO sislub_usuarios;


--
-- TOC entry 1775 (class 0 OID 0)
-- Dependencies: 1262
-- Name: TR001_Parametros; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Parametros" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Parametros" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Parametros" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Parametros" TO sislub_usuarios;


--
-- TOC entry 1778 (class 0 OID 0)
-- Dependencies: 1261
-- Name: TR001_Parametros_id_Parametros_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Parametros_id_Parametros_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Parametros_id_Parametros_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Parametros_id_Parametros_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Parametros_id_Parametros_seq" TO sislub_usuarios;


--
-- TOC entry 1779 (class 0 OID 0)
-- Dependencies: 1264
-- Name: TR001_Perfiles; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Perfiles" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Perfiles" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Perfiles" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Perfiles" TO sislub_usuarios;


--
-- TOC entry 1782 (class 0 OID 0)
-- Dependencies: 1263
-- Name: TR001_Perfiles_id_Perfil_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Perfiles_id_Perfil_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Perfiles_id_Perfil_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Perfiles_id_Perfil_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Perfiles_id_Perfil_seq" TO sislub_usuarios;


--
-- TOC entry 1783 (class 0 OID 0)
-- Dependencies: 1266
-- Name: TR001_Personal; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Personal" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Personal" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Personal" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Personal" TO sislub_usuarios;


--
-- TOC entry 1786 (class 0 OID 0)
-- Dependencies: 1265
-- Name: TR001_Personal_id_Personal_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Personal_id_Personal_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Personal_id_Personal_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Personal_id_Personal_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Personal_id_Personal_seq" TO sislub_usuarios;


--
-- TOC entry 1787 (class 0 OID 0)
-- Dependencies: 1268
-- Name: TR001_Productos_Deltaven; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Productos_Deltaven" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Productos_Deltaven" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Productos_Deltaven" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Productos_Deltaven" TO sislub_usuarios;


--
-- TOC entry 1790 (class 0 OID 0)
-- Dependencies: 1267
-- Name: TR001_Productos_Deltaven_id_Producto_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Productos_Deltaven_id_Producto_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Productos_Deltaven_id_Producto_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Productos_Deltaven_id_Producto_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Productos_Deltaven_id_Producto_seq" TO sislub_usuarios;


--
-- TOC entry 1793 (class 0 OID 0)
-- Dependencies: 1270
-- Name: TR001_Resultado; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Resultado" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Resultado" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Resultado" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Resultado" TO sislub_usuarios;


--
-- TOC entry 1796 (class 0 OID 0)
-- Dependencies: 1269
-- Name: TR001_Resultado_id_resultado_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Resultado_id_resultado_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Resultado_id_resultado_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Resultado_id_resultado_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Resultado_id_resultado_seq" TO sislub_usuarios;


--
-- TOC entry 1803 (class 0 OID 0)
-- Dependencies: 1272
-- Name: TR001_Solicitud; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Solicitud" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Solicitud" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Solicitud" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Solicitud" TO sislub_usuarios;


--
-- TOC entry 1806 (class 0 OID 0)
-- Dependencies: 1271
-- Name: TR001_Solicitud_id_Solicitud_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Solicitud_id_Solicitud_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Solicitud_id_Solicitud_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Solicitud_id_Solicitud_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Solicitud_id_Solicitud_seq" TO sislub_usuarios;


--
-- TOC entry 1807 (class 0 OID 0)
-- Dependencies: 1274
-- Name: TR001_Status; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Status" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Status" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Status" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Status" TO sislub_usuarios;


--
-- TOC entry 1810 (class 0 OID 0)
-- Dependencies: 1273
-- Name: TR001_Status_id_Status_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Status_id_Status_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Status_id_Status_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Status_id_Status_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Status_id_Status_seq" TO sislub_usuarios;


--
-- TOC entry 1811 (class 0 OID 0)
-- Dependencies: 1276
-- Name: TR001_Zona; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON TABLE "TR001_Zona" FROM PUBLIC;
REVOKE ALL ON TABLE "TR001_Zona" FROM sislub_adm;
GRANT ALL ON TABLE "TR001_Zona" TO sislub_adm;
GRANT SELECT,INSERT,UPDATE ON TABLE "TR001_Zona" TO sislub_usuarios;


--
-- TOC entry 1814 (class 0 OID 0)
-- Dependencies: 1275
-- Name: TR001_Zona_id_zona_seq; Type: ACL; Schema: public; Owner: sislub_adm
--

REVOKE ALL ON SEQUENCE "TR001_Zona_id_zona_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "TR001_Zona_id_zona_seq" FROM sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Zona_id_zona_seq" TO sislub_adm;
GRANT SELECT,UPDATE ON SEQUENCE "TR001_Zona_id_zona_seq" TO sislub_usuarios;


-- Completed on 2009-07-31 16:41:36

--
-- PostgreSQL database dump complete
--

