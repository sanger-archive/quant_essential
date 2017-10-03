# frozen_string_literal: true

class PrintJob
  include ActiveModel::Model
  attr_accessor :printables, :printer, :response

  validates_presence_of :printer
  validate :printer_is_suitable?

  def print
    return false unless valid?
    begin
      job = PMB::PrintJob.new(
        printer_name: printer,
        label_template_id: printer_record.template_id,
        labels: { body: printables }
      )
      if job.save
        true
      else
        errors.add(:print_server, job.errors.full_messages.join(' - '))
        false
      end
    # The PMB errors are not JSON API compliant
    # We rescue the resulting exception, and double check its the one we expect
    rescue NoMethodError => exception
      handle_pmb_error(exception)
    end
  end

  private

  def printer_record
    @printer_record ||= Printer.find_by(name: printer)
  end

  def printer_is_suitable?
    errors.add(:printer, I18n.t(:not_found, scope: %i[errors print_job printer])) if printer_record.nil?
    printer_record.present?
  end

  def handle_pmb_error(exception)
    raise exception unless exception.message.include?('`with_indifferent_access')
    error = /undefined method \`with_indifferent_access\' for (\[.*\])\:Array/.match(exception.message)[1]
    error_array = JSON.parse(error)
    errors.add(:print_server, error_array.join(' - '))
    false
  rescue JSON::ParserError => exception
    errors.add(:print_server, error)
    false
  end
end
