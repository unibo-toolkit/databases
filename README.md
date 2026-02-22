# UniBo Toolkit - Database Migrations

PostgreSQL schema for the UniBo Toolkit project. Contains 13 tables for users, courses, calendars, and timetables.

## Quick Start

```bash
make setup        # Start PostgreSQL
make migrate-up   # Apply migrations
make psql         # Connect to DB
```

## Commands

```bash
make help              # Show all commands
make migrate-down      # Rollback last migration
make migrate-reset     # Rollback all migrations
make create name=XXX   # Create new migration
make clean             # Remove PostgreSQL + data
```

## Connection

```
postgresql://unibo_user:unibo_pass@localhost:5432/unibo_toolkit?sslmode=disable
```
