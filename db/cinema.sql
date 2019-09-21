DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE films;
DROP TABLE customers;

CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE screenings(
  id SERIAL4 PRIMARY KEY,
  start_time VARCHAR(255),
  film_id  INT4 REFERENCES films ON DELETE CASCADE,
  total_tickets INT
);

CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers ON DELETE CASCADE,
  screening_id INT4 REFERENCES screenings ON DELETE CASCADE
);
