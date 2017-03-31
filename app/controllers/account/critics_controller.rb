class Account::CriticsController < ApplicationController
  before_action :authenticate_user!
  def index
    @critics = current_user.critics
  end
end
