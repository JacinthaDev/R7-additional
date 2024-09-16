require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { Order.new( product_name: "gears", product_count: 7, customer: FactoryBot.create(:customer))}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a product name" do
    subject.product_name = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a product count" do
    subject.product_count = nil
    expect(subject).to_not be_valid
  end
  it "is not valid with a non-integer product count" do
    subject.product_count = "ten"
    expect(subject).to_not be_valid
  end
  it "is not valid without an associated customer" do
    subject.customer_id = nil
    expect(subject).to_not be_valid
  end
  context "when created with a non-existent customer" do
    it "is not valid" do
      order = Order.new(product_name: "gears", product_count: 7, customer_id: 1)
      expect(order).to_not be_valid
      expect(order.errors[:customer]).to include("must exist")
    end
  end
end
