require 'leveldb'

namespace :telegram do
  desc "Create sample question and answer"
  task :sample_data => :environment do
    db = LevelDB::DB.new("my-database.db")
    db.put "question1", "Question 1 Content"
    db.put "q1_a1", "For Question 1, You choose - Option 1"
    db.put "q1_a2", "Question 1 - Option 2"
    
    sleep 0.5
    db.close()
  end
end