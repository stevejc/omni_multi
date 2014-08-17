class AccountsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def new
    @account = Account.new(plan: params[:plan])
    unless current_user
      @account.build_owner
      if session["devise.user_attributes"]
        @account.owner.provider = session["devise.user_attributes"]["provider"]
        @account.owner.uid = session["devise.user_attributes"]["uid"]
      end
    end
  end

  def create
    @account = Account.new(account_params)
    @account.owner_id = current_account.owner_id if current_user
    if @account.save
      user = User.find(@account.owner_id)
      sign_in user
      redirect_to root_path, notice: 'Successfully Created Account!'
    else
      render action: 'new'
    end
  end
  
  def edit
    @account = current_account
  end
  
  def update
    @account = current_account
    respond_to do |format|
      if @account.update_attributes(account_params)
        format.html { redirect_to edit_account_path(@account), notice: 'Settings were successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def account_params
      params.require(:account).permit(:owner_id, :name, :plan, :email, :phone, :address, :time_zone, owner_attributes: [:account_id, :first_name, :last_name, :provider, :uid, :email, :password, :password_confirmation])
    end

end