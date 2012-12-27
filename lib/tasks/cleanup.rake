task :clean_up_cart => :environment do
  Order.where("state = 'cart' and updated_at < ?", 2.week.ago).destroy_all
  puts "Clean up successed"
end
