Rails.application.routes.draw do

  root 'assay_sets#index'

  resources :assays, param: :barcode, only: [:show,:index]
  resources :assay_sets, param: :uuid, only: [:show,:index,:new,:create]

  resources :standards, param: :barcode, only: [:show,:index]
  resources :standard_sets, param: :uuid, only: [:show,:index,:new,:create]
  resources :standard_types, except: :delete
  resources :quant_types, except: :delete

end
