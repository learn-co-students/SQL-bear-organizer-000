
CREATE TABLE bears(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  age INTEGER,
  gender char(1),
  color TEXT,
  temperament TEXT,
  alive INTEGER
);

SELECT name, age FROM bears WHERE gender = "F";