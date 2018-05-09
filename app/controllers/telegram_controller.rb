class TelegramController < ApplicationController
  
  def show
    @me_info = @api.getMe
    @updates = @api.getUpdates

    client = Telegram::Bot::Client.new(TelegramService)

    @updates.each do |update|
      if message = update.message
        p "update - normal message - #{update.message.as_json}"

        # Check if user has been shown the questions today or not
        # uq: user question
        # if @db.get("uq_#{message.date}_#{message.from.id}")
          # TODO send msg inform user that user tested today
        # else
          client.handle({message: {text: update.message.text, chat: {id: update.message.chat.id}}})
          @db.put "uq_#{message.date}_#{message.from.id}", "yes"
        # end
      elsif callback_query = update.callback_query
        p "callback query - #{callback_query.as_json}"

        # send updated message instead of showing keyboard markup
        @api.deleteMessage(callback_query.message.chat.id, callback_query.message.message_id)
        client.handle({message: {text: callback_query.data, chat: {id: callback_query.message.chat.id}}})

        # TODO: store user_answer
        # user_answers
        # u_a_1 telegram_uuid, question id, answer id, date
        message = callback_query.message
        # @db.put "ua_#{message.date}_#{callback_query.from.id}", "yes"

        # TODO: Store user in correct_answer of user_answers key

        # TODO: migration to create questions, answer to show user
        # DB
        # questions
        # q_1, id, name, description
        
        # answers
        # a_1, id, callback_data, question
      end
          
    end

  end
end
