require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super(questions.db)
        self.type_translation = true
        self.results_as_hash = true
    end
end

class Users 

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| Users.new(datum) }
      end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def create
        raise "#{self} already in database" if self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname)
          INSERT INTO
            users (fname, lname)
          VALUES
            (?, ?)
        SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
      end

    def find_by_id

    end
end