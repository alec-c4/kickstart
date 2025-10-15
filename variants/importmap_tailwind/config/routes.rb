Rails.application.routes.draw do
  draw :pages
  draw :errors
  draw :dev
  draw :support

  root "pages#home"
end
