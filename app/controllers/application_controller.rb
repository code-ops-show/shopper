class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_or_guest_user
    current_user || guest_user
  end
  helper_method :current_or_guest_user

private
  def guest_user
    session[:guest_user_id] = session[:guest_user_id].present? ? session[:guest_user_id] : create_guest_user.id
    User.find(session[:guest_user_id])
  end

  def create_guest_user
    u = User.create(name: "Guest", email: "guest_#{Time.now.to_i}#{rand(99)}@example.com", type: "Guest")
    u.save(validate: false)
    u
  end

  def token
    cookies[:token] ? cookies[:token] : rand(2468**10).to_s(32)
  end
  
  def current_order
    cookies[:token] = { value: token, expires: 1.hour.from_now }
    @current_order ||= Order.cart_by(token) || Order.create!(token: token)
    first_time_visit unless session[:first_time]
    @current_order
  end
  helper_method :current_order

  def render_form_error_for object
    error = 
      {
        id: object.id,
        model: controller_name.singularize, 
        errors: object.errors 
      }
    render json: error , status: :unprocessable_entity
  end

  def render_box_error_for object, text = nil
    error = { noty: text ? text : object.errors }
    render json: error, status: :unprocessable_entity
  end

  def first_time_visit
    session[:first_time] = true
    current_order.touch
  end

  def after_sign_in_path_for(resource)
    URI(request.referer).path == new_guest_path ? edit_cart_path(current_order) : root_path
  end
end
