## Author
Waai Mee Kian

## loginApp
Risk-Based Authentication Simulator


## Overview
This project implements a **risk-based authentication system** that evaluates login attempts using contextual factors such as device, location, and login behaviour.
Instead of applying static authentication rules, the system dynamically adjusts security measures based on the calculated risk level, improving both **security and usability**.


## Live Demo
🔗 https://loginapp-6qe2.onrender.com/loginApp/admin/dashboard

_> Note: The application is hosted on Render free tier and may go to sleep after inactivity._


## Key Features
- 🔐 Risk-based authentication decision engine
- 📊 Real-time risk scoring and decision (Allow / OTP / Block)
- 🧪 Single and bulk simulation of login scenarios
- 📈 Dashboard analytics for insights and trends
- 🗂 Simulation history tracking for traceability
- ⚙️ Configurable risk factors and thresholds


## System Architecture
The system follows a layered architecture:
- **Frontend:** Thymeleaf + Bootstrap  
- **Backend:** Spring Boot  
- **Database:** PostgreSQL  

Core components include:
- Risk Evaluation Engine
- Decision Engine
- Simulation & Analytics Modules


## How It Works
1. User selects login conditions (device, location, etc.)
2. Each factor contributes to a risk score
3. Total score is calculated
4. Decision is determined:
   - Low risk → Allow
   - Medium risk → OTP
   - High risk → Block
  
## Technologies Used
- Java (Spring Boot)
- Thymeleaf
- Bootstrap
- PostgreSQL
- JavaScript
- Chart.js

## Limitations
- Uses a rule-based model (no machine learning)
- Limited contextual factors
- Simulated data (not real user data)
- Prototype system (not production-ready)

## Future Improvements
- Machine learning-based risk scoring
- Behavioural analysis
- Integration with real authentication systems
- Real-time monitoring and alerts
