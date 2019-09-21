DROP TABLE screenings;
DROP TABLE tickets;
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

CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers ON DELETE CASCADE,
  film_id INT4 REFERENCES films ON DELETE CASCADE
);

CREATE TABLE screenings(
  id SERIAL4 PRIMARY KEY,
  start_time DATE,
  film_id  INT4 REFERENCES films ON DELETE CASCADE,
  ticket_id INT4 REFERENCES tickets ON DELETE CASCADE
);
