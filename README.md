# Movie ETL — Analysis & Notes

This repository contains the deliverables for the "Building a Simple Movie Data Pipeline" take-home assignment.
Files included/generated (you should commit these to your repo):
- `etl.py` — (not included here) main ETL script (the notebook implements the ETL; consider converting to etl.py)
- `schema.sql` — database schema (created from analysis of the notebook)
- `queries.sql` — analytical SQL queries (extracted from the notebook)
- `omdb_cache.json` — (optional) API response cache generated on runs
- `movies.csv`, `ratings.csv` — MovieLens input files (not included, download as instructed)
- `movie_data.db` or `movie_etl.db` — SQLite database produced by the notebook (generated when running the ETL)

## Overview of what the notebook implements (checked)
- Reads `movies.csv` and `ratings.csv` from MovieLens small dataset.
- Cleans movie titles and parses release year where available.
- Calls OMDb API per movie with caching to enrich details (Director, Plot, BoxOffice, Runtime, Released, Language, Actors, imdbID, Genre).
- Implements a JSON cache `omdb_cache.json` and configurable sleep/backoff to avoid rate limits.
- Parses runtime to integer minutes and merges OMDb results into movies table.
- Creates idempotent behavior when loading into SQLite (`if_exists='replace'` used).
- Writes `queries.sql` containing SQL answers to the assignment questions.
- Saves cleaned CSVs (`movies_cleaned.csv`, `ratings_cleaned.csv`) and loads final tables into SQLite.

## Missing / Recommended fixes before submission
1. **Add `schema.sql`** (created in this repo) — required by assignment.
2. **Create `etl.py`** — convert the notebook to a runnable script with CLI flags (e.g., `--api-key`, `--db`).
3. **Remove hard-coded OMDb API key**: Use an environment variable or `.env` file. The notebook currently contains `OMDB_API_KEY = "36dc668c"` which should be removed before publishing.
4. **Add `requirements.txt`**: list packages used (`pandas`, `requests`, `sqlalchemy`, `tqdm`).
5. **Add `README.md` improvements**: include exact run commands:
   ```bash
   pip install -r requirements.txt
   export OMDB_API_KEY=your_key_here
   python etl.py --movies movies.csv --ratings ratings.csv --db movie_data.db
   ```
6. **Add Presentation notes**: include architecture diagram and decisions (see NOTES.md).

## How I validated the notebook
- Confirmed OMDb enrichment function with caching exists and is used.
- Confirmed transformation steps: parsing runtime, merging genres, creating `decade` feature, creating `movie_avg_ratings` view/table.
- Confirmed load step uses SQLAlchemy to write to SQLite with `if_exists='replace'` for idempotency.
- Confirmed `queries.sql` is written from notebook content.

## Next steps before uploading to Git
- Replace/remove the embedded API key.
- Move runnable ETL code into `etl.py` and add CLI options.
- Add `schema.sql`, `queries.sql`, `README.md`, `requirements.txt` to repo root.
- Ensure `.gitignore` excludes `omdb_cache.json` or `movie_data.db` if you don't want to commit generated artifacts.
- Prepare a 15-minute presentation slide deck summarizing: architecture, data model, challenges, scaling ideas, and demo steps.

