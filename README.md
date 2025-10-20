# Movie Data Pipeline - Data Engineering Assignment

## Project Structure
```
your-repo-name/
├── etl.py         
├── schema.sql     
├── queries.sql    
└── README.md      
```

## Features
- **Extract:** Reads `movies.csv` and `ratings.csv` from MovieLens dataset and fetches additional movie details from the OMDb API.
- **Transform:** Cleans and enriches data, handles missing values, converts data types, and performs feature engineering (e.g., genre parsing, release decade categorization).
- **Load:** Inserts cleaned and enriched data into the relational database (SQLite/MySQL/PostgreSQL). The ETL script is idempotent to avoid duplicate entries.
- **API Handling:** OMDb API restricts free requests to 1000 records per day. Implemented a retry mechanism and batch processing to handle this limitation.
- **Batch Processing:** Movies are processed in batches to manage API rate limits and ensure data integrity.
- **Analytics:** Queries to answer:
  1. Highest average-rated movie
  2. Top 5 movie genres by average rating
  3. Director with most movies
  4. Average rating of movies released each year

## Setup Instructions

### 1. Clone the Repository
```bash
git clone  https://github.com/ONSTEROIDS/Movies-ETL-pipeline/tree/main
cd your-repo-name
```

### 2. Install Dependencies
```bash
pip install -r requirements.txt
```

### 3. Configure Database
- Create a database in SQLite/MySQL/PostgreSQL.
- Run the schema script to create necessary tables:
```bash
mysql -u <user> -p <database_name> < schema.sql
# or for SQLite
sqlite3 movies.db < schema.sql
```

### 4. Configure OMDb API
- Obtain a free API key from [OMDb API](http://www.omdbapi.com/).(used api key is mentioned in the code)
- Add your API key in `etl.py` in the designated variable.

### 5. Run ETL Pipeline
```bash
python etl.py
```
- ETL reads CSV files, enriches data from OMDb API, cleans and transforms data, and loads it into the database.
- Handles API limits using batch processing and retry mechanism.

### 6. Run Queries
- You can use Python `pandas`  to run queries from `queries.sql`:
```python
import pandas as pd
import sqlite3

conn = sqlite3.connect("movies.db")
queries = open("queries.sql").read()

# Example: Run a query
df = pd.read_sql_query("SELECT * FROM movies LIMIT 10;", conn)
print(df.head())
```


## Challenges & Solutions
- **API Limit:** OMDb API only allows 1000 records per day. Solved by implementing batch processing and retry logic.
- **Data Mismatches:** Movie titles in CSV may not match API results. Resolved with fuzzy matching and logging missing entries.
- **Missing Values & Type Conversions:** Handled missing values and ensured proper data types before loading into the database.

## Potential Improvements
- Parallel API requests to reduce runtime.
- Implement incremental ETL to process only new or updated movies.
- Use cloud-based database and scheduling tools (Airflow) for production-level scalability.
