CREATE DATABASE POLITICAL_ANALYSIS;

-- Use Database
USE POLITICAL_ANALYSIS;

select count(*) as total_records
from POLITICAL_ANALYSIS.cons_clean_2014;

select count(*) as total_records
from POLITICAL_ANALYSIS.cons_clean_2019;

-- source for abhriviation : https://ceodelhi.gov.in/OnlineERMS/PERMORMANCE/P9.pdf

/*
NOTE: The data underwent initial cleaning in Power Query before SQL. In both 2014 and 2019 datasets, text fields
(state, constituency, candidate) were trimmed and capitalized. Missing ages were replaced with 46; missing sex or 
category values were set to "Unknown." In 2019, sex labels ("MALE/FEM/THIRD") were standardized to "M/F/O," "GENERAL"
was shortened to "GEN," and "None Of The Above" candidates were set to "NOTA." 
These steps provided a standardized baseline before SQL operations.
*/

-- VERIFY THAT THE REQUIRED TABLES EXIST IN THE POLITICAL_ANALYSIS DATABASE
SHOW TABLES FROM POLITICAL_ANALYSIS;

DESCRIBE political_analysis.state_pc_name;

----------------------------------------------------
-- FIX SPELLING (2014)
UPDATE political_analysis.cons_clean_2014
SET pc_name = 'Narasapuram'
WHERE state = 'Andhra Pradesh'
  AND pc_name = 'Narsapuram'
LIMIT 1000;

-- FIX SPELLING (2019)
UPDATE political_analysis.cons_clean_2019
SET pc_name = 'Narasapuram'
WHERE state = 'Andhra Pradesh'
  AND pc_name = 'Narsapuram'
LIMIT 1000;

-- ASSAM: STANDARDIZE OFFICIAL NAME VARIANTS TO MATCH THE PROVIDED REFERENCE LIST (RUN ONCE FOR BOTH YEARS)
UPDATE political_analysis.cons_clean_2014
SET pc_name = CASE
  WHEN pc_name = 'Gauhati' THEN 'Guwahati'
  WHEN pc_name = 'Nowgong' THEN 'Nagaon'
  WHEN pc_name = 'Kaliabor' THEN 'Kaziranga'
  WHEN pc_name = 'Tezpur' THEN 'Sonitpur'
  WHEN pc_name = 'Autonomous District' THEN 'Diphu'
  WHEN pc_name = 'Mangaldoi' THEN 'Darrang-Udalguri'
  ELSE pc_name
END
WHERE state = 'Assam'
  AND pc_name IN ('Gauhati','Nowgong','Kaliabor','Tezpur','Autonomous District','Mangaldoi')
LIMIT 10000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = CASE
  WHEN pc_name = 'Gauhati' THEN 'Guwahati'
  WHEN pc_name = 'Nowgong' THEN 'Nagaon'
  WHEN pc_name = 'Kaliabor' THEN 'Kaziranga'
  WHEN pc_name = 'Tezpur' THEN 'Sonitpur'
  WHEN pc_name = 'Autonomous District' THEN 'Diphu'
  WHEN pc_name = 'Mangaldoi' THEN 'Darrang-Udalguri'
  ELSE pc_name
END
WHERE state = 'Assam'
  AND pc_name IN ('Gauhati','Nowgong','Kaliabor','Tezpur','Autonomous District','Mangaldoi')
LIMIT 10000;

-- FIX: STANDARDIZE "JANJGIR-CHAMPA" TO "JANJGIR–CHAMPA" (EN DASH) IN 2019
UPDATE political_analysis.cons_clean_2019
SET pc_name = 'Janjgir–Champa'
WHERE state = 'Chhattisgarh'
  AND pc_name = 'Janjgir-Champa'
LIMIT 1000;

-- ALIAS FIX: STANDARDIZE "ANANTNAG" TO "ANANTNAG–RAJOURI" (ONLY IF YOU WANT ONE STANDARD LABEL)
UPDATE political_analysis.cons_clean_2014
SET pc_name = 'Anantnag–Rajouri'
WHERE state = 'Jammu & Kashmir'
  AND pc_name = 'Anantnag'
LIMIT 1000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = 'Anantnag–Rajouri'
WHERE state = 'Jammu & Kashmir'
  AND pc_name = 'Anantnag'
LIMIT 1000;

-- FIX: STANDARDIZE KODARMA -> KODERMA AND PALAMAU -> PALAMU (BOTH YEARS)
UPDATE political_analysis.cons_clean_2014
SET pc_name = CASE
  WHEN pc_name = 'Kodarma' THEN 'Koderma'
  WHEN pc_name = 'Palamau' THEN 'Palamu'
  ELSE pc_name
END
WHERE state = 'Jharkhand'
  AND pc_name IN ('Kodarma','Palamau')
LIMIT 10000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = CASE
  WHEN pc_name = 'Kodarma' THEN 'Koderma'
  WHEN pc_name = 'Palamau' THEN 'Palamu'
  ELSE pc_name
END
WHERE state = 'Jharkhand'
  AND pc_name IN ('Kodarma','Palamau')
LIMIT 10000;

-- FIX: STANDARDIZE "CHIKKBALLAPUR" TO "CHIKBALLAPUR" (BOTH YEARS)
UPDATE political_analysis.cons_clean_2014
SET pc_name = 'Chikballapur'
WHERE state = 'Karnataka'
  AND pc_name = 'Chikkballapur'
LIMIT 1000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = 'Chikballapur'
WHERE state = 'Karnataka'
  AND pc_name = 'Chikkballapur'
LIMIT 1000;

-- FIX: STANDARDIZE VADAKARA -> VATAKARA AND MAVELIKKARA -> MAVELIKARA (BOTH YEARS)
UPDATE political_analysis.cons_clean_2014
SET pc_name = CASE
  WHEN pc_name = 'Vadakara' THEN 'Vatakara'
  WHEN pc_name = 'Mavelikkara' THEN 'Mavelikara'
  ELSE pc_name
END
WHERE state = 'Kerala'
  AND pc_name IN ('Vadakara','Mavelikkara')
LIMIT 10000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = CASE
  WHEN pc_name = 'Vadakara' THEN 'Vatakara'
  WHEN pc_name = 'Mavelikkara' THEN 'Mavelikara'
  ELSE pc_name
END
WHERE state = 'Kerala'
  AND pc_name IN ('Vadakara','Mavelikkara')
LIMIT 10000;

-- FIX: STANDARDIZE "MANDSOUR" TO "MANDSAUR" (BOTH YEARS)
UPDATE political_analysis.cons_clean_2014
SET pc_name = 'Mandsaur'
WHERE state = 'Madhya Pradesh'
  AND pc_name = 'Mandsour'
LIMIT 1000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = 'Mandsaur'
WHERE state = 'Madhya Pradesh'
  AND pc_name = 'Mandsour'
LIMIT 1000;

-- FIX: STANDARDIZE MAHARASHTRA VARIANTS TO MATCH REFERENCE (BOTH YEARS)
UPDATE political_analysis.cons_clean_2014
SET pc_name = CASE
  WHEN pc_name = 'Ahmadnagar' THEN 'Ahmednagar'
  WHEN pc_name = 'Bhandara - Gondiya' THEN 'Bhandara–Gondiya'
  WHEN pc_name = 'Ratnagiri - Sindhudurg' THEN 'Ratnagiri–Sindhudurg'
  WHEN pc_name = 'Mumbai   South' THEN 'Mumbai South'
  ELSE pc_name
END
WHERE state = 'Maharashtra'
  AND pc_name IN ('Ahmadnagar','Bhandara - Gondiya','Ratnagiri - Sindhudurg','Mumbai   South')
LIMIT 10000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = CASE
  WHEN pc_name = 'Ahmadnagar' THEN 'Ahmednagar'
  WHEN pc_name = 'Bhandara - Gondiya' THEN 'Bhandara–Gondiya'
  WHEN pc_name = 'Ratnagiri - Sindhudurg' THEN 'Ratnagiri–Sindhudurg'
  WHEN pc_name = 'Mumbai   South' THEN 'Mumbai South'
  ELSE pc_name
END
WHERE state = 'Maharashtra'
  AND pc_name IN ('Ahmadnagar','Bhandara - Gondiya','Ratnagiri - Sindhudurg','Mumbai   South')
LIMIT 10000;

-- FIX: STANDARDIZE VILUPPURAM -> VILLUPURAM AND MAYILADUTHURAI -> MAYILADUTURAI (BOTH YEARS)
UPDATE political_analysis.cons_clean_2014
SET pc_name = CASE
  WHEN pc_name = 'Viluppuram' THEN 'Villupuram'
  WHEN pc_name = 'Mayiladuthurai' THEN 'Mayiladuturai'
  ELSE pc_name
END
WHERE state = 'Tamil Nadu'
  AND pc_name IN ('Viluppuram','Mayiladuthurai')
LIMIT 10000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = CASE
  WHEN pc_name = 'Viluppuram' THEN 'Villupuram'
  WHEN pc_name = 'Mayiladuthurai' THEN 'Mayiladuturai'
  ELSE pc_name
END
WHERE state = 'Tamil Nadu'
  AND pc_name IN ('Viluppuram','Mayiladuthurai')
LIMIT 10000;

-- FIX: STANDARDIZE "SECUNDRABAD" -> "SECUNDERABAD" (2014 + 2019)
UPDATE political_analysis.cons_clean_2014
SET pc_name = 'Secunderabad'
WHERE pc_name = 'Secundrabad'
LIMIT 10000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = 'Secunderabad'
WHERE pc_name = 'Secundrabad'
LIMIT 10000;

-- FIX: STANDARDIZE "HARDWAR" TO "HARIDWAR" (BOTH YEARS)
UPDATE political_analysis.cons_clean_2014
SET pc_name = 'Haridwar'
WHERE state = 'Uttarakhand'
  AND pc_name = 'Hardwar'
LIMIT 1000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = 'Haridwar'
WHERE state = 'Uttarakhand'
  AND pc_name = 'Hardwar'
LIMIT 1000;

-- FIX: STANDARDIZE WEST BENGAL PC NAMES (ROBUST TO EXTRA SPACES)
-- 1) "BURDWAN - DURGAPUR" (2014) + "BARDHAMAN DURGAPUR" (2019)  -> "BARDHAMAN–DURGAPUR"
-- 2) "JOYNAGAR" -> "JAYNAGAR"

UPDATE political_analysis.cons_clean_2014
SET pc_name = CASE
  WHEN TRIM(REPLACE(REPLACE(pc_name,'  ',' '),'  ',' ')) = 'Burdwan - Durgapur' THEN 'Bardhaman–Durgapur'
  WHEN TRIM(REPLACE(REPLACE(pc_name,'  ',' '),'  ',' ')) = 'Joynagar' THEN 'Jaynagar'
  ELSE pc_name
END
WHERE state = 'West Bengal'
  AND TRIM(REPLACE(REPLACE(pc_name,'  ',' '),'  ',' ')) IN ('Burdwan - Durgapur','Joynagar')
LIMIT 10000;

UPDATE political_analysis.cons_clean_2019
SET pc_name = CASE
  WHEN TRIM(REPLACE(REPLACE(pc_name,'  ',' '),'  ',' ')) = 'Bardhaman Durgapur' THEN 'Bardhaman–Durgapur'
  WHEN TRIM(REPLACE(REPLACE(pc_name,'  ',' '),'  ',' ')) = 'Joynagar' THEN 'Jaynagar'
  ELSE pc_name
END
WHERE state = 'West Bengal'
  AND TRIM(REPLACE(REPLACE(pc_name,'  ',' '),'  ',' ')) IN ('Bardhaman Durgapur','Joynagar')
LIMIT 10000;

/* CHECK: Are there leading/trailing spaces in STATE names (2014)? */
SELECT state, COUNT(*) AS cnt
FROM cons_clean_2014
WHERE state <> TRIM(state)
GROUP BY state
ORDER BY cnt DESC;

/* CHECK: Are there leading/trailing spaces in PC names (2014)? */
SELECT pc_name, COUNT(*) AS cnt
FROM cons_clean_2014
WHERE pc_name <> TRIM(pc_name)
GROUP BY pc_name
ORDER BY cnt DESC
LIMIT 30;

/* CHECK: Do we have spelling variants for Andhra Pradesh (2014)? */
SELECT state, COUNT(*) AS cnt
FROM cons_clean_2014
WHERE LOWER(state) LIKE '%andhra%'
GROUP BY state
ORDER BY cnt DESC;

/* CHECK: Do we have spelling variants for Telangana (2014)? */
SELECT state, COUNT(*) AS cnt
FROM cons_clean_2014
WHERE LOWER(state) LIKE '%telang%'
GROUP BY state
ORDER BY cnt DESC;

/* CHECK: Telangana PC list presence under Andhra Pradesh (should be >0 before update) */
SELECT pc_name, COUNT(*) AS cnt
FROM cons_clean_2014
WHERE state = 'Andhra Pradesh'
  AND pc_name IN (
    'Adilabad','Peddapalle','Karimnagar','Nizamabad','Zahirabad','Medak',
    'Malkajgiri','Secunderabad','Hyderabad','Chevella','Mahbubnagar',
    'Nagarkurnool','Nalgonda','Bhongir','Warangal','Mahabubabad','Khammam'
  )
GROUP BY pc_name
ORDER BY pc_name;

/* CHECK: Likely spelling mismatches for Secunderabad / Chevella (2014) */
SELECT DISTINCT pc_name
FROM cons_clean_2014
WHERE LOWER(pc_name) LIKE '%secund%'
   OR LOWER(pc_name) LIKE '%chev%'
ORDER BY pc_name;

SET SQL_SAFE_UPDATES = 0;

/* 2014: TRIM PC_NAME WHERE NEEDED */
UPDATE cons_clean_2014
SET pc_name = TRIM(pc_name)
WHERE pc_name <> TRIM(pc_name);

/* 2019: TRIM PC_NAME WHERE NEEDED */
UPDATE cons_clean_2019
SET pc_name = TRIM(pc_name)
WHERE pc_name <> TRIM(pc_name);

/* 2014: VALIDATE TRIM (SHOULD BE 0) */
SELECT COUNT(*) AS remaining_pc_trim_issues_2014
FROM cons_clean_2014
WHERE pc_name <> TRIM(pc_name);

/* 2019: VALIDATE TRIM (SHOULD BE 0) */
SELECT COUNT(*) AS remaining_pc_trim_issues_2019
FROM cons_clean_2019
WHERE pc_name <> TRIM(pc_name);

-- source : https://en.wikipedia.org/wiki/List_of_constituencies_of_the_Lok_Sabha#Telangana_(17)
/* SAFETY COUNT: TELANGANA PCS CURRENTLY UNDER ANDHRA PRADESH (2014) */
SELECT COUNT(*) AS rows_to_move_2014
FROM cons_clean_2014
WHERE state = 'Andhra Pradesh'
  AND pc_name IN (
    'Adilabad','Peddapalle','Karimnagar','Nizamabad','Zahirabad','Medak',
    'Malkajgiri','Secunderabad','Hyderabad','Chevella','Mahbubnagar',
    'Nagarkurnool','Nalgonda','Bhongir','Warangal','Mahabubabad','Khammam'
  );

/* UPDATE: REASSIGN TELANGANA PCS TO TELANGANA (2014) */
UPDATE cons_clean_2014
SET state = 'Telangana'
WHERE state = 'Andhra Pradesh'
  AND pc_name IN (
    'Adilabad','Peddapalle','Karimnagar','Nizamabad','Zahirabad','Medak',
    'Malkajgiri','Secunderabad','Hyderabad','Chevella','Mahbubnagar',
    'Nagarkurnool','Nalgonda','Bhongir','Warangal','Mahabubabad','Khammam'
  );

/* VALIDATION: MUST BE 0 AFTER UPDATE */
SELECT COUNT(*) AS still_wrong_2014
FROM cons_clean_2014
WHERE state = 'Andhra Pradesh'
  AND pc_name IN (
    'Adilabad','Peddapalle','Karimnagar','Nizamabad','Zahirabad','Medak',
    'Malkajgiri','Secunderabad','Hyderabad','Chevella','Mahbubnagar',
    'Nagarkurnool','Nalgonda','Bhongir','Warangal','Mahabubabad','Khammam'
  );

/* OPTIONAL: FIND CHEVELLA VARIANTS IF IT DIDN'T MOVE */
SELECT DISTINCT pc_name
FROM cons_clean_2014
WHERE state = 'Andhra Pradesh'
  AND LOWER(pc_name) LIKE '%chev%'
ORDER BY pc_name;


SET SQL_SAFE_UPDATES = 1;

/* CREATE UNIFIED TABLE USING UNION ALL (KEEPS ALL ROWS) */
CREATE TABLE fact_election_results AS
SELECT
  2014 AS election_year,
  state,
  pc_name,
  candidate,
  sex,
  age,
  category,
  party,
  party_symbol,
  general_votes,
  postal_votes,
  total_votes,
  total_electors
FROM cons_clean_2014

UNION ALL

SELECT
  2019 AS election_year,
  state,
  pc_name,
  candidate,
  sex,
  age,
  category,
  party,
  party_symbol,
  general_votes,
  postal_votes,
  total_votes,
  total_electors
FROM cons_clean_2019;


/* TOTAL ROWS SHOULD EQUAL 2014 ROWS + 2019 ROWS */
SELECT
  (SELECT COUNT(*) FROM cons_clean_2014) AS rows_2014,
  (SELECT COUNT(*) FROM cons_clean_2019) AS rows_2019,
  (SELECT COUNT(*) FROM fact_election_results) AS rows_combined;
  
/* TELANGANA SANITY CHECK (2014 SHOULD NOW HAVE TELANGANA AFTER FIX) */
SELECT election_year, state, COUNT(*) AS cnt
FROM fact_election_results
WHERE state IN ('Telangana', 'Andhra Pradesh')
GROUP BY election_year, state
ORDER BY election_year, state;

-- SESSION: DISABLE SAFE UPDATES (NO KEYS YET, BULK UPDATES AHEAD)

SET SQL_SAFE_UPDATES = 0;

-- TRIM state_name + abbreviation (prevents invisible mismatch bugs) 
UPDATE clean_state_codes
SET state_name = TRIM(state_name),
    abbreviation = TRIM(abbreviation)
WHERE state_name <> TRIM(state_name)
   OR abbreviation <> TRIM(abbreviation);
   
-- CONVERT TYPES (TEXT -> VARCHAR) TO SUPPORT INDEXES/KEYS
ALTER TABLE clean_state_codes
MODIFY state_name VARCHAR(100) NOT NULL,
MODIFY abbreviation VARCHAR(10) NOT NULL;

-- ADD state_id SURROGATE KEY 
ALTER TABLE clean_state_codes
ADD COLUMN state_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

-- ENFORCE UNIQUENESS (PREVENT DUPLICATE STATES/CODES)
ALTER TABLE clean_state_codes
ADD CONSTRAINT uq_state_name UNIQUE (state_name),
ADD CONSTRAINT uq_abbreviation UNIQUE (abbreviation);

-- ADD PRIMARY KEY COLUMN
ALTER TABLE fact_election_results
ADD COLUMN election_result_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY;

-- ADD state_id COLUMN (FOR FK)
ALTER TABLE fact_election_results
ADD COLUMN state_id INT NULL;

-- TRIM state values in fact (avoids join mismatches) 
UPDATE fact_election_results
SET state = TRIM(state)
WHERE state <> TRIM(state);

-- POPULATE state_id USING clean_state_codes 
UPDATE fact_election_results f
JOIN clean_state_codes s
  ON f.state = s.state_name
SET f.state_id = s.state_id;


-- CHECK FOR UNMAPPED STATES (FIX THESE BEFORE FK)
SELECT state, COUNT(*) AS unmapped_rows
FROM fact_election_results
WHERE state_id IS NULL
GROUP BY state
ORDER BY unmapped_rows DESC;


-- ADD INDEX ON FK COLUMN (GOOD PRACTICE + SOMETIMES REQUIRED)
CREATE INDEX idx_fact_state_id ON fact_election_results(state_id);

-- ADD FOREIGN KEY CONSTRAINT 
ALTER TABLE fact_election_results
ADD CONSTRAINT fk_fact_state
FOREIGN KEY (state_id) REFERENCES clean_state_codes(state_id);

-- CONFIRM PK EXISTS AND ROW COUNTS LOOK OK
SELECT COUNT(*) AS total_fact_rows
FROM fact_election_results;

-- CHECK YEAR-WISE DISTRIBUTION STILL INTACT
SELECT election_year, COUNT(*) AS cnt
FROM fact_election_results
GROUP BY election_year
ORDER BY election_year;

SET SQL_SAFE_UPDATES = 1;

-- SHOW ANY STATES THAT FAILED TO MAP (SHOULD RETURN 0 ROWS)
SELECT state, COUNT(*) AS unmapped_rows
FROM fact_election_results
WHERE state_id IS NULL
GROUP BY state
ORDER BY unmapped_rows DESC;

-- CHECK : Telangana vs Andhra Pradesh counts by year (proves bifurcation fix survived merge)
SELECT election_year, state, COUNT(*) AS cnt
FROM fact_election_results
WHERE state IN ('Telangana','Andhra Pradesh')
GROUP BY election_year, state
ORDER BY election_year, state;

-- CHECK : total_electors must be consistent within a constituency (otherwise turnout calc breaks)
SELECT election_year, state, pc_name,
       COUNT(DISTINCT total_electors) AS distinct_electors_values
FROM fact_election_results
GROUP BY election_year, state, pc_name
HAVING COUNT(DISTINCT total_electors) > 1
ORDER BY distinct_electors_values DESC
LIMIT 50;
-------------------------------- view----------------------------------------
/* VIEW: Constituency turnout using MAX(total_electors) to avoid double counting */
CREATE OR REPLACE VIEW vw_constituency_turnout AS
WITH pc_level AS (
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    MAX(total_electors) AS total_electors,
    SUM(total_votes) AS votes_cast
  FROM fact_election_results
  GROUP BY election_year, state_id, state, pc_name
)
SELECT
  election_year,
  state_id,
  state,
  pc_name,
  total_electors,
  votes_cast,
  ROUND(votes_cast * 100.0 / NULLIF(total_electors, 0), 2) AS turnout_pct
FROM pc_level;


/* VIEW: Winner per constituency (rank candidates by votes) */
CREATE OR REPLACE VIEW vw_winner_by_constituency AS
WITH ranked AS (
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    candidate,
    party,
    party_symbol,
    total_votes,
    ROW_NUMBER() OVER (
      PARTITION BY election_year, state_id, pc_name
      ORDER BY total_votes DESC
    ) AS rn
  FROM fact_election_results
)
SELECT
  election_year,
  state_id,
  state,
  pc_name,
  candidate AS winner_candidate,
  party AS winner_party,
  party_symbol AS winner_symbol,
  total_votes AS winner_votes
FROM ranked
WHERE rn = 1;


/* VIEW: Top 2 candidates per constituency */
CREATE OR REPLACE VIEW vw_top2_by_constituency AS
SELECT *
FROM (
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    candidate,
    party,
    total_votes,
    ROW_NUMBER() OVER (
      PARTITION BY election_year, state_id, pc_name
      ORDER BY total_votes DESC
    ) AS rn
  FROM fact_election_results
) x
WHERE rn <= 2;

/* VIEW: Winning margin per constituency (votes + margin % of votes_cast) */
CREATE OR REPLACE VIEW vw_margin_by_constituency AS
WITH top2 AS (
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    MAX(CASE WHEN rn = 1 THEN total_votes END) AS winner_votes,
    MAX(CASE WHEN rn = 2 THEN total_votes END) AS runnerup_votes
  FROM vw_top2_by_constituency
  GROUP BY election_year, state_id, state, pc_name
),
turnout AS (
  SELECT
    election_year,
    state_id,
    pc_name,
    votes_cast
  FROM vw_constituency_turnout
)
SELECT
  t.election_year,
  t.state_id,
  t.state,
  t.pc_name,
  t.winner_votes,
  t.runnerup_votes,
  (t.winner_votes - t.runnerup_votes) AS margin_votes,
  ROUND((t.winner_votes - t.runnerup_votes) * 100.0 / NULLIF(tr.votes_cast, 0), 2) AS margin_pct_of_votes_cast
FROM top2 t
JOIN turnout tr
  ON t.election_year = tr.election_year
 AND t.state_id = tr.state_id
 AND t.pc_name = tr.pc_name;


/* VALIDATION: Winners view should have 1 row per constituency-year */
SELECT election_year, COUNT(*) AS winner_rows
FROM vw_winner_by_constituency
GROUP BY election_year
ORDER BY election_year;

/* VALIDATION: Margin view should not have NULL runnerup_votes (should be 0 rows) */
SELECT *
FROM vw_margin_by_constituency
WHERE runnerup_votes IS NULL
LIMIT 20;

-- Primary Questions
/* 1. List top 5 / bottom 5 constituencies of 2014 and 2019 in terms of voter turnout ratio? */

/* Q1A: TOP 5 CONSTITUENCIES BY VOTER TURNOUT (2014) */
SELECT
  election_year,
  state,
  pc_name,
  total_electors,
  votes_cast,
  turnout_pct
FROM vw_constituency_turnout
WHERE election_year = 2014
ORDER BY turnout_pct DESC
LIMIT 5;

/* Q1B: BOTTOM 5 CONSTITUENCIES BY VOTER TURNOUT (2014) */
SELECT
  election_year,
  state,
  pc_name,
  total_electors,
  votes_cast,
  turnout_pct
FROM vw_constituency_turnout
WHERE election_year = 2014
ORDER BY turnout_pct ASC
LIMIT 5;

/* Q1C: TOP 5 CONSTITUENCIES BY VOTER TURNOUT (2019) */
SELECT
  election_year,
  state,
  pc_name,
  total_electors,
  votes_cast,
  turnout_pct
FROM vw_constituency_turnout
WHERE election_year = 2019
ORDER BY turnout_pct DESC
LIMIT 5;

/* Q1D: BOTTOM 5 CONSTITUENCIES BY VOTER TURNOUT (2019) */
SELECT
  election_year,
  state,
  pc_name,
  total_electors,
  votes_cast,
  turnout_pct
FROM vw_constituency_turnout
WHERE election_year = 2019
ORDER BY turnout_pct ASC
LIMIT 5;


/* 2.List top 5 / bottom 5 states of 2014 and 2019 in terms of voter turnout ratio? */

/* VIEW: STATE-WISE TURNOUT (YEAR + STATE) BUILT FROM CONSTITUENCY-LEVEL DATA */
CREATE OR REPLACE VIEW vw_state_turnout AS
WITH state_level AS (
  SELECT
    election_year,
    state_id,
    state,
    SUM(total_electors) AS total_electors_state,
    SUM(votes_cast) AS votes_cast_state
  FROM vw_constituency_turnout
  GROUP BY election_year, state_id, state
)
SELECT
  election_year,
  state_id,
  state,
  total_electors_state,
  votes_cast_state,
  ROUND(votes_cast_state * 100.0 / NULLIF(total_electors_state, 0), 2) AS turnout_pct
FROM state_level;

/* Q2A: TOP 5 STATES BY VOTER TURNOUT (2014) */
SELECT
  election_year,
  state,
  total_electors_state,
  votes_cast_state,
  turnout_pct
FROM vw_state_turnout
WHERE election_year = 2014
ORDER BY turnout_pct DESC
LIMIT 5;

/* Q2B: BOTTOM 5 STATES BY VOTER TURNOUT (2014) */
SELECT
  election_year,
  state,
  total_electors_state,
  votes_cast_state,
  turnout_pct
FROM vw_state_turnout
WHERE election_year = 2014
ORDER BY turnout_pct ASC
LIMIT 5;

/* Q2C: TOP 5 STATES BY VOTER TURNOUT (2019) */
SELECT
  election_year,
  state,
  total_electors_state,
  votes_cast_state,
  turnout_pct
FROM vw_state_turnout
WHERE election_year = 2019
ORDER BY turnout_pct DESC
LIMIT 5;

/* Q2D: BOTTOM 5 STATES BY VOTER TURNOUT (2019) */
SELECT
  election_year,
  state,
  total_electors_state,
  votes_cast_state,
  turnout_pct
FROM vw_state_turnout
WHERE election_year = 2019
ORDER BY turnout_pct ASC
LIMIT 5;

/*3. Which constituencies have elected the same party for two consecutive elections,
 rank them by % of votes to that winning party in 2019 */

WITH winners AS (
  /* WINNER PARTY PER CONSTITUENCY FOR BOTH YEARS */
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    winner_party,
    winner_votes
  FROM vw_winner_by_constituency
  WHERE election_year IN (2014, 2019)
),
same_party AS (
  /* KEEP ONLY CONSTITUENCIES WHERE WINNER PARTY MATCHES IN BOTH YEARS */
  SELECT
    w14.state_id,
    w14.state,
    w14.pc_name,
    w14.winner_party AS winner_party_2014,
    w19.winner_party AS winner_party_2019,
    w19.winner_votes AS winner_votes_2019
  FROM winners w14
  JOIN winners w19
    ON w14.state_id = w19.state_id
   AND w14.pc_name = w19.pc_name
  WHERE w14.election_year = 2014
    AND w19.election_year = 2019
    AND w14.winner_party = w19.winner_party
),
votes_cast_2019 AS (
  /* TOTAL VOTES CAST PER CONSTITUENCY IN 2019 */
  SELECT
    election_year,
    state_id,
    pc_name,
    votes_cast
  FROM vw_constituency_turnout
  WHERE election_year = 2019
)
SELECT
  sp.state,
  sp.pc_name,
  sp.winner_party_2019 AS party,
  ROUND(sp.winner_votes_2019 * 100.0 / NULLIF(vc.votes_cast, 0), 2) AS winner_vote_share_pct_2019
FROM same_party sp
JOIN votes_cast_2019 vc
  ON sp.state_id = vc.state_id
 AND sp.pc_name = vc.pc_name
ORDER BY winner_vote_share_pct_2019 DESC
Limit 1;

/*4.	Which constituencies have voted for different parties in two elections 
(list top 10 based on difference (2019-2014) in winner vote percentage in two elections) */

WITH winners AS (
  /* WINNER DETAILS PER CONSTITUENCY PER YEAR */
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    winner_candidate,
    winner_party,
    winner_votes
  FROM vw_winner_by_constituency
  WHERE election_year IN (2014, 2019)
),
votes_cast AS (
  /* TOTAL VOTES CAST PER CONSTITUENCY PER YEAR */
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    votes_cast
  FROM vw_constituency_turnout
  WHERE election_year IN (2014, 2019)
),
winner_share AS (
  /* WINNER VOTE SHARE % PER CONSTITUENCY PER YEAR */
  SELECT
    w.election_year,
    w.state_id,
    w.state,
    w.pc_name,
    w.winner_candidate,
    w.winner_party,
    ROUND(w.winner_votes * 100.0 / NULLIF(v.votes_cast, 0), 2) AS winner_vote_share_pct
  FROM winners w
  JOIN votes_cast v
    ON w.election_year = v.election_year
   AND w.state_id = v.state_id
   AND w.pc_name = v.pc_name
),
paired AS (
  /* PAIR 2014 VS 2019 FOR SAME CONSTITUENCY */
  SELECT
    s14.state_id,
    s14.state,
    s14.pc_name,
    s14.winner_party AS winner_party_2014,
    s14.winner_vote_share_pct AS winner_share_2014,
    s19.winner_party AS winner_party_2019,
    s19.winner_vote_share_pct AS winner_share_2019,
    ROUND(s19.winner_vote_share_pct - s14.winner_vote_share_pct, 2) AS share_diff_2019_minus_2014
  FROM winner_share s14
  JOIN winner_share s19
    ON s14.state_id = s19.state_id
   AND s14.pc_name = s19.pc_name
  WHERE s14.election_year = 2014
    AND s19.election_year = 2019
    AND s14.winner_party <> s19.winner_party
)
SELECT
  state,
  pc_name,
  winner_party_2014,
  winner_share_2014,
  winner_party_2019,
  winner_share_2019,
  share_diff_2019_minus_2014
FROM paired
ORDER BY share_diff_2019_minus_2014 DESC
LIMIT 10;

/* 5. Top 5 candidates based on margin difference with runners in 2014 and 2019. */

/* Q5A: TOP 5 WINNERS BY MARGIN (WINNER - RUNNER-UP) IN 2014 */
WITH top2 AS (
  SELECT
    election_year,
    state,
    pc_name,
    candidate,
    party,
    total_votes,
    rn
  FROM vw_top2_by_constituency
  WHERE election_year = 2014
),
margins AS (
  SELECT
    t1.state,
    t1.pc_name,
    t1.candidate AS winner_candidate,
    t1.party AS winner_party,
    t1.total_votes AS winner_votes,
    t2.candidate AS runnerup_candidate,
    t2.party AS runnerup_party,
    t2.total_votes AS runnerup_votes,
    (t1.total_votes - t2.total_votes) AS margin_votes
  FROM top2 t1
  JOIN top2 t2
    ON t1.election_year = t2.election_year
   AND t1.state = t2.state
   AND t1.pc_name = t2.pc_name
  WHERE t1.rn = 1
    AND t2.rn = 2
)
SELECT *
FROM margins
ORDER BY margin_votes DESC
LIMIT 5;


/* Q5B: TOP 5 WINNERS BY MARGIN (WINNER - RUNNER-UP) IN 2019 */
WITH top2 AS (
  SELECT
    election_year,
    state,
    pc_name,
    candidate,
    party,
    total_votes,
    rn
  FROM vw_top2_by_constituency
  WHERE election_year = 2019
),
margins AS (
  SELECT
    t1.state,
    t1.pc_name,
    t1.candidate AS winner_candidate,
    t1.party AS winner_party,
    t1.total_votes AS winner_votes,
    t2.candidate AS runnerup_candidate,
    t2.party AS runnerup_party,
    t2.total_votes AS runnerup_votes,
    (t1.total_votes - t2.total_votes) AS margin_votes
  FROM top2 t1
  JOIN top2 t2
    ON t1.election_year = t2.election_year
   AND t1.state = t2.state
   AND t1.pc_name = t2.pc_name
  WHERE t1.rn = 1
    AND t2.rn = 2
)
SELECT *
FROM margins
ORDER BY margin_votes DESC
LIMIT 5;


/* 6.% Split of votes of parties between 2014 vs 2019 at national level */

/* Q6: NATIONAL-LEVEL PARTY VOTE SHARE (%) IN 2014 VS 2019 */
WITH party_votes AS (
  /* TOTAL VOTES PER PARTY PER YEAR (NATIONAL) */
  SELECT
    election_year,
    party,
    SUM(total_votes) AS party_votes
  FROM fact_election_results
  WHERE election_year IN (2014, 2019)
  GROUP BY election_year, party
),
total_votes_year AS (
  /* TOTAL VOTES CAST PER YEAR (NATIONAL) */
  SELECT
    election_year,
    SUM(total_votes) AS total_votes
  FROM fact_election_results
  WHERE election_year IN (2014, 2019)
  GROUP BY election_year
),
party_share AS (
  /* PARTY VOTE SHARE % (2 DECIMALS) */
  SELECT
    p.election_year,
    p.party,
    ROUND(p.party_votes * 100.0 / NULLIF(t.total_votes, 0), 2) AS vote_share_pct
  FROM party_votes p
  JOIN total_votes_year t
    ON p.election_year = t.election_year
),
pivoted AS (
  /* ONE ROW PER PARTY WITH 2014 & 2019 SHARES */
  SELECT
    party,
    MAX(CASE WHEN election_year = 2014 THEN vote_share_pct END) AS share_2014,
    MAX(CASE WHEN election_year = 2019 THEN vote_share_pct END) AS share_2019
  FROM party_share
  GROUP BY party
)
SELECT
  party,
  share_2014,
  share_2019,
  ROUND(share_2019 - share_2014, 2) AS change_2019_minus_2014
FROM pivoted
ORDER BY share_2019 DESC;


/*7. % Split of votes of parties between 2014 vs 2019 at state level. */

with party_votes as (
  select
    election_year,
    state_id,
    state,
    party,
    sum(total_votes) as party_votes
  from fact_election_results
  where election_year in (2014, 2019)
  group by election_year, state_id, state, party
),
state_votes as (
  select
    election_year,
    state_id,
    state,
    sum(total_votes) as state_total_votes
  from fact_election_results
  where election_year in (2014, 2019)
  group by election_year, state_id, state
),
shares as (
  select
    p.election_year,
    p.state_id,
    p.state,
    p.party,
    round(p.party_votes * 100.0 / nullif(s.state_total_votes, 0), 2) as vote_share_pct
  from party_votes p
  join state_votes s
    on p.election_year = s.election_year
   and p.state_id = s.state_id
),
pivoted as (
  select
    state_id,
    state,
    party,
    max(case when election_year = 2014 then vote_share_pct end) as share_2014,
    max(case when election_year = 2019 then vote_share_pct end) as share_2019
  from shares
  group by state_id, state, party
),
ranked as (
  select
    *,
    row_number() over (partition by state_id order by share_2019 desc) as rn
  from pivoted
),
top5 as (
  select
    state_id,
    state,
    party,
    share_2014,
    share_2019
  from ranked
  where rn <= 5
),
others as (
  select
    state_id,
    state,
    'OTHERS' as party,
    round(100 - sum(coalesce(share_2014, 0)), 2) as share_2014,
    round(100 - sum(coalesce(share_2019, 0)), 2) as share_2019
  from top5
  group by state_id, state
)
select
  state,
  party,
  coalesce(share_2014, 0) as share_2014,
  coalesce(share_2019, 0) as share_2019,
  case
    when share_2014 is not null and share_2019 is not null
      then cast(round(share_2019 - share_2014, 2) as char)
    when share_2014 is null and share_2019 is not null
      then concat('New in 2019 (+', round(share_2019, 2), ')')
    when share_2014 is not null and share_2019 is null
      then concat('Absent in 2019 (-', round(share_2014, 2), ')')
    else '0'
  end as change_2019_minus_2014
from (
  select * from top5
  union all
  select * from others
) x
order by state, share_2019 desc;

/* 8. List top 5 constituencies for two major national parties where they have gained vote share in 2019 as compared to 2014. */

WITH party_pc_votes AS (
  /* TOTAL VOTES PER PARTY PER CONSTITUENCY PER YEAR */
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    party,
    SUM(total_votes) AS party_votes
  FROM fact_election_results
  WHERE election_year IN (2014, 2019)
    AND party IN ('BJP', 'INC')
  GROUP BY election_year, state_id, state, pc_name, party
),
pc_total_votes AS (
  /* TOTAL VOTES CAST PER CONSTITUENCY PER YEAR (ALL PARTIES) */
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    SUM(total_votes) AS votes_cast
  FROM fact_election_results
  WHERE election_year IN (2014, 2019)
  GROUP BY election_year, state_id, state, pc_name
),
shares AS (
  /* PARTY VOTE SHARE % IN EACH CONSTITUENCY (2 DECIMALS) */
  SELECT
    p.election_year,
    p.state_id,
    p.state,
    p.pc_name,
    p.party,
    ROUND(p.party_votes * 100.0 / NULLIF(t.votes_cast, 0), 2) AS vote_share_pct
  FROM party_pc_votes p
  JOIN pc_total_votes t
    ON p.election_year = t.election_year
   AND p.state_id = t.state_id
   AND p.pc_name = t.pc_name
),
pivoted AS (
  /* PUT 2014 AND 2019 SHARES ON ONE ROW */
  SELECT
    state_id,
    state,
    pc_name,
    party,
    MAX(CASE WHEN election_year = 2014 THEN vote_share_pct END) AS share_2014,
    MAX(CASE WHEN election_year = 2019 THEN vote_share_pct END) AS share_2019
  FROM shares
  GROUP BY state_id, state, pc_name, party
),
gains AS (
  /* COMPUTE GAIN AND KEEP ONLY POSITIVE GAINS */
  SELECT
    state,
    pc_name,
    party,
    share_2014,
    share_2019,
    ROUND(share_2019 - share_2014, 2) AS gain_pct
  FROM pivoted
  WHERE share_2014 IS NOT NULL
    AND share_2019 IS NOT NULL
    AND (share_2019 - share_2014) > 0
),
ranked AS (
  /* RANK CONSTITUENCIES PER PARTY BY GAIN */
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY party ORDER BY gain_pct DESC) AS rn
  FROM gains
)
SELECT
  party,
  state,
  pc_name,
  share_2014,
  share_2019,
  gain_pct
FROM ranked
WHERE rn <= 5
ORDER BY party, gain_pct DESC;


/* 9.List top 5 constituencies for two major national parties where they have lost vote share in 2019 as compared to 2014. */

WITH party_pc_votes AS (
  /* TOTAL VOTES PER PARTY PER CONSTITUENCY PER YEAR */
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    party,
    SUM(total_votes) AS party_votes
  FROM fact_election_results
  WHERE election_year IN (2014, 2019)
    AND party IN ('BJP', 'INC')
  GROUP BY election_year, state_id, state, pc_name, party
),
pc_total_votes AS (
  /* TOTAL VOTES CAST PER CONSTITUENCY PER YEAR (ALL PARTIES) */
  SELECT
    election_year,
    state_id,
    state,
    pc_name,
    SUM(total_votes) AS votes_cast
  FROM fact_election_results
  WHERE election_year IN (2014, 2019)
  GROUP BY election_year, state_id, state, pc_name
),
shares AS (
  /* PARTY VOTE SHARE % IN EACH CONSTITUENCY (2 DECIMALS) */
  SELECT
    p.election_year,
    p.state_id,
    p.state,
    p.pc_name,
    p.party,
    ROUND(p.party_votes * 100.0 / NULLIF(t.votes_cast, 0), 2) AS vote_share_pct
  FROM party_pc_votes p
  JOIN pc_total_votes t
    ON p.election_year = t.election_year
   AND p.state_id = t.state_id
   AND p.pc_name = t.pc_name
),
pivoted AS (
  /* PUT 2014 AND 2019 SHARES ON ONE ROW */
  SELECT
    state_id,
    state,
    pc_name,
    party,
    MAX(CASE WHEN election_year = 2014 THEN vote_share_pct END) AS share_2014,
    MAX(CASE WHEN election_year = 2019 THEN vote_share_pct END) AS share_2019
  FROM shares
  GROUP BY state_id, state, pc_name, party
),
losses AS (
  /* COMPUTE LOSS AND KEEP ONLY NEGATIVE CHANGES */
  SELECT
    state,
    pc_name,
    party,
    share_2014,
    share_2019,
    ROUND(share_2019 - share_2014, 2) AS change_pct
  FROM pivoted
  WHERE share_2014 IS NOT NULL
    AND share_2019 IS NOT NULL
    AND (share_2019 - share_2014) < 0
),
ranked AS (
  /* RANK BIGGEST LOSSES PER PARTY (MOST NEGATIVE FIRST) */
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY party ORDER BY change_pct ASC) AS rn
  FROM losses
)
SELECT
  party,
  state,
  pc_name,
  share_2014,
  share_2019,
  change_pct AS loss_pct
FROM ranked
WHERE rn <= 5
ORDER BY party, loss_pct ASC;

/*10. Which constituency has voted the most for NOTA? */

/* Q10A: CONSTITUENCY WITH HIGHEST NOTA VOTE SHARE IN 2014 (MOST FOR NOTA) */
WITH nota_votes AS (
  /* NOTA VOTES PER CONSTITUENCY */
  SELECT
    election_year,
    state,
    pc_name,
    SUM(total_votes) AS nota_votes
  FROM fact_election_results
  WHERE election_year = 2014
    AND party = 'NOTA'
  GROUP BY election_year, state, pc_name
),
pc_total_votes AS (
  /* TOTAL VOTES CAST PER CONSTITUENCY (ALL PARTIES) */
  SELECT
    election_year,
    state,
    pc_name,
    SUM(total_votes) AS votes_cast
  FROM fact_election_results
  WHERE election_year = 2014
  GROUP BY election_year, state, pc_name
)
SELECT
  n.election_year,
  n.state,
  n.pc_name,
  n.nota_votes,
  t.votes_cast,
  ROUND(n.nota_votes * 100.0 / NULLIF(t.votes_cast, 0), 2) AS nota_vote_share_pct
FROM nota_votes n
JOIN pc_total_votes t
  ON n.election_year = t.election_year
 AND n.state = t.state
 AND n.pc_name = t.pc_name
ORDER BY nota_vote_share_pct DESC
LIMIT 1;

/* Q10B: CONSTITUENCY WITH HIGHEST NOTA VOTE SHARE IN 2019 (MOST FOR NOTA) */
WITH nota_votes AS (
  /* NOTA VOTES PER CONSTITUENCY */
  SELECT
    election_year,
    state,
    pc_name,
    SUM(total_votes) AS nota_votes
  FROM fact_election_results
  WHERE election_year = 2019
    AND party = 'NOTA'
  GROUP BY election_year, state, pc_name
),
pc_total_votes AS (
  /* TOTAL VOTES CAST PER CONSTITUENCY (ALL PARTIES) */
  SELECT
    election_year,
    state,
    pc_name,
    SUM(total_votes) AS votes_cast
  FROM fact_election_results
  WHERE election_year = 2019
  GROUP BY election_year, state, pc_name
)
SELECT
  n.election_year,
  n.state,
  n.pc_name,
  n.nota_votes,
  t.votes_cast,
  ROUND(n.nota_votes * 100.0 / NULLIF(t.votes_cast, 0), 2) AS nota_vote_share_pct
FROM nota_votes n
JOIN pc_total_votes t
  ON n.election_year = t.election_year
 AND n.state = t.state
 AND n.pc_name = t.pc_name
ORDER BY nota_vote_share_pct DESC
LIMIT 1;

/* 11.Which constituencies have elected candidates whose party has less than 10% vote share at state level in 2019? */

WITH state_party_votes AS (
  /* TOTAL VOTES PER PARTY PER STATE (2019) */
  SELECT
    state_id,
    state,
    party,
    SUM(total_votes) AS party_votes
  FROM fact_election_results
  WHERE election_year = 2019
  GROUP BY state_id, state, party
),
state_total_votes AS (
  /* TOTAL VOTES CAST PER STATE (2019) */
  SELECT
    state_id,
    state,
    SUM(total_votes) AS state_votes
  FROM fact_election_results
  WHERE election_year = 2019
  GROUP BY state_id, state
),
state_party_share AS (
  /* PARTY STATE-LEVEL VOTE SHARE % (2019) */
  SELECT
    spv.state_id,
    spv.state,
    spv.party,
    ROUND(spv.party_votes * 100.0 / NULLIF(stv.state_votes, 0), 2) AS party_state_share_pct
  FROM state_party_votes spv
  JOIN state_total_votes stv
    ON spv.state_id = stv.state_id
),
ranked_winners AS (
  /* WINNER PER CONSTITUENCY (2019) */
  SELECT
    state_id,
    state,
    pc_name,
    candidate,
    party,
    total_votes,
    ROW_NUMBER() OVER (
      PARTITION BY state_id, pc_name
      ORDER BY total_votes DESC
    ) AS rn
  FROM fact_election_results
  WHERE election_year = 2019
)
SELECT
  w.state,
  w.pc_name,
  w.candidate AS winner_candidate,
  w.party AS winner_party,
  sps.party_state_share_pct
FROM ranked_winners w
JOIN state_party_share sps
  ON w.state_id = sps.state_id
 AND w.party = sps.party
WHERE w.rn = 1
  AND sps.party_state_share_pct < 10
ORDER BY sps.party_state_share_pct ASC, w.state, w.pc_name;


select * from fact_election_results;

