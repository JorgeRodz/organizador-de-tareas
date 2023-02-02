class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user! # Devise

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path
  end

  def set_locale
    I18n.locale = 'es'
  end
end
