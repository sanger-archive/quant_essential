module PrintedLabelsHelper
  def available_printers
    Printer.pluck(:name, :description).map do |name, description|
      select_text = description.blank? ? name : "#{description} (#{name})"
      [select_text, name]
    end
  end
end
