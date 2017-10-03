# frozen_string_literal: true

module PrintersHelper
  def available_label_templates
    LabelTemplate.pluck(:name, :id)
  end

  def available_external_printers
    Printer.external_printers
  # If something goes wrong here, just rescue it and return an empty array
  rescue JsonApiClient::Errors::ApiError
    []
  end
end
