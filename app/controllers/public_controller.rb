class PublicController <ApplicationController
  skip_before_action :ensure_authenticated

end
