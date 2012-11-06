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

  Cart.blueprint do
    token             { rand(2468**10).to_s(32) }
  end

  User.blueprint do
    email             { "test#{sn}@test.com" }
    password          { "secretssss" }
  end
