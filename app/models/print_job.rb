# frozen_string_literal: true

class PrintJob
  include ActiveModel::Model
  attr_accessor :printables, :printer, :response

  validates_presence_of :printer
  validate :printer_is_suitable?

  def print
    return false unless valid?
    job = new_job
    if job.save
      true
    else
      errors.add(:print_server, job.errors.full_messages.join(' - '))
      false
    end
  end

  private

  def new_job
    PMB::PrintJob.new(
      printer_name: printer,
      label_template_id: printer_record.template_id,
      labels: { body: printables }
    )
  end

  def printer_record
    @printer_record ||= Printer.find_by(name: printer)
  end

  def printer_is_suitable?
    errors.add(:printer, I18n.t(:not_found, scope: %i[errors print_job printer])) if printer_record.nil?
    printer_record.present?
  end
end
