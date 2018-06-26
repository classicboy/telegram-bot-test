class CronJob
  include Sidekiq::Worker
  def perform
    logger = Logger.new("#{Rails.root}/log/cron_job.log")
    logger.info("Cronjob was run at: #{Time.now}")
  end
end