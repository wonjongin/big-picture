require 'swagger_helper'

RSpec.describe 'basic', type: :request do

  path '/basic/index' do

    get('index basics') do
      tags 'Basics'
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
      tags 'Basics'
      produces 'application/json'
      request_body_example value: { text: 'Foo' }, name: 'basic', summary: 'Request example description'
      response(200, 'successful') do
        let(:text) { 'Hello world!' }

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
        # run_test!
        it 'should response now time' do |example|
          puts example.metadata
          expect(1).to eq 1
        end
      end
    end
  end
end
