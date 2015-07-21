INSERT INTO bears VALUES (1, "Mr. Chocolate", 24, "M", "Black", "Happy", 1),(2, "Wendy", 43, "F", "Grizzly Brown", "Loving", 1), 
(3, "Rowdy", 23, "M", "Brown", "Sad", 1),
(4, "Tabitha", 4, "F", "Black", "Horny", 1),
(5, "Sergeant Brown", 14, "M", "White & Black", "Angry", 1),
(6, "Melissa", 21, "F", "Brown", "Bitchy", 1),
(7, "Grinch", 10, "M", "Jet Black", "WILD", 1),
(8, NULL, 24, "M", "Black", "Text", 1);

SELECT name, age FROM bears WHERE gender = "F";