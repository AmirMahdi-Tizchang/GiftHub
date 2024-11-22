-- Children table
CREATE TABLE children(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    location TEXT NOT NULL,
    status TEXT CHECK(status IN ('naughty', 'nice')) NOT NULL,
    birth DATE NOT NULL
);

-- Letters table
CREATE TABLE letters(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    child_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    year INTEGER NOT NULL,
    FOREIGN KEY(child_id) REFERENCES children(id)
);

-- Gifts table
CREATE TABLE gifts(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    model TEXT NOT NULL,
    description TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity >= 0),
    category TEXT CHECK(category IN ('Action Figures & Dolls', 'Educational Toys', 'Plush Toys', 'Outdoor Toys', 'Electronic Toys', 'Board Games & Puzzles', 'Creative Arts & Crafts', 'Musical Instruments')) NOT NULL
);

-- Deliveries connection table
CREATE TABLE deliveries(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    gift_id INTEGER NOT NULL,
    child_id INTEGER NOT NULL,
    year INTEGER NOT NULL,
    FOREIGN KEY(child_id) REFERENCES children(id),
    FOREIGN KEY(gift_id) REFERENCES gifts(id)
);

-- Create a trigger for updating quantities of gifts
CREATE TRIGGER decrease_quantity
AFTER INSERT ON deliveries
FOR EACH ROW
BEGIN
    UPDATE gifts
    SET quantity = quantity - 1
    WHERE id = NEW.gift_id;
END;

-- Create a view for new letters
CREATE VIEW Letters2024 AS
    SELECT children.name AS Name, content AS Letter
    FROM letters
    JOIN children ON letters.child_id = children.id
    WHERE letters.year = 2024;

-- Create a view for who haven't written letters
CREATE VIEW Blank2024 AS
SELECT name AS Name
FROM children
LEFT JOIN letters ON children.id = letters.child_id
WHERE letters.child_id IS NULL;

-- Create index on important sections
CREATE INDEX idx_name ON children(name);
CREATE INDEX idx_year_deliveries ON deliveries(year);
CREATE INDEX idx_year_letters ON letters(year);
CREATE INDEX idx_model ON gifts(model);
