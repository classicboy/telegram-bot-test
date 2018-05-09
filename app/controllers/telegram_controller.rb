class TelegramController < ApplicationController
  
  def show
    @me_info = @api.getMe
    @updates = @api.getUpdates

    client = Telegram::Bot::Client.new(TelegramService)

    @updates.each do |update|
      if message = update.message
        p "update - normal message - #{update.message.as_json}"

        # Check if user has been shown the questions today or not
        # if not, do below
        unless @db.get("uq_#{message.date}_#{message.from.id}")
          client.handle({message: {text: update.message.text, chat: {id: update.message.chat.id}}})
          @db.put "uq_#{message.date}_#{message.from.id}", "yes"
        end
      elsif callback_query = update.callback_query
        p "callback query - #{callback_query.as_json}"
        binding.pry

        @api.deleteMessage(callback_query.message.chat.id, callback_query.message.message_id)
        msg_content = @db.get("#{callback_query.data.delete '/'}")
        @api.sendMessage(callback_query.message.chat.id, msg_content )



        # DB
        # questions
        # q_1, id, name, description
        
        # answers
        # a_1, id, callback_data, question

        # user_answers
        # u_a_1 telegram_uuid, question id, answer id, time, chatid

        # user_questions
        # uq_uuid, date, yes
      end
          
    end

  end
end
