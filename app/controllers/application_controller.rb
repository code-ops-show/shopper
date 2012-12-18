class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_or_guest_user
    current_user || guest_user
  end

private

  def guest_user
   User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  end

  def create_guest_user
    u = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(99)}@example.com")
    u.save(:validate => false)
    u
  end

  def token
    cookies[:token] ? cookies[:token] : rand(2468**10).to_s(32)
  end
  
  def current_order
    cookies[:token] = { value: token, expires: 1.hour.from_now }
    @current_order ||= Order.cart_by(token) || Order.create!(token: token)
  end
  helper_method :current_order

  def render_form_error_for object
    error = {
        id: object.id,
        model: controller_name.singularize, 
        errors: object.errors 
      }
    render json: error , status: :unprocessable_entity
  end

  def render_box_error_for object
    error = { noty: object.errors  }
    render json: error , status: :unprocessable_entity
  end

  def after_sign_in_path_for(resource)
    current_order.items.present? ? edit_cart_path(current_order) : root_path
  end   
end
