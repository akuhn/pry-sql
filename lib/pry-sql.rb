require "pry-sql/version"

module PrySQL

  def self.database
    @database
  end

  def self.connect(cmd, fname)
    if fname != ':memory:' && !File.exist?(fname)
      raise Pry::CommandError, "database file not found: #{fname}"
    end
    require "sqlite3"
    @database = SQLite3::Database.new(fname)
  end

  def self.execute(cmd, query)
    if @database.nil?
      cmd.output.puts 'Error: Not connected. Use `connect filename` to open database.'
      return
    end
    @database.execute(query)
  end

end

Pry::Commands.create_command 'connect' do

  group 'pry-sql'
  description 'open SQLite database'
  command_options argument_required: true, requires_gem: ['sqlite3']

  def process(fname)
    PrySQL::connect(self, fname)
  end
end

Pry::Commands.create_command 'query' do

  group 'pry-sql'
  description 'Execute SQL query'
  command_options argument_required: true, keep_retval: true, requires_gem: ['sqlite3']

  def process
    PrySQL::execute(self, arg_string)
  end
end

%w(SELECT INSERT UPDATE CREATE).each do |command|
  Pry::Commands.create_command(command) do

    group 'pry-sql'
    description "Execute inline #{command.downcase} command."
    command_options keep_retval: true, requires_gem: ['sqlite3']

    def process
      PrySQL::execute(self, "#{command_name} #{arg_string}")
    end
  end
end
