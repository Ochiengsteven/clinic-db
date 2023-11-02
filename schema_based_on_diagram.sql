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
    status VARCHAR(80),
    FOREIGN KEY (patient_id) REFERENCES Patients(id)
);

-- Create an index on the patient_id column
CREATE INDEX idx_patient_id ON Medical_Histories (patient_id);

CREATE TABLE Treatments (
    id SERIAL PRIMARY KEY,
    type VARCHAR(80),
    name VARCHAR(80)
);

CREATE TABLE Invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES Medical_Histories(id)
);

-- Create an index on the medical_history_id column
CREATE INDEX idx_medical_history_id ON Invoices (medical_history_id);

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

-- Create an index on the invoice_id column
CREATE INDEX idx_invoice_id ON Invoice_Items (invoice_id);

-- Create an index on the treatment_id column
CREATE INDEX idx_treatment_id ON Invoice_Items (treatment_id);

-- Create a join table for the many-to-many relationship
CREATE TABLE Medical_History_Treatments (
    id SERIAL PRIMARY KEY,
    medical_history_id INT,
    treatment_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES Medical_Histories(id),
    FOREIGN KEY (treatment_id) REFERENCES Treatments(id)
);

-- Create indexes for the foreign keys in the join table
CREATE INDEX idx_medical_history_id ON Medical_History_Treatments (medical_history_id);
CREATE INDEX idx_treatment_id ON Medical_History_Treatments (treatment_id);
