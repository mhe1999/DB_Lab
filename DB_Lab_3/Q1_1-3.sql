------------Q1------------

--STEP 1
create login TestLogin with PASSWORD = 'TestPass',

--STEP 2
create server role TestRole;

grant create ANY DATABASE 
to TestRole; 

grant alter ANY DATABASE 
to TestRole;

--STEP 3
alter server role TestRole add member TestLogin;



------------Q2------------
create role TestRole2;

create user TestUser for login TestLogin;

alter role TestRole2 add member TestUser;

alter role db_securityadmin add member TestRole2;
