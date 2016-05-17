Rails.application.routes.draw do

  root 'quants#new'

  resources :assays, param: :barcode, only: [:show,:index] do
    resources :print_jobs, only: :create
  end

  resources :assay_sets, param: :uuid, only: [:show,:index,:new,:create] do
    resources :print_jobs, only: :create
  end

  resources :standards, param: :barcode, only: [:show,:index] do
    resources :print_jobs, only: :create
  end

  resources :standard_sets, param: :uuid, only: [:show,:index,:new,:create] do
    resources :print_jobs, only: :create
  end

  resources :standard_types, except: :delete

  resources :quants, only: [:create,:new,:show,:index], param: :assay_barcode
  resources :quant_types, except: :delete

  resources :printers, param: :name

end
