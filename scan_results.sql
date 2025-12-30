-- scan_results.sql
-- Network Scan Results Database

CREATE TABLE network_scans (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ip_address TEXT NOT NULL,
    port INTEGER NOT NULL,
    status TEXT NOT NULL,
    scan_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Example queries

-- Show all hosts with SSH open
SELECT ip_address FROM network_scans
WHERE port = 22 AND status = 'OPEN';

-- Count open ports per host
SELECT ip_address, COUNT(*) AS open_ports
FROM network_scans
GROUP BY ip_address;
