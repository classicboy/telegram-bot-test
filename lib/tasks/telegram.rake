require 'leveldb'

namespace :telegram do
  desc "update telegram"
  task update: :environment do
    @api = Telegram::Bot::Api.new(ENV['telegram_bot_token'])
    @db = LevelDB::DB.new ENV["db_name"]
    @updates = @api.getUpdates

    client = Telegram::Bot::Client.new(TelegramService)

    @updates.reverse.each do |update|
      if message = update.message
        next unless update.message.text.include? '/test'
        lastest_message_id = @db.get("uq_#{TimeFormatter.today_str}_#{message.from.id}")
        if lastest_message_id
          next if lastest_message_id.to_i >= message.message_id.to_i
          @api.sendMessage(message.chat.id, 'Please comback tomorrow')
        else
          client.handle({message: {text: update.message.text, chat: {id: update.message.chat.id}}})
        end

        # Store user question
        @db.put "uq_#{TimeFormatter.today_str}_#{message.from.id}", "#{message.message_id}"
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