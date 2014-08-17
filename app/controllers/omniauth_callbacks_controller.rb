class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user =  User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    elsif current_user
      current_user.update_attributes(uid: user.uid, provider: user.provider)
      redirect_to edit_user_registration_path, notice: "You can now sign-in with Twitter!"
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_authorization_path, notice: "We don't have an account associated with this twitter!"
    end
  end
  alias_method :twitter, :all
  
end
