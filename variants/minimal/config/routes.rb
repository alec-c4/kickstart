Rails.application.routes.draw do
  draw :pages
  draw :dev
  draw :support

  root "pages#home"
end
