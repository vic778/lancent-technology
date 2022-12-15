class PurchasesController < PermissionsController
  before_action :authenticate_user!

  def create
    @product = Product.find(purchase_params[:product_id])
    prod_price = @product.price
    @user = current_user
    @purchase = @user.purchases.create(product: @product, price: five_purcent_off?(prod_price))
    if @purchase.save
      # check if the price is more than 100
      create_point if prod_price >= 100
      render json: { success: true, message: 'Purchase successful', data: @purchase, point: sum_of_user_points }, status: :ok
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create_point
    @point = ge_user_points
    @user.points.create(point: @point)

    create_reward
    update_user_rule
    # expire_points
    bonus_points
  end

  def create_reward
    if check_user_points_for_coffee
      @user.rewards.create(reward_type: 'Coffee')
    else
      free_movie_ticket
      @user.rewards.create(reward_type: 'Ticket')
    end
  end

  def check_user_points_for_coffee
    @user.points.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).sum(:point) >= 100
  end

  def check_cash_reward
    transactions = 10
    purchase = @user.purchases.where(price: 100..200).count
    purchase >= transactions
  end

  def five_purcent_off?(price)
    return price unless check_cash_reward

    reward = price * 0.05
    price - reward
  end

  def free_movie_ticket
    @user.created_at > 60.days.ago && (@user.purchases.where(created_at: 60.days.ago..Time.now).sum(:price) > 1000)
  end

  def ge_user_points
    user_location = current_user.location
    point = 0
    if @product.price >= 100
      point += 10
      point *= 2 if user_location != 'singapore'
    end
    point
  end

  def update_user_rule
    if sum_of_user_points >= 1000
      current_user.update(rule: 'gold')
      louange_access_reward_to_gold_user
    end
    current_user.update(rule: 'platinum') if sum_of_user_points >= 5000
  end

  def sum_of_user_points
    current_user.points.sum(:point)
  end

  # Points expire every year
  def expire_points
    current_user.points.where(created_at: 1.year.ago..Time.current).destroy_all
    current_user.update(rule: 'standard')
  end

  def louange_access_reward_to_gold_user
    return unless current_user.rule == 'gold'

    @user.rewards.create(reward_type: '4xAirport')
  end

  # Every calendar quarterly give 100 bonus points for any user spending greater than $2000 in that quarter
  def bonus_points
    return unless current_user.purchases.where(created_at: Time.current.beginning_of_quarter..Time.current.end_of_quarter).sum(:price) >= 2000
  end

  private

  def purchase_params
    params.require(:purchase).permit(:product_id, :user_id, :price)
  end
end
