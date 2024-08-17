require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { Order.new(product_name: "Tate's Cookies", product_count: 10, customer_id: "1")}
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
  it "is not valid with a non-existent customer" do
    # Assuming there's a Customer model and a valid customer_id should exist
    allow(Customer).to receive(:find_by).with(id: subject.customer_id).and_return(nil)
    expect(subject).to_not be_valid
  end
end
