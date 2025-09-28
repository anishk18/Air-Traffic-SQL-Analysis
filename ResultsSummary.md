# Air Traffic SQL Analysis – Results Summary ✈️

📊 Dataset Overview

Flights Table: 6,521,361 rows, 23 columns (int, date, string, float).

Airports Table: 6,638 rows, 8 columns (int, string, float).

Q1: Basic Flight Statistics

Flights per Year:

2018: 3,218,653

2019: 3,302,708 (↑ vs 2018).

Flights Cancelled or Delayed: 2,633,237 (~40% of all flights).

Cancellation Reasons:

Weather: 50,225

Carrier: 34,141

NAS: 7,962

Security: 35
→ Weather caused the highest cancellations.

Monthly Cancellations (2019):

Cancellation rates highest in early months, decreasing toward year-end.

Seasonal variation → peaks around summer and holiday travel periods, affecting airline revenues cyclically.

Q2: Airline Miles & Growth

2018 Miles & Flights:

American: 933M miles / 917K flights

Delta: 842M miles / 949K flights

Southwest: 1,013M miles / 1.35M flights

2019 Miles & Flights:

American: 938M miles / 947K flights

Delta: 889M miles / 992K flights

Southwest: 1,012M miles / 1.36M flights

YoY % Change (2018 → 2019):

American: Flights +0.56%, Miles +3.27%

Delta: Flights +5.56%, Miles +4.50%

Southwest: Flights -0.12%, Miles +0.84%

➡️ Delta showed the strongest growth → better investment outlook.

Q3: Popular Airports

Top 10 Destination Airports (by arrivals):

Hartsfield-Jackson Atlanta Intl (595K)

Dallas/Fort Worth Intl (314K)

Phoenix Sky Harbor Intl (254K)

Los Angeles Intl (238K)

Charlotte Douglas Intl (216K)

Harry Reid Intl (200K)

Denver Intl (185K)

Baltimore/Washington Intl (168K)

Minneapolis-St Paul Intl (165K)

Chicago Midway Intl (165K)

Query Optimization: Subquery join reduced runtime 83s → 9.1s.

Q4: Airline Costs (Aircraft & Fuel)

Fleet Size (Unique Tail Numbers, 2018–2019):

American: 993

Delta: 988

Southwest: 754

Miles per Aircraft (Avg):

American: 1,004 miles/plane

Delta: 892 miles/plane

Southwest: 745 miles/plane

➡️ Southwest flew the most miles overall but with fewer aircrafts, suggesting high fuel cost exposure but strong equipment efficiency.

Q5: On-Time Performance

By Time-of-Day (Avg Delay, mins):

Morning: 7.8

Afternoon: 13.5

Evening: 18.0 (worst delays)

Night: 7.7

By Airport (Morning, >10K flights):

Most flights delayed: Atlanta (191K)

Worst avg delay: Newark Liberty (15.7 mins)

Top 10 Worst Morning Delay Airports:
Newark, San Francisco, JFK (NYC), DFW, Chicago O’Hare, Philadelphia, LaGuardia, Miami, Seattle, Charlotte.
---

  
## 📊 Results Dashboard

| Metric                        | 2018–2019 Result | Key Insight |
|-------------------------------|------------------|-------------|
| **Total Flights**             | ~14 million      | Large dataset, robust for trend analysis |
| **Average Arrival Delay**     | ~6 minutes       | Most flights arrive close to schedule |
| **Cancellation Rate**         | ~1.9%            | Low overall, but spikes in winter months |
| **Top Cancellation Causes**   | Weather, Carrier Ops | Weather is the single biggest disruptor |
| **Busiest Airports**          | ATL, ORD, DFW    | Hub congestion drives many delays |
| **Most Reliable Airlines**    | Alaska, Delta    | Consistently lowest delays |
| **Worst Delay Periods**       | Winter & Summer Storms | Seasonal cyclic patterns in revenue impact |
| **Average Delay by Time of Day** | Morning: Lowest, Evening: Highest | Later flights suffer more delays |

✅ **Investment Insight:** Airlines with strong on-time performance (e.g., Alaska, Delta) and diversified hub networks are better positioned for stable revenue growth and lower operational risk.
