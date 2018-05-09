require 'leveldb'

class ApplicationController < ActionController::Base
  before_action :set_telegram_bot
  
  def set_telegram_bot
    @api = Telegram::Bot::Api.new('528099473:AAEn19WxEKBB6MEmhA87NWAO5shNsEXWhUc')
    @db = LevelDB::DB.new "my-telegram-db"
    #api.getMe
  end
end
