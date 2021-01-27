class AggregateJob < ApplicationJob
  require 'selenium-webdriver'
  require 'csv'
  require 'pry'
  queue_as :default

  def perform(*args)
    subscription = Subscription.all[0]
    driver = Selenium::WebDriver.for :chrome
    driver.get "https://e-mdl.kure-nct.ac.jp/login/index.php"

    query = driver.find_element(:id, 'username')
    query.send_keys(subscription.username)

    query = driver.find_element(:id, 'password')
    query.send_keys(subscription.password)

    driver.find_element(:id, "loginbtn").click

    driver.get subscription.url
    driver.find_element(:xpath, '//*[@id="region-main"]/div/form[1]/div/input[5]').click

    sleep 5

    driver.find_element(:xpath, '//*[@id="region-main"]/div/form[2]/div/label/input').click

    sleep 5

    month = Date.today.month.to_s
    day = Date.today.day.to_s
    year = Date.today.year.to_s
    time = Time.now.strftime("%Y%m%d")

    csv_file_path = Dir.glob("/Users/moriyamatakamasa/Downloads/logs_" + time + '*').last
    csv_file = CSV.read(csv_file_path)

    logname = subscription.logname + ' ' + month + '月' + day + '日'
    log = Log.create(name: logname)
    num = 0

    csv_file.each do |row|
      if num == 0
        num = num + 1
      else
        elements = Element.new
        elements.log_id = log.id
        elements.time = row[0]
        elements.name = row[1]
        elements.event_context = row[3]
        elements.event = row[5]
        elements.save
      end
    end
  end
end
