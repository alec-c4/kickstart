if Rails.env.development?
  namespace :dev do
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
    mount MissionControl::Jobs::Engine, at: "/jobs"
  end
end
