class TelegramController < ApplicationController
  
  def show
    @me_info = @api.getMe
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

        if !(@db.get "ua_q1_#{callback_query.from.id}") || (@db.get "ua_q1_#{callback_query.from.id}").to_i < TimeFormatter.today_str.to_i
          # send updated message instead of showing keyboard markup
          @api.deleteMessage(callback_query.message.chat.id, callback_query.message.message_id)
          client.handle({message: {text: callback_query.data, chat: {id: callback_query.message.chat.id}}})
        end 

        # Store user_answer
        message = callback_query.message
        # @db.put "ua_q1_#{message.date}_#{callback_query.from.id}", "a_1" 
        @db.put "ua_q1_#{callback_query.from.id}", TimeFormatter.today_str
      end
    end

    @db.close 
  end
end
