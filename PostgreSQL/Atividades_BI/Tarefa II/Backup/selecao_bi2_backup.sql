PGDMP  	    0                 }            selecao_bi2    17.2    17.2 $    A           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            B           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            C           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            D           1262    24921    selecao_bi2    DATABASE     �   CREATE DATABASE selecao_bi2 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE selecao_bi2;
                     igor    false            �            1259    24999    order_items    TABLE     �   CREATE TABLE public.order_items (
    order_item_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL
);
    DROP TABLE public.order_items;
       public         heap r       igor    false            �            1259    24998    order_items_order_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_items_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.order_items_order_item_id_seq;
       public               igor    false    224            E           0    0    order_items_order_item_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;
          public               igor    false    223            �            1259    24987    orders    TABLE     �   CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    order_date date NOT NULL,
    total_amount numeric(10,2) NOT NULL
);
    DROP TABLE public.orders;
       public         heap r       igor    false            �            1259    24986    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public               igor    false    222            F           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;
          public               igor    false    221            �            1259    24980    products    TABLE     �   CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(100) NOT NULL,
    price numeric(10,2) NOT NULL,
    stock_quantity integer NOT NULL
);
    DROP TABLE public.products;
       public         heap r       igor    false            �            1259    24979    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.products_product_id_seq;
       public               igor    false    220            G           0    0    products_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;
          public               igor    false    219            �            1259    24971    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    created_at date NOT NULL
);
    DROP TABLE public.users;
       public         heap r       igor    false            �            1259    24970    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public               igor    false    218            H           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public               igor    false    217            �           2604    25002    order_items order_item_id    DEFAULT     �   ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);
 H   ALTER TABLE public.order_items ALTER COLUMN order_item_id DROP DEFAULT;
       public               igor    false    223    224    224            �           2604    24990    orders order_id    DEFAULT     r   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public               igor    false    222    221    222            �           2604    24983    products product_id    DEFAULT     z   ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 B   ALTER TABLE public.products ALTER COLUMN product_id DROP DEFAULT;
       public               igor    false    220    219    220            �           2604    24974    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               igor    false    218    217    218            >          0    24999    order_items 
   TABLE DATA           [   COPY public.order_items (order_item_id, order_id, product_id, quantity, price) FROM stdin;
    public               igor    false    224   `(       <          0    24987    orders 
   TABLE DATA           M   COPY public.orders (order_id, user_id, order_date, total_amount) FROM stdin;
    public               igor    false    222   +       :          0    24980    products 
   TABLE DATA           K   COPY public.products (product_id, name, price, stock_quantity) FROM stdin;
    public               igor    false    220   �,       8          0    24971    users 
   TABLE DATA           A   COPY public.users (user_id, name, email, created_at) FROM stdin;
    public               igor    false    218   �-       I           0    0    order_items_order_item_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 81, true);
          public               igor    false    223            J           0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orders_order_id_seq', 51, true);
          public               igor    false    221            K           0    0    products_product_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.products_product_id_seq', 26, true);
          public               igor    false    219            L           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 11, true);
          public               igor    false    217            �           2606    25004    order_items order_items_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);
 F   ALTER TABLE ONLY public.order_items DROP CONSTRAINT order_items_pkey;
       public                 igor    false    224            �           2606    24992    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public                 igor    false    222            �           2606    24985    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public                 igor    false    220            �           2606    24978    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 igor    false    218            �           2606    24976    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 igor    false    218            �           2606    25005    order_items fk_order    FK CONSTRAINT     {   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id);
 >   ALTER TABLE ONLY public.order_items DROP CONSTRAINT fk_order;
       public               igor    false    224    222    4768            �           2606    25010    order_items fk_product    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES public.products(product_id);
 @   ALTER TABLE ONLY public.order_items DROP CONSTRAINT fk_product;
       public               igor    false    224    220    4766            �           2606    24993    orders fk_user    FK CONSTRAINT     r   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 8   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk_user;
       public               igor    false    4764    222    218            >   �  x�-T˕1;�bx���^��:Vb�6��,!���^g���<rV��W�s���/��@������Yv��c��+�O�^��Z^���Nk���,G[�����e��������
;���&bXn�&f�9mӗbg����N����7p��� )@����������/��M�&��&h���3v�=boh֌��8�ȍj��-X�� lW��qPc���#م���+�K?�z�M�>��fz[N��!6p/&5��ZO���� >��G|Cc<p�Z@-�>�Z%N�)�:��L��O�%��O��@ɕ��b�[�r�'��RCS�0V�ЃI��g�Cp{�(1F�|�I(��pz������DaF�}�O8ٞ�-h�`��ߔ*H�s|1;��~�,!d+b��b����z*JF`��K#�8���K��K�A����<d��%>\�y��8��$�P�3S\�$�˪�j��t�%���X�̕|�v裧�I�9mPGP))����j�y7�ib��_��Mưb4��c yR9Q�>�Ao���5�5�`�)��5t'vP�Y���2v'�7�WJ+���I��r�a���+�:z�|;
�1^L~��H����t�RH�/b7�_�͒�A�6�!���?�I&w3�#�5��?�%��e      <   �  x�]SK�1[��e~��%�?GļT7/K�T $Y��[��#��%��.}�m�v��u���,�5ɗ��XǊ�S<�s���������eO��,�sل�`C���F�Z�ݘ+��7��S��T���!ŗą� ѕ�t�w��-���Z$>RYf�v��l-X�#��N��!��H>Jra�3Ijի�4�C��]7Wd�)莭�>���Z�g��3���� ��>��{����q�����_��9kg2Y��N5�����#]��eO�PS(c2cC!����	����lv��܌i��HG��,�R�S'���"KT�v�-灴a4����z[9��=��o�����Q�.F'�6�W�}���5n��G]r�[Q��='��g���>�W�2�I�9Ŵ��.�����V��{MN�qjQ�vg�����/�aŪ      :   �   x�M�;NE1Dk{1�q�]� �W@��`��nS�hd%>����ߏ��Q.�XT���Ni[�P���/9I��7M2sх��M�i���uâe�N;y�p�i�a�s�CQ[��}�&Ƕ�4�����mx�lb��*
�c4-iܖl��-dA����ƫ�t{|�X]UZi���:�S`X=ec�q�ߛ�}\�����L��f�d����N�M�)���(9j��&��ȃ}d��D���]��E��s      8   �   x�uн
�0���.	�l�g�Kd+��5�����^Fe��;.��=^�>�s�u�Ǽ=���6I��@ɔL]��D�Ȓ�:2Y&�~��Ȍ�ξ�BV\*Y%�~hG#kd�u�N��n	Q�}�X|�q�� Nus     