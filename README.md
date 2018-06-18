# QuyetDC - Telegram bot Test 

# Gem

```
gem 'telegram-ruby'
gem 'leveldb-ruby'
```

# Data

Rake task is defined in `lib/tasks/*.rake`

There are three database

#### question - answers database

Sample data can be generated using `rake qa:sample`

Data can be fetched using `rake qa:fetch`

To flush data `rake qa:flush`

#### user database

Data can be fetched using `rake user:fetch`

To flush data `rake user:flush`

#### users' answers database

Data can be fetched using `rake data:fetch`

To flush data `rake data:flush`

# How to

Please create a telegram bot first, or use mine 

```
https://web.telegram.org/#/im?p=@third_colinvn_bot
```

Please do set your bot test API key in `config/application.yml`

For now, there's no polling job or webhook yet.
Run 
```rake telegram:update```
to pull new updates from Telegram and send replies to Telegram users

On telegram, run: 
```/test```
to get questions, or
```/result KyberNetwork```
To know today result

# Source code

Source code are mainly in `lib/tasks` and `app/services`