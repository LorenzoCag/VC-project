-- Founders table to store founder information
-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS startup_platform;
USE startup_platform;

-- Startups table to store company information
CREATE TABLE startups (
    startup_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    description TEXT,
    industry VARCHAR(50),
    funding_stage VARCHAR(20),
    funding_goal DECIMAL(10,2),
    founding_date DATE,
    location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Founders table to store founder information
CREATE TABLE founders (
    founder_id INT PRIMARY KEY AUTO_INCREMENT,
    startup_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(100),
    university VARCHAR(100),
    graduation_year VARCHAR(4),
    email VARCHAR(100) UNIQUE NOT NULL,
    linkedin_url VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (startup_id) REFERENCES startups(startup_id)
);

-- Universities table to track associated schools
CREATE TABLE universities (
    university_id INT PRIMARY KEY AUTO_INCREMENT,
    university_name VARCHAR(100) UNIQUE NOT NULL,
    location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Startup-University relationship table
CREATE TABLE startup_university_relation (
    startup_id INT,
    university_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (startup_id, university_id),
    FOREIGN KEY (startup_id) REFERENCES startups(startup_id),
    FOREIGN KEY (university_id) REFERENCES universities(university_id)
);
