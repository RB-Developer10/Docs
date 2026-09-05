
-- =========================================
-- Table: role
-- =========================================
CREATE TABLE role (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE
);

-- =========================================
-- Table: "user"
-- =========================================
CREATE TABLE "user" (
    id              SERIAL PRIMARY KEY,
    role_id         INT NOT NULL REFERENCES role(id),
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(255) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    email_verified  BOOLEAN NOT NULL DEFAULT FALSE,
    profile_image   VARCHAR(255),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =========================================
-- Table: session
-- =========================================
CREATE TABLE session (
    id          SERIAL PRIMARY KEY,
    user_id     INT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    token       VARCHAR(255) NOT NULL UNIQUE,
    device_info VARCHAR(255),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expired_at  TIMESTAMPTZ NOT NULL
);

-- =========================================
-- Table: event
-- =========================================
CREATE TABLE event (
    id          SERIAL PRIMARY KEY,
    user_id     INT NOT NULL REFERENCES "user"(id),
    title       VARCHAR(255) NOT NULL,
    summary     VARCHAR(500),
    description TEXT,
    start_date  TIMESTAMPTZ NOT NULL,
    end_date    TIMESTAMPTZ NOT NULL,
    address     VARCHAR(255),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (end_date > start_date)
);

-- =========================================
-- Table: contributor_role
-- =========================================
CREATE TABLE contributor_role (
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(100) NOT NULL,
    event_id    INT NOT NULL REFERENCES event(id) ON DELETE CASCADE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =========================================
-- Table: event_contributor
-- =========================================
CREATE TABLE event_contributor (
    id                  SERIAL PRIMARY KEY,
    first_name          VARCHAR(100) NOT NULL,
    last_name           VARCHAR(100) NOT NULL,
    description         TEXT,
    email               VARCHAR(255),
    profile_image       VARCHAR(255),
    event_id            INT NOT NULL REFERENCES event(id) ON DELETE CASCADE,
    contributor_role_id INT REFERENCES contributor_role(id),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =========================================
-- Table: item
-- =========================================
CREATE TABLE item (
    id                      SERIAL PRIMARY KEY,
    title                   VARCHAR(255) NOT NULL,
    summary                 VARCHAR(500),
    description             TEXT,
    date                    TIMESTAMPTZ,
    min_price               NUMERIC(12,2) NOT NULL,
    event_id                INT NOT NULL REFERENCES event(id) ON DELETE CASCADE,
    event_contributor_id    INT REFERENCES event_contributor(id),
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK (min_price > 0)
);

-- =========================================
-- Table: item_image
-- =========================================
CREATE TABLE item_image (
    id          SERIAL PRIMARY KEY,
    item_id     INT NOT NULL REFERENCES item(id) ON DELETE CASCADE,
    image_url   VARCHAR(500) NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =========================================
-- Table: bidding
-- =========================================
CREATE TABLE bidding (
    id          SERIAL PRIMARY KEY,
    item_id     INT NOT NULL REFERENCES item(id) ON DELETE CASCADE,
    user_id     INT NOT NULL REFERENCES "user"(id),
    price       NUMERIC(12,2) NOT NULL,
    is_cancelled BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    cancelled_at TIMESTAMPTZ
);

-- =========================================
-- Table: event_bidder
-- =========================================
CREATE TABLE event_bidder (
    id          SERIAL PRIMARY KEY,
    user_id     INT NOT NULL REFERENCES "user"(id),
    event_id    INT NOT NULL REFERENCES event(id) ON DELETE CASCADE,
    is_removed  BOOLEAN NOT NULL DEFAULT FALSE,
    removed_at  TIMESTAMPTZ,
    UNIQUE (user_id, event_id)
);

-- =========================================
-- Table: notification_type
-- =========================================
CREATE TABLE notification_type (
    id      SERIAL PRIMARY KEY,
    title   VARCHAR(100) NOT NULL UNIQUE
    -- e.g. 'outbid', 'highest_bid', 'winner', 'remove_from_event', 'approve_bidder'
);

-- =========================================
-- Table: notification
-- =========================================
CREATE TABLE notification (
    id                  SERIAL PRIMARY KEY,
    user_id             INT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    notification_type_id INT NOT NULL REFERENCES notification_type(id),
    event_id            INT REFERENCES event(id),
    item_id             INT REFERENCES item(id),
    message             VARCHAR(500) NOT NULL,
    is_read             BOOLEAN NOT NULL DEFAULT FALSE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =========================================
-- Indexes
-- =========================================
CREATE INDEX idx_user_role_id ON "user"(role_id);
CREATE INDEX idx_session_user_id ON session(user_id);
CREATE INDEX idx_event_user_id ON event(user_id);
CREATE INDEX idx_contributor_role_event_id ON contributor_role(event_id);
CREATE INDEX idx_event_contributor_event_id ON event_contributor(event_id);
CREATE INDEX idx_item_event_id ON item(event_id);
CREATE INDEX idx_item_image_item_id ON item_image(item_id);
CREATE INDEX idx_bidding_item_id_price ON bidding(item_id, price DESC);
CREATE INDEX idx_event_bidder_event_id ON event_bidder(event_id);
CREATE INDEX idx_notification_user_id ON notification(user_id);