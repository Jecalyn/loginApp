CREATE TABLE IF NOT EXISTS risk_factors (
    id SERIAL PRIMARY KEY,
    factor_key VARCHAR(50) NOT NULL UNIQUE,
    factor_name VARCHAR(100) NOT NULL,
    score INT NOT NULL,
    description VARCHAR(255),
	recommended_action VARCHAR(255)
);

-- Insert data
INSERT INTO risk_factors (factor_key, factor_name, score, description, recommended_action) VALUES
('UNTRUSTED_DEVICE', 'Untrusted Device', 20, 'Device not recognized / new device',
 'Require step-up authentication and verify the device before allowing access'),

('DEVICE_FINGERPRINT_CHANGED', 'Device Fingerprint Changed', 25, 'Browser/OS signature changed',
 'Review device changes and require additional verification if needed'),

('NEW_IP', 'New IP Address', 10, 'Login from a new IP',
 'Monitor the new IP address and trigger extra verification if behaviour is unusual'),

('NEW_COUNTRY', 'New Country', 30, 'Login from a different country',
 'Review geo-location anomaly and require OTP or stronger authentication'),

('VPN', 'VPN / Proxy Detected', 20, 'VPN, Proxy, or anonymizer detected',
 'Monitor proxy usage and consider stricter rules for anonymized connections'),

('BLACKLISTED_IP', 'Blacklisted IP', 50, 'IP flagged as malicious',
 'Block the request immediately and investigate the malicious source'),

('UNUSUAL_TIME', 'Unusual Login Time', 15, 'Login outside normal hours',
 'Monitor off-hours access and require step-up authentication if necessary'),

('IMPOSSIBLE_TRAVEL', 'Impossible Travel', 40, 'Geolocation too far from previous login',
 'Flag the session for review and require strong re-authentication'),

('FAILED_ATTEMPT_3', '3 Failed Login Attempts', 15, 'Possible brute-force attempt',
 'Warn the user and monitor for additional failed attempts'),

('FAILED_ATTEMPT_4', '4 Failed Login Attempts', 25, 'Higher risk of brute-force',
 'Trigger OTP and closely monitor suspicious login behaviour'),

('FAILED_ATTEMPT_5', '5+ Failed Login Attempts', 35, 'High risk, account may be locked',
 'Temporarily block access or lock the account pending review');

CREATE TABLE IF NOT EXISTS risk_decisions (
    id SERIAL PRIMARY KEY,
    min_score INT NOT NULL,
    max_score INT NOT NULL,
    decision_key VARCHAR(50) NOT NULL UNIQUE,
    decision_name VARCHAR(50) NOT NULL,
	risk_level VARCHAR(20) NOT NULL,
    color VARCHAR(20)
);

-- Insert data
INSERT INTO risk_decisions (min_score, max_score, decision_key, decision_name, risk_level, color) VALUES
(0, 29, 'ALLOW', 'ALLOW','LOW','#22c55e'),
(30, 59, 'REQUIRE_OTP', 'Require OTP','MEDIUM', '#f59e0b'),
(60, 9999, 'BLOCK', 'BLOCK','HIGH', '#ef4444');

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