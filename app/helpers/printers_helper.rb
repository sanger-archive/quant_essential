# frozen_string_literal: true

#
# Module PrintersHelper provides printer methods for use in the printers controller
#
module PrintersHelper
  #
  # Array of label templates for use in select tags.
  #
  #
  # @return [Array<Array<String, Int>>] Array of Label names and their ids.
  #
  def available_label_templates
    LabelTemplate.pluck(:name, :id)
  end

  #
  # Array of external printer names. Falls back to empty array if
  # print my barcode is inaccessible.
  #
  # @return [Array] Array of available printers
  #
  def available_external_printers
    Printer.external_printers
  # If something goes wrong here, just rescue it and return an empty array
  rescue JsonApiClient::Errors::ApiError
    []
  end
end
