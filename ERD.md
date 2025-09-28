## 📐 Database ERD

```mermaid
erDiagram
    airports {
        int AirportID PK
        string AirportName
        string City
        string State
        string Country
        float Latitude
        float Longitude
    }

    flights {
        int FlightID PK
        date FlightDate
        string ReportingAirline
        string TailNumber
        string FlightNumberReportingAirline
        int OriginAirportID FK
        int DestAirportID FK
        string CRSDepTime
        string DepTime
        int DepDelay
        int TaxiOut
        string WheelsOff
        string WheelsOn
        int TaxiIn
        string CRSArrTime
        string ArrTime
        int ArrDelay
        int Cancelled
        int Diverted
        int AirTime
        float Distance
        string AirlineName
        string CancellationReason
    }

    flights ||--|| airports : "OriginAirportID"
    flights ||--|| airports : "DestAirportID"
