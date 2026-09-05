# Data Dictionary

## Table: role

| Column | Type                  | Null | Default | Description       |
| ------ | --------------------- | ---- | ------- | ----------------- |
| id     | int `PK`              | No   | auto    | Unique identifier |
| name   | varchar(255) `UNIQUE` | No   | -       | -                 |

**Data:**

- `admin` website owner, able to create event

- `event-owner` event organizer

- `user` authenticated user

## Table: user

| Column         | Type                  | Null | Default | Description                |
| -------------- | --------------------- | ---- | ------- | -------------------------- |
| id             | int `PK`              | No   | auto    | Unique identifier          |
| email          | varchar(255) `UNIQUE` | No   | -       | verified via OTP           |
| password_hash  | varchar(255)          | No   | -       | Bcrypt hashed              |
| first_name     | varchar(100)          | No   | -       | Min 2 characters           |
| last_name      | varchar(100)          | No   | -       | Min 2 characters           |
| role_id        | int `FK → role.id`    | No   | -       | -                          |
| email_verified | boolean               | No   | false   | Set true after OTP confirm |
| profile_image  | varchar(255)          | Yes  | null    | -                          |
| created_at     | timestamptz           | No   | now()   | -                          |
| updated_at     | timestamptz           | No   | now()   | -                          |

**Relationships:**

- Belong → `role` (role_id)
- Has many → `session` (user_id)
- Has many → `event` (user_id)
- Has many → `bidder` (user_id)

---

## Table: session

| Column      | Type                  | Null | Default | Description       |
| ----------- | --------------------- | ---- | ------- | ----------------- |
| id          | int `PK`              | No   | auto    | Unique identifier |
| user_id     | int `FK → user.id`    | No   | -       | -                 |
| token       | varchar(255) `UNIQUE` | No   | -       | -                 |
| device_info | varchar(255)          | No   | -       | -                 |
| created_at  | timestamptz           | No   | now()   | -                 |
| expired_at  | timestamptz           | No   | now()   | -                 |

**Relationships:**

- Belong → `user` (user_id)

## Table: event

| Column      | Type               | Null | Default | Description                |
| ----------- | ------------------ | ---- | ------- | -------------------------- |
| id          | int `PK`           | No   | auto    | Unique identifier          |
| user_id     | int `FK → user.id` | No   | -       | -                          |
| title       | varchar(255)       | No   | -       | -                          |
| summary     | varchar(500)       | Yes  | -       | -                          |
| description | text               | Yes  | -       | -                          |
| start_date  | timestamptz        | No   | -       | -                          |
| end_date    | timestamptz        | No   | -       | must be after `start_date` |
| address     | varchar(255)       | Yes  | -       | -                          |
| created_at  | timestamptz        | No   | now()   | -                          |
| updated_at  | timestamptz        | No   | now()   | -                          |

**Relationships:**

- Belong → `user` (user_id)
- Has many → `contributor_role` (event_id)
- Has many → `event_contributor` (event_id)
- Has many → `item` (event_id)
- Has many → `event_bidder` (event_id)
- Has many → `notification` (event_id)

---

## Table: contributor_role

| Column     | Type                | Null | Default | Description       |
| ---------- | ------------------- | ---- | ------- | ----------------- |
| id         | int `PK`            | No   | auto    | Unique identifier |
| title      | varchar(100)        | No   | -       | -                 |
| event_id   | int `FK → event.id` | No   | -       | -                 |
| created_at | timestamptz         | No   | now()   | -                 |
| updated_at | timestamptz         | No   | now()   | -                 |

**Relationships:**

- Belong → `event` (event_id)
- Has many → `event_contributor` (contributor_role_id)

---

## Table: event_contributor

| Column              | Type                           | Null | Default | Description       |
| ------------------- | ------------------------------ | ---- | ------- | ----------------- |
| id                  | int `PK`                       | No   | auto    | Unique identifier |
| first_name          | varchar(100)                   | No   | -       | -                 |
| last_name           | varchar(100)                   | No   | -       | -                 |
| description         | text                           | Yes  | -       | -                 |
| email               | varchar(255)                   | Yes  | -       | -                 |
| profile_image       | varchar(255)                   | Yes  | -       | -                 |
| event_id            | int `FK → event.id`            | No   | -       | -                 |
| contributor_role_id | int `FK → contributor_role.id` | Yes  | -       | -                 |
| created_at          | timestamptz                    | No   | now()   | -                 |
| updated_at          | timestamptz                    | No   | now()   | -                 |

**Relationships:**

- Belong → `event` (event_id)
- Belong → `contributor_role` (contributor_role_id)
- Has many → `item` (event_contributor_id)

---

## Table: item

| Column               | Type                            | Null | Default | Description                 |
| -------------------- | ------------------------------- | ---- | ------- | --------------------------- |
| id                   | int `PK`                        | No   | auto    | Unique identifier           |
| title                | varchar(255)                    | No   | -       | -                           |
| summary              | varchar(500)                    | Yes  | -       | -                           |
| description          | text                            | Yes  | -       | -                           |
| date                 | timestamptz                     | Yes  | -       | auction slot / display date |
| min_price            | numeric(12,2)                   | No   | -       | starting bid price          |
| event_id             | int `FK → event.id`             | No   | -       | -                           |
| event_contributor_id | int `FK → event_contributor.id` | Yes  | -       | -                           |
| created_at           | timestamptz                     | No   | now()   | -                           |
| updated_at           | timestamptz                     | No   | now()   | -                           |

**Relationships:**

- Belong → `event` (event_id)
- Belong → `event_contributor` (event_contributor_id)
- Has many → `item_image` (item_id)
- Has many → `bidding` (item_id)
- Has many → `notification` (item_id)

---

## Table: item_image

| Column     | Type               | Null | Default | Description       |
| ---------- | ------------------ | ---- | ------- | ----------------- |
| id         | int `PK`           | No   | auto    | Unique identifier |
| item_id    | int `FK → item.id` | No   | -       | -                 |
| image_url  | varchar(500)       | No   | -       | -                 |
| created_at | timestamptz        | No   | now()   | -                 |

**Relationships:**

- Belong → `item` (item_id)

---

## Table: bidding

| Column       | Type               | Null | Default | Description                |
| ------------ | ------------------ | ---- | ------- | -------------------------- |
| id           | int `PK`           | No   | auto    | Unique identifier          |
| item_id      | int `FK → item.id` | No   | -       | -                          |
| user_id      | int `FK → user.id` | No   | -       | bidder                     |
| price        | numeric(12,2)      | No   | -       | must be ≥ `item.min_price` |
| is_cancelled | boolean            | No   | false   | -                          |
| created_at   | timestamptz        | No   | now()   | -                          |
| cancelled_at | timestamptz        | Yes  | -       | set when cancelled         |

**Relationships:**

- Belong → `item` (item_id)
- Belong → `user` (user_id)

---

## Table: event_bidder

| Column     | Type                | Null | Default | Description       |
| ---------- | ------------------- | ---- | ------- | ----------------- |
| id         | int `PK`            | No   | auto    | Unique identifier |
| user_id    | int `FK → user.id`  | No   | -       | -                 |
| event_id   | int `FK → event.id` | No   | -       | -                 |
| is_removed | boolean             | No   | false   | -                 |
| removed_at | timestamptz         | Yes  | -       | set when removed  |

**Relationships:**

- Belong → `user` (user_id)
- Belong → `event` (event_id)

**Data:**

- unique per (`user_id`, `event_id`) — a user can only be a bidder once per event

---

## Table: notification_type

| Column | Type                  | Null | Default | Description       |
| ------ | --------------------- | ---- | ------- | ----------------- |
| id     | int `PK`              | No   | auto    | Unique identifier |
| title  | varchar(100) `UNIQUE` | No   | -       | -                 |

**Data:**

- `outbid`
- `highest_bid`
- `winner`
- `remove_from_event`
- `approve_bidder`

**Relationships:**

- Has many → `notification` (notification_type_id)

---

## Table: notification

| Column               | Type                            | Null | Default | Description       |
| -------------------- | ------------------------------- | ---- | ------- | ----------------- |
| id                   | int `PK`                        | No   | auto    | Unique identifier |
| user_id              | int `FK → user.id`              | No   | -       | recipient         |
| notification_type_id | int `FK → notification_type.id` | No   | -       | -                 |
| event_id             | int `FK → event.id`             | Yes  | -       | -                 |
| item_id              | int `FK → item.id`              | Yes  | -       | -                 |
| message              | varchar(500)                    | No  | -       | -                 |
| is_read              | boolean                         | No   | false   | -                 |
| created_at           | timestamptz                     | No   | now()   | -                 |

**Relationships:**

- Belong → `user` (user_id)
- Belong → `notification_type` (notification_type_id)
- Belong → `event` (event_id)
- Belong → `item` (item_id)

---

## Constraints & Indexes

### role

- `PK`: `id`
- `UNIQUE`: `name`

### user

- `PK`: `id`
- `UNIQUE`: `email`
- `FK`: `role_id` → `role.id`
- `INDEX`: `role_id`

### session

- `PK`: `id`
- `FK`: `user_id` → `user.id`
- `UNIQUE`: `token_hash`
- `INDEX`: `user_id`
- `INDEX`: `expired_at`

### event

- `PK`: `id`
- `FK`: `user_id` → `user.id`
- `CHECK`: `end_date > start_date`
- `INDEX`: `user_id`

### contributor_role

- `PK`: `id`
- `FK`: `event_id` → `event.id` (`ON DELETE CASCADE`)
- `INDEX`: `event_id`

### event_contributor

- `PK`: `id`
- `FK`: `event_id` → `event.id` (`ON DELETE CASCADE`)
- `FK`: `contributor_role_id` → `contributor_role.id`
- `INDEX`: `event_id`

### item

- `PK`: `id`
- `FK`: `event_id` → `event.id` (`ON DELETE CASCADE`)
- `FK`: `event_contributor_id` → `event_contributor.id`
- `INDEX`: `event_id`

### item_image

- `PK`: `id`
- `FK`: `item_id` → `item.id` (`ON DELETE CASCADE`)
- `INDEX`: `item_id`

### bidding

- `PK`: `id`
- `FK`: `item_id` → `item.id` (`ON DELETE CASCADE`)
- `FK`: `user_id` → `user.id`
- `INDEX`: `item_id, price DESC` (fast highest-bid lookup)

### event_bidder

- `PK`: `id`
- `FK`: `user_id` → `user.id`
- `FK`: `event_id` → `event.id` (`ON DELETE CASCADE`)
- `UNIQUE`: `(user_id, event_id)`
- `INDEX`: `event_id`

### notification_type

- `PK`: `id`
- `UNIQUE`: `title`

### notification

- `PK`: `id`
- `FK`: `user_id` → `user.id` (`ON DELETE CASCADE`)
- `FK`: `notification_type_id` → `notification_type.id`
- `FK`: `event_id` → `event.id`
- `FK`: `item_id` → `item.id`
- `INDEX`: `user_id`
