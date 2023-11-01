CREATE DATABASE clinic_database;

CREATE TABLE Patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    date_of_birth DATE
);

CREATE TABLE Medical_Histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status varchar(80),
    FOREIGN KEY (patient_id) REFERENCES Patients(id)
);

CREATE TABLE Treatments (
    id SERIAL PRIMARY KEY,
    type varchar(80),
    name varchar(80)
);

CREATE TABLE Invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES Medical_Histories(id)
);

CREATE TABLE Invoice_Items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    FOREIGN KEY (invoice_id) REFERENCES Invoices(id),
    FOREIGN KEY (treatment_id) REFERENCES Treatments(id)
);

-- add Medical_Histories and Treatments relationship
ALTER TABLE Medical_Histories
ADD COLUMN treatment_id INT,
ADD CONSTRAINT fk_treatment_id
    FOREIGN KEY (treatment_id)
    REFERENCES Treatments(id);

ALTER TABLE Treatments
ADD COLUMN history_id INT;
