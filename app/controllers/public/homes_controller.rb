class Public::HomesController < ApplicationController
  before_action :authenticate_user!
  def about
  end
end
