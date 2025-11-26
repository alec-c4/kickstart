# frozen_string_literal: true

class UI::AlertComponent < ViewComponent::Base
  def initialize(flash:)
    @flash = flash
    @flash_class = {
      notice: "text-blue-800 bg-blue-50 dark:bg-gray-800 dark:text-blue-400",
      success: "text-green-800 bg-green-50 dark:bg-gray-800 dark:text-green-400",
      error: "text-red-800 bg-red-50 dark:bg-gray-800 dark:text-red-400",
      alert: "text-yellow-800 bg-yellow-50 dark:bg-gray-800 dark:text-yellow-300"
    }
  end
end
