require 'pry'
class Student

  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id = nil)
    @id = id 
    @name = name 
    @grade = grade
  end
  
  def self.create_table 
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
        )
        SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table 
    sql =  <<-SQL 
      DROP TABLE students
        SQL
    DB[:conn].execute(sql)
  end
  
  def save 
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL
 
    DB[:conn].execute(sql, self.name, self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students").flatten[0]
  end
  
  def self.create(attributes)
    attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    binding.pry
  end
  
end






