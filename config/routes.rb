Rails.application.routes.draw do
  root 'quants#new'

  resources :assays, param: :barcode, only: %i[show index] do
    resources :print_jobs, only: :create
  end

  resources :assay_sets, param: :uuid, only: %i[show index new create] do
    resources :print_jobs, only: :create
  end

  resources :standards, param: :barcode, only: %i[show index] do
    resources :print_jobs, only: :create
  end

  resources :standard_sets, param: :uuid, only: %i[show index new create] do
    resources :print_jobs, only: :create
  end

  resources :standard_types, except: :delete

  resources :quants, only: %i[create new show index], param: :assay_barcode do
    resource :input, only: :show
  end

  resources :quant_types, except: :delete

  resources :printers, param: :name

  resources :barcodes, only: %i[show index], param: :barcode
  resources :inputs, only: %i[show index], param: :barcode
end
