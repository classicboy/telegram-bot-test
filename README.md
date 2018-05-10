# QuyetDC - Telegram bot Test 

# Gem

```
gem 'telegram-ruby'
gem 'leveldb-ruby'
```

# BOT test url

```
https://web.telegram.org/#/im?p=@second_colinvn_bot
```

# Sample Data

Rake task is defined in `lib/tasks/data.rake`

There are two database

#### question - answers database

Sample data can be generated using `rake qa:sample`

Data can be fetched using `rake qa:fetch`

To flush data `rake qa:flush`

#### users' answers database

Data can be fetched using `rake data:fetch`

To flush data `rake data:flush`
