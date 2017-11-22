# frozen_string_literal: true

# Provides print job capability to a controller.
# The parent controller should respond to printable_record and return an
# ActiveRecord::Base object the responds to printables
# eg.

module PrintJobs
  extend ActiveSupport::Concern
  include UuidReaders

  included do
    rescue_from ActionController::RedirectBackError, with: :redirect_home

    delegate :printables, to: :printable_record
  end

  def create
    @print_job = PrintJob.new(printables: printables.map(&:label_atttibutes), printer: printer_param)
    if @print_job.print
      flash.notice = t('.success', count: printables.length, printer: printer_param)
    else
      flash.alert = @print_job.errors.full_messages
    end
    redirect_to :back
  end

  private

  def redirect_home
    redirect_to :root
  end

  def printer_param
    params.require(:print_job).fetch(:printer, nil)
  end
end
