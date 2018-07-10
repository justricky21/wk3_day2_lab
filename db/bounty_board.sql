DROP TABLE bounties;

CREATE TABLE bounties (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(50),
  value INT8,
  danger_level VARCHAR(50),
  cashed_in BOOLEAN
);
