module Api
  # ユーザ登録API
  class UsersController < ApiController
    def create
      load_new_user
      raise_api_error :invalid_param if @user.invalid?
      raise_api_error :system_error unless @user.save
      response_success @user.identifier
    end

    private

    def load_new_user
      @user = User.new(user_params)
    end

    def user_params
      params.permit(:gender, :year_of_birth, :prefecture)
    end
  end
end
