module PrintersHelper
  def available_label_templates
    LabelTemplate.pluck(:name, :id)
  end

  def available_external_printers
    begin
      Printer.external_printers
    # If something goes wrong here, just rescue it and return an empty array
    rescue
      []
    end
  end
end
