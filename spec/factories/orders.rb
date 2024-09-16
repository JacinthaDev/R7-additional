FactoryBot.define do
  factory :order do
    product_name { "MyString" }
    product_count { 1 }
    association :customer
  end
end
