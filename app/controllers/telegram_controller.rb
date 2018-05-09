class TelegramController < ApplicationController
  
  def show
    @me_info = @api.getMe
    @updates = @api.getUpdates

    client = Telegram::Bot::Client.new(TelegramService)

    @updates.each do |update|
      # p "update - #{update.as_json}"
      
      if update.message
        client.handle({message: {text: update.message.text, chat: {id: update.message.chat.id}}})
      elsif callback_query = update.callback_query
        @api.deleteMessage(callback_query.message.chat.id, callback_query.message.message_id)
        
        msg_content = @db.get("#{callback_query.data.delete '/'}")
        sleep 0.5
        @db.close
        @api.sendMessage(callback_query.message.chat.id, msg_content )


        # DB
        # questions
        # id, name, description
        
        # answer
        # id, callback_data, question
      end
          
    end

  end
end
