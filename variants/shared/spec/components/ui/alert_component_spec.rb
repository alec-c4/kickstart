require "rails_helper"

RSpec.describe UI::AlertComponent, type: :component do
  before do
    flash = {notice: "Notification message!"}
    render_inline(described_class.new(flash:))
  end

  it "renders flash notification" do
    expect(page).to have_text("Notification message!")
  end
end
