require "rails_helper"

RSpec.describe Announcement, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:announcement_type) }
    it { is_expected.to validate_presence_of(:published_at) }
    it { is_expected.to validate_inclusion_of(:announcement_type).in_array(Announcement::TYPES) }
  end
end
