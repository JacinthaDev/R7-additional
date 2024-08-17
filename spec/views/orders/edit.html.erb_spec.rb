require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  let(:order) {
    Order.create!(
      product_name: "MyString",
      product_count: 1,
      customer: nil
    )
  }

  before(:each) do
    assign(:order, order)
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(order), "post" do

      assert_select "input[name=?]", "order[product_name]"

      assert_select "input[name=?]", "order[product_count]"

      assert_select "input[name=?]", "order[customer_id]"
    end
  end
end
