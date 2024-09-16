require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do
  let!(:customer) { FactoryBot.create(:customer) }

  describe "GET /orders" do
    it "renders the index view" do
      FactoryBot.create_list(:order, 10, customer: customer)
      get orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /orders/:id" do
    context "when the order ID is valid" do
      let!(:order) { FactoryBot.create(:order, customer: customer) }

      it "renders the show view" do
        get order_path(order.id)
        expect(response).to render_template(:show)
      end
    end

    context "when the order ID is invalid" do
      it "redirects to the index path" do
        invalid_id = Order.maximum(:id).to_i + 1 
        get order_path(invalid_id)
        expect(response).to redirect_to(orders_path)
        expect(flash[:alert]).to eq("Order not found.") 
      end
    end
  end

  describe "GET /orders/new" do
    it "renders the :new template" do
      get new_order_path
      expect(response).to render_template(:new)
    end
  end

  describe "GET /orders/:id/edit" do
    let!(:order) { FactoryBot.create(:order, customer: customer) }

    it "renders the :edit template" do
      get edit_order_path(order.id)
      expect(response).to render_template(:edit)
    end
  end

  describe "POST /orders" do
    context "with valid data" do
      it "saves a new entry and redirects to the show path for the entry" do
        order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
        expect { post orders_path, params: { order: order_attributes } }.to change(Order, :count).by(1)
        expect(response).to redirect_to order_path(Order.last.id)
      end
    end

    context "with invalid data" do
      it "does not save a new entry or redirect" do
        order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
        order_attributes[:product_name] = nil
        expect { post orders_path, params: { order: order_attributes } }.to_not change(Order, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {product_count: 50}}
      order.reload
      expect(order.product_count).to eq(50)
      expect(response).to redirect_to("/orders/#{order.id}")
    end
  end
  describe "put order_path with invalid data" do
    it "does not update the customer record or redirect" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {customer_id: 5001}}
      order.reload
      expect(order.customer_id).not_to eq(5001)
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE /orders/:id" do
    it "deletes an order record" do
      order = FactoryBot.create(:order, customer: customer)
      expect { delete order_path(order.id) }.to change(Order, :count).by(-1)
      expect(response).to redirect_to orders_path
    end
  end
end
