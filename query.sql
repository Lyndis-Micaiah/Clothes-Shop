USE ClothesShop;

-- CREATE TABLE Clothes (
--     ProductID INT PRIMARY KEY IDENTITY(1,1), -- Auto-incremented unique identifier for each product
--     Title NVARCHAR(255) NOT NULL,             -- Product title (string, maximum 255 characters)
--     Description NVARCHAR(1000),               -- Product description (string, optional)
--     Price DECIMAL(18, 2) NOT NULL CHECK (Price >= 0), -- Product price (decimal with 2 decimal places)
--     ImageUrl NVARCHAR(1000)                   -- Product image URL (string, optional)
-- );

INSERT INTO Clothes (Title, Description, Price, ImageUrl)
VALUES
('Casual T-Shirt', 'Comfortable cotton t-shirt for everyday wear.', 19.99, 'https://example.com/images/casual_tshirt.jpg'),
('Slim Fit Jeans', 'Stylish slim fit jeans with a modern design.', 39.99, 'https://example.com/images/slim_fit_jeans.jpg'),
('Winter Jacket', 'Warm jacket with insulated lining for cold weather.', 89.99, 'https://example.com/images/winter_jacket.jpg'),
('Sports Shoes', 'Breathable shoes designed for running and fitness.', 59.99, 'https://example.com/images/sports_shoes.jpg'),
('Leather Boots', 'Durable leather boots for outdoor adventures.', 129.99, 'https://example.com/images/leather_boots.jpg'),
('Summer Dress', 'Lightweight and stylish dress for hot weather.', 49.99, 'https://example.com/images/summer_dress.jpg'),
('Classic Hoodie', 'Warm hoodie with adjustable drawstrings for comfort.', 34.99, 'https://example.com/images/classic_hoodie.jpg'),
('Smartwatch', 'Track your fitness with this stylish smartwatch.', 149.99, 'https://example.com/images/smartwatch.jpg');

SELECT * FROM Clothes;