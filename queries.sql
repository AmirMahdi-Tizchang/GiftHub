-- Insert children
INSERT INTO children (name, location, status, birth)
VALUES ('Alice Brown', 'Paris', 'nice', '2013-07-21'),
       ('Charlie Smith', 'Berlin', 'naughty', '2014-11-03'),
       ('Emily White', 'Rome', 'nice', '2012-02-17'),
       ('John Doe', 'New York', 'nice', '2012-05-14'),
       ('Jane Hamilton', 'London', 'naughty', '2011-09-23');

-- Insert letters
INSERT INTO letters (content, year, child_id)
VALUES ('Dear Santa, I would like a bicycle.', 2024, 1),
       ('Dear Santa, I want a toy car.', 2024, 2),
       ('Dear Santa, I would like a doll.', 2024, 3);

INSERT INTO deliveries (gift_id, year, child_id)
VALUES (4, 2023, 2),
       (1, 2023, 4);

-- Insert gifts with repeated and non-repeated categories
INSERT INTO gifts (model, description, category, quantity)
VALUES
    ('Action Figure Hero', 'A superhero action figure', 'Action Figures & Dolls', 10),
    ('Learning Tablet', 'An educational tablet for kids', 'Educational Toys', 5),
    ('Stuffed Teddy Bear', 'A soft teddy bear for cuddles', 'Plush Toys', 12),
    ('Outdoor Ball', 'A ball for outdoor play', 'Outdoor Toys', 8),
    ('Electronic Robot', 'A programmable electronic robot', 'Electronic Toys', 6),
    ('Board Game Set', 'A set of fun board games', 'Board Games & Puzzles', 7),
    ('Art Set', 'Complete art supplies set', 'Creative Arts & Crafts', 15),
    ('Musical Drum Kit', 'A small drum kit for kids', 'Musical Instruments', 4),
    ('Plush Doll', 'A soft and cuddly doll', 'Plush Toys', 9),
    ('Educational Puzzle', 'A puzzle that teaches shapes and numbers', 'Educational Toys', 11);


-- Update information
UPDATE children
SET status = 'nice'
WHERE id = 4;

-- Delete a letter
DELETE FROM letters
WHERE id = 2;

-- Query

-- Find All Gifts for a Specific Child
SELECT gifts.model, gifts.description, deliveries.year
FROM gifts
JOIN deliveries ON gifts.id = deliveries.gift_id
WHERE deliveries.child_id = ?;  -- Replace ? with the specific child's ID

-- Get the Number of Gifts Delivered in a Given Year
SELECT COUNT(*) AS total_gifts
FROM deliveries
WHERE year = ?; -- Replace ? with the year of interest

-- List All Children Who Have Not Written Letters in a Specific Year
SELECT children.name
FROM children
LEFT JOIN letters ON children.id = letters.child_id
WHERE letters.year IS NULL OR letters.year <> ?;  -- Replace ? with the specific year

-- View the Details of Letters Written by a Specific Child
SELECT content, year
FROM letters
WHERE child_id = (
    SELECT id FROM children WHERE name = ? -- Replace ? with the specific child's name
);
