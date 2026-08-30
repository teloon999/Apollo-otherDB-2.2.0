--
-- Kingbase database dump
--

-- Dumped from database version 12.1
-- Dumped by sys_dump version 12.1

-- Started on 2024-02-07 14:40:28

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', 'public', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 292 (class 1259 OID 693845)
-- Name: App; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."App" (
    "Id" bigint NOT NULL,
    "AppId" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "Name" character varying(500) DEFAULT 'default'::character varying NOT NULL,
    "OrgId" character varying(32) DEFAULT 'default'::character varying NOT NULL,
    "OrgName" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "OwnerName" character varying(500) DEFAULT 'default'::character varying NOT NULL,
    "OwnerEmail" character varying(500) DEFAULT 'default'::character varying NOT NULL,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."App" OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 693960)
-- Name: AppNamespace; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AppNamespace" (
    "Id" bigint NOT NULL,
    "Name" character varying(32) DEFAULT ''::character varying NOT NULL,
    "AppId" character varying(64) DEFAULT ''::character varying NOT NULL,
    "Format" character varying(32) DEFAULT 'properties'::character varying NOT NULL,
    "IsPublic" boolean DEFAULT false NOT NULL,
    "Comment" character varying(64) DEFAULT ''::character varying NOT NULL,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."AppNamespace" OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 693958)
-- Name: AppNamespace_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AppNamespace_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AppNamespace_Id_seq" OWNER TO postgres;

--
-- TOC entry 3933 (class 0 OID 0)
-- Dependencies: 305
-- Name: AppNamespace_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AppNamespace_Id_seq" OWNED BY public."AppNamespace"."Id";


--
-- TOC entry 291 (class 1259 OID 693843)
-- Name: App_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."App_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."App_Id_seq" OWNER TO postgres;

--
-- TOC entry 3934 (class 0 OID 0)
-- Dependencies: 291
-- Name: App_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."App_Id_seq" OWNED BY public."App"."Id";


--
-- TOC entry 278 (class 1259 OID 693736)
-- Name: AuditLog; Type: TABLE; Schema: public; Owner: postgres
--


CREATE TABLE public."AuditLog" (
    "id" bigint NOT NULL,
    "traceid" character varying(32) DEFAULT ''::character varying NOT NULL,
    "spanid" character varying(32) DEFAULT ''::character varying NOT NULL,
    "parentspanid" character varying(32),
    "followsfromspanid" character varying(32),
    "operator" character varying(64) DEFAULT 'anonymous'::character varying NOT NULL,
    "optype" character varying(50) DEFAULT 'default'::character varying NOT NULL,
    "opname" character varying(150) DEFAULT 'default'::character varying NOT NULL,
    "description" character varying(200),
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64),
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE public."AuditLog" OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 693904)
-- Name: AuditLogDataInfluence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AuditLogDataInfluence" (
    "Id" bigint NOT NULL,
    "spanid" character(32) DEFAULT ''::bpchar NOT NULL,
    "influenceentityid" character varying(50) DEFAULT '0'::character varying NOT NULL,
    "influenceentityname" character varying(50) DEFAULT 'default'::character varying NOT NULL,
    "fieldname" character varying(50),
    "fieldoldvalue" character varying(500),
    "fieldnewvalue" character varying(500),
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64),
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."AuditLogDataInfluence" OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 693902)
-- Name: AuditLogDataInfluence_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AuditLogDataInfluence_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AuditLogDataInfluence_Id_seq" OWNER TO postgres;

--
-- TOC entry 3935 (class 0 OID 0)
-- Dependencies: 297
-- Name: AuditLogDataInfluence_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AuditLogDataInfluence_Id_seq" OWNED BY public."AuditLogDataInfluence"."Id";


--
-- TOC entry 277 (class 1259 OID 693734)
-- Name: AuditLog_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AuditLog_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AuditLog_Id_seq" OWNER TO postgres;

--
-- TOC entry 3936 (class 0 OID 0)
-- Dependencies: 277
-- Name: AuditLog_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AuditLog_Id_seq" OWNED BY public."AuditLog"."id";


--
-- TOC entry 276 (class 1259 OID 693729)
-- Name: Authorities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Authorities" (
    "Id" bigint NOT NULL,
    "Username" character varying(64) NOT NULL,
    "Authority" character varying(50) NOT NULL
);


ALTER TABLE public."Authorities" OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 693727)
-- Name: Authorities_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Authorities_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Authorities_Id_seq" OWNER TO postgres;

--
-- TOC entry 3937 (class 0 OID 0)
-- Dependencies: 275
-- Name: Authorities_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Authorities_Id_seq" OWNED BY public."Authorities"."Id";


--
-- TOC entry 284 (class 1259 OID 693786)
-- Name: Consumer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Consumer" (
    "Id" bigint NOT NULL,
    "AppId" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "Name" character varying(500) DEFAULT 'default'::character varying NOT NULL,
    "OrgId" character varying(32) DEFAULT 'default'::character varying NOT NULL,
    "OrgName" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "OwnerName" character varying(500) DEFAULT 'default'::character varying NOT NULL,
    "OwnerEmail" character varying(500) DEFAULT 'default'::character varying NOT NULL,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."Consumer" OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 693756)
-- Name: ConsumerAudit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ConsumerAudit" (
    "Id" bigint NOT NULL,
    "ConsumerId" bigint,
    "Uri" character varying(1024) DEFAULT ''::character varying NOT NULL,
    "Method" character varying(16) DEFAULT ''::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."ConsumerAudit" OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 693754)
-- Name: ConsumerAudit_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ConsumerAudit_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ConsumerAudit_Id_seq" OWNER TO postgres;

--
-- TOC entry 3938 (class 0 OID 0)
-- Dependencies: 279
-- Name: ConsumerAudit_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ConsumerAudit_Id_seq" OWNED BY public."ConsumerAudit"."Id";


--
-- TOC entry 288 (class 1259 OID 693826)
-- Name: ConsumerRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ConsumerRole" (
    "Id" bigint NOT NULL,
    "ConsumerId" bigint,
    "RoleId" bigint,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."ConsumerRole" OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 693824)
-- Name: ConsumerRole_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ConsumerRole_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ConsumerRole_Id_seq" OWNER TO postgres;

--
-- TOC entry 3939 (class 0 OID 0)
-- Dependencies: 287
-- Name: ConsumerRole_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ConsumerRole_Id_seq" OWNED BY public."ConsumerRole"."Id";


--
-- TOC entry 296 (class 1259 OID 693889)
-- Name: ConsumerToken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ConsumerToken" (
    "Id" bigint NOT NULL,
    "ConsumerId" bigint,
    "Token" character varying(128) DEFAULT ''::character varying NOT NULL,
    "Expires" timestamp(0) without time zone DEFAULT '2099-01-01 00:00:00'::timestamp without time zone NOT NULL,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."ConsumerToken" OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 693884)
-- Name: ConsumerToken_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ConsumerToken_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ConsumerToken_Id_seq" OWNER TO postgres;

--
-- TOC entry 3940 (class 0 OID 0)
-- Dependencies: 295
-- Name: ConsumerToken_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ConsumerToken_Id_seq" OWNED BY public."ConsumerToken"."Id";


--
-- TOC entry 283 (class 1259 OID 693784)
-- Name: Consumer_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Consumer_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Consumer_Id_seq" OWNER TO postgres;

--
-- TOC entry 3941 (class 0 OID 0)
-- Dependencies: 283
-- Name: Consumer_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Consumer_Id_seq" OWNED BY public."Consumer"."Id";


--
-- TOC entry 282 (class 1259 OID 693770)
-- Name: Favorite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Favorite" (
    "Id" bigint NOT NULL,
    "UserId" character varying(32) DEFAULT 'default'::character varying NOT NULL,
    "AppId" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "Position" integer DEFAULT 10000 NOT NULL,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."Favorite" OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 693768)
-- Name: Favorite_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Favorite_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Favorite_Id_seq" OWNER TO postgres;

--
-- TOC entry 3942 (class 0 OID 0)
-- Dependencies: 281
-- Name: Favorite_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Favorite_Id_seq" OWNED BY public."Favorite"."Id";


--
-- TOC entry 302 (class 1259 OID 693931)
-- Name: Permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Permission" (
    "Id" bigint NOT NULL,
    "PermissionType" character varying(32) DEFAULT ''::character varying NOT NULL,
    "TargetId" character varying(256) DEFAULT ''::character varying NOT NULL,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."Permission" OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 693929)
-- Name: Permission_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Permission_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Permission_Id_seq" OWNER TO postgres;

--
-- TOC entry 3943 (class 0 OID 0)
-- Dependencies: 301
-- Name: Permission_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Permission_Id_seq" OWNED BY public."Permission"."Id";


--
-- TOC entry 304 (class 1259 OID 693946)
-- Name: Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Role" (
    "Id" bigint NOT NULL,
    "RoleName" character varying(256) DEFAULT ''::character varying NOT NULL,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."Role" OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 693840)
-- Name: RolePermission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RolePermission" (
    "Id" bigint NOT NULL,
    "RoleId" bigint,
    "PermissionId" bigint,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."RolePermission" OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 693838)
-- Name: RolePermission_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."RolePermission_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."RolePermission_Id_seq" OWNER TO postgres;

--
-- TOC entry 3944 (class 0 OID 0)
-- Dependencies: 289
-- Name: RolePermission_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."RolePermission_Id_seq" OWNED BY public."RolePermission"."Id";


--
-- TOC entry 303 (class 1259 OID 693940)
-- Name: Role_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Role_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Role_Id_seq" OWNER TO postgres;

--
-- TOC entry 3945 (class 0 OID 0)
-- Dependencies: 303
-- Name: Role_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Role_Id_seq" OWNED BY public."Role"."Id";


--
-- TOC entry 300 (class 1259 OID 693926)
-- Name: SPRING_SESSION; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SPRING_SESSION" (
    "PRIMARY_ID" character(36) NOT NULL,
    "SESSION_ID" character(36) NOT NULL,
    "CREATION_TIME" bigint NOT NULL,
    "LAST_ACCESS_TIME" bigint NOT NULL,
    "MAX_INACTIVE_INTERVAL" integer NOT NULL,
    "EXPIRY_TIME" bigint NOT NULL,
    "PRINCIPAL_NAME" character varying(100)
);


ALTER TABLE public."SPRING_SESSION" OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 693920)
-- Name: SPRING_SESSION_ATTRIBUTES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SPRING_SESSION_ATTRIBUTES" (
    "SESSION_PRIMARY_ID" character(36) NOT NULL,
    "ATTRIBUTE_NAME" character varying(200) NOT NULL,
    "ATTRIBUTE_BYTES" bytea NOT NULL
);


ALTER TABLE public."SPRING_SESSION_ATTRIBUTES" OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 693808)
-- Name: ServerConfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ServerConfig" (
    "Id" bigint NOT NULL,
    "Key" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "Value" character varying(2048) DEFAULT 'default'::character varying NOT NULL,
    "Comment" character varying(1024) DEFAULT ''::character varying,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."ServerConfig" OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 693805)
-- Name: ServerConfig_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ServerConfig_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ServerConfig_Id_seq" OWNER TO postgres;

--
-- TOC entry 3946 (class 0 OID 0)
-- Dependencies: 285
-- Name: ServerConfig_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ServerConfig_Id_seq" OWNED BY public."ServerConfig"."Id";


--
-- TOC entry 294 (class 1259 OID 693875)
-- Name: UserRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserRole" (
    "Id" bigint NOT NULL,
    "UserId" character varying(128) DEFAULT ''::character varying,
    "RoleId" bigint,
    "IsDeleted" smallint DEFAULT 0 NOT NULL,
    "DeletedAt" bigint DEFAULT 0 NOT NULL,
    "DataChange_CreatedBy" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "DataChange_CreatedTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "DataChange_LastModifiedBy" character varying(64) DEFAULT ''::character varying,
    "DataChange_LastTime" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."UserRole" OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 693873)
-- Name: UserRole_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserRole_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UserRole_Id_seq" OWNER TO postgres;

--
-- TOC entry 3947 (class 0 OID 0)
-- Dependencies: 293
-- Name: UserRole_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserRole_Id_seq" OWNED BY public."UserRole"."Id";


--
-- TOC entry 274 (class 1259 OID 693715)
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    "Id" bigint NOT NULL,
    "Username" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "Password" character varying(512) DEFAULT 'default'::character varying NOT NULL,
    "UserDisplayName" character varying(512) DEFAULT 'default'::character varying NOT NULL,
    "Email" character varying(64) DEFAULT 'default'::character varying NOT NULL,
    "Enabled" smallint
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 693713)
-- Name: Users_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Users_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Users_Id_seq" OWNER TO postgres;

--
-- TOC entry 3948 (class 0 OID 0)
-- Dependencies: 273
-- Name: Users_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Users_Id_seq" OWNED BY public."Users"."Id";


--
-- TOC entry 307 (class 1259 OID 694467)
-- Name: spring_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spring_session (
    primary_id character(36) NOT NULL,
    session_id character(36) NOT NULL,
    creation_time bigint NOT NULL,
    last_access_time bigint NOT NULL,
    max_inactive_interval integer NOT NULL,
    expiry_time bigint NOT NULL,
    principal_name character varying(100)
);


ALTER TABLE public.spring_session OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 694482)
-- Name: spring_session_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spring_session_attributes (
    session_primary_id character(36) NOT NULL,
    attribute_name character varying(200) NOT NULL,
    attribute_bytes bytea NOT NULL
);


ALTER TABLE public.spring_session_attributes OWNER TO postgres;

--
-- TOC entry 3573 (class 2604 OID 693850)
-- Name: App Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."App" ALTER COLUMN "Id" SET DEFAULT nextval('public."App_Id_seq"'::regclass);


--
-- TOC entry 3630 (class 2604 OID 693963)
-- Name: AppNamespace Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AppNamespace" ALTER COLUMN "Id" SET DEFAULT nextval('public."AppNamespace_Id_seq"'::regclass);


--
-- TOC entry 3510 (class 2604 OID 693739)
-- Name: AuditLog Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AuditLog" ALTER COLUMN "id" SET DEFAULT nextval('public."AuditLog_Id_seq"'::regclass);


--
-- TOC entry 3603 (class 2604 OID 693907)
-- Name: AuditLogDataInfluence Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AuditLogDataInfluence" ALTER COLUMN "Id" SET DEFAULT nextval('public."AuditLogDataInfluence_Id_seq"'::regclass);


--
-- TOC entry 3508 (class 2604 OID 693732)
-- Name: Authorities Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Authorities" ALTER COLUMN "Id" SET DEFAULT nextval('public."Authorities_Id_seq"'::regclass);


--
-- TOC entry 3536 (class 2604 OID 693789)
-- Name: Consumer Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Consumer" ALTER COLUMN "Id" SET DEFAULT nextval('public."Consumer_Id_seq"'::regclass);


--
-- TOC entry 3520 (class 2604 OID 693759)
-- Name: ConsumerAudit Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ConsumerAudit" ALTER COLUMN "Id" SET DEFAULT nextval('public."ConsumerAudit_Id_seq"'::regclass);


--
-- TOC entry 3559 (class 2604 OID 693829)
-- Name: ConsumerRole Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ConsumerRole" ALTER COLUMN "Id" SET DEFAULT nextval('public."ConsumerRole_Id_seq"'::regclass);


--
-- TOC entry 3594 (class 2604 OID 693892)
-- Name: ConsumerToken Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ConsumerToken" ALTER COLUMN "Id" SET DEFAULT nextval('public."ConsumerToken_Id_seq"'::regclass);


--
-- TOC entry 3526 (class 2604 OID 693773)
-- Name: Favorite Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Favorite" ALTER COLUMN "Id" SET DEFAULT nextval('public."Favorite_Id_seq"'::regclass);


--
-- TOC entry 3612 (class 2604 OID 693934)
-- Name: Permission Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permission" ALTER COLUMN "Id" SET DEFAULT nextval('public."Permission_Id_seq"'::regclass);


--
-- TOC entry 3621 (class 2604 OID 693949)
-- Name: Role Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Role" ALTER COLUMN "Id" SET DEFAULT nextval('public."Role_Id_seq"'::regclass);


--
-- TOC entry 3566 (class 2604 OID 693848)
-- Name: RolePermission Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RolePermission" ALTER COLUMN "Id" SET DEFAULT nextval('public."RolePermission_Id_seq"'::regclass);


--
-- TOC entry 3549 (class 2604 OID 693811)
-- Name: ServerConfig Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ServerConfig" ALTER COLUMN "Id" SET DEFAULT nextval('public."ServerConfig_Id_seq"'::regclass);


--
-- TOC entry 3586 (class 2604 OID 693878)
-- Name: UserRole Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole" ALTER COLUMN "Id" SET DEFAULT nextval('public."UserRole_Id_seq"'::regclass);


--
-- TOC entry 3503 (class 2604 OID 693718)
-- Name: Users Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users" ALTER COLUMN "Id" SET DEFAULT nextval('public."Users_Id_seq"'::regclass);


--
-- TOC entry 3908 (class 0 OID 693845)
-- Dependencies: 292
-- Data for Name: App; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."App" ("Id", "AppId", "Name", "OrgId", "OrgName", "OwnerName", "OwnerEmail", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
\.


--
-- TOC entry 3922 (class 0 OID 693960)
-- Dependencies: 306
-- Data for Name: AppNamespace; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AppNamespace" ("Id", "Name", "AppId", "Format", "IsPublic", "Comment", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
\.


--
-- TOC entry 3894 (class 0 OID 693736)
-- Dependencies: 278
-- Data for Name: AuditLog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AuditLog" ("id", "traceid", "spanid", "parentspanid", "followsfromspanid", "operator", "optype", "opname", "description", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
\.


--
-- TOC entry 3914 (class 0 OID 693904)
-- Dependencies: 298
-- Data for Name: AuditLogDataInfluence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AuditLogDataInfluence" ("Id", "spanid", "influenceentityid", "influenceentityname", "fieldname", "fieldoldvalue", "fieldnewvalue", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
\.


--
-- TOC entry 3892 (class 0 OID 693729)
-- Dependencies: 276
-- Data for Name: Authorities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Authorities" ("Id", "Username", "Authority") FROM stdin;
1	apollo	ROLE_user
\.


--
-- TOC entry 3900 (class 0 OID 693786)
-- Dependencies: 284
-- Data for Name: Consumer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Consumer" ("Id", "AppId", "Name", "OrgId", "OrgName", "OwnerName", "OwnerEmail", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
\.


--
-- TOC entry 3896 (class 0 OID 693756)
-- Dependencies: 280
-- Data for Name: ConsumerAudit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ConsumerAudit" ("Id", "ConsumerId", "Uri", "Method", "DataChange_CreatedTime", "DataChange_LastTime") FROM stdin;
\.


--
-- TOC entry 3904 (class 0 OID 693826)
-- Dependencies: 288
-- Data for Name: ConsumerRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ConsumerRole" ("Id", "ConsumerId", "RoleId", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
\.


--
-- TOC entry 3912 (class 0 OID 693889)
-- Dependencies: 296
-- Data for Name: ConsumerToken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ConsumerToken" ("Id", "ConsumerId", "Token", "Expires", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
\.


--
-- TOC entry 3898 (class 0 OID 693770)
-- Dependencies: 282
-- Data for Name: Favorite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Favorite" ("Id", "UserId", "AppId", "Position", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
\.


--
-- TOC entry 3918 (class 0 OID 693931)
-- Dependencies: 302
-- Data for Name: Permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Permission" ("Id", "PermissionType", "TargetId", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
4	CreateApplication	SystemRole	0	0	apollo	2024-02-07 10:22:27	apollo	2024-02-07 10:22:27
5	CreateNamespace	test	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
6	CreateCluster	test	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
7	AssignRole	test	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
8	ManageAppMaster	test	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
9	ModifyNamespace	test+application	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
10	ReleaseNamespace	test+application	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
11	ModifyNamespace	test+application+DEV	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
12	ReleaseNamespace	test+application+DEV	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
13	CreateNamespace	test	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
14	AssignRole	test	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
15	CreateCluster	test	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
16	ManageAppMaster	test	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
17	ModifyNamespace	test+application	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
18	ReleaseNamespace	test+application	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
19	ModifyNamespace	test+application+DEV	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
20	ReleaseNamespace	test+application+DEV	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
21	CreateCluster	aaa	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
22	CreateNamespace	aaa	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
23	AssignRole	aaa	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
24	ManageAppMaster	aaa	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
25	ModifyNamespace	aaa+application	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
26	ReleaseNamespace	aaa+application	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
27	ModifyNamespace	aaa+application+DEV	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
28	ReleaseNamespace	aaa+application+DEV	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
29	CreateCluster	aaa	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
30	CreateNamespace	aaa	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
31	AssignRole	aaa	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
32	ManageAppMaster	aaa	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
33	ModifyNamespace	aaa+application	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
34	ReleaseNamespace	aaa+application	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
35	ModifyNamespace	aaa+application+DEV	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
36	ReleaseNamespace	aaa+application+DEV	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
37	CreateNamespace	bbb	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
38	AssignRole	bbb	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
39	CreateCluster	bbb	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
40	ManageAppMaster	bbb	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
41	ModifyNamespace	bbb+application	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
42	ReleaseNamespace	bbb+application	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
43	ModifyNamespace	bbb+application+DEV	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
44	ReleaseNamespace	bbb+application+DEV	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
\.


--
-- TOC entry 3920 (class 0 OID 693946)
-- Dependencies: 304
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Role" ("Id", "RoleName", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
2	CreateApplication+SystemRole	0	0	apollo	2024-02-07 10:22:27	apollo	2024-02-07 10:22:27
3	Master+test	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
4	ManageAppMaster+test	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
5	ModifyNamespace+test+application	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
6	ReleaseNamespace+test+application	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
7	ModifyNamespace+test+application+DEV	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
8	ReleaseNamespace+test+application+DEV	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
9	Master+test	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
10	ManageAppMaster+test	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
11	ModifyNamespace+test+application	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
12	ReleaseNamespace+test+application	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
13	ModifyNamespace+test+application+DEV	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
14	ReleaseNamespace+test+application+DEV	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
15	Master+aaa	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
16	ManageAppMaster+aaa	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
17	ModifyNamespace+aaa+application	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
18	ReleaseNamespace+aaa+application	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
19	ModifyNamespace+aaa+application+DEV	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
20	ReleaseNamespace+aaa+application+DEV	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
21	Master+aaa	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
22	ManageAppMaster+aaa	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
23	ModifyNamespace+aaa+application	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
24	ReleaseNamespace+aaa+application	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
25	ModifyNamespace+aaa+application+DEV	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
26	ReleaseNamespace+aaa+application+DEV	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
27	Master+bbb	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
28	ManageAppMaster+bbb	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
29	ModifyNamespace+bbb+application	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
30	ReleaseNamespace+bbb+application	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
31	ModifyNamespace+bbb+application+DEV	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
32	ReleaseNamespace+bbb+application+DEV	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
\.


--
-- TOC entry 3906 (class 0 OID 693840)
-- Dependencies: 290
-- Data for Name: RolePermission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RolePermission" ("Id", "RoleId", "PermissionId", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
1	2	4	0	0	apollo	2024-02-07 10:22:27	apollo	2024-02-07 10:22:27
2	3	5	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
3	3	6	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
4	3	7	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
5	4	8	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
6	5	9	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
7	6	10	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
8	7	11	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
9	8	12	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
10	9	13	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
11	9	14	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
12	9	15	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
13	10	16	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
14	11	17	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
15	12	18	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
16	13	19	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
17	14	20	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
18	15	21	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
19	15	22	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
20	15	23	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
21	16	24	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
22	17	25	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
23	18	26	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
24	19	27	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
25	20	28	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
26	21	29	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
27	21	30	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
28	21	31	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
29	22	32	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
30	23	33	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
31	24	34	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
32	25	35	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
33	26	36	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
34	27	37	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
35	27	38	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
36	27	39	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
37	28	40	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
38	29	41	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
39	30	42	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
40	31	43	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
41	32	44	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
\.


--
-- TOC entry 3916 (class 0 OID 693926)
-- Dependencies: 300
-- Data for Name: SPRING_SESSION; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SPRING_SESSION" ("PRIMARY_ID", "SESSION_ID", "CREATION_TIME", "LAST_ACCESS_TIME", "MAX_INACTIVE_INTERVAL", "EXPIRY_TIME", "PRINCIPAL_NAME") FROM stdin;
\.


--
-- TOC entry 3915 (class 0 OID 693920)
-- Dependencies: 299
-- Data for Name: SPRING_SESSION_ATTRIBUTES; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SPRING_SESSION_ATTRIBUTES" ("SESSION_PRIMARY_ID", "ATTRIBUTE_NAME", "ATTRIBUTE_BYTES") FROM stdin;
\.


--
-- TOC entry 3902 (class 0 OID 693808)
-- Dependencies: 286
-- Data for Name: ServerConfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ServerConfig" ("Id", "Key", "Value", "Comment", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
1	apollo.portal.envs	dev	可支持的环境列表	0	0	default	2024-02-04 09:42:48		2024-02-04 09:42:48
2	organizations	[{"orgId":"DEV","orgName":"研发中心"}]	部门列表	0	0	default	2024-02-04 09:42:48		2024-02-04 09:42:48
3	superAdmin	apollo	Portal超级管理员	0	0	default	2024-02-04 09:42:48		2024-02-04 09:42:48
4	api.readTimeout	10000	http接口read timeout	0	0	default	2024-02-04 09:42:48		2024-02-04 09:42:48
5	consumer.token.salt	someSalt	consumer token salt	0	0	default	2024-02-04 09:42:48		2024-02-04 09:42:48
6	admin.createPrivateNamespace.switch	true	是否允许项目管理员创建私有namespace	0	0	default	2024-02-04 09:42:48		2024-02-04 09:42:48
7	configView.memberOnly.envs	pro	只对项目成员显示配置信息的环境列表，多个env以英文逗号分隔	0	0	default	2024-02-04 09:42:48		2024-02-04 09:42:48
8	apollo.portal.meta.servers	{}	各环境Meta Service列表	0	0	default	2024-02-04 09:42:48		2024-02-04 09:42:48
\.


--
-- TOC entry 3910 (class 0 OID 693875)
-- Dependencies: 294
-- Data for Name: UserRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserRole" ("Id", "UserId", "RoleId", "IsDeleted", "DeletedAt", "DataChange_CreatedBy", "DataChange_CreatedTime", "DataChange_LastModifiedBy", "DataChange_LastTime") FROM stdin;
1	apollo	3	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
2	apollo	5	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
3	apollo	6	1	1707286575	apollo	2024-02-07 10:38:03	apollo	2024-02-07 10:38:03
4	apollo	9	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
5	apollo	11	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
6	apollo	12	1	1707286715	apollo	2024-02-07 14:16:25	apollo	2024-02-07 14:16:25
7	apollo	15	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
8	apollo	17	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
9	apollo	18	1	1707286947	apollo	2024-02-07 14:18:52	apollo	2024-02-07 14:18:52
10	apollo	21	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
11	apollo	23	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
12	apollo	24	1	1707287786	apollo	2024-02-07 14:22:40	apollo	2024-02-07 14:22:40
13	apollo	27	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
14	apollo	29	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
15	apollo	30	0	0	apollo	2024-02-07 14:36:40	apollo	2024-02-07 14:36:40
\.


--
-- TOC entry 3890 (class 0 OID 693715)
-- Dependencies: 274
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" ("Id", "Username", "Password", "UserDisplayName", "Email", "Enabled") FROM stdin;
1	apollo	$2a$10$7r20uS.BQ9uBpf3Baj3uQOZvMVvB1RN3PYoKE94gtz2.WAOuiiwXS	apollo	apollo@acme.com	1
\.


--
-- TOC entry 3923 (class 0 OID 694467)
-- Dependencies: 307
-- Data for Name: spring_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spring_session (primary_id, session_id, creation_time, last_access_time, max_inactive_interval, expiry_time, principal_name) FROM stdin;
\.


--
-- TOC entry 3924 (class 0 OID 694482)
-- Dependencies: 308
-- Data for Name: spring_session_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spring_session_attributes (session_primary_id, attribute_name, attribute_bytes) FROM stdin;
d9c2b822-898b-4b5e-b8ad-cc5ed1747d10	SPRING_SECURITY_CONTEXT	\\x7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e636f6e746578742e5365637572697479436f6e74657874496d706c222c2261757468656e7469636174696f6e223a7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e222c22617574686f726974696573223a5b226a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c6552616e646f6d4163636573734c697374222c5b7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f72697479222c22617574686f72697479223a22524f4c455f75736572227d5d5d2c2264657461696c73223a7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c73222c2272656d6f746541646472657373223a223132372e302e302e31222c2273657373696f6e4964223a2234326531616331332d383833652d343130652d626266632d616634306436353064666334227d2c2261757468656e74696361746564223a747275652c227072696e636970616c223a7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e55736572222c2270617373776f7264223a6e756c6c2c22757365726e616d65223a2261706f6c6c6f222c22617574686f726974696573223a5b226a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574222c5b7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f72697479222c22617574686f72697479223a22524f4c455f75736572227d5d5d2c226163636f756e744e6f6e45787069726564223a747275652c226163636f756e744e6f6e4c6f636b6564223a747275652c2263726564656e7469616c734e6f6e45787069726564223a747275652c22656e61626c6564223a747275657d2c2263726564656e7469616c73223a6e756c6c7d7d
188a2d74-5dee-4100-af30-a7f6b6d428b8	SPRING_SECURITY_CONTEXT	\\x7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e636f6e746578742e5365637572697479436f6e74657874496d706c222c2261757468656e7469636174696f6e223a7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e222c22617574686f726974696573223a5b226a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c6552616e646f6d4163636573734c697374222c5b7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f72697479222c22617574686f72697479223a22524f4c455f75736572227d5d5d2c2264657461696c73223a7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c73222c2272656d6f746541646472657373223a223132372e302e302e31222c2273657373696f6e4964223a2261313134353834662d316264312d343231302d613761302d623838636232356337336461227d2c2261757468656e74696361746564223a747275652c227072696e636970616c223a7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e55736572222c2270617373776f7264223a6e756c6c2c22757365726e616d65223a2261706f6c6c6f222c22617574686f726974696573223a5b226a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574222c5b7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f72697479222c22617574686f72697479223a22524f4c455f75736572227d5d5d2c226163636f756e744e6f6e45787069726564223a747275652c226163636f756e744e6f6e4c6f636b6564223a747275652c2263726564656e7469616c734e6f6e45787069726564223a747275652c22656e61626c6564223a747275657d2c2263726564656e7469616c73223a6e756c6c7d7d
2324f950-cd4d-49a0-ae2f-77a4fc207762	SPRING_SECURITY_CONTEXT	\\x7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e636f6e746578742e5365637572697479436f6e74657874496d706c222c2261757468656e7469636174696f6e223a7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e222c22617574686f726974696573223a5b226a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c6552616e646f6d4163636573734c697374222c5b7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f72697479222c22617574686f72697479223a22524f4c455f75736572227d5d5d2c2264657461696c73223a7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c73222c2272656d6f746541646472657373223a223132372e302e302e31222c2273657373696f6e4964223a2236383663653436312d613630622d346561352d616633352d303238666336623236623337227d2c2261757468656e74696361746564223a747275652c227072696e636970616c223a7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e55736572222c2270617373776f7264223a6e756c6c2c22757365726e616d65223a2261706f6c6c6f222c22617574686f726974696573223a5b226a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574222c5b7b2240636c617373223a226f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f72697479222c22617574686f72697479223a22524f4c455f75736572227d5d5d2c226163636f756e744e6f6e45787069726564223a747275652c226163636f756e744e6f6e4c6f636b6564223a747275652c2263726564656e7469616c734e6f6e45787069726564223a747275652c22656e61626c6564223a747275657d2c2263726564656e7469616c73223a6e756c6c7d7d
\.


--
-- TOC entry 3949 (class 0 OID 0)
-- Dependencies: 305
-- Name: AppNamespace_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AppNamespace_Id_seq"', 5, true);


--
-- TOC entry 3950 (class 0 OID 0)
-- Dependencies: 291
-- Name: App_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."App_Id_seq"', 5, true);


--
-- TOC entry 3951 (class 0 OID 0)
-- Dependencies: 297
-- Name: AuditLogDataInfluence_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AuditLogDataInfluence_Id_seq"', 112, true);


--
-- TOC entry 3952 (class 0 OID 0)
-- Dependencies: 277
-- Name: AuditLog_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AuditLog_Id_seq"', 82, true);


--
-- TOC entry 3953 (class 0 OID 0)
-- Dependencies: 275
-- Name: Authorities_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Authorities_Id_seq"', 2, false);


--
-- TOC entry 3954 (class 0 OID 0)
-- Dependencies: 279
-- Name: ConsumerAudit_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ConsumerAudit_Id_seq"', 1, false);


--
-- TOC entry 3955 (class 0 OID 0)
-- Dependencies: 287
-- Name: ConsumerRole_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ConsumerRole_Id_seq"', 1, false);


--
-- TOC entry 3956 (class 0 OID 0)
-- Dependencies: 295
-- Name: ConsumerToken_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ConsumerToken_Id_seq"', 1, false);


--
-- TOC entry 3957 (class 0 OID 0)
-- Dependencies: 283
-- Name: Consumer_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Consumer_Id_seq"', 1, false);


--
-- TOC entry 3958 (class 0 OID 0)
-- Dependencies: 281
-- Name: Favorite_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Favorite_Id_seq"', 23, false);


--
-- TOC entry 3959 (class 0 OID 0)
-- Dependencies: 301
-- Name: Permission_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Permission_Id_seq"', 44, true);


--
-- TOC entry 3960 (class 0 OID 0)
-- Dependencies: 289
-- Name: RolePermission_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."RolePermission_Id_seq"', 41, true);


--
-- TOC entry 3961 (class 0 OID 0)
-- Dependencies: 303
-- Name: Role_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Role_Id_seq"', 32, true);


--
-- TOC entry 3962 (class 0 OID 0)
-- Dependencies: 285
-- Name: ServerConfig_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ServerConfig_Id_seq"', 9, false);


--
-- TOC entry 3963 (class 0 OID 0)
-- Dependencies: 293
-- Name: UserRole_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserRole_Id_seq"', 15, true);


--
-- TOC entry 3964 (class 0 OID 0)
-- Dependencies: 273
-- Name: Users_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_Id_seq"', 2, false);


--
-- TOC entry 3705 (class 2606 OID 694014)
-- Name: AuditLogDataInfluence PRIMARY_11ECE35D; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AuditLogDataInfluence"
    ADD CONSTRAINT "PRIMARY_11ECE35D" PRIMARY KEY ("Id");


--
-- TOC entry 3693 (class 2606 OID 693991)
-- Name: UserRole PRIMARY_2EA9C8FC; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "PRIMARY_2EA9C8FC" PRIMARY KEY ("Id");


--
-- TOC entry 3659 (class 2606 OID 693979)
-- Name: Favorite PRIMARY_42F7B9B7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Favorite"
    ADD CONSTRAINT "PRIMARY_42F7B9B7" PRIMARY KEY ("Id");


--
-- TOC entry 3681 (class 2606 OID 693985)
-- Name: RolePermission PRIMARY_63002D00; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "PRIMARY_63002D00" PRIMARY KEY ("Id");


--
-- TOC entry 3645 (class 2606 OID 694004)
-- Name: Authorities PRIMARY_64031CFC; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Authorities"
    ADD CONSTRAINT "PRIMARY_64031CFC" PRIMARY KEY ("Id");


--
-- TOC entry 3709 (class 2606 OID 694001)
-- Name: SPRING_SESSION PRIMARY_65B44DBC; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SPRING_SESSION"
    ADD CONSTRAINT "PRIMARY_65B44DBC" PRIMARY KEY ("PRIMARY_ID");


--
-- TOC entry 3707 (class 2606 OID 694007)
-- Name: SPRING_SESSION_ATTRIBUTES PRIMARY_710A7420; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SPRING_SESSION_ATTRIBUTES"
    ADD CONSTRAINT "PRIMARY_710A7420" PRIMARY KEY ("ATTRIBUTE_NAME", "SESSION_PRIMARY_ID");


--
-- TOC entry 3737 (class 2606 OID 694489)
-- Name: spring_session_attributes PRIMARY_710A74202; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spring_session_attributes
    ADD CONSTRAINT "PRIMARY_710A74202" PRIMARY KEY (attribute_name, session_primary_id);


--
-- TOC entry 3721 (class 2606 OID 694017)
-- Name: Role PRIMARY_7EFD8C91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "PRIMARY_7EFD8C91" PRIMARY KEY ("Id");


--
-- TOC entry 3669 (class 2606 OID 693998)
-- Name: ServerConfig PRIMARY_81230E80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ServerConfig"
    ADD CONSTRAINT "PRIMARY_81230E80" PRIMARY KEY ("Id");


--
-- TOC entry 3641 (class 2606 OID 693993)
-- Name: Users PRIMARY_85B151E3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PRIMARY_85B151E3" PRIMARY KEY ("Id");


--
-- TOC entry 3655 (class 2606 OID 693983)
-- Name: ConsumerAudit PRIMARY_86BC7B60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ConsumerAudit"
    ADD CONSTRAINT "PRIMARY_86BC7B60" PRIMARY KEY ("Id");


--
-- TOC entry 3727 (class 2606 OID 694029)
-- Name: AppNamespace PRIMARY_9906B455; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AppNamespace"
    ADD CONSTRAINT "PRIMARY_9906B455" PRIMARY KEY ("Id");


--
-- TOC entry 3651 (class 2606 OID 693977)
-- Name: AuditLog PRIMARY_AF43F384; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AuditLog"
    ADD CONSTRAINT "PRIMARY_AF43F384" PRIMARY KEY ("id");


--
-- TOC entry 3698 (class 2606 OID 694009)
-- Name: ConsumerToken PRIMARY_B1B19D7E; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ConsumerToken"
    ADD CONSTRAINT "PRIMARY_B1B19D7E" PRIMARY KEY ("Id");


--
-- TOC entry 3716 (class 2606 OID 694013)
-- Name: Permission PRIMARY_CE267EA; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permission"
    ADD CONSTRAINT "PRIMARY_CE267EA" PRIMARY KEY ("Id");


--
-- TOC entry 3664 (class 2606 OID 693981)
-- Name: Consumer PRIMARY_DD828011; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Consumer"
    ADD CONSTRAINT "PRIMARY_DD828011" PRIMARY KEY ("Id");


--
-- TOC entry 3687 (class 2606 OID 693988)
-- Name: App PRIMARY_E21D63FC; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."App"
    ADD CONSTRAINT "PRIMARY_E21D63FC" PRIMARY KEY ("Id");


--
-- TOC entry 3675 (class 2606 OID 693989)
-- Name: ConsumerRole PRIMARY_FFA18DA7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ConsumerRole"
    ADD CONSTRAINT "PRIMARY_FFA18DA7" PRIMARY KEY ("Id");


--
-- TOC entry 3711 (class 2606 OID 694055)
-- Name: SPRING_SESSION SPRING_SESSION_IX1_51F0BCDE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SPRING_SESSION"
    ADD CONSTRAINT "SPRING_SESSION_IX1_51F0BCDE" UNIQUE ("SESSION_ID");


--
-- TOC entry 3733 (class 2606 OID 694473)
-- Name: spring_session SPRING_SESSION_copy_SESSION_ID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spring_session
    ADD CONSTRAINT "SPRING_SESSION_copy_SESSION_ID_key" UNIQUE (session_id);


--
-- TOC entry 3735 (class 2606 OID 694471)
-- Name: spring_session SPRING_SESSION_copy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spring_session
    ADD CONSTRAINT "SPRING_SESSION_copy_pkey" PRIMARY KEY (primary_id);


--
-- TOC entry 3689 (class 2606 OID 694040)
-- Name: App UK_AppId_DeletedAt_3DEBF313; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."App"
    ADD CONSTRAINT "UK_AppId_DeletedAt_3DEBF313" UNIQUE ("AppId", "DeletedAt");


--
-- TOC entry 3666 (class 2606 OID 694020)
-- Name: Consumer UK_AppId_DeletedAt_BAB36028; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Consumer"
    ADD CONSTRAINT "UK_AppId_DeletedAt_BAB36028" UNIQUE ("AppId", "DeletedAt");


--
-- TOC entry 3729 (class 2606 OID 694065)
-- Name: AppNamespace UK_AppId_Name_DeletedAt_DE2CC392; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AppNamespace"
    ADD CONSTRAINT "UK_AppId_Name_DeletedAt_DE2CC392" UNIQUE ("AppId", "Name", "DeletedAt");


--
-- TOC entry 3677 (class 2606 OID 694047)
-- Name: ConsumerRole UK_ConsumerId_RoleId_DeletedAt_EAA023BE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ConsumerRole"
    ADD CONSTRAINT "UK_ConsumerId_RoleId_DeletedAt_EAA023BE" UNIQUE ("ConsumerId", "RoleId", "DeletedAt");


--
-- TOC entry 3671 (class 2606 OID 694052)
-- Name: ServerConfig UK_Key_DeletedAt_62F63017; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ServerConfig"
    ADD CONSTRAINT "UK_Key_DeletedAt_62F63017" UNIQUE ("Key", "DeletedAt");


--
-- TOC entry 3683 (class 2606 OID 694041)
-- Name: RolePermission UK_RoleId_PermissionId_DeletedAt_6808A3F7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "UK_RoleId_PermissionId_DeletedAt_6808A3F7" UNIQUE ("RoleId", "PermissionId", "DeletedAt");


--
-- TOC entry 3723 (class 2606 OID 694059)
-- Name: Role UK_RoleName_DeletedAt_214A534; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "UK_RoleName_DeletedAt_214A534" UNIQUE ("RoleName", "DeletedAt");


--
-- TOC entry 3718 (class 2606 OID 694056)
-- Name: Permission UK_TargetId_PermissionType_DeletedAt_760562E1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permission"
    ADD CONSTRAINT "UK_TargetId_PermissionType_DeletedAt_760562E1" UNIQUE ("TargetId", "PermissionType", "DeletedAt");


--
-- TOC entry 3700 (class 2606 OID 694051)
-- Name: ConsumerToken UK_Token_DeletedAt_63E54ED5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ConsumerToken"
    ADD CONSTRAINT "UK_Token_DeletedAt_63E54ED5" UNIQUE ("Token", "DeletedAt");


--
-- TOC entry 3661 (class 2606 OID 694046)
-- Name: Favorite UK_UserId_AppId_DeletedAt_B770FDFE; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Favorite"
    ADD CONSTRAINT "UK_UserId_AppId_DeletedAt_B770FDFE" UNIQUE ("UserId", "AppId", "DeletedAt");


--
-- TOC entry 3695 (class 2606 OID 694062)
-- Name: UserRole UK_UserId_RoleId_DeletedAt_84DA91F3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UK_UserId_RoleId_DeletedAt_84DA91F3" UNIQUE ("UserId", "RoleId", "DeletedAt");


--
-- TOC entry 3643 (class 2606 OID 694018)
-- Name: Users UK_Username_A3445096; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "UK_Username_A3445096" UNIQUE ("Username");


--
-- TOC entry 3656 (class 1259 OID 693997)
-- Name: AppId_49B7595F; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "AppId_49B7595F" ON public."Favorite" USING btree ("AppId");


--
-- TOC entry 3724 (class 1259 OID 694048)
-- Name: DataChange_LastTime_2F675AA1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "DataChange_LastTime_2F675AA1" ON public."AppNamespace" USING btree ("DataChange_LastTime");


--
-- TOC entry 3662 (class 1259 OID 693999)
-- Name: DataChange_LastTime_4BB17865; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "DataChange_LastTime_4BB17865" ON public."Consumer" USING btree ("DataChange_LastTime");


--
-- TOC entry 3696 (class 1259 OID 694032)
-- Name: DataChange_LastTime_52D88E18; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "DataChange_LastTime_52D88E18" ON public."ConsumerToken" USING btree ("DataChange_LastTime");


--
-- TOC entry 3657 (class 1259 OID 694024)
-- Name: DataChange_LastTime_588A287F; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "DataChange_LastTime_588A287F" ON public."Favorite" USING btree ("DataChange_LastTime");


--
-- TOC entry 3684 (class 1259 OID 694010)
-- Name: DataChange_LastTime_C007005A; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "DataChange_LastTime_C007005A" ON public."App" USING btree ("DataChange_LastTime");


--
-- TOC entry 3667 (class 1259 OID 694033)
-- Name: DataChange_LastTime_DE221456; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "DataChange_LastTime_DE221456" ON public."ServerConfig" USING btree ("DataChange_LastTime");


--
-- TOC entry 3652 (class 1259 OID 693994)
-- Name: IX_ConsumerId_383A8FBC; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_ConsumerId_383A8FBC" ON public."ConsumerAudit" USING btree ("ConsumerId");


--
-- TOC entry 3701 (class 1259 OID 694034)
-- Name: IX_DataChange_CreatedTime_17772E57; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_DataChange_CreatedTime_17772E57" ON public."AuditLogDataInfluence" USING btree ("DataChange_CreatedTime");


--
-- TOC entry 3646 (class 1259 OID 693996)
-- Name: IX_DataChange_CreatedTime_AA27E93E; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_DataChange_CreatedTime_AA27E93E" ON public."AuditLog" USING btree ("DataChange_CreatedTime");


--
-- TOC entry 3690 (class 1259 OID 694031)
-- Name: IX_DataChange_LastTime_236BDEAE; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_DataChange_LastTime_236BDEAE" ON public."UserRole" USING btree ("DataChange_LastTime");


--
-- TOC entry 3714 (class 1259 OID 694038)
-- Name: IX_DataChange_LastTime_463D459C; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_DataChange_LastTime_463D459C" ON public."Permission" USING btree ("DataChange_LastTime");


--
-- TOC entry 3672 (class 1259 OID 694005)
-- Name: IX_DataChange_LastTime_936E3759; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_DataChange_LastTime_936E3759" ON public."ConsumerRole" USING btree ("DataChange_LastTime");


--
-- TOC entry 3678 (class 1259 OID 694003)
-- Name: IX_DataChange_LastTime_BC9132B2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_DataChange_LastTime_BC9132B2" ON public."RolePermission" USING btree ("DataChange_LastTime");


--
-- TOC entry 3653 (class 1259 OID 694025)
-- Name: IX_DataChange_LastTime_DC7C0112; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_DataChange_LastTime_DC7C0112" ON public."ConsumerAudit" USING btree ("DataChange_LastTime");


--
-- TOC entry 3719 (class 1259 OID 694037)
-- Name: IX_DataChange_LastTime_FA840E43; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_DataChange_LastTime_FA840E43" ON public."Role" USING btree ("DataChange_LastTime");


--
-- TOC entry 3702 (class 1259 OID 694060)
-- Name: IX_EntityId_96BFAB9E; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_EntityId_96BFAB9E" ON public."AuditLogDataInfluence" USING btree ("influenceentityid");


--
-- TOC entry 3685 (class 1259 OID 694026)
-- Name: IX_Name_EB95B6C; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Name_EB95B6C" ON public."App" USING btree ("Name");


--
-- TOC entry 3647 (class 1259 OID 694030)
-- Name: IX_OpName_35A45D96; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OpName_35A45D96" ON public."AuditLog" USING btree ("opname");


--
-- TOC entry 3648 (class 1259 OID 694021)
-- Name: IX_Operator_1683F3E6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Operator_1683F3E6" ON public."AuditLog" USING btree ("operator");


--
-- TOC entry 3679 (class 1259 OID 694023)
-- Name: IX_PermissionId_2062840E; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_PermissionId_2062840E" ON public."RolePermission" USING btree ("PermissionId");


--
-- TOC entry 3691 (class 1259 OID 694045)
-- Name: IX_RoleId_576FE1D8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_RoleId_576FE1D8" ON public."UserRole" USING btree ("RoleId");


--
-- TOC entry 3673 (class 1259 OID 694022)
-- Name: IX_RoleId_EE4E3A43; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_RoleId_EE4E3A43" ON public."ConsumerRole" USING btree ("RoleId");


--
-- TOC entry 3703 (class 1259 OID 694063)
-- Name: IX_SpanId_781FF521; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_SpanId_781FF521" ON public."AuditLogDataInfluence" USING btree ("spanid");


--
-- TOC entry 3649 (class 1259 OID 694042)
-- Name: IX_TraceId_E33D4416; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_TraceId_E33D4416" ON public."AuditLog" USING btree ("traceid");


--
-- TOC entry 3725 (class 1259 OID 694058)
-- Name: Name_AppId_B47ED639; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Name_AppId_B47ED639" ON public."AppNamespace" USING btree ("Name", "AppId");


--
-- TOC entry 3712 (class 1259 OID 694027)
-- Name: SPRING_SESSION_IX2_A2002052; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "SPRING_SESSION_IX2_A2002052" ON public."SPRING_SESSION" USING btree ("EXPIRY_TIME");


--
-- TOC entry 3713 (class 1259 OID 694039)
-- Name: SPRING_SESSION_IX3_77A04504; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "SPRING_SESSION_IX3_77A04504" ON public."SPRING_SESSION" USING btree ("PRINCIPAL_NAME");


--
-- TOC entry 3730 (class 1259 OID 694474)
-- Name: SPRING_SESSION_copy_EXPIRY_TIME_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "SPRING_SESSION_copy_EXPIRY_TIME_idx" ON public.spring_session USING btree (expiry_time);


--
-- TOC entry 3731 (class 1259 OID 694475)
-- Name: SPRING_SESSION_copy_PRINCIPAL_NAME_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "SPRING_SESSION_copy_PRINCIPAL_NAME_idx" ON public.spring_session USING btree (principal_name);


--
-- TOC entry 3738 (class 2606 OID 694066)
-- Name: SPRING_SESSION_ATTRIBUTES SPRING_SESSION_ATTRIBUTES_FK_60BD67; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SPRING_SESSION_ATTRIBUTES"
    ADD CONSTRAINT "SPRING_SESSION_ATTRIBUTES_FK_60BD67" FOREIGN KEY ("SESSION_PRIMARY_ID") REFERENCES public."SPRING_SESSION"("PRIMARY_ID") ON UPDATE RESTRICT ON DELETE CASCADE;



-- Completed on 2024-02-07 14:40:28

--
-- Kingbase database dump complete
--

