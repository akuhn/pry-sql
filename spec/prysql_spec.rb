require 'spec_helper'

describe PrySQL do
  it 'has a version number' do
    expect(PrySQL::VERSION).not_to be nil
  end

  describe 'connect' do

    it 'requires an argument' do
      expect {
        pry_eval('connect')
      }.to raise_error Pry::CommandError, /requires an argument/
    end

    it 'opens memory database' do
      expect(pry_eval('connect :memory:')).to be_empty
      expect(PrySQL::database).to_not be_nil
    end

    it 'opens database file' do
      temp = Tempfile.new('example')
      fname = temp.path
      expect(pry_eval("connect #{fname}")).to be_empty
      expect(PrySQL::database).to_not be_nil
    end

    it 'does not create new files' do
      temp = Tempfile.new('example')
      fname = temp.path
      temp.delete
      expect {
        pry_eval("connect #{fname}")
      }.to raise_error Pry::CommandError, /file not found/
    end

  end

  describe 'README.md' do

    it 'example should work' do
      data = pry_eval(
        'connect :memory:',
        'CREATE TABLE examples (text TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP)',
        'INSERT INTO examples (text) VALUES ("Hello, worlds!")',
        'SELECT * FROM examples',
      )
      expect(data.size).to eq 1
      expect(data.first.size).to eq 2
      expect(data.to_s).to match /Hello, worlds!/
    end

  end

  describe 'query' do

    before :each do
      pry_eval('connect :memory:')
    end

    it "executes SQL queries" do
      data = pry_eval(
        'query create table foo (text text)',
        'query insert into foo values ("a"), ("b"), ("c")',
        'query select * from foo',
      )
      expect(data.size).to eq 3
      expect(data.first.size).to eq 1
      expect(data.map { |each| each[0] }).to match_array %w(a b c)
    end

    it 'requires an argument' do
      expect {
        pry_eval('query')
      }.to raise_error Pry::CommandError, /requires an argument/
    end

  end

end
