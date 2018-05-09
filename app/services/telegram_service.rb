class TelegramService
  include Telegram::Bot::ClientAccessors

  # this method will be called if /test string was found in message text
  def cmd_test
    # api.sendMessage(message.chat.id, 'Yes, it is test')

    # Question 1    
    btn1 = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Q1 - Option 1', callback_data: '/q1_a1')
    btn2 = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Q1 - Option 2', callback_data: '/q1_a2')
    api.sendMessage(message.chat.id, 'Please answer Question 1', reply_markup: 
      Telegram::Bot::Types::InlineKeyboardMarkup.new( [[btn1, btn2]] ))
  end
  
  # def cmd_q1_a1
    
  #   p "cmd_q1_a1"
  #   api.sendMessage(message.chat.id, 'Your answer for first question is Option 1')
  # end
  
  # def q1_a1
  #   p "qa a1"
  # end
  
  def cmd_q1_a2
    api.sendMessage(message.chat.id, 'Your answer for first question is Option 2')
  end

  # this method will be called if no command found
  def cmd_fallback
    # log message
  end
end