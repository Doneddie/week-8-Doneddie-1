CREATE DATABASE SDG_6;
USE SDG_6;

CREATE TABLE Regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(255),
    population INT
);

CREATE TABLE Water_Sources (
    source_id INT PRIMARY KEY,
    region_id INT,
    source_type VARCHAR(50),
    capacity INT,
    contamination_level DECIMAL(5,2),
    FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);


CREATE TABLE Households (
    household_id INT PRIMARY KEY,
    region_id INT,
    has_clean_water BOOLEAN,
    daily_water_consumption INT,
    FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);

CREATE TABLE Sanitation_Facilities (
    facility_id INT PRIMARY KEY,
    region_id INT,
    facility_type VARCHAR(50),
    conditions VARCHAR(50),
    FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);

INSERT INTO Regions (region_id, region_name, population) 
VALUES (1, 'Region A', 15000),
(2, 'Region B', 23000),
(3, 'Region C', 8000);

INSERT INTO Water_sources (source_id, region_id, source_type, capacity, contamination_level) VALUES 
(1, 1, 'River', 100000, 2.5),
(2, 2, 'Well', 50000, 1.2),
(3, 3, 'Rainwater Harvesting', 20000, 0.8);

INSERT INTO Households (household_id, region_id, has_clean_water, daily_water_consumption) VALUES 
(1, 1, FALSE, 15),
(2, 1, TRUE, 30),
(3, 2, TRUE, 50);

INSERT INTO Sanitation_facilities (facility_id, region_id, facility_type, conditions) VALUES 
(1, 1, 'Public Toilet', 'Poor'),
(2, 2, 'Sewage System', 'Good');

SELECT region_name, COUNT(*) AS households_without_clean_water
FROM Households h
JOIN Regions r ON h.region_id = r.region_id
WHERE h.has_clean_water = FALSE
GROUP BY r.region_name;

SELECT region_name, source_type, contamination_level
FROM Water_sources ws
JOIN Regions r ON ws.region_id = r.region_id
ORDER BY contamination_level DESC;

SELECT region_name, AVG(daily_water_consumption) AS avg_water_consumption
FROM Households h
JOIN Regions r ON h.region_id = r.region_id
GROUP BY r.region_name;

