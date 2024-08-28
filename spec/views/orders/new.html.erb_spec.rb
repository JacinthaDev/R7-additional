require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  let(:customer) { FactoryBot.create(:customer) }

  before(:each) do
    assign(:order, Order.new)
  end

  it "renders the new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do
      assert_select "input[name=?]", "order[product_name]"
      assert_select "input[name=?]", "order[product_count]"
      assert_select "select[name=?]", "order[customer_id]"
    end
  end
end
