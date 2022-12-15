require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string },
              date_of_birth: { type: :date },
              password: { type: :string },
              password_confirmation: { type: :string }
            },
            required: %w[email password date_of_birth password_confirmation]
          }
        },
        required: ['user']
      }

      response '200', 'user created' do
        let(:user) { { user: { email: 'barhvictor@gmail.com', date_of_birth: '1990-01-01', password: '123456', password_confirmation: '123456' } } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['title']) == ("Registration Successful")
          expect(data['message']) == ("Thank you for joining Perx Technologies platform, please check your email and verify your account!")
        end
      end

      response '422', 'invalid request' do
        let(:user) { { user: { email: 'foo' } } }
        run_test!
      end
    end

    path '/api/users/login' do
      post 'Logs in a user' do
        tags 'Users'
        consumes 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            user: {
              type: :object,
              properties: {
                email: { type: :string },
                password: { type: :string }
              },
              required: %w[email password]
            }
          },
          required: ['user']
        }

        response '200', 'user logged in' do
          # create a user
          let(:user) { { user: { email: 'barhvictor@gmail.com', date_of_birth: '1990-01-01', password: '123456', password_confirmation: '123456' } } }
          # login the user
          # let(:user) { { user: { email: 'barhvictor@gmail.com', password: '123456' } } }
          # run_test! do |response|
          #   data = JSON.parse(response.body)
          # expect(data['success']).to eq(true)
          # expect(data['message']).to eq('Login successful')
          # expect(data['data']['token']).to be_present
          # end
        end

        response '422', 'invalid request' do
          let(:user) { { user: { email: 'barhvictor@gmail.com', password: '123456' } } }
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['success']) == false
            expect(data['message']) == ('Invalid email or password')
          end
        end
      end
    end
  end
end
