class AuthController < ActionController::API

  def initialize
    @user_model = UserModel.new
  end

  private def validate_signin

    unless Utils.is_email params[:email]
      return {
          status: false,
          message: "Email format is invalid"
      }
    end

    unless Utils.is_between params[:password], 4, 16
      return {
          status: false,
          message: "Password length must between 4 to 16 chars"
      }
    end

    { status: true }
  end

  private def validate_register

    valid = validate_signin

    unless valid[:status]
      return valid
    end

    if params[:address] == "" or params[:address] == nil
      return {
          status: false,
          message: "Address cant be empty"
      }
    end

    if params[:photo] == nil
      return {
          status: false,
          message: "Photo must not be null"
      }
    end

    { status: true }
  end

  def signin

    valid = validate_signin

    unless valid[:status]
      return render json: {
          status: false,
          message: valid[:message],
          data: nil
      }
    end

    user = @user_model.detail email: params[:email]

    if user == nil
      return render json: {
          status: false,
          message: "User not found",
          data: nil
      }
    end

    unless user["password"] == (Utils.encrypt params[:password])
      return render json: {
          status: false,
          message: "Password didn't match",
          data: nil
      }
    end

    render json: {
        status: true,
        message: "Success Signin",
        data: user
    }
  end

  def signup

    valid = validate_register

    unless valid[:status]
      return render json: {
          status: false,
          message: valid[:message],
          data: nil
      }
    end

    user = @user_model.detail email: params[:email]

    unless user == nil
      return render json: {
          status: false,
          message: "Email has been registered in another account",
          data: nil
      }
    end

    photo = Utils.upload params[:photo]
    password = Utils.encrypt params[:password]

    user = @user_model.insert params[:name], params[:email], password, params[:address], photo

    render json: {
        status: true,
        message: "Success Register",
        data: user
    }
  end
end