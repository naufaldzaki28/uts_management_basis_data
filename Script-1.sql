CREATE SCHEMA IF NOT EXISTS SALAM;

CREATE TABLE SALAM.mahasiswas (
    nim VARCHAR(10) PRIMARY KEY,              
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,                
    angkatan INT CHECK (angkatan >= 2000)    
);

CREATE TABLE SALAM.dosen (
    nip VARCHAR(18) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE SALAM.matakuliah (
    kode_mk VARCHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(100) NOT NULL,
    sks INT CHECK (sks > 0)
);

CREATE TABLE SALAM.perwalian (
    id_perwalian SERIAL PRIMARY KEY,
    nim VARCHAR(10) REFERENCES SALAM.mahasiswas(nim) ON DELETE CASCADE,
    nip VARCHAR(18) REFERENCES SALAM.dosen(nip) ON DELETE SET NULL,
    tanggal_perwalian DATE DEFAULT CURRENT_DATE
);

INSERT INTO SALAM.mahasiswas (nim, nama, email, angkatan) 
VALUES ('22082001', 'Naufal', 'naufal@test.com', 2024);

INSERT INTO SALAM.mahasiswas (nim, nama, email, angkatan) 
VALUES ('22082001', 'Budi', 'budi@test.com', 2022);

INSERT INTO SALAM.mahasiswas (nim, nama, email, angkatan) 
VALUES ('22082002', 'Andi', 'naufal@test.com', 2022);

INSERT INTO SALAM.mahasiswas (nim, nama, email, angkatan) 
VALUES ('22082003', 'Cici', 'cici@test.com', 1999);

-- 1. User: backend_dev (Role: CRUD semua table)
CREATE USER backend_dev WITH PASSWORD 'pass_backend123';
GRANT USAGE ON SCHEMA SALAM TO backend_dev;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA SALAM TO backend_dev;

-- 2. User: bi_dev (Role: Hanya READ/SELECT semua table/view)
CREATE USER bi_dev WITH PASSWORD 'pass_bidev123';
GRANT USAGE ON SCHEMA SALAM TO bi_dev;
GRANT SELECT ON ALL TABLES IN SCHEMA SALAM TO bi_dev;

-- 3. User: data_engineer (Role: DDL + CRUD semua table)
CREATE USER data_engineer WITH PASSWORD 'pass_dataeng123';
GRANT ALL PRIVILEGES ON SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA SALAM TO data_engineer;