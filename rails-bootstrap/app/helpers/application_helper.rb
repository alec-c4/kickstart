module ApplicationHelper
  include Pagy::Frontend
  include BetterHtml::Helpers

  def enabled_feature?(feature)
    Flipper.enabled? feature.to_sym, current_user
  end
end
