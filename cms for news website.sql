PGDMP     	    ;    	            {            cms    15.2    15.1 $    !           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            "           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            #           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            $           1262    32768    cms    DATABASE     ~   CREATE DATABASE cms WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE cms;
                postgres    false            �            1255    32813    add_new_tags()    FUNCTION     �   CREATE FUNCTION public.add_new_tags() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO tags (name) SELECT UNNEST(NEW.tags)
    ON CONFLICT DO NOTHING;
    RETURN NEW;
END;
$$;
 %   DROP FUNCTION public.add_new_tags();
       public          postgres    false            �            1259    32770    articles    TABLE     �   CREATE TABLE public.articles (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    tags text[],
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.articles;
       public         heap    postgres    false            �            1255    32815    search_articles_by_tag(text)    FUNCTION     �   CREATE FUNCTION public.search_articles_by_tag(tag_name text) RETURNS SETOF public.articles
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT *
    FROM articles
    WHERE tags @> ARRAY[tag_name];
END;
$$;
 <   DROP FUNCTION public.search_articles_by_tag(tag_name text);
       public          postgres    false    215            �            1259    32769    articles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.articles_id_seq;
       public          postgres    false    215            %           0    0    articles_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;
          public          postgres    false    214            �            1259    32781    images    TABLE     �   CREATE TABLE public.images (
    id integer NOT NULL,
    filename text NOT NULL,
    caption text,
    metadata jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.images;
       public         heap    postgres    false            �            1259    32780    images_id_seq    SEQUENCE     �   CREATE SEQUENCE public.images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.images_id_seq;
       public          postgres    false    217            &           0    0    images_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;
          public          postgres    false    216            �            1259    32802    tags    TABLE     �   CREATE TABLE public.tags (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.tags;
       public         heap    postgres    false            �            1259    32801    tags_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.tags_id_seq;
       public          postgres    false    221            '           0    0    tags_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;
          public          postgres    false    220            �            1259    32791    videos    TABLE     �   CREATE TABLE public.videos (
    id integer NOT NULL,
    filename text NOT NULL,
    caption text,
    metadata xml,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.videos;
       public         heap    postgres    false            �            1259    32790    videos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.videos_id_seq;
       public          postgres    false    219            (           0    0    videos_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;
          public          postgres    false    218            v           2604    32773    articles id    DEFAULT     j   ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);
 :   ALTER TABLE public.articles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            x           2604    32784 	   images id    DEFAULT     f   ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);
 8   ALTER TABLE public.images ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            |           2604    32805    tags id    DEFAULT     b   ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);
 6   ALTER TABLE public.tags ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            z           2604    32794 	   videos id    DEFAULT     f   ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);
 8   ALTER TABLE public.videos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219                      0    32770    articles 
   TABLE DATA           H   COPY public.articles (id, title, content, tags, created_at) FROM stdin;
    public          postgres    false    215   D&                 0    32781    images 
   TABLE DATA           M   COPY public.images (id, filename, caption, metadata, created_at) FROM stdin;
    public          postgres    false    217   a&                 0    32802    tags 
   TABLE DATA           4   COPY public.tags (id, name, created_at) FROM stdin;
    public          postgres    false    221   �&                 0    32791    videos 
   TABLE DATA           M   COPY public.videos (id, filename, caption, metadata, created_at) FROM stdin;
    public          postgres    false    219   *'       )           0    0    articles_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.articles_id_seq', 1, false);
          public          postgres    false    214            *           0    0    images_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.images_id_seq', 1, true);
          public          postgres    false    216            +           0    0    tags_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.tags_id_seq', 1, true);
          public          postgres    false    220            ,           0    0    videos_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.videos_id_seq', 1, true);
          public          postgres    false    218                       2606    32778    articles articles_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.articles DROP CONSTRAINT articles_pkey;
       public            postgres    false    215            �           2606    32789    images images_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.images DROP CONSTRAINT images_pkey;
       public            postgres    false    217            �           2606    32812    tags tags_name_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);
 <   ALTER TABLE ONLY public.tags DROP CONSTRAINT tags_name_key;
       public            postgres    false    221            �           2606    32810    tags tags_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.tags DROP CONSTRAINT tags_pkey;
       public            postgres    false    221            �           2606    32799    videos videos_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.videos DROP CONSTRAINT videos_pkey;
       public            postgres    false    219            �           2620    32814    articles add_new_tags_trigger    TRIGGER     y   CREATE TRIGGER add_new_tags_trigger AFTER INSERT ON public.articles FOR EACH ROW EXECUTE FUNCTION public.add_new_tags();
 6   DROP TRIGGER add_new_tags_trigger ON public.articles;
       public          postgres    false    222    215                  x������ � �         x   x�-��� ��5<ń�%c���=�4�0�6�Ѥ�ݝ����9N�g*����Eu��'�2EV��s���Z�	��w�{�uA<�I�c���W��.�.oi$My�4�qpxD��=�G}�Z�*$	         1   x�3�L�H�-�I�4202�50�54V0��26�26�37045����� Ҕ�         q   x�3�L�H�-�I��-0�t�S�r�2SR�9mrSKSK�lRJ�K2����l��<������R����A��>���>� N##c]]CcK+cc+c#=sCSS�=... �w+1     