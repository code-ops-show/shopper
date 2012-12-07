task :clean_up_cart => :environment do
  Order.where("updated_at < ?", 2.week.ago).destroy_all
  puts "Clean up successed"
end
