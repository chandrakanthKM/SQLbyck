-- Various Statistics on Car Prices
SELECT 
    COUNT(DISTINCT make) AS company_name,
    COUNT(DISTINCT model) AS company_model,
    MIN(mmr) AS minimum,
    MAX(mmr) AS maximum,
    MAX(mmr) - MIN(mmr) AS range,
    AVG(mmr) AS mean,
    STDDEV(sellingprice) AS standard_deviation
FROM 
    car_prices;

   
-- Constructing a Histogram
WITH Histogram AS (
    SELECT 
        sellingprice,
        COUNT(*) AS frequency,
        sellingprice * COUNT(*) AS value
    FROM 
        car_prices
    GROUP BY 
        sellingprice
)
SELECT 
    AVG(sellingprice) AS mean_selling_price,
    SUM(value) / SUM(frequency) AS mean_value
FROM 
    Histogram;

-- Calculate the mean using a normalized histogram
WITH NHistogram AS (
    SELECT 
        sellingprice, 
        SUM(1.0 / total) AS Prob
    FROM 
        car_prices,
        (SELECT COUNT(*) AS total FROM car_prices) AS Temp
    GROUP BY 
        sellingprice
)
SELECT 
    SUM(sellingprice * Prob) AS mean
FROM 
    NHistogram;

-- Calculate the harmonic mean of selling prices
SELECT COUNT(sellingprice) / SUM(1/sellingprice) AS harmonicmean
FROM car_prices;

-- Find the mode (most frequent color)
WITH MHistogram AS (
    SELECT 
        color AS val, 
        COUNT(*) AS freq
    FROM 
        car_prices
    GROUP BY 
        color
)
SELECT 
    val
FROM 
    MHistogram, 
    (SELECT MAX(freq) AS top FROM MHistogram) AS T
WHERE 
    freq = top;

-- Calculating the Median Selling Price
SELECT AVG(sellingprice)
FROM (
    SELECT sellingprice, seller
    FROM car_prices cp
    ORDER BY sellingprice
    LIMIT 2 - MOD((SELECT COUNT(*) FROM car_prices), 2)
    OFFSET CEIL((SELECT COUNT(*) FROM car_prices) / 2.0)
) AS T;

-- Variance of Selling Prices
SELECT variance(sellingprice) FROM car_prices;

-- Skewness of Selling Prices
SELECT sum(pow(sellingprice - mean, 3)) / count(*) /
pow(sum(pow(sellingprice - mean, 2)) / (count(*) - 1), 1 / 3) as skewness
FROM car_prices cp , (SELECT avg(sellingprice) as mean FROM car_prices cp2) AS T;

-- Kurtosis of Selling Prices
SELECT sum(pow(sellingprice - mean, 4)) / count(*) /
pow(sum(pow(sellingprice - mean, 2)) / (count(*) - 1), 1 / 3) as kurtosis
FROM car_prices cp , (SELECT avg(sellingprice) as mean FROM car_prices cp2) AS T;

-- Count of cars by make
SELECT distinct make, count(*)
FROM car_prices cp 
GROUP BY make;

-- Count of cars by seller
SELECT seller, count(*) as seller_count
FROM car_prices cp 
GROUP BY seller;
-- Calculate sum(Pa * log(Pa))
SELECT sum(Pa * log(Pa))
FROM (
    SELECT model, sum(1.0 /total) as Pa
    FROM car_prices cp , (SELECT count(*) as total FROM car_prices cp2) AS T
    GROUP BY model
) AS SubqueryAlias;



SELECT make, model, sum(1.0 / total) as JointProb
FROM car_prices cp, (SELECT count(*) as total FROM car_prices) AS subquery
GROUP BY make, model;

-- 14. Update state names to full names

UPDATE car_prices SET state = 'Alabama' WHERE state = 'ab';
UPDATE car_prices SET state = 'Alaska' WHERE state = 'al';
UPDATE car_prices SET state = 'Arizona' WHERE state = 'az';
UPDATE car_prices SET state = 'Arkansas' WHERE state = 'ar';
UPDATE car_prices SET state = 'California' WHERE state = 'ca';
UPDATE car_prices SET state = 'Colorado' WHERE state = 'co';
UPDATE car_prices SET state = 'Connecticut' WHERE state = 'ct';
UPDATE car_prices SET state = 'Delaware' WHERE state = 'de';
UPDATE car_prices SET state = 'District of Columbia' WHERE state = 'dc';
UPDATE car_prices SET state = 'Florida' WHERE state = 'fl';
UPDATE car_prices SET state = 'Georgia' WHERE state = 'ga';
UPDATE car_prices SET state = 'Hawaii' WHERE state = 'hi';
UPDATE car_prices SET state = 'Idaho' WHERE state = 'id';
UPDATE car_prices SET state = 'Illinois' WHERE state = 'il';
UPDATE car_prices SET state = 'Indiana' WHERE state = 'in';
UPDATE car_prices SET state = 'Iowa' WHERE state = 'ia';
UPDATE car_prices SET state = 'Kansas' WHERE state = 'ks';
UPDATE car_prices SET state = 'Kentucky' WHERE state = 'ky';
UPDATE car_prices SET state = 'Louisiana' WHERE state = 'la';
UPDATE car_prices SET state = 'Maine' WHERE state = 'me';
UPDATE car_prices SET state = 'Maryland' WHERE state = 'md';
UPDATE car_prices SET state = 'Massachusetts' WHERE state = 'ma';
UPDATE car_prices SET state = 'Michigan' WHERE state = 'mi';
UPDATE car_prices SET state = 'Minnesota' WHERE state = 'mn';
UPDATE car_prices SET state = 'Mississippi' WHERE state = 'ms';
UPDATE car_prices SET state = 'Missouri' WHERE state = 'mo';
UPDATE car_prices SET state = 'Montana' WHERE state = 'mt';
UPDATE car_prices SET state = 'Nebraska' WHERE state = 'ne';
UPDATE car_prices SET state = 'Nevada' WHERE state = 'nv';
UPDATE car_prices SET state = 'Nova Scotia' WHERE state = 'ns';
UPDATE car_prices SET state = 'New Jersey' WHERE state = 'nj';
UPDATE car_prices SET state = 'New Mexico' WHERE state = 'nm';
UPDATE car_prices SET state = 'New York' WHERE state = 'ny';
UPDATE car_prices SET state = 'North Carolina' WHERE state = 'nc';
UPDATE car_prices SET state = 'North Dakota' WHERE state = 'nd';
UPDATE car_prices SET state = 'Ohio' WHERE state = 'oh';
UPDATE car_prices SET state = 'Oklahoma' WHERE state = 'ok';
UPDATE car_prices SET state = 'Oregon' WHERE state = 'or';
UPDATE car_prices SET state = 'Oregon' WHERE state = 'on';
UPDATE car_prices SET state = 'Pennsylvania' WHERE state = 'pa';
UPDATE car_prices SET state = 'Rhode Island' WHERE state = 'ri';
UPDATE car_prices SET state = 'South Carolina' WHERE state = 'sc';
UPDATE car_prices SET state = 'South Dakota' WHERE state = 'sd';
UPDATE car_prices SET state = 'Tennessee' WHERE state = 'tn';
UPDATE car_prices SET state = 'Texas' WHERE state = 'tx';
UPDATE car_prices SET state = 'Utah' WHERE state = 'ut';
UPDATE car_prices SET state = 'Quebec' WHERE state = 'qc';
UPDATE car_prices SET state = 'Virginia' WHERE state = 'va';
UPDATE car_prices SET state = 'Washington' WHERE state = 'wa';
UPDATE car_prices SET state = 'West Virginia' WHERE state = 'wv';
UPDATE car_prices SET state = 'Wisconsin' WHERE state = 'wi';
UPDATE car_prices SET state = 'Wyoming' WHERE state = 'wy';
UPDATE car_prices SET state = 'American Samoa' WHERE state = 'as';
UPDATE car_prices SET state = 'Guam' WHERE state = 'gu';
UPDATE car_prices SET state = 'Northern Mariana Islands' WHERE state = 'mp';
UPDATE car_prices SET state = 'Puerto Rico' WHERE state = 'pr';
UPDATE car_prices SET state = 'Virgin Islands' WHERE state = 'vi';
UPDATE car_prices SET state = 'Trust Territories' WHERE state = 'tt';
UPDATE car_prices
SET state = 
    CASE 
        WHEN state = '3vwd17aj0fm227318' THEN 'California'
        WHEN state = '3vwd17aj2fm258506' THEN 'New York'
        WHEN state = '3vwd17aj2fm261566' THEN 'Texas'
        WHEN state = '3vwd17aj2fm285365' THEN 'Florida'
        WHEN state = '3vwd17aj3fm259017' THEN 'California'
        WHEN state = '3vwd17aj3fm276741' THEN 'Texas'
        WHEN state = '3vwd17aj4fm201708' THEN 'Arizona'
        WHEN state = '3vwd17aj4fm236636' THEN 'Florida'
        WHEN state = '3vwd17aj5fm206111' THEN 'New York'
        WHEN state = '3vwd17aj5fm219943' THEN 'California'
        WHEN state = '3vwd17aj5fm221322' THEN 'Texas'
        WHEN state = '3vwd17aj5fm225953' THEN 'Florida'
        WHEN state = '3vwd17aj5fm268964' THEN 'New York'
        WHEN state = '3vwd17aj5fm273601' THEN 'California'
        WHEN state = '3vwd17aj5fm297123' THEN 'Texas'
        WHEN state = '3vwd17aj6fm218641' THEN 'Florida'
        WHEN state = '3vwd17aj6fm231972' THEN 'California'
        WHEN state = '3vwd17aj7fm218440' THEN 'New York'
        WHEN state = '3vwd17aj7fm222388' THEN 'Texas'
        WHEN state = '3vwd17aj7fm223475' THEN 'California'
        WHEN state = '3vwd17aj7fm229552' THEN 'Florida'
        WHEN state = '3vwd17aj7fm326640' THEN 'New York'
        WHEN state = '3vwd17aj8fm239622' THEN 'Texas'
        WHEN state = '3vwd17aj8fm298895' THEN 'California'
        WHEN state = '3vwd17aj9fm219766' THEN 'Florida'
        WHEN state = '3vwd17ajxfm315938' THEN 'New York'
        ELSE state
    END;
-- Update the table to convert numbers to years
UPDATE car_prices
SET year = EXTRACT(YEAR FROM TO_TIMESTAMP(year::text, 'YYYY'))::integer;
SELECT make,
       STRING_AGG(state, ', ' ORDER BY sellingprice DESC) AS states
FROM car_prices 
GROUP BY make;

UPDATE car_prices
SET make = 
    CASE 
        WHEN make = 'acura' THEN 'Acura'
        WHEN make = 'airstream' THEN 'Airstream'
        WHEN make = 'aston martin' THEN 'Aston Martin'
        WHEN make = 'audi' THEN 'Audi'
        WHEN make = 'bentley' THEN 'Bentley'
        WHEN make = 'bmw' THEN 'BMW'
        WHEN make = 'buick' THEN 'Buick'
        WHEN make = 'cadillac' THEN 'Cadillac'
        WHEN make = 'chevrolet' THEN 'Chevrolet'
        WHEN make = 'chev truck' THEN 'Chevrolet Truck'
        WHEN make = 'chrysler' THEN 'Chrysler'
        WHEN make = 'daewoo' THEN 'Daewoo'
        WHEN make = 'dodge' THEN 'Dodge'
        WHEN make = 'dodge truck' THEN 'Dodge Truck'
        WHEN make = 'dot' THEN 'Dot'
        WHEN make = 'ferrari' THEN 'Ferrari'
        WHEN make = 'fiat' THEN 'FIAT'
        WHEN make = 'fisker' THEN 'Fisker'
        WHEN make = 'ford' THEN 'Ford'
        WHEN make = 'ford truck' THEN 'Ford Truck'
        WHEN make = 'geo' THEN 'Geo'
        WHEN make = 'gmc' THEN 'GMC'
        WHEN make = 'gmc truck' THEN 'GMC Truck'
        WHEN make = 'honda' THEN 'Honda'
        WHEN make = 'hummer' THEN 'HUMMER'
        WHEN make = 'hyundai' THEN 'Hyundai'
        WHEN make = 'hyundai truck' THEN 'Hyundai Truck'
        WHEN make = 'infiniti' THEN 'Infiniti'
        WHEN make = 'isuzu' THEN 'Isuzu'
        WHEN make = 'jaguar' THEN 'Jaguar'
        WHEN make = 'jeep' THEN 'Jeep'
        WHEN make = 'kia' THEN 'Kia'
        WHEN make = 'lamborghini' THEN 'Lamborghini'
        WHEN make = 'landrover' THEN 'Landrover'
        WHEN make = 'land rover' THEN 'Land Rover'
        WHEN make = 'lexus' THEN 'Lexus'
        WHEN make = 'lincoln' THEN 'Lincoln'
        WHEN make = 'lotus' THEN 'Lotus'
        WHEN make = 'maserati' THEN 'Maserati'
        WHEN make = 'mazda' THEN 'Mazda'
        WHEN make = 'mazda truck' THEN 'Mazda Truck'
        WHEN make = 'mercedes' THEN 'Mercedes'
        WHEN make = 'mercedes-b' THEN 'Mercedes-B'
        WHEN make = 'mercedes-benz' THEN 'Mercedes-Benz'
        WHEN make = 'mercury' THEN 'Mercury'
        WHEN make = 'mini' THEN 'MINI'
        WHEN make = 'mitsubishi' THEN 'Mitsubishi'
        WHEN make = 'nissan' THEN 'Nissan'
        WHEN make = 'oldsmobile' THEN 'Oldsmobile'
        WHEN make = 'plymouth' THEN 'Plymouth'
        WHEN make = 'pontiac' THEN 'Pontiac'
        WHEN make = 'porsche' THEN 'Porsche'
        WHEN make = 'ram' THEN 'Ram'
        WHEN make = 'rolls-royce' THEN 'Rolls-Royce'
        WHEN make = 'saab' THEN 'Saab'
        WHEN make = 'saturn' THEN 'Saturn'
        WHEN make = 'scion' THEN 'Scion'
        WHEN make = 'smart' THEN 'Smart'
        WHEN make = 'subaru' THEN 'Subaru'
        WHEN make = 'suzuki' THEN 'Suzuki'
        WHEN make = 'tesla' THEN 'Tesla'
        WHEN make = 'toyota' THEN 'Toyota'
        WHEN make = 'volkswagen' THEN 'Volkswagen'
        WHEN make = 'volvo' THEN 'Volvo'
        ELSE make
    END;

UPDATE car_prices
SET make = 
    CASE 
        WHEN make = 'Mercedes' THEN 'Mercedes-Benz'
        WHEN make = 'Mercedes-B' THEN 'Mercedes-Benz'
        ELSE make
    END;
   
UPDATE car_prices
SET make = 
    CASE 
        WHEN make = 'Landrover' THEN 'Land Rover'
        WHEN make = 'ford Truck' THEN 'Ford Truck'
        WHEN make = 'Chev Truck' THEN 'Chevrolet Truck'
        ELSE make
    END;

DELETE FROM car_prices
WHERE year IS NULL OR transmission IS NULL OR model IS NULL OR make IS NULL OR trim IS NULL OR 
      body IS NULL OR vin IS NULL OR state IS NULL OR condition IS NULL OR odometer IS NULL OR 
      color IS NULL OR interior IS NULL OR seller IS NULL OR mmr IS NULL OR sellingprice IS NULL OR 
      saledate IS NULL;


SELECT make, ARRAY_TO_STRING(ARRAY_AGG(model ORDER BY sellingprice DESC), ', ')
FROM car_prices cp 
GROUP BY make;

DELETE FROM car_prices
WHERE year IS NULL OR
      make IS NULL OR
      model IS NULL OR
      trim IS NULL OR
      body IS NULL OR
      transmission IS NULL OR
      vin IS NULL OR
      state IS NULL OR
      condition IS NULL OR
      odometer IS NULL OR
      color IS NULL OR
      interior IS NULL OR
      seller IS NULL OR
      mmr IS NULL OR
      sellingprice IS NULL OR
      saledate IS NULL;

SELECT 
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS null_year,
    SUM(CASE WHEN make IS NULL THEN 1 ELSE 0 END) AS null_make,
    SUM(CASE WHEN model IS NULL THEN 1 ELSE 0 END) AS null_model,
    SUM(CASE WHEN trim IS NULL THEN 1 ELSE 0 END) AS null_trim,
    SUM(CASE WHEN body IS NULL THEN 1 ELSE 0 END) AS null_body,
    SUM(CASE WHEN transmission IS NULL THEN 1 ELSE 0 END) AS null_transmission,
    SUM(CASE WHEN vin IS NULL THEN 1 ELSE 0 END) AS null_vin,
    SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN condition IS NULL THEN 1 ELSE 0 END) AS null_condition,
    SUM(CASE WHEN odometer IS NULL THEN 1 ELSE 0 END) AS null_odometer,
    SUM(CASE WHEN color IS NULL THEN 1 ELSE 0 END) AS null_color,
    SUM(CASE WHEN interior IS NULL THEN 1 ELSE 0 END) AS null_interior,
    SUM(CASE WHEN seller IS NULL THEN 1 ELSE 0 END) AS null_seller,
    SUM(CASE WHEN mmr IS NULL THEN 1 ELSE 0 END) AS null_mmr,
    SUM(CASE WHEN sellingprice IS NULL THEN 1 ELSE 0 END) AS null_sellingprice,
    SUM(CASE WHEN saledate IS NULL THEN 1 ELSE 0 END) AS null_saledate
FROM 
    car_prices;
 SELECT make, COUNT(*) AS freq
FROM car_prices
GROUP BY make
HAVING COUNT(*) = 1;
SELECT 
    year, make, model, trim, body, transmission, vin, state, condition, odometer,
    color, interior, seller, mmr, sellingprice, saledate, 
    COUNT(*) AS frequency
FROM 
    car_prices
GROUP BY 
    year, make, model, trim, body, transmission, vin, state, condition, odometer,
    color, interior, seller, mmr, sellingprice, saledate
HAVING 
    COUNT(*) > 1;
select * from car_prices order by random() limit 10;

