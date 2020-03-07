BEGIN;
    -- the MATERIALIZED VIEW

    CREATE MATERIALIZED VIEW "exercises_library"."tags_by_exercise_state"
    AS
        SELECT
            et."tag_id" AS "tag_id",
            COUNT(*) FILTER (WHERE ex.state = 'DRAFT') AS "total_draft",
            COUNT(*) FILTER (WHERE ex.state = 'PENDING') AS "total_pending",
            COUNT(*) FILTER (WHERE ex.state = 'VALIDATED') AS "total_validated",
            COUNT(*) FILTER (WHERE ex.state = 'NOT_VALIDATED') AS "total_not_validated",
            COUNT(*) FILTER (WHERE ex.state = 'ARCHIVED') AS "total_archived"
        FROM "exercises_library"."Exercises" ex
        LEFT JOIN "exercises_library"."Exercises_Tags" et
        ON et."exercise_id" = ex.id
        GROUP BY et."tag_id"
    WITH DATA;

    -- index required for MATERIALIZED VIEW CONCURRENTLY

    CREATE UNIQUE INDEX tags_by_exercise_state_tag_id
    ON "exercises_library"."tags_by_exercise_state"(tag_id);

    -- function for trigger

    CREATE OR REPLACE FUNCTION "exercises_library"."refresh_tags_summary_search"() RETURNS TRIGGER LANGUAGE plpgsql AS $$
    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY "exercises_library"."tags_by_exercise_state";
        RETURN NULL;
    END $$;

    -- triggers

    CREATE TRIGGER auto_refresh_materialized_tag_view_1
    AFTER INSERT OR DELETE OR TRUNCATE
    ON "exercises_library"."Exercises_Tags"
    FOR EACH STATEMENT
    EXECUTE PROCEDURE "exercises_library"."refresh_tags_summary_search"();

    CREATE TRIGGER auto_refresh_materialized_tag_view_2
    AFTER UPDATE OR DELETE OR TRUNCATE
    ON "exercises_library"."Exercises"
    FOR EACH STATEMENT
    EXECUTE PROCEDURE "exercises_library"."refresh_tags_summary_search"();

    CREATE TRIGGER auto_refresh_materialized_tag_view_3
    AFTER INSERT OR DELETE OR TRUNCATE
    ON "exercises_library"."Tags"
    FOR EACH STATEMENT
    EXECUTE PROCEDURE "exercises_library"."refresh_tags_summary_search"();

COMMIT;
