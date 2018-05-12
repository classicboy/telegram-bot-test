require './lib/handlers/leveldb_handler.rb'

namespace :qa do
  desc "Create sample question and answer"
  task :sample => :environment do
	LevelDBHandler.new("qa_db_name").sample_data
  end

  desc "Fetch DB and output to console"
  task :fetch => :environment do
	LevelDBHandler.new("qa_db_name").fetch
  end

  desc "Remove all data in selected db"
  task :flush => :environment do
	LevelDBHandler.new("qa_db_name").flush
  end
end

namespace :data do
  task :fetch => :environment do
	LevelDBHandler.new("db_name").fetch
  end

  task :flush => :environment do
	LevelDBHandler.new("db_name").flush
  end
end

namespace :user do
  task :fetch => :environment do
	LevelDBHandler.new("user_db_name").fetch
  end

  task :flush => :environment do
	LevelDBHandler.new("user_db_name").flush
  end
end