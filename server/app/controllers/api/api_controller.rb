module Api
  # API共通コントローラ
  class ApiController < ApplicationController
    protect_from_forgery

    def response_hash(hash)
      render json: hash
    end

    def response_data(data)
      response_hash data: data
    end
  end
end
