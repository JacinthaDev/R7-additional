require 'rails_helper'

RSpec.describe "orders/show" do
  let(:customer) { FactoryBot.create(:customer) }
  let(:order) { FactoryBot.create(:order, customer: customer) }

  before(:each) do
    assign(:order, order)
  end

end
