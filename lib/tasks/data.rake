require 'leveldb'

namespace :data do
  desc "Create sample question and answer"
  task :sample => :environment do
	@db = LevelDB::DB.new ENV["db_name"]
	@db.put "q1", "1. Kyber là sàn tập trung hay phi tập trung?"
	@db.put "q1_a1", "Tập trung"
	@db.put "q1_a2", "Phi tập trung"
	@db.put "q1_correct_answer", "Phi tập chung"

	@db.put "q2", "2. Kyber được tích hợp vào ví nào?"
	@db.put "q2_a1", "MEW"
	@db.put "q2_a2", "Metamask"
	@db.put "q2_correct_answer", "MEW"

	@db.put "q3", "3. Có cần deposit token khi giao dịch trên Kyber không?"
	@db.put "q3_a1", "Có"
	@db.put "q3_a2", "Không"
	@db.put "q3_correct_answer", "Có"
  end

  task :fetch => :environment do
	@db = LevelDB::DB.new "my-telegram-db"
	@db.each { |k, v| puts "--- #{k}: #{v}"}
  end

  task :flush => :environment do 
  	@db = LevelDB::DB.new "my-telegram-db"
	@db.keys.each { |key| @db.delete(key)}
  end
end