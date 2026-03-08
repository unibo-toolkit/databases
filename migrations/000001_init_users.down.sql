DROP TRIGGER IF EXISTS trg_oauth_providers_updated_at ON oauth_providers;
DROP TRIGGER IF EXISTS trg_users_updated_at ON users;
DROP FUNCTION IF EXISTS update_updated_at;

DROP TABLE IF EXISTS login_history;
DROP TABLE IF EXISTS refresh_tokens;
DROP TABLE IF EXISTS oauth_providers;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS users;

DROP EXTENSION IF EXISTS "pg_trgm";
DROP EXTENSION IF EXISTS "uuid-ossp";