class UserController < ActionController::API

  def initialize
    @user_model = UserModel.new
  end

  def all
    user = @user_model.all

    if user.size == 0
      return render json: {
          status: false,
          message: "User Not Found",
          data: nil
      }
    end

    render json: {
        status: true,
        message: "Success get users",
        data: user
    }
  end

  def detail

    user = @user_model.detail id: params[:personId]

    if user == nil
      return render json: {
          status: false,
          message: "User Not Found",
          data: nil
      }
    end

    render json: {
        status: true,
        message: "Success get users",
        data: user
    }
  end
end