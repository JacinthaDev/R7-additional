require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      product_name: "MyString",
      product_count: 1,
      customer: nil
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input[name=?]", "order[product_name]"

      assert_select "input[name=?]", "order[product_count]"

      assert_select "input[name=?]", "order[customer_id]"
    end
  end
end
