Rails.application.routes.draw do
  draw :pages
  draw :landing
  draw :errors
  draw :dev
  draw :support

  root "landing#home"
end
