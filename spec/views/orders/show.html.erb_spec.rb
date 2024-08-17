require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    assign(:order, Order.create!(
      product_name: "Product Name",
      product_count: 2,
      customer: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Product Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
