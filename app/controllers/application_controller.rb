require 'leveldb'

class ApplicationController < ActionController::Base
  before_action :set_telegram_bot
  
  def set_telegram_bot
    @api = Telegram::Bot::Api.new('528099473:AAEn19WxEKBB6MEmhA87NWAO5shNsEXWhUc')

    #TODO: change this to setting var
    @db = LevelDB::DB.new ENV["db_name"]
    #api.getMe
  end
end
