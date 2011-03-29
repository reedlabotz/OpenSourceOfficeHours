class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticatedSystem
  before_filter :login_required
  
  protected
  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render :file => "#{Rails.root}/public/404.html", :status => :not_found 
  end
end
