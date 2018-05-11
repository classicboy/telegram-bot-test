require 'leveldb'

class MessageHandler
  
  def initialize client, api, db, message = ''
    @message = message
    @db = db
    @api = api
    @client = client
  end

  def cmd_test
    return unless @message.text.include? '/test'

    lastest_message_id = @db.get("uq_#{TimeFormatter.today_str}_#{@message.from.id}")
    if lastest_message_id
      return if lastest_message_id.to_i >= @message.message_id.to_i
      @api.sendMessage(@message.chat.id, 'Please comback tomorrow')
    else
      @client.handle({message: {text: @message.text, chat: {id: @message.chat.id}}})
    end

    @db.put "uq_#{TimeFormatter.today_str}_#{@message.from.id}", "#{@message.message_id}"
  end

  # BEING IN PROGRESS
  def cmd_result
    return unless @message.text.include? '/result'
    
    user_answers = {}
    @db.each { |k, v| user_answers[k.split('_').last] = v if k.include? "ua_#{TimeFormatter.today_str}" }

    correct_answers = []
    qa_db = LevelDB::DB.new ENV["qa_db_name"]
    qa_db.each { |k, v|  correct_answers.push v if k.include? 'correct_answer' }
    qa_db.close

    correct_user_answers = []

    # Find user id who has correct answer
    user_answers.each do |k,v|
      is_correct = true
      correct_answers.each do |a|
        is_correct = false unless v.include? a
      end

      correct_user_answers.push k if is_correct
    end

    p " correct_user_answers: #{correct_user_answers} "

    # TODO: store user information to show on telegram chat box

    # TODO: select random 3 users & store selected ones for the day
  end

end

namespace :telegram do
  desc "update telegram"
  task update: :environment do
    @api = Telegram::Bot::Api.new(ENV['telegram_bot_token'])
    @db = LevelDB::DB.new ENV["db_name"]
    @updates = @api.getUpdates

    client = Telegram::Bot::Client.new(TelegramService)

    @updates.reverse.each do |update|
      if message = update.message
        message_handler = MessageHandler.new(client, @api, @db, message)
        message_handler.cmd_test
        message_handler.cmd_result
      elsif callback_query = update.callback_query
        # Store user_answer
        today_user_answer = @db.get("ua_#{TimeFormatter.today_str}_#{callback_query.from.id}").to_s
        if !today_user_answer.include?(callback_query.data.delete('/'))
          today_user_answer += "#{callback_query.data.delete('/')}."
          # send updated message instead of showing keyboard markup
          @api.deleteMessage(callback_query.message.chat.id, callback_query.message.message_id)
          client.handle({message: {text: callback_query.data, chat: {id: callback_query.message.chat.id}}})
        end

        @db.put "ua_#{TimeFormatter.today_str}_#{callback_query.from.id}", today_user_answer
      end
    end

    @db.close
  end
end
