require './lib/handlers/user_handler.rb'
require './lib/handlers/message_handler.rb'

require 'leveldb'

namespace :telegram do
  desc "update telegram"
  task update: :environment do
    @api = Telegram::Bot::Api.new(ENV['telegram_bot_token'])
    @db = LevelDB::DB.new ENV["db_name"]
    user_db = LevelDB::DB.new ENV["user_db_name"]

    @updates = @api.getUpdates

    client = Telegram::Bot::Client.new(TelegramService)
    user_handler = UserHandler.new(user_db)

    @updates.reverse.each do |update|
      if message = update.message
        message_handler = MessageHandler.new(client, @api, @db, message)
        message_handler.cmd_test
        
        if message.text.include? '/result'
          uuids = message_handler.cmd_result
          user_names = (uuids.map { |uid| user_handler.get_user uid}).join(', ')
          @api.sendMessage(message.chat.id, "Selected users are: #{user_names}")
        end
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

        # store user information
        user_handler.store callback_query.from
      end
    end

    user_db.close
    @db.close
  end
end
