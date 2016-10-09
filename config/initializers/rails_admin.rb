RailsAdmin.config do |config|
  ### Popular gems integration
  config.authorize_with do |controller|
    if !(current_user.nil?)
      unless (warden.user.admin == true)
        flash[:notice] = "No eres administrador"
        redirect_to '/'
      end
    else
      flash[:notice] = "Por favor inicie sesion"
      redirect_to '/'
    end
  end
end

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
 #config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
