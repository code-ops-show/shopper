require 'machinist/active_record'

Address.blueprint do
  street_address    { "street-#{sn}" }
  city              { "city-#{sn}" }
  state             { "state-#{sn}" }
  zip               { sn }
  phone             { sn }
  country           { object.country || Country.make! }
  user              { object.user || User.make! }
end

Category.blueprint do
  name              { "category-#{sn}" }
  description       { "category description" }
end

Country.blueprint do
  name              { "country-#{sn}" }
  shipping_rate     { object.shipping_rate || ShippingRate.make! }
end

Guest.blueprint do
  name              { "Guest" }
  email             { "guest#{sn}@test.com" }
  password          { "secretssss" }
  type              { "Guest" }
end

Item.blueprint do
  quantity          { 1 }
  product           { object.product || Product.make! }
  order             { object.order || Order.make! }
end

Member.blueprint do
  name              { "Member" }
  email             { "member#{sn}@test.com" }
  password          { "secretssss" }
  type              { "Member" }
end

Order.blueprint do
  token             { rand(2468 ** 10).to_s(32) }
  address           { object.address || Address.make! }
end

Product.blueprint do
  name              { "product-#{sn}" }
  description       { "product description" }
  price             { 100 }
  quantity          { 10 }
  category          { object.category || Category.make! }
end

ShippingRate.blueprint do
  name              { "shipping-#{sn}" }
  rate              { 100 }
end

User.blueprint do
  name              { "User" }
  email             { "test#{sn}@test.com" }
  password          { "secretssss" }
end

######################
## Item with Member ##
######################

Address.blueprint(:member) do
  street_address    { "street-#{sn}" }
  city              { "city-#{sn}" }
  state             { "state-#{sn}" }
  zip               { sn }
  phone             { sn }
  country           { object.country || Country.make! }
  user              { object.user || Member.make! }
end

Item.blueprint(:member) do
  quantity          { 1 }
  product           { object.product || Product.make! }
  order             { object.order || Order.make!(:member) }
end

Order.blueprint(:member) do
  token             { rand(2468 ** 10).to_s(32) }
  address           { object.address || Address.make!(:member) }
end

#######################
## Item without User ##
#######################

Address.blueprint(:no_user) do
  street_address    { "street-#{sn}" }
  city              { "city-#{sn}" }
  state             { "state-#{sn}" }
  zip               { sn }
  phone             { sn }
  country           { object.country || Country.make! }
end

Item.blueprint(:no_user) do
  quantity          { 1 }
  product           { object.product || Product.make! }
  order             { object.order || Order.make!(:no_user) }
end

Order.blueprint(:no_user) do
  token             { rand(2468 ** 10).to_s(32) }
  address           { object.address || Address.make!(:no_user) }
end

##########################
## Order and Items Only ##
##########################

Item.blueprint(:only) do
  quantity          { 1 }
  product           { object.product || Product.make! }
  order             { object.order || Order.make!(:only) }
end

Order.blueprint(:only) do
  token             { rand(2468 ** 10).to_s(32) }
  address           { nil }
end
