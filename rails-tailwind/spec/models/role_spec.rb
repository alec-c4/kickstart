require "rails_helper"

RSpec.describe Role, type: :model do
  describe "associations" do
    it { is_expected.to have_and_belong_to_many(:users) }
    it { is_expected.to belong_to(:resource).optional }
  end

  describe "validations" do
    it { is_expected.to validate_inclusion_of(:resource_type).in_array(Rolify.resource_types) }
    it { is_expected.to allow_value(nil).for(:resource_type) }
  end
end
