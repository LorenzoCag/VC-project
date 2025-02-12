-- Founders table to store founder information
CREATE TABLE founders (
    founder_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    linkedin_url VARCHAR(255),
    university_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Universities table to store university information
CREATE TABLE universities (
    university_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    country VARCHAR(50)
);

-- Industries table for different startup categories
CREATE TABLE industries (
    industry_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Funding stages lookup table
CREATE TABLE funding_stages (
    stage_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,  -- Pre-seed, Seed, Series A, etc.
    description TEXT
);

-- Main startups table
CREATE TABLE startups (
    startup_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    founding_date DATE,
    website_url VARCHAR(255),
    logo_url VARCHAR(255),
    current_stage_id INT,
    funding_sought DECIMAL(10,2),
    university_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (current_stage_id) REFERENCES funding_stages(stage_id) ON DELETE SET NULL,
    FOREIGN KEY (university_id) REFERENCES universities(university_id) ON DELETE SET NULL
);

-- Junction table for startups and industries (many-to-many)
CREATE TABLE startup_industries (
    startup_id INT,
    industry_id INT,
    PRIMARY KEY (startup_id, industry_id),
    FOREIGN KEY (startup_id) REFERENCES startups(startup_id) ON DELETE CASCADE,
    FOREIGN KEY (industry_id) REFERENCES industries(industry_id) ON DELETE CASCADE
);

-- Junction table for startups and founders (many-to-many)
CREATE TABLE startup_founders (
    startup_id INT,
    founder_id INT,
    role VARCHAR(50),  -- CEO, CTO, etc.
    PRIMARY KEY (startup_id, founder_id),
    FOREIGN KEY (startup_id) REFERENCES startups(startup_id) ON DELETE CASCADE,
    FOREIGN KEY (founder_id) REFERENCES founders(founder_id) ON DELETE CASCADE
);

-- Funding rounds table to track investment history
CREATE TABLE funding_rounds (
    round_id SERIAL PRIMARY KEY,
    startup_id INT,
    stage_id INT,
    amount DECIMAL(10,2),
    date DATE,
    lead_investor VARCHAR(100),
    notes TEXT,
    FOREIGN KEY (startup_id) REFERENCES startups(startup_id) ON DELETE CASCADE,
    FOREIGN KEY (stage_id) REFERENCES funding_stages(stage_id) ON DELETE SET NULL
);