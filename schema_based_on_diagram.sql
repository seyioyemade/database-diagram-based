Create DATABASE Clinical;

CREATE TABLE patients(
id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
name varchar(40) NOT NULL,
date_of_birth date
);

CREATE TABLE invoices (
  id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
  medical_history_id int,
  total_amount decimal,
  generated_at timestamp,
  payed_at timestamp,
  CONSTRAINT fk_medical
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
);

CREATE TABLE medical_histories (
  id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
  admitted_at timestamp,
  patient_id int,
  status varchar(40),
  CONSTRAINT fk_patient
  FOREIGN KEY (patient_id) REFERENCES patients(id),
);

CREATE TABLE invoice_items (
  id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
  unit_price decimal,
  quantity int,
  total_price decimal
  invoice_id int,
  treatment_id int,
  CONSTRAINT fk_invoice
  FOREIGN KEY (invoice_id ) REFERENCES invoices(id),
  CONSTRAINT fk_treatment
  FOREIGN KEY (treatment_id ) REFERENCES treatments(id),
);

CREATE TABLE treatments(
id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
type varchar(40),
name varchar(40)
);


CREATE TABLE medical_treatments (
  medical_id INT,
  treatments_id INT,
  CONSTRAINT fk_medical_many
  FOREIGN KEY (medical_id) REFERENCES medical_histories(id),
  CONSTRAINT fk_treatment_many
  FOREIGN KEY (treatments_id) REFERENCES treatments(id)
);

//Indexes
CREATE INDEX ON medical_histories (patient_id)
CREATE INDEX ON medical_Treatment (medical_id)
CREATE INDEX ON medical_Treatment (treatments_id)
CREATE INDEX ON invoice_items (invoice_id)
CREATE INDEX ON invoice_items (treatment_id)
CREATE INDEX ON invoices (medical_history_id)