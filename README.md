# pry-sql

Execute SQL commands from the pry command line.

```
$ pry
[1] pry(main)> connect example.sqlite
[2] pry(main)> CREATE TABLE examples (text TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP)
[3] pry(main)> INSERT INTO examples (text) VALUES ("Hello, worlds!")
[4] pry(main)> SELECT * FROM examples
=> [["Hello, worlds!", "2015-07-26 08:30:00"]]
```

## Installation

Install the gem globally or inside the :development group of your gemfile:

```
gem install 'pry-sql'
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/akuhn/pry-sql.

