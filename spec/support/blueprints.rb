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
  category          { object.category || Category.make! }
end

Order.blueprint do
  token             { rand(2468**10).to_s(32) }
  address           { object.address || Address.make! }
end

Item.blueprint do
  quantity          { 1 }
  product           { object.product || Product.make! }
  order             { object.order || Order.make! }
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
  phone             { sn }
  email             { "email-#{sn}@test.com" }
  user              { object.user || User.make! }
  country           { object.country || Country.make! }
end

Country.blueprint do
  name              { "country-#{sn}" }
end
