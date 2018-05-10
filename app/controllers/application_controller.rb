require 'leveldb'

class ApplicationController < ActionController::Base
  before_action :set_telegram_bot
  
  def set_telegram_bot
    @api = Telegram::Bot::Api.new(ENV['telegram_bot_token'])
    @db = LevelDB::DB.new ENV["db_name"]
  end
end
