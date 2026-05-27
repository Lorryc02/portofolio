--
-- PostgreSQL database dump
--

\restrict tUQXjUuuRsJhVthfxKmbG5PLhjJUkVuVKD8tRmmTfqNBsJD6wG1f67EQQ9eZbch

-- Dumped from database version 16.13
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: groupeffa
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO groupeffa;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: client; Type: TABLE; Schema: public; Owner: groupeffa
--

CREATE TABLE public.client (
    refclient integer NOT NULL,
    nomclient character varying(100),
    email character varying(150),
    adresse character varying(200),
    tel integer,
    actif boolean DEFAULT true
);


ALTER TABLE public.client OWNER TO groupeffa;

--
-- Name: client_refclient_seq; Type: SEQUENCE; Schema: public; Owner: groupeffa
--

CREATE SEQUENCE public.client_refclient_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_refclient_seq OWNER TO groupeffa;

--
-- Name: client_refclient_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: groupeffa
--

ALTER SEQUENCE public.client_refclient_seq OWNED BY public.client.refclient;


--
-- Name: demande; Type: TABLE; Schema: public; Owner: groupeffa
--

CREATE TABLE public.demande (
    refdemande character varying(50) NOT NULL,
    datecreation date,
    nbvouchers integer,
    valeurvoucher integer,
    statusdemande character varying(50),
    datepaiement date,
    dateapprobation date,
    refpaiement character varying(50),
    "Initiateur" character varying(50),
    "Payeur" character varying(50),
    "Approbateur" character varying(50),
    refclient character varying(50) NOT NULL
);


ALTER TABLE public.demande OWNER TO groupeffa;

--
-- Name: magasin; Type: TABLE; Schema: public; Owner: groupeffa
--

CREATE TABLE public.magasin (
    refmagasin character varying(50) NOT NULL,
    nom character varying(100),
    adresse character varying(200)
);


ALTER TABLE public.magasin OWNER TO groupeffa;

--
-- Name: users; Type: TABLE; Schema: public; Owner: groupeffa
--

CREATE TABLE public.users (
    username character varying(50) NOT NULL,
    nom character varying(100),
    prenom character varying(100),
    userrole character varying(50),
    userpassword character varying(255),
    ddl date,
    titre character varying(100),
    email character varying(150),
    statususer character varying(50)
);


ALTER TABLE public.users OWNER TO groupeffa;

--
-- Name: voucher; Type: TABLE; Schema: public; Owner: groupeffa
--

CREATE TABLE public.voucher (
    refvoucher character varying(50) NOT NULL,
    valeurvoucher integer,
    dateemission date,
    dateexpiration date,
    statusvoucher character varying(50),
    "redeemedBy" character varying(50) NOT NULL,
    refmagasin character varying(50),
    refclient character varying(50) NOT NULL,
    "redeemedOn" timestamp without time zone,
    refdemande character varying(50) NOT NULL
);


ALTER TABLE public.voucher OWNER TO groupeffa;

--
-- Name: client refclient; Type: DEFAULT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.client ALTER COLUMN refclient SET DEFAULT nextval('public.client_refclient_seq'::regclass);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (refclient);


--
-- Name: demande demande_pkey; Type: CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.demande
    ADD CONSTRAINT demande_pkey PRIMARY KEY (refdemande);


--
-- Name: magasin magasin_pkey; Type: CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.magasin
    ADD CONSTRAINT magasin_pkey PRIMARY KEY (refmagasin);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- Name: voucher voucher_pkey; Type: CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.voucher
    ADD CONSTRAINT voucher_pkey PRIMARY KEY (refvoucher);


--
-- Name: idx_client_actif; Type: INDEX; Schema: public; Owner: groupeffa
--

CREATE INDEX idx_client_actif ON public.client USING btree (actif);


--
-- Name: demande demande_approbateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.demande
    ADD CONSTRAINT demande_approbateur_fkey FOREIGN KEY ("Approbateur") REFERENCES public.users(username);


--
-- Name: demande demande_initiateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.demande
    ADD CONSTRAINT demande_initiateur_fkey FOREIGN KEY ("Initiateur") REFERENCES public.users(username);


--
-- Name: demande demande_payeur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.demande
    ADD CONSTRAINT demande_payeur_fkey FOREIGN KEY ("Payeur") REFERENCES public.users(username);


--
-- Name: voucher voucher_refdemande_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.voucher
    ADD CONSTRAINT voucher_refdemande_fkey FOREIGN KEY (refdemande) REFERENCES public.demande(refdemande) ON DELETE CASCADE;


--
-- Name: voucher voucher_refmagasin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.voucher
    ADD CONSTRAINT voucher_refmagasin_fkey FOREIGN KEY (refmagasin) REFERENCES public.magasin(refmagasin);


--
-- Name: voucher voucher_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: groupeffa
--

ALTER TABLE ONLY public.voucher
    ADD CONSTRAINT voucher_username_fkey FOREIGN KEY ("redeemedBy") REFERENCES public.users(username);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: groupeffa
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict tUQXjUuuRsJhVthfxKmbG5PLhjJUkVuVKD8tRmmTfqNBsJD6wG1f67EQQ9eZbch

