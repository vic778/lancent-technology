class UsersController < PermissionsController
  before_action :authenticate_user!

  def show; end

  def check_birth_date
    user = current_user
    user.date_of_birth.day == Time.now.day && user.date_of_birth.month == Time.now.month if user.date_of_birth
    user.rewards.create(reward_type: 'Coffee')
  end

  def update
    if current_user.update!(user_params)
      render json: {
        user: current_user
      }
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  def auto_login
    render json: {
      user: current_user,
      point: current_user.point || nil,
      talent: current_user.purchase || nil
    }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :date_of_birth, :location)
  end
end
