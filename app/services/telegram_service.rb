class TelegramService
  include Telegram::Bot::ClientAccessors

  # this method will be called if /test string was found in message text
  def cmd_test
    @db = LevelDB::DB.new(ENV["qa_db_name"])
    keys = @db.keys
    qas = [] # collection question with answers

    index = 0
    keys.sort!
    keys.each do |key|
      index += 1 if key.include? "q#{index + 2}"
      qas[index] = {"q#{index + 1}": [] } unless qas[index]
      qas[index][:"q#{index + 1}"].push key if key.include? "q#{index + 1}_a"
    end
    qas.each do |qa|
      btns = []
      qa.values[0].each do |a|
        btns.push Telegram::Bot::Types::InlineKeyboardButton.new(text: "#{@db.get("#{a}").force_encoding('UTF-8')}", callback_data: "/#{a}")
      end

      api.sendMessage(message.chat.id, "#{@db.get("#{qa.keys[0]}").force_encoding('UTF-8')}", reply_markup:
          Telegram::Bot::Types::InlineKeyboardMarkup.new( [btns] ))
    end

    @db.close
    # api.sendMessage(message.chat.id, 'this is a test')
  end

  @db = LevelDB::DB.new(ENV["qa_db_name"]).keys.each do |key|
    if key.include? '_a'
      define_method "cmd_#{key}" do
        question = key.split('_').first.delete('q')
        answer = key.split('_').last.delete('a')
        api.sendMessage(message.chat.id, "Your answer for question #{question} is Option #{answer}")
      end
    end
  end

  # this method will be called if no command found
  def cmd_fallback
    # log message
  end
end