CREATE TABLE IF NOT EXISTS risk_factors (
    id SERIAL PRIMARY KEY,
    factor_key VARCHAR(50) NOT NULL UNIQUE,
    factor_name VARCHAR(100) NOT NULL,
    score INT NOT NULL,
    description VARCHAR(255)
);

-- Insert data
INSERT INTO risk_factors (factor_key, factor_name, score, description) VALUES
('UNTRUSTED_DEVICE', 'Untrusted Device', 20, 'Device not recognized / new device'),
('DEVICE_FINGERPRINT_CHANGED', 'Device Fingerprint Changed', 25, 'Browser/OS signature changed'),
('NEW_IP', 'New IP Address', 10, 'Login from a new IP'),
('NEW_COUNTRY', 'New Country', 30, 'Login from a different country'),
('VPN', 'VPN / Proxy Detected', 20, 'VPN, Proxy, or anonymizer detected'),
('BLACKLISTED_IP', 'Blacklisted IP', 50, 'IP flagged as malicious'),
('UNUSUAL_TIME', 'Unusual Login Time', 15, 'Login outside normal hours'),
('IMPOSSIBLE_TRAVEL', 'Impossible Travel', 40, 'Geolocation too far from previous login'),
('FAILED_ATTEMPT_3', '3 Failed Login Attempts', 15, 'Possible brute-force attempt'),
('FAILED_ATTEMPT_4', '4 Failed Login Attempts', 25, 'Higher risk of brute-force'),
('FAILED_ATTEMPT_5', '5+ Failed Login Attempts', 35, 'High risk, account may be locked');

CREATE TABLE IF NOT EXISTS risk_decisions (
    id SERIAL PRIMARY KEY,
    min_score INT NOT NULL,
    max_score INT NOT NULL,
    decision_key VARCHAR(50) NOT NULL UNIQUE,
    decision_name VARCHAR(50) NOT NULL,
    color VARCHAR(20)
);

-- Insert data
INSERT INTO risk_decisions (min_score, max_score, decision_key, decision_name, color) VALUES
(0, 29, 'ALLOW', 'ALLOW', '#22c55e'),
(30, 59, 'REQUIRE_OTP', 'Require OTP', '#f59e0b'),
(60, 9999, 'BLOCK', 'BLOCK', '#ef4444');

-- Simulation Results (Single + Bulk)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema='public'
        AND table_name='simulation_results'
    ) THEN

        CREATE TABLE public.simulation_results (

            id BIGSERIAL PRIMARY KEY,

            -- SINGLE or BULK
            simulation_type VARCHAR(10) NOT NULL,

            -- NULL for single simulation
            run_id BIGINT,

	selected_factor_count INT,
	risk_level VARCHAR(20),
            factors VARCHAR(500),

            risk_score INT NOT NULL,

            decision VARCHAR(20) NOT NULL,

            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

        );

    END IF;
END
$$;