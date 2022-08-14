-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2022-08-11 18:17:51 EEST
--   site:      Oracle Database 21c
--   type:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE book (
    title            VARCHAR2(1000 BYTE) NOT NULL,
    description      VARCHAR2(4000 BYTE),
    isbn             VARCHAR2(13),
    author           VARCHAR2(1000 BYTE),
    picture          VARCHAR2(4000 BYTE),
    book_id          NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    book_category_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX book_isbn_idx ON
    book (
        isbn
    ASC );

CREATE UNIQUE INDEX book_book_id_idx ON
    book (
        book_id
    ASC );

CREATE INDEX book_book_category_id_idx ON
    book (
        book_category_id
    ASC );

ALTER TABLE book ADD CONSTRAINT book_pk PRIMARY KEY ( book_id );

ALTER TABLE book ADD CONSTRAINT book_isbn_uk UNIQUE ( isbn );

CREATE TABLE book_category (
    name             VARCHAR2(1000 BYTE) NOT NULL,
    description      VARCHAR2(4000 BYTE),
    book_category_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL
);

CREATE UNIQUE INDEX book_category_name_idx ON
    book_category (
        name
    ASC );

CREATE UNIQUE INDEX book_category_book_category_id_idx ON
    book_category (
        book_category_id
    ASC );

ALTER TABLE book_category ADD CONSTRAINT book_category_pk PRIMARY KEY ( book_category_id );

ALTER TABLE book_category ADD CONSTRAINT book_category_name_uk UNIQUE ( name );

CREATE TABLE book_category_tl (
    name                VARCHAR2(1000 BYTE),
    description         VARCHAR2(4000 BYTE) NOT NULL,
    book_category_tl_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    book_category_id    NUMBER NOT NULL,
    language_id         NUMBER NOT NULL
);

CREATE UNIQUE INDEX book_category_tl_book_category_id_language_id_idx ON
    book_category_tl (
        book_category_id
    ASC,
        language_id
    ASC );

CREATE UNIQUE INDEX book_category_tl_book_category_tl_id_idx ON
    book_category_tl (
        book_category_tl_id
    ASC );

CREATE INDEX book_category_tl_language_id_idx ON
    book_category_tl (
        language_id
    ASC );

ALTER TABLE book_category_tl ADD CONSTRAINT book_category_tl_pk PRIMARY KEY ( book_category_tl_id );

ALTER TABLE book_category_tl ADD CONSTRAINT book_category_tl__uk UNIQUE ( book_category_id,
                                                                          language_id );

CREATE TABLE book_inventory (
    quantity          NUMBER DEFAULT 0 NOT NULL,
    book_inventory_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    book_id           NUMBER NOT NULL
);

CREATE UNIQUE INDEX book_inventory_book_id_idx ON
    book_inventory (
        book_id
    ASC );

CREATE UNIQUE INDEX book_inventory_book_inventory_id_idx ON
    book_inventory (
        book_inventory_id
    ASC );

ALTER TABLE book_inventory ADD CONSTRAINT book_inventory_pk PRIMARY KEY ( book_inventory_id );

ALTER TABLE book_inventory ADD CONSTRAINT book_inventory__uk UNIQUE ( book_id );

CREATE TABLE book_price (
    price         NUMBER NOT NULL,
    valid_from    DATE NOT NULL,
    valid_to      DATE NOT NULL,
    book_price_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    book_id       NUMBER NOT NULL
);

CREATE UNIQUE INDEX book_price_book_price_id_idx ON
    book_price (
        book_price_id
    ASC );

CREATE INDEX book_price_book_id_idx ON
    book_price (
        book_id
    ASC );

ALTER TABLE book_price ADD CONSTRAINT book_price_pk PRIMARY KEY ( book_price_id );

CREATE TABLE book_review (
    review         VARCHAR2(4000 BYTE) NOT NULL,
    rating         INTEGER DEFAULT 1 NOT NULL,
    book_review_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    book_id        NUMBER NOT NULL,
    customer_id    NUMBER NOT NULL
);

ALTER TABLE book_review
    ADD CONSTRAINT rating CHECK ( rating IN ( 1, 2, 3, 4, 5 ) );

CREATE UNIQUE INDEX book_review_book_review_id_idx ON
    book_review (
        book_review_id
    ASC );

CREATE INDEX book_review_book_id_idx ON
    book_review (
        book_id
    ASC );

CREATE INDEX book_review_customer_id_idx ON
    book_review (
        customer_id
    ASC );

ALTER TABLE book_review ADD CONSTRAINT book_review_pk PRIMARY KEY ( book_review_id );

CREATE TABLE book_tl (
    title       VARCHAR2(1000 BYTE),
    description VARCHAR2(4000 BYTE),
    book_tl_id  NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    book_id     NUMBER NOT NULL,
    language_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX book_tl_language_id_book_id_idx ON
    book_tl (
        language_id
    ASC,
        book_id
    ASC );

CREATE UNIQUE INDEX book_tl_book_tl_id_idx ON
    book_tl (
        book_tl_id
    ASC );

CREATE INDEX book_tl_book_id_idx ON
    book_tl (
        book_id
    ASC );

ALTER TABLE book_tl ADD CONSTRAINT book_tl_pk PRIMARY KEY ( book_tl_id );

ALTER TABLE book_tl ADD CONSTRAINT book_tl__uk UNIQUE ( language_id,
                                                        book_id );

CREATE TABLE cart (
    amount      NUMBER DEFAULT 0 NOT NULL,
    cart_id     NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    customer_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX cart_customer_id_idx ON
    cart (
        customer_id
    ASC );

CREATE UNIQUE INDEX cart_cart_id_idx ON
    cart (
        cart_id
    ASC );

ALTER TABLE cart ADD CONSTRAINT cart_pk PRIMARY KEY ( cart_id );

ALTER TABLE cart ADD CONSTRAINT cart__uk UNIQUE ( customer_id );

CREATE TABLE cart_line (
    quantity     NUMBER DEFAULT 0 NOT NULL,
    unit_price   NUMBER DEFAULT 0 NOT NULL,
    amount       NUMBER DEFAULT 0 NOT NULL,
    cart_line_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    cart_id      NUMBER NOT NULL,
    book_id      NUMBER NOT NULL
);

CREATE UNIQUE INDEX cart_line_cart_line_id_idx ON
    cart_line (
        cart_line_id
    ASC );

CREATE INDEX cart_line_cart_id_idx ON
    cart_line (
        cart_id
    ASC );

CREATE INDEX cart_line_book_id_idx ON
    cart_line (
        book_id
    ASC );

ALTER TABLE cart_line ADD CONSTRAINT cart_line_pk PRIMARY KEY ( cart_line_id );

CREATE TABLE config (
    id        NUMBER NOT NULL,
    key       VARCHAR2(100 BYTE) NOT NULL,
    value     VARCHAR2(1000 BYTE) NOT NULL,
    config_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL
);

CREATE UNIQUE INDEX config_id_idx ON
    config (
        id
    ASC );

CREATE UNIQUE INDEX config_key_idx ON
    config (
        key
    ASC );

CREATE UNIQUE INDEX config_config_id_idx ON
    config (
        config_id
    ASC );

ALTER TABLE config ADD CONSTRAINT config_pk PRIMARY KEY ( config_id );

ALTER TABLE config ADD CONSTRAINT config_id_uk UNIQUE ( id );

ALTER TABLE config ADD CONSTRAINT config_key_uk UNIQUE ( key );

CREATE TABLE country (
    country_code VARCHAR2(2 BYTE) NOT NULL,
    name         VARCHAR2(100 BYTE) NOT NULL,
    country_id   NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL
);

CREATE UNIQUE INDEX country_country_code_idx ON
    country (
        country_code
    ASC );

CREATE UNIQUE INDEX country_name_idx ON
    country (
        name
    ASC );

CREATE UNIQUE INDEX country_country_id_idx ON
    country (
        country_id
    ASC );

ALTER TABLE country ADD CONSTRAINT country_pk PRIMARY KEY ( country_id );

ALTER TABLE country ADD CONSTRAINT country_country_code_uk UNIQUE ( country_code );

ALTER TABLE country ADD CONSTRAINT country_name_uk UNIQUE ( name );

CREATE TABLE customer (
    first_name  VARCHAR2(1000 BYTE),
    last_name   VARCHAR2(1000 BYTE),
    email       VARCHAR2(254 BYTE) NOT NULL,
    password    VARCHAR2(4000 BYTE) NOT NULL,
    phone       VARCHAR2(1000 BYTE),
    age         INTEGER,
    gender      VARCHAR2(2),
    customer_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    language_id NUMBER NOT NULL
);

ALTER TABLE customer ADD CHECK ( age >= 0 );

ALTER TABLE customer
    ADD CHECK ( gender IN ( 'F', 'M' ) );

CREATE UNIQUE INDEX customer_email_idx ON
    customer (
        email
    ASC );

CREATE UNIQUE INDEX customer_customer_id_idx ON
    customer (
        customer_id
    ASC );

CREATE INDEX customer_language_id_idx ON
    customer (
        language_id
    ASC );

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customer_id );

ALTER TABLE customer ADD CONSTRAINT customer_email_uk UNIQUE ( email );

CREATE TABLE customer_address (
    address1            VARCHAR2(1000 BYTE),
    address2            VARCHAR2(1000 BYTE),
    city                VARCHAR2(1000 BYTE),
    postal_code         VARCHAR2(1000 BYTE),
    phone               VARCHAR2(1000 BYTE),
    customer_address_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    country_id          NUMBER NOT NULL,
    customer_id         NUMBER NOT NULL
);

CREATE UNIQUE INDEX customer_address_customer_address_id_idx ON
    customer_address (
        customer_address_id
    ASC );

CREATE UNIQUE INDEX customer_address_customer_id_country_id_customer_address_id_idx ON
    customer_address (
        customer_id
    ASC,
        country_id
    ASC,
        customer_address_id
    ASC );

CREATE INDEX customer_address_country_id_idx ON
    customer_address (
        country_id
    ASC );

ALTER TABLE customer_address ADD CONSTRAINT customer_address_pk PRIMARY KEY ( customer_address_id );

ALTER TABLE customer_address
    ADD CONSTRAINT customer_address__uk UNIQUE ( customer_id,
                                                 country_id,
                                                 customer_address_id );

CREATE TABLE customer_payment (
    payment_type        VARCHAR2(1000 BYTE) NOT NULL,
    provider            VARCHAR2(1000 BYTE),
    account_number      NUMBER,
    valid_to            DATE,
    customer_payment_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    customer_id         NUMBER NOT NULL
);

CREATE UNIQUE INDEX customer_payment_customer_payment_id_idx ON
    customer_payment (
        customer_payment_id
    ASC );

CREATE INDEX customer_payment_customer_id_idx ON
    customer_payment (
        customer_id
    ASC );

ALTER TABLE customer_payment ADD CONSTRAINT customer_payment_pk PRIMARY KEY ( customer_payment_id );

CREATE TABLE invoice (
    invoice_number      NUMBER,
    invoice_date        DATE DEFAULT sysdate NOT NULL,
    amount              NUMBER DEFAULT 0 NOT NULL,
    invoice_id          NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    customer_id         NUMBER NOT NULL,
    customer_address_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX invoice_invoice_number_idx ON
    invoice (
        invoice_number
    ASC );

CREATE UNIQUE INDEX invoice_invoice_id_idx ON
    invoice (
        invoice_id
    ASC );

CREATE INDEX invoice_customer_id_idx ON
    invoice (
        customer_id
    ASC );

CREATE INDEX invoice_customer_address_id_idx ON
    invoice (
        customer_address_id
    ASC );

ALTER TABLE invoice ADD CONSTRAINT invoice_pk PRIMARY KEY ( invoice_id );

ALTER TABLE invoice ADD CONSTRAINT invoice_invoice_number_uk UNIQUE ( invoice_number );

CREATE TABLE invoice_line (
    quantity        NUMBER DEFAULT 0 NOT NULL,
    unit_price      NUMBER DEFAULT 0 NOT NULL,
    amount          NUMBER DEFAULT 0 NOT NULL,
    invoice_line_id NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    book_id         NUMBER NOT NULL,
    invoice_id      NUMBER NOT NULL
);

CREATE UNIQUE INDEX invoice_line_invoice_line_id_idx ON
    invoice_line (
        invoice_line_id
    ASC );

CREATE INDEX invoice_line_book_id_idx ON
    invoice_line (
        book_id
    ASC );

CREATE INDEX invoice_line_invoice_id_idx ON
    invoice_line (
        invoice_id
    ASC );

ALTER TABLE invoice_line ADD CONSTRAINT invoice_line_pk PRIMARY KEY ( invoice_line_id );

CREATE TABLE invoice_payment (
    payment_date        DATE DEFAULT sysdate NOT NULL,
    amount              NUMBER DEFAULT 0 NOT NULL,
    status              VARCHAR2(10) DEFAULT 'S' NOT NULL,
    invoice_payment_id  NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    invoice_id          NUMBER NOT NULL,
    customer_payment_id NUMBER NOT NULL
);

ALTER TABLE invoice_payment
    ADD CHECK ( status IN ( 'E', 'S', 'W' ) );

CREATE UNIQUE INDEX invoice_payment_invoice_payment_id_idx ON
    invoice_payment (
        invoice_payment_id
    ASC );

CREATE INDEX invoice_payment_invoice_id_idx ON
    invoice_payment (
        invoice_id
    ASC );

CREATE INDEX invoice_payment_customer_payment_id_idx ON
    invoice_payment (
        customer_payment_id
    ASC );

ALTER TABLE invoice_payment ADD CONSTRAINT invoice_payment_pk PRIMARY KEY ( invoice_payment_id );

CREATE TABLE language (
    language_code VARCHAR2(2 BYTE) NOT NULL,
    name          VARCHAR2(100 BYTE) NOT NULL,
    language_id   NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL
);

CREATE UNIQUE INDEX language_language_code_idx ON
    language (
        language_code
    ASC );

CREATE UNIQUE INDEX language_name_idx ON
    language (
        name
    ASC );

CREATE UNIQUE INDEX language_language_id_idx ON
    language (
        language_id
    ASC );

ALTER TABLE language ADD CONSTRAINT language_pk PRIMARY KEY ( language_id );

ALTER TABLE language ADD CONSTRAINT language_language_code_uk UNIQUE ( language_code );

ALTER TABLE language ADD CONSTRAINT language_name_uk UNIQUE ( name );

CREATE TABLE log (
    id          NUMBER NOT NULL,
    event       DATE NOT NULL,
    description VARCHAR2(4000 BYTE),
    log_id      NUMBER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL
);

CREATE UNIQUE INDEX log_id_idx ON
    log (
        id
    ASC );

CREATE UNIQUE INDEX log_log_id_idx ON
    log (
        log_id
    ASC );

ALTER TABLE log ADD CONSTRAINT log_pk PRIMARY KEY ( log_id );

ALTER TABLE log ADD CONSTRAINT log_id_uk UNIQUE ( id );

ALTER TABLE book
    ADD CONSTRAINT book_book_category_fk FOREIGN KEY ( book_category_id )
        REFERENCES book_category ( book_category_id );

ALTER TABLE book_category_tl
    ADD CONSTRAINT book_category_tl_book_category_fk FOREIGN KEY ( book_category_id )
        REFERENCES book_category ( book_category_id );

ALTER TABLE book_category_tl
    ADD CONSTRAINT book_category_tl_language_fk FOREIGN KEY ( language_id )
        REFERENCES language ( language_id );

ALTER TABLE book_inventory
    ADD CONSTRAINT book_inventory_book_fk FOREIGN KEY ( book_id )
        REFERENCES book ( book_id );

ALTER TABLE book_price
    ADD CONSTRAINT book_price_book_fk FOREIGN KEY ( book_id )
        REFERENCES book ( book_id );

ALTER TABLE book_review
    ADD CONSTRAINT book_review_book_fk FOREIGN KEY ( book_id )
        REFERENCES book ( book_id );

ALTER TABLE book_review
    ADD CONSTRAINT book_review_customer_fk FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE book_tl
    ADD CONSTRAINT book_tl_book_fk FOREIGN KEY ( book_id )
        REFERENCES book ( book_id );

ALTER TABLE book_tl
    ADD CONSTRAINT book_tl_language_fk FOREIGN KEY ( language_id )
        REFERENCES language ( language_id );

ALTER TABLE cart
    ADD CONSTRAINT cart_customer_fk FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE cart_line
    ADD CONSTRAINT cart_line_book_fk FOREIGN KEY ( book_id )
        REFERENCES book ( book_id );

ALTER TABLE cart_line
    ADD CONSTRAINT cart_line_cart_fk FOREIGN KEY ( cart_id )
        REFERENCES cart ( cart_id );

ALTER TABLE customer_address
    ADD CONSTRAINT customer_address_country_fk FOREIGN KEY ( country_id )
        REFERENCES country ( country_id );

ALTER TABLE customer_address
    ADD CONSTRAINT customer_address_customer_fk FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE customer
    ADD CONSTRAINT customer_language_fk FOREIGN KEY ( language_id )
        REFERENCES language ( language_id );

ALTER TABLE customer_payment
    ADD CONSTRAINT customer_payment_customer_fk FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE invoice
    ADD CONSTRAINT invoice_customer_address_fk FOREIGN KEY ( customer_address_id )
        REFERENCES customer_address ( customer_address_id );

ALTER TABLE invoice
    ADD CONSTRAINT invoice_customer_fk FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE invoice_line
    ADD CONSTRAINT invoice_line_book_fk FOREIGN KEY ( book_id )
        REFERENCES book ( book_id );

ALTER TABLE invoice_line
    ADD CONSTRAINT invoice_line_invoice_fk FOREIGN KEY ( invoice_id )
        REFERENCES invoice ( invoice_id );

ALTER TABLE invoice_payment
    ADD CONSTRAINT invoice_payment_customer_payment_fk FOREIGN KEY ( customer_payment_id )
        REFERENCES customer_payment ( customer_payment_id );

ALTER TABLE invoice_payment
    ADD CONSTRAINT invoice_payment_invoice_fk FOREIGN KEY ( invoice_id )
        REFERENCES invoice ( invoice_id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            19
-- CREATE INDEX                            52
-- ALTER TABLE                             61
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0