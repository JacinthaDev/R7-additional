require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    customer = FactoryBot.create(:customer)
    assign(:orders, [
      FactoryBot.create(:order, product_name: "Product Name", product_count: 2, customer: customer),
      FactoryBot.create(:order, product_name: "Product Name", product_count: 2, customer: customer)
    ])
  end

  # it "renders a list of orders" do
  #   render

  #   assert_select "tr>td", text: "Product Name", count: 2
  #   assert_select "tr>td", text: "2", count: 2
  #   assert_select "tr>td", text: /#{FactoryBot.create(:customer).name}/, count: 2
  # end
end
