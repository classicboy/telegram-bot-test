require 'telegram/bot'
    
Telegram::Bot.configure do |conf|
    conf.token = '528099473:AAEn19WxEKBB6MEmhA87NWAO5shNsEXWhUc'
    conf.raise_exceptions = false #By default true
    conf.name = '@colinvn_lottery_bot'
    # conf.botan_token = 'Botan token' #If using botan.io
end