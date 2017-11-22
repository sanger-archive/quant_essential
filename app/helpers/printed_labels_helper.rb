# frozen_string_literal: true

#
# Module PrintedLabelsHelper provides tools for listing
# available printers in pages.
#
module PrintedLabelsHelper
  #
  # Returns an array of available printer names for use in select dropdowns
  #
  #
  # @return [Array<Array<String>>] An array of string arrays.
  # Eg. [["printer_a (upstairs)","printer_a"], ["printer_b (downstairs)","printer_b"]]
  #
  def available_printers
    Printer.pluck(:name, :description).map do |name, description|
      select_text = description.blank? ? name : "#{description} (#{name})"
      [select_text, name]
    end
  end
end
