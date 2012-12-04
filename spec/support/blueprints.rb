require 'machinist/active_record'

Category.blueprint do
  name              { "category-#{sn}" }
  description       { "category description" }
end

Product.blueprint do
  name              { "product-#{sn}" }
  description       { "product description" }
  price             { 100 }
  quantity          { 10  }
end

Order.blueprint do
  token             { rand(2468**10).to_s(32) }
end

User.blueprint do
  email             { "test#{sn}@test.com" }
  password          { "secretssss" }
end

Address.blueprint do
  street_address    { "street-#{sn}" }
  city              { "city-#{sn}" }
  state             { "state-#{sn}" }
  zip               { sn }
  country           { "country-#{sn}" }
  phone             { sn }
  email             { "email-#{sn}@test.com" }
  user_id           { User.make }
end 
