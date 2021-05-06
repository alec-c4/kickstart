module ApplicationHelper
  include Pagy::Frontend

  def enabled_feature?(feature)
    Flipper.enabled? feature.to_sym, current_user
  end
end
