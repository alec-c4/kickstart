require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { described_class.new }

  describe "associations" do
    it { is_expected.to have_many(:identities) }
    it { is_expected.to belong_to(:banned_by).class_name("User").optional }
    it { is_expected.to belong_to(:referred_by).class_name("User").optional }

    it {
      expect(user).to have_many(:referred_users)
        .class_name("User").with_foreign_key("referred_by_id")
        .dependent(:nullify).inverse_of(:referred_by)
    }

    it { is_expected.to have_many(:visits).class_name("Ahoy::Visit").dependent(:destroy) }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:first_name).on(:update) }
    it { is_expected.to validate_presence_of(:last_name).on(:update) }
  end
end
