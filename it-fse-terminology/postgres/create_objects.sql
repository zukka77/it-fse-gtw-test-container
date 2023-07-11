CREATE TABLE ROLES ( ID varchar(255) PRIMARY KEY, DESCRIPTION varchar(255) );
INSERT INTO ROLES VALUES(gen_random_uuid()::text, 'ADMIN'); 
INSERT INTO ROLES VALUES(gen_random_uuid()::text, 'ARCHITECT'); 
INSERT INTO ROLES VALUES(gen_random_uuid()::text, 'APPROVER'); 
INSERT INTO ROLES VALUES(gen_random_uuid()::text, 'AUTHOR_CS'); 
INSERT INTO ROLES VALUES(gen_random_uuid()::text, 'AUTHOR_VS'); 
INSERT INTO ROLES VALUES(gen_random_uuid()::text, 'AUTHOR_CM'); 
INSERT INTO ROLES VALUES(gen_random_uuid()::text, 'CONSUMER'); 
INSERT INTO ROLES VALUES(gen_random_uuid()::text, 'EDS');