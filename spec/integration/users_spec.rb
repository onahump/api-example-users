# spec/integration/pets_spec.rb
require 'swagger_helper'
  describe 'Users API' do
  path '/api/v1/users' do
  	post 'Creates a user' do
    tags 'Users'
    consumes 'application/json', 'application/xml'
    parameter name: :user, in: :body, schema: {
      type: :object,
      properties: {
        name: { type: :string },
        password: { type: :string },
        }, required: [ 'name', 'password' ]
      }

      response '201', 'user created' do
        let(:user) { { name: 'Dodo', password: 'hola' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
        properties: {
          id: { type: :integer },
          name: { type: :string },
          password: { type: :string }
          },
          required: [ 'id', 'password']

          let(:id) { User.create(name: 'foo', password: 'bar').id }
          run_test!
        end

        response '404', 'user not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
  end