require 'swagger_helper'

RSpec.describe 'basic', type: :request do

  path '/basic/index' do

    get('list basics') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/basic/index/{text}' do
    # You'll want to customize the parameter types...
    parameter name: 'text', in: :path, type: :string, description: 'text'

    get('list basics') do
      response(200, 'successful') do
        let(:text) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/basic/time' do

    get('time basic') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
