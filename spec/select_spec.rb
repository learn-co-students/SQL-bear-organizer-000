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
    sql = <<-SQL
    SELECT name, age FROM bears WHERE gender = "F";
    SQL
    expect(@db.execute(sql)).to eq([["Tabitha", 6],["Melissa", 13], ["Wendy", 6]])
  end

  it 'selects all of the bears names and orders them in alphabetical order' do
    sql = <<-SQL
    SELECT name FROM bears ORDER BY name;
    SQL
    expect(@db.execute(sql)).to eq([[nil],["Grinch"],["Melissa"],["Mr. Chocolate"],["Rowdy"],["Sargeant Brown"],["Tabitha"],["Wendy"]])
  end

  it 'selects all of the bears names and ages that are alive and order them from youngest to oldest' do
    sql = <<-SQL
    SELECT name, age FROM bears WHERE alive = "TRUE" ORDER BY age ASC; 
    SQL
    expect(@db.execute(sql)).to eq([["Grinch", 2], ["Tabitha", 6], ["Wendy", 6], ["Rowdy", 10], ["Melissa", 13]])
  end

  it 'selects the oldest bear and returns their name and age' do
  sql = <<-SQL
    SELECT name, MAX(age) FROM bears;
    SQL

    expect(@db.execute(sql)).to eq([["Mr. Chocolate", 20]])
  end

  it 'selects the youngest bear and returns their name and age' do
    sql = <<-SQL
    SELECT name, MIN(age) FROM bears;
    SQL
    expect(@db.execute(sql)).to eq([["Grinch", 2]])
  end

  it 'selects the most prominent color and returns it with its count' do
    sql = <<-SQL
    SELECT MAX(color), COUNT(color) FROM bears WHERE color = 'dark brown'
    SQL
    expect(@db.execute(sql)).to eq([["dark brown", 3]])
  end

  it 'counts the number of bears with goofy temperments' do
    sql = <<-SQL
    SELECT COUNT(temperament) FROM bears WHERE temperament = "goofy";
    SQL
    expect(@db.execute(sql)).to eq([[1]])
  end

  it 'selects the bear that killed Tim' do
    sql = <<-SQL

    SELECT MAX(id), name, age, gender, color, temperament, alive FROM bears ;
    SQL
    expect(@db.execute(sql)).to eq([[8, nil, 20, "M", "black", "aggressive", "FALSE"]])
  end
end
