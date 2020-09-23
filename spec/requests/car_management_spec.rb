require 'rails_helper'

describe 'Car management' do
  context 'index' do
    it 'renders available cars' do
      car_model = create(:car_model)
      create(:car, license_plate: 'AAA1111', color: 'Preto', car_model: car_model, status: :available)
      create(:car, license_plate: 'BBB2222', color: 'Vermelho', car_model: car_model, status: :rented)
      create(:car, license_plate: 'CCC3333', color: 'Prata', car_model: car_model, status: :available)

      get '/api/v1/cars'

      expect(response).to have_http_status(200)
      expect(response.body).to include('AAA1111')
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[1][:license_plate]).to eq('CCC3333')
    end

    it 'renders empty json' do
      get '/api/v1/cars'

      response_json = JSON.parse(response.body)
      expect(response).to be_ok
      expect(response.content_type).to include('application/json')
      expect(response_json).to be_empty
    end
  end

  context 'GET /api/v1/car/:id' do
    context 'record exists' do
      let(:car) { create(:car, license_plate: 'CCC3333', color: 'Prata', mileage: 1207, status: :available) }

      it 'returns 200 status' do
        get api_v1_car_path(car)

        expect(response).to be_ok
      end

      it 'returns car' do
        get api_v1_car_path(car)

        response_json = JSON.parse(response.body, symbolize_names: true)
        expect(response_json[:license_plate]).to eq(car.license_plate)
        expect(response_json[:color]).to eq(car.color)
        expect(response_json[:mileage]).to eq(car.mileage)
      end
    end

    context 'record not exist' do
      it 'returns status code 404' do
        get api_v1_car_path(1234)

        expect(response).to be_not_found
      end

      it 'returns status code 404' do
        get api_v1_car_path(1234)

        expect(response.body).to include('Carro não encontrado')
      end
    end

    context 'POST /cars' do
      context 'with valid params' do
        let(:car_model) { create(:car_model) }
        let(:attributes) { attributes_for(:car, car_model_id: car_model.id) }

        it 'returns 201 status' do
          post '/api/v1/cars', params: { car: attributes }

          expect(response).to be_created
        end

        it 'creates a car' do
          post '/api/v1/cars', params: { car: attributes }

          car = JSON.parse(response.body, symbolize_names: true)
          expect(car[:id]).to be_present
          expect(car[:license_plate]).to eq(attributes[:license_plate])
          expect(car[:color]).to eq(attributes[:color])
          expect(car[:car_model_id]).to eq(attributes[:car_model_id])
          expect(Car.all.count).to eq(1)
        end
      end

      context 'with invalid params' do
        it 'without car key' do
          post '/api/v1/cars'

          expect(response).to have_http_status(:precondition_failed)
          expect(response.body).to include('Parâmetros inválidos')
        end

        it 'without required params' do
          post '/api/v1/cars', params: { car: { foo: 'bar' } }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include('Placa não pode ficar em branco')
          expect(response.body).to include('Cor não pode ficar em branco')
          expect(response.body).to include('Modelo de carro é obrigatório(a)')
        end
      end
    end
  end
end
