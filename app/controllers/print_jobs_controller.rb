class PrintJobsController < ApplicationController
  include UuidReaders
  # PrintableFinders provides :printables which returns an array of object that need their labels printed
  include PrintableFinders

  def create
    @print_job = PrintJob.new(printables:printables,printer:params[:printer])
    if @print_job.print
      flash.notice = t('.success',count:printables.length,printer:params[:printer])
    else
      flash.alert = @print_job.errors.full_messages
    end
    redirect_to :back
  end

  rescue_from ActionController::RedirectBackError, with: :redirect_home

  private

  def redirect_home
    redirect_to :root
  end

end
