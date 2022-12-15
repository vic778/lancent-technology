require 'swagger_helper'

RSpec.describe 'api/purchases', type: :request do
  path '/api/purchases' do
    post 'Create a purchase' do
      tags 'Purchases'
      security [bearer_auth: []]
      consumes 'application/json'

      parameter name: :purchase, in: :body, schema: {
        type: :object,
        properties: {
          product_id: { type: :integer }
        },
        required: %w[user_id product_id price]
      }

      response '200', 'purchase created' do
        let(:user) { User.create(email: "barhvictor@gmail.com", date_of_birth: "1990-01-01", password: "123456", password_confirmation: "123456") }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }
        let(:product) { Product.create(name: "test", price: 100) }
        let(:purchase) { Purchase.create(user_id: user.id, product_id: product.id, price: 100) }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['success']).to eq(true)
          expect(data['message']).to eq('Purchase successful')
          expect(data['data']['point']) == 100
        end
      end

      response '422', 'invalid request' do
        let(:user) { User.create(email: "barh@gmail.com", date_of_birth: "1990-01-01", password: "123456", password_confirmation: "123456") }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }
        let(:purchase) { Purchase.create(user_id: user.id, product_id: nil, price: nil) }
        # run_test!
      end
    end
  end
end
