FactoryGirl.define do

  # sequence :uuid do
  #   UUIDTools::UUID.random_create
  # end

  factory :assay do
    assay_set
  end

  factory :assay_set do
    # uuid
    assay_count 1
  end

end
