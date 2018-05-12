class UserHandler
  def initialize db
    @db = db
  end

  def store user
    @db.put "#{user.id}", "#{user.first_name} #{user.last_name}" unless @db.get "#{user.id}"
  end

  def get_user uuid
    @db.get "#{uuid}"
  end
end