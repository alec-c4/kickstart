class UI::AlertComponentPreview < Lookbook::Preview
  def alert
    flash = {notice: "Notification message!"}
    render UI::AlertComponent.new(flash:)
  end
end
