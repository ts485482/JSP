CREATE TABLE cloth (

    c_id VARCHAR2(10) NOT NULL,         -- ��ǰ��ȣ
    c_name VARCHAR2(100) NOT NULL,      -- ��ǰ�̸�

    c_price NUMBER,                     -- ����

    c_manufacturer VARCHAR2(50),        -- ������
    c_brand VARCHAR2(50),               -- �귣��

    c_country VARCHAR2(50),             -- ������

    c_topLength VARCHAR2(30),           -- �Ҹű���
    c_pattern VARCHAR2(30),             -- ����

    c_pantsLength VARCHAR2(30),         -- ���Ǳ���
    c_season VARCHAR2(30),              -- �������?

    c_category VARCHAR2(30),            -- ����

    c_stock NUMBER,                     -- �������?

    c_description CLOB,                 -- ��ǰ����

    c_fileName VARCHAR2(100),           -- �̹���

    CONSTRAINT PK_CLOTH PRIMARY KEY (c_id)

);


CREATE TABLE member ( 
    m_id VARCHAR2(30) NOT NULL,
    m_password VARCHAR2(100) NOT NULL,
    m_name VARCHAR2(20) NOT NULL,
    m_gender VARCHAR2(10),
    m_birth VARCHAR2(10),
    m_email VARCHAR2(30),
    m_phone VARCHAR2(20),
    m_address VARCHAR2(90),
    regist_day VARCHAR2(50),    
    CONSTRAINT PK_MEMBER PRIMARY KEY(m_id) 
);

INSERT INTO member VALUES('admin','1234','������',null,null,null,null,null,null);
DROP TABLE MEMBER;
ALTER TABLE member MODIFY m_id VARCHAR2(30);

CREATE TABLE cart (

    cart_id NUMBER GENERATED ALWAYS AS IDENTITY,
    
    m_id VARCHAR2(10) NOT NULL,

    c_id VARCHAR2(10) NOT NULL,

    quantity NUMBER DEFAULT 1,

    CONSTRAINT PK_CART PRIMARY KEY(cart_id),

    CONSTRAINT FK_CART_MEMBER
        FOREIGN KEY(m_id)
        REFERENCES member(m_id),

    CONSTRAINT FK_CART_CLOTH
        FOREIGN KEY(c_id)
        REFERENCES cloth(c_id)

);

--AI
CREATE TABLE recent_view (
    m_id VARCHAR2(20),
    c_id VARCHAR2(20),
    viewed_at DATE DEFAULT SYSDATE,

    CONSTRAINT pk_recent_view PRIMARY KEY (m_id, c_id),

    CONSTRAINT fk_recent_member
        FOREIGN KEY (m_id)
        REFERENCES member(m_id),

    CONSTRAINT fk_recent_cloth
        FOREIGN KEY (c_id)
        REFERENCES cloth(c_id)
);

CREATE TABLE orderinfo (
    order_id NUMBER PRIMARY KEY,
    m_id VARCHAR2(20),
    receiver_name VARCHAR2(30),
    receiver_phone VARCHAR2(30),
    receiver_address VARCHAR2(200),
    message VARCHAR2(200),
    total_price NUMBER,
    order_date DATE DEFAULT SYSDATE
);

CREATE TABLE orderitem (
    item_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    c_id VARCHAR2(20),
    c_name VARCHAR2(100),
    c_price NUMBER,
    quantity NUMBER,
    subtotal NUMBER
);

CREATE SEQUENCE order_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE orderitem_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

INSERT INTO cloth VALUES (
'P001',
'��ũ ���ڸ� ��Ʈ',
59000,
'�������丮',
'�������?',
'���ѹα�',
'����',
'����',
'�����?',
'��/����',
'�������?',
50,
'�ε巯�� ��ũ ������ ���� ���? ��Ʈ',
'men1.jpg'
);

INSERT INTO cloth VALUES (
'P002',
'üũ �� ���?',
39000,
'��ư����',
'��������',
'���ѹα�',
'����',
'üũ',
'�����?',
'�ܿ�',
'�������?',
30,
'������ üũ ���� �� ���?',
'men2.jpg'
);

INSERT INTO cloth VALUES (
'P003',
'���̽� Ȩ����',
49000,
'�帲���丮',
'�帲����',
'���ѹα�',
'����',
'����',
'�ݹ���',
'����',
'�������?',
40,
'���̽� ����Ʈ ���� Ȩ���� ��Ʈ',
'women1.jpg'
);

INSERT INTO cloth VALUES (
'P004',
'��ũ ���ǽ� ���?',
42000,
'��������',
'��������',
'���ѹα�',
'����',
'ĳ����',
'���ǽ�',
'����',
'�������?',
25,
'�ε巯�� ��ư ���ǽ� ��Ÿ�� ���?',
'women2.jpg'
);

INSERT INTO cloth VALUES (
'P005',
'���� Ŀ�� ���ڸ�',
79000,
'�������?',
'���꽽��',
'���ѹα�',
'����',
'������',
'�����?',
'�ܿ�',
'Ŀ�ü�Ʈ',
15,
'������ ���� Ŀ�� ���? ��Ʈ',
'couple1.jpg'
);

INSERT INTO cloth VALUES (
'P006',
'��Ʈ������ Ŀ�� ���?',
85000,
'���տ���',
'���տ���',
'���ѹα�',
'����',
'��Ʈ������',
'�����?',
'��/����',
'Ŀ�ü�Ʈ',
20,
'������ ��Ʈ������ Ŀ�� Ȩ����',
'couple2.jpg'
);

ALTER TABLE orderinfo
ADD order_status VARCHAR2(20) DEFAULT '�����Ϸ�';

CREATE TABLE wishlist (
    wishlist_id NUMBER GENERATED ALWAYS AS IDENTITY,
    m_id VARCHAR2(10),
    c_id VARCHAR2(10),

    CONSTRAINT pk_wishlist PRIMARY KEY(wishlist_id),

    CONSTRAINT fk_wishlist_member
        FOREIGN KEY(m_id)
        REFERENCES member(m_id),

    CONSTRAINT fk_wishlist_cloth
        FOREIGN KEY(c_id)
        REFERENCES cloth(c_id)
);

