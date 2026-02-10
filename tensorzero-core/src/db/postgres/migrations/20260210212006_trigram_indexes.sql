-- Enable pg_trgm extension for substring search on JSONB columns.
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Trigram GIN indexes for substring search on input/output JSONB columns.
-- These cast JSONB to text and use gin_trgm_ops for efficient LIKE/ILIKE queries.

-- chat_inferences
-- These cannot run CONCURRENTLY because chat_inferences is a partitioned table.
CREATE INDEX idx_chat_inferences_input_trgm
    ON tensorzero.chat_inferences USING GIN ((input::text) gin_trgm_ops);
CREATE INDEX idx_chat_inferences_output_trgm
    ON tensorzero.chat_inferences USING GIN ((output::text) gin_trgm_ops);

-- json_inferences
-- These cannot run CONCURRENTLY because json_inferences is a partitioned table.
CREATE INDEX idx_json_inferences_input_trgm
    ON tensorzero.json_inferences USING GIN ((input::text) gin_trgm_ops);
CREATE INDEX idx_json_inferences_output_trgm
    ON tensorzero.json_inferences USING GIN ((output::text) gin_trgm_ops);

-- chat_datapoints
CREATE INDEX idx_chat_datapoints_input_trgm
    ON tensorzero.chat_datapoints USING GIN ((input::text) gin_trgm_ops);
CREATE INDEX idx_chat_datapoints_output_trgm
    ON tensorzero.chat_datapoints USING GIN ((output::text) gin_trgm_ops);

-- json_datapoints
CREATE INDEX idx_json_datapoints_input_trgm
    ON tensorzero.json_datapoints USING GIN ((input::text) gin_trgm_ops);
CREATE INDEX idx_json_datapoints_output_trgm
    ON tensorzero.json_datapoints USING GIN ((output::text) gin_trgm_ops);
