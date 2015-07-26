require "pry-sql/version"
require "sqlite3"

module PrySQL

  DB = SQLite3::Database.new(':memory:')

  %w(select create insert update show).each do |command|
    Pry::Commands.create_command(command) do

      match /(#{command}\s.*)/i

      description "execute #{command.upcase} query"

      command_options listing: command, keep_retval: true

      def process
        DB.execute(captures[0])
      end
    end
  end

end
