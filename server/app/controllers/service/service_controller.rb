module Service
  class ServiceController < ApplicationController
    before_action :authenticate_administrator!

    layout 'service/service'
  end
end
