class Connection < Constants
  def initialize
    @db = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "root", :database => "example")
  end

  def execute(query, *params)
    @db.query <<-Query
      #{query % params}
    Query
  end

  def single(query, *params)
    (
      @db.query <<-Query
        #{query % params}
      Query
    ).first
  end

  def last_insert_id
    data = @db.query <<-Query
      SELECT LAST_INSERT_ID() AS id
    Query
    data.first["id"]
  end
end