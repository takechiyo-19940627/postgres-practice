-- Create tables

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL
);

CREATE TABLE film (
    film_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year INTEGER,
    rental_rate DECIMAL(4,2) NOT NULL,
    length INTEGER,
    rating VARCHAR(5)
);

CREATE TABLE film_category (
    film_id INTEGER,
    category_id INTEGER,
    PRIMARY KEY (film_id, category_id)
);

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL
);

CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    film_id INTEGER NOT NULL,
    store_id INTEGER NOT NULL
);

CREATE TABLE rental (
    rental_id SERIAL PRIMARY KEY,
    rental_date TIMESTAMP NOT NULL,
    inventory_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    return_date TIMESTAMP,
    staff_id INTEGER NOT NULL
);

CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    store_id INTEGER NOT NULL
);

-- Add foreign key constraints

ALTER TABLE film_category
ADD CONSTRAINT fk_film_category_film FOREIGN KEY (film_id) REFERENCES film (film_id),
ADD CONSTRAINT fk_film_category_category FOREIGN KEY (category_id) REFERENCES category (category_id);

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_film FOREIGN KEY (film_id) REFERENCES film (film_id);

ALTER TABLE rental
ADD CONSTRAINT fk_rental_inventory FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id),
ADD CONSTRAINT fk_rental_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
ADD CONSTRAINT fk_rental_staff FOREIGN KEY (staff_id) REFERENCES staff (staff_id);
