CREATE TABLE cloth (

    c_id VARCHAR2(10) NOT NULL,          -- ï¿½ï¿½Ç°ï¿½ï¿½È£
    c_name VARCHAR2(100) NOT NULL,      -- ï¿½ï¿½Ç°ï¿½ï¿½

    c_price NUMBER,                     -- ï¿½ï¿½ï¿½ï¿½

    c_manufacturer VARCHAR2(50),        -- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
    c_brand VARCHAR2(50),               -- ï¿½ê·£ï¿½ï¿½

    c_country VARCHAR2(50),             -- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½

    c_topLength VARCHAR2(30),           -- ï¿½Ò¸Å±ï¿½ï¿½ï¿½
    c_pattern VARCHAR2(30),             -- ï¿½ï¿½ï¿½ï¿½

    c_pantsLength VARCHAR2(30),         -- ï¿½ï¿½ï¿½Ç±ï¿½ï¿½ï¿½
    c_season VARCHAR2(30),              -- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?

    c_category VARCHAR2(30),            -- ï¿½ï¿½ï¿½ï¿½

    c_stock NUMBER,                     -- ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?

    c_description CLOB,                 -- ï¿½ï¿½Ç°ï¿½ï¿½ï¿½ï¿½

    c_fileName VARCHAR2(100),           -- ï¿½Ì¹ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½Ï¸ï¿½

    CONSTRAINT PK_CLOTH PRIMARY KEY (c_id)

);


CREATE TABLE member ( 
    m_id VARCHAR2(10) NOT NULL,
    m_password VARCHAR2(100) NOT NULL,
    m_name VARCHAR2(10) NOT NULL,
    m_gender VARCHAR2(10),
    m_birth VARCHAR2(10),
    m_email VARCHAR2(30),
    m_phone VARCHAR2(20),
    m_address VARCHAR2(90),
    regist_day VARCHAR2(50),    
    CONSTRAINT PK_MEMBER PRIMARY KEY(m_id) 
);

DROP TABLE MEMBER;


INSERT INTO cloth VALUES (
'P001',
'½ÇÅ© ÆÄÀÚ¸¶ ¼¼Æ®',
59000,
'½½¸³ÆÑÅä¸®',
'¸ð´ø½½¸³',
'´ëÇÑ¹Î±¹',
'±äÆÈ',
'¹«Áö',
'±ä¹ÙÁö',
'º½/°¡À»',
'³²¼ºÀá¿Ê',
50,
'ºÎµå·¯¿î ½ÇÅ© ¼ÒÀçÀÇ ³²¼º Àá¿Ê ¼¼Æ®',
'men1.jpg'
);

INSERT INTO cloth VALUES (
'P002',
'Ã¼Å© ¸é Àá¿Ê',
39000,
'ÄÚÆ°¿þ¾î',
'½½¸³¿þ¾î',
'´ëÇÑ¹Î±¹',
'±äÆÈ',
'Ã¼Å©',
'±ä¹ÙÁö',
'°Ü¿ï',
'³²¼ºÀá¿Ê',
30,
'Æí¾ÈÇÑ Ã¼Å© ÆÐÅÏ ¸é Àá¿Ê',
'men2.jpg'
);

INSERT INTO cloth VALUES (
'P003',
'·¹ÀÌ½º È¨¿þ¾î',
49000,
'µå¸²ÆÑÅä¸®',
'µå¸²¿þ¾î',
'´ëÇÑ¹Î±¹',
'¹ÝÆÈ',
'¹«Áö',
'¹Ý¹ÙÁö',
'¿©¸§',
'¿©¼ºÀá¿Ê',
40,
'·¹ÀÌ½º Æ÷ÀÎÆ® ¿©¼º È¨¿þ¾î ¼¼Æ®',
'women1.jpg'
);

INSERT INTO cloth VALUES (
'P004',
'ÇÎÅ© ¿øÇÇ½º Àá¿Ê',
42000,
'ÄÚÁö¿þ¾î',
'ÄÚÁö³ªÀÕ',
'´ëÇÑ¹Î±¹',
'¹ÝÆÈ',
'Ä³¸¯ÅÍ',
'¿øÇÇ½º',
'¿©¸§',
'¿©¼ºÀá¿Ê',
25,
'ºÎµå·¯¿î ÄÚÆ° ¿øÇÇ½º ½ºÅ¸ÀÏ Àá¿Ê',
'women2.jpg'
);

INSERT INTO cloth VALUES (
'P005',
'º£¾î Ä¿ÇÃ ÆÄÀÚ¸¶',
79000,
'·¯ºê¿þ¾î',
'·¯ºê½½¸³',
'´ëÇÑ¹Î±¹',
'±äÆÈ',
'°õµ¹ÀÌ',
'±ä¹ÙÁö',
'°Ü¿ï',
'Ä¿ÇÃ¼¼Æ®',
15,
'°õµ¹ÀÌ ÆÐÅÏ Ä¿ÇÃ Àá¿Ê ¼¼Æ®',
'couple1.jpg'
);

INSERT INTO cloth VALUES (
'P006',
'½ºÆ®¶óÀÌÇÁ Ä¿ÇÃ Àá¿Ê',
85000,
'³ªÀÕ¿þ¾î',
'³ªÀÕ¿þ¾î',
'´ëÇÑ¹Î±¹',
'±äÆÈ',
'½ºÆ®¶óÀÌÇÁ',
'±ä¹ÙÁö',
'º½/°¡À»',
'Ä¿ÇÃ¼¼Æ®',
20,
'½ÉÇÃÇÑ ½ºÆ®¶óÀÌÇÁ Ä¿ÇÃ È¨¿þ¾î',
'couple2.jpg'
);
