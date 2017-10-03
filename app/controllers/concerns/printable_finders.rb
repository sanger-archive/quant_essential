# frozen_string_literal: true

module PrintableFinders
  # Works out what you are wanting to print
  def printables
    return assay_set.printables if params[:assay_set_uuid]
    return standard_set.printables if params[:standard_set_uuid]
    return assay.printables if params[:assay_barcode]
    return standard.printables if params[:standard_barcode]
    # We shouldn't really get here as our routes mean one of the above should be set.
    # However if we do we'll return nil, and let the validation on PrintJob handle the rest
    nil
  end

  def assay_set
    AssaySet.find_by!(uuid: uuid_from(params[:assay_set_uuid]))
  end

  def standard_set
    StandardSet.find_by!(uuid: uuid_from(params[:standard_set_uuid]))
  end

  def assay
    Assay.with_barcode(params[:assay_barcode]).first!
  end

  def standard
    Standard.with_barcode(params[:standard_barcode]).first!
  end
end
