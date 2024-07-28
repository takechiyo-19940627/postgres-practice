-- Insert sample data into customer table
INSERT INTO customer (first_name, last_name, email, registration_date)
SELECT
    'FirstName' || generate_series,
    'LastName' || generate_series,
    'customer' || generate_series || '@example.com',
    CURRENT_DATE - (random() * 365 * 3)::integer
FROM generate_series(1, 600);

-- Insert sample data into film table
INSERT INTO film (title, description, release_year, rental_rate, length, rating)
SELECT
    'Film Title ' || generate_series,
    'Description for film ' || generate_series,
    2000 + (random() * 23)::integer,
    (random() * 5 + 0.99)::numeric(4,2),
    (random() * 120 + 60)::integer,
    (ARRAY['G', 'PG', 'PG-13', 'R', 'NC-17'])[floor(random() * 5 + 1)]
FROM generate_series(1, 700);

-- Insert sample data into category table
INSERT INTO category (name)
VALUES
    ('Action'), ('Adventure'), ('Animation'), ('Children'),
    ('Comedy'), ('Documentary'), ('Drama'), ('Fantasy'),
    ('Film-Noir'), ('Horror'), ('Musical'), ('Mystery'),
    ('Romance'), ('Sci-Fi'), ('Thriller'), ('War'), ('Western');

-- Insert sample data into film_category table
INSERT INTO film_category (film_id, category_id)
SELECT
    film_id,
    (random() * 16 + 1)::integer
FROM film;

-- Insert sample data into inventory table
INSERT INTO inventory (film_id, store_id)
SELECT
    film_id,
    (random() * 2 + 1)::integer
FROM film,
     generate_series(1, 3);

-- Insert sample data into staff table
INSERT INTO staff (first_name, last_name, email, store_id)
SELECT
    'StaffFirst' || generate_series,
    'StaffLast' || generate_series,
    'staff' || generate_series || '@example.com',
    (random() * 2 + 1)::integer
FROM generate_series(1, 10);

-- Insert sample data into rental table
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
SELECT
    CURRENT_DATE - (random() * 365 * 2)::integer - (random() * 24 * 60 * 60)::integer * interval '1 second',
    inventory_id,
    (random() * 599 + 1)::integer,
    CASE WHEN random() > 0.1 THEN CURRENT_DATE - (random() * 30)::integer ELSE NULL END,
    (random() * 9 + 1)::integer
FROM inventory
LIMIT 750;
