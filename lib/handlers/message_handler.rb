
class MessageHandler
  def initialize client, api, db, message = ''
    @message = message
    @db = db
    @api = api
    @client = client    
  end

  def cmd_test
    return unless @message.text.include? '/test'

    #TODO: we need to check which date the message sent

    lastest_message_id = @db.get("uq_#{TimeFormatter.today_str}_#{@message.from.id}")
    if lastest_message_id
      return if lastest_message_id.to_i >= @message.message_id.to_i
      @api.sendMessage(@message.chat.id, 'Please comback tomorrow')
    else
      @client.handle({message: {text: @message.text, chat: {id: @message.chat.id}}})
    end

    @db.put "uq_#{TimeFormatter.today_str}_#{@message.from.id}", "#{@message.message_id}"
  end

  def cmd_result
    return unless @message.text.include? '/result'
    
    password = @message.text.gsub '/result', ''
    if password == ENV['password']
      user_answers = {}
      @db.each { |k, v| user_answers[k.split('_').last] = v if k.include? "ua_#{TimeFormatter.today_str}" }

      correct_answers = []
      qa_db = LevelDB::DB.new ENV["qa_db_name"]
      qa_db.each { |k, v|  correct_answers.push v if k.include? 'correct_answer' }
      qa_db.close

      correct_user_answers = []

      user_answers.each do |k,v|
        is_correct = true
        correct_answers.each do |a|
          is_correct = false unless v.include? a
        end

        correct_user_answers.push k if is_correct
      end
      return correct_user_answers.sample(3)  
    else 
      return nil
    end
  
  end

end
