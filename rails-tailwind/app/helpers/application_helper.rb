module ApplicationHelper
  include Pagy::Frontend
  include BetterHtml::Helpers

  def shallow_args(parent, child)
    child.try(:new_record?) ? [parent, child] : child
  end

  def enabled_feature?(feature)
    Flipper.enabled? feature.to_sym, current_user
  end
end
