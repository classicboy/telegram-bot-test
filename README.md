# QuyetDC - Telegram bot Test 

# Gem

```
gem 'telegram-ruby'
gem 'leveldb-ruby'
```

# Data

- I defined some sample questions in `db/seeds.rb` file. You can run `rake db:seed`

# Cronjob

- We use `sidekiq` + `whenever` to run cronjob. Check `Gemfile` for more detail.
- We will need redis installed. Just follow this article: `https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04`
- You can update cronjob by running: `whenever --update-crontab` 
    or view cronjob of system by `crontab -l`
    or remove cronjob by `crontab -r`
- To run sidekiq `bundle exec sidekiq`
- To view sidekiq web `localhost/sidekiq`



-----------------------------------------

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