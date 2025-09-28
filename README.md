# Air-Traffic-SQL-Analysis-
SQL-based data analysis of U.S. airline performance (2018–2019) to generate investment insights for BrainStation Mutual Fund managers.


# Air Traffic SQL Analysis ✈️

## 📌 Project Overview
This project analyzes U.S. airline flight data (2018–2019) to support investment decisions for the **BrainStation Mutual Fund**.  
The goal is twofold:
1. Provide **business insights** into airline performance, cancellations, costs, and airport operations.
2. Demonstrate **SQL expertise** with complex queries, aggregations, joins, and optimizations.

Data was sourced from the [Bureau of Transportation Statistics](https://www.transtats.bts.gov/).

---

## 📂 Project Structure
AirTraffic-SQL-Analysis/
- [SQL file](AirTrafficAnalysis.sql) # Fully commented SQL script (main deliverable)
- [README.md](README.md) # Project documentation (this file)
- [Results_Summary.md](ResultsSummary.md) # Key business insights 
-  AirTraffic_ERD.png # Database schema diagram 



---

## 🗄️ Dataset Description
Two main tables were used:

**1. flights (2018–2019, top 3 airlines)**  
- FlightID, FlightDate, AirlineName  
- OriginAirportID, DestAirportID  
- Departure/Arrival times & delays  
- Cancelled/Diverted indicators  
- Distance, AirTime, TailNumber, etc.  

**2. airports**  
- AirportID, AirportName, City, State, Country  
- Latitude, Longitude  

---

## ❓ Business Questions Answered

### **Q1. Basic Flight Statistics**
- Total flights per year (2018 vs. 2019).  
- Total cancelled or late departures across both years.  
- Cancellations broken down by reason.  
- Monthly 2019 cancellations (% of flights) → insights into **seasonality of airline revenue**.  

### **Q2. Airline Performance Year-over-Year**
- Created summary tables for each year: total miles & number of flights per airline.  
- Calculated **YoY % change** for flights and miles.  
- Investment guidance provided based on growth/decline.  

### **Q3. Most Popular Airports**
- Top 10 destination airports overall.  
- Compared **two query strategies**:  
  - Join before aggregation  
  - Subquery aggregation before join (faster runtime).  

### **Q4. Airline Operating Costs (Proxies)**
- Unique tail numbers → approximate fleet size.  
- Total miles traveled → proxy for fuel costs.  
- Average miles per aircraft → proxy for equipment utilization.  
- Compared financial implications for the 3 airlines.  

### **Q5. On-Time Performance**
- Departure delay patterns by **time-of-day** (morning, afternoon, evening, night).  
- Average delay per airport + time-of-day.  
- Focused on **morning flights** at high-traffic airports (>10,000 flights).  
- Identified **top-10 worst airports for morning delays**.  

---

## 📊 Key Insights (Highlights)
- ✈️ **Seasonality:** Cancellation rates spike in winter months → airline revenue is cyclic.  
- 📈 **Airline growth:** One airline showed YoY increase in both flights & miles traveled, making it a stronger candidate for investment.  
- 🛫 **Popular hubs:** Major airports dominate destination traffic (Atlanta, Chicago, Los Angeles).  
- ⏱️ **Delays:** Evening flights suffer the most delays, while mornings are generally more punctual — except at specific congested airports.  
- 🛩️ **Fleet utilization:** Airlines with fewer planes but higher miles per aircraft may have higher maintenance costs but better asset utilization.  

---

## ⚙️ How to Run the Project
1. Download the cleaned dataset provided [under data](data).  
2. Import into MySQL Workbench:  
   - `Server > Data Import` → Select "Import from Self-Contained File".  
   - Set default schema as **AirTraffic**.  
3. Run the SQL script:  
   - Open **`AirTraffic_Analysis.sql`**.  
   - Execute queries section by section (Q1–Q5).  
4. Review comments and insights in the SQL file or `Results_Summary.md`.  

---

## 📌 Tech Stack
- **MySQL Workbench** (SQL analysis)  
- **GitHub** (version control & portfolio showcase)  
---

## 📄 License
This project is open-source under the [MIT License](LICENSE).  

---

## 👤 Author
**Anish Karnik**  
- Process Engineer | Data Science | Cleantech & Finance Enthusiast  
- 🌐 [LinkedIn](https://www.linkedin.com/) | [GitHub](https://github.com/YourUsername)
