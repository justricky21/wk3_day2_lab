require 'pg'

# has:
# name: string (VARCHAR(50))
# value: string.to_int (INT8)
# danger_level: string (VARCHAR(50))
# cashed_in: boolean (BOOLEAN)
# id: string.to_int (SERIAL8)

class Bounty
  attr_writer :name
  def initialize(option)
    @name = option['name']
    @value = option['value'].to_i
    @danger_level = option['danger_level']
    @cashed_in = option['cashed_in']
  end

  def save
    db = PG.connect({dbname: 'bounty_board', host: 'localhost'})
    sql = "INSERT INTO bounties (name, value, danger_level, cashed_in)
    VALUES($1, $2, $3, $4) RETURNING *;"
    values = [@name, @value, @danger_level, @cashed_in]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    @id = result.first['id'].to_i
    db.close()
  end

  def delete
    db = PG.connect({dbname: 'bounty_board', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1;"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update
    db = PG.connect({dbname: 'bounty_board', host: 'localhost'})
    sql = "UPDATE bounties SET (name, value,
    danger_level, cashed_in) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@name, @value, @danger_level, @cashed_in, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Bounty.find_by_name(name)
  db = PG.connect({dbname: 'bounty_board', host: 'localhost'})
  sql = "SELECT * FROM bounties WHERE name = $1;"
  values = [name]
  db.prepare("find_by_name", sql)
  result = db.exec_prepared("find_by_name", values)
  db.close()
  return result.first
  end

  def Bounty.find_by_id(id)
  db = PG.connect({dbname: 'bounty_board', host: 'localhost'})
  sql = "SELECT * FROM bounties WHERE id = $1;"
  values = [id]
  db.prepare("find_by_id", sql)
  result = db.exec_prepared("find_by_id", values)
  db.close()
  return result.first
  end

end
