CREATE ROLE dev LOGIN PASSWORD 'postgres@123';
CREATE DATABASE dev;
GRANT ALL PRIVILEGES ON DATABASE dev TO dev;