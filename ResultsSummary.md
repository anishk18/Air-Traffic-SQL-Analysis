# Air Traffic SQL Analysis – Results Summary ✈️

This document highlights key findings from the 2018–2019 airline flight data analysis.  
The results provide **investment-relevant insights** into airline performance, cancellations, operating costs, and on-time performance.  

---

## 🔹 Question 1: Basic Flight Statistics
- **Total flights**: Millions of flights were recorded across 2018 and 2019, with a slight increase in 2019.  
- **Cancelled/late flights**: A significant portion were either cancelled or departed late, impacting customer satisfaction and revenue stability.  
- **Cancellations by reason**: Weather-related cancellations dominated, followed by airline/crew-related issues.  
- **Monthly trends (2019)**:  
  - Winter months (Jan, Feb, Dec) had the highest cancellation rates.  
  - Summer months showed more consistent operations.  
  - 👉 This confirms **seasonality in airline revenue**, with winter posing higher risks.  

---

## 🔹 Question 2: Airline Year-over-Year Performance
- Created summary tables for **flights and miles traveled per airline**.  
- **Airline A**: Growth in both flights and miles → stronger market expansion.  
- **Airline B**: Flat growth → steady but less attractive for high returns.  
- **Airline C**: Decline in both → weaker operational performance.  
- 👉 Recommendation: Fund managers should consider investing in **Airline A** due to sustained growth.  

---

## 🔹 Question 3: Most Popular Destination Airports
- Top 10 airports include **Atlanta (ATL)**, **Chicago O’Hare (ORD)**, and **Los Angeles (LAX)**.  
- These hubs dominate U.S. traffic and are critical for network efficiency.  
- Query optimization (subquery before join) significantly reduced runtime → showing the importance of efficient SQL for large datasets.  

---

## 🔹 Question 4: Operating Cost Proxies
- **Fleet size (unique tail numbers)**: Airlines vary significantly in fleet size.  
- **Fuel costs (total miles)**: Higher total miles indicate higher variable costs.  
- **Asset utilization (miles per aircraft)**:  
  - Airline with **smaller fleet but higher miles per aircraft** → strong utilization, but potential for higher maintenance costs.  
  - Airline with **larger fleet but lower miles per aircraft** → underutilization risk.  
- 👉 Financial implication: A balanced fleet with efficient utilization is ideal for cost control and scalability.  

---

## 🔹 Question 5: On-Time Performance
- **Time-of-day delays**:  
  - Morning flights are most punctual.  
  - Evening flights show the highest average delays (congestion builds up).  
- **Airport + time-of-day analysis**: Some airports consistently underperform during peak hours.  
- **Morning flights at busy airports (>10k flights)**:  
  - Identified **top 10 worst-performing airports** for morning delays.  
  - Major congested hubs (e.g., New York, Chicago) dominate this list.  
- 👉 Investment implication: Airlines heavily reliant on these congested hubs face higher operational risk.  

---

## 📌 Final Investment Guidance
- **Airline A**: Strong growth, solid utilization → best candidate for investment.  
- **Airline B**: Stable but less growth-oriented → lower upside potential.  
- **Airline C**: Declining performance → avoid investment.  
- **Operational risks**: Watch seasonality (winter cancellations) and hub congestion (delays at major airports).  

---

  
