require 'telegram/bot'
    
Telegram::Bot.configure do |conf|
    conf.token = ENV['telegram_bot_token']

    conf.raise_exceptions = false #By default true
    conf.name = '@colinvn_lottery_bot'
    # conf.botan_token = 'Botan token' #If using botan.io
end