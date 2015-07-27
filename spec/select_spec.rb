describe 'querying the bears table' do
  before do
    @db = SQLite3::Database.new(':memory:')
    @sql_runner = SQLRunner.new(@db)
    @sql_runner.execute_create_file
    @sql_runner.execute_encoded_data
  end
  after do
    File.open('lib/decoded_data.sql', 'w'){ |f| f.truncate(0) }
  end

  it 'selects all of the female bears and returns their name and age' do
    expect(@db.execute('SELECT name, age FROM bears WHERE gender = "F"')).to eq([["Tabitha", 6],["Melissa", 13], ["Wendy", 6]])
  end

  it 'selects all of the bears names and orders them in alphabetical order' do
    expect(@db.execute("SELECT name FROM bears ORDER BY name")).to eq([[nil],["Grinch"],["Melissa"],["Mr. Chocolate"],["Rowdy"],["Sargeant Brown"],["Tabitha"],["Wendy"]])
  end

  it 'selects all of the bears names and ages that are alive and order them from youngest to oldest' do
    expect(@db.execute('SELECT name, age FROM bears WHERE alive = "TRUE" ORDER BY age')).to eq([["Grinch", 2], ["Tabitha", 6], ["Wendy", 6], ["Rowdy", 10], ["Melissa", 13]])
  end

  it 'selects the oldest bear and returns their name and age' do
    expect(@db.execute("SELECT name, age FROM bears ORDER BY age DESC LIMIT 1")).to eq([["Mr. Chocolate", 20]])
  end

  it 'selects the youngest bear and returns their name and age' do
    expect(@db.execute("SELECT name, age FROM bears ORDER BY age LIMIT 1")).to eq([["Grinch", 2]])
  end

  it 'selects the most prominent color and returns it with its count' do
    expect(@db.execute("SELECT color, COUNT(id) FROM bears WHERE color = 'dark brown' GROUP BY color")).to eq([["dark brown", 3]])
  end

  it 'counts the number of bears with goofy temperments' do
    expect(@db.execute('SELECT COUNT(*) FROM bears WHERE temperament = "goofy"')).to eq([[1]])
  end

  it 'selects the bear that killed Tim' do
    expect(@db.execute("SELECT * FROM bears WHERE name IS NULL")).to eq([[8, nil, 20, "M", "black", "aggressive", "FALSE"]])
  end
end
