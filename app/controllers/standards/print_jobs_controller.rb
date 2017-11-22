# frozen_string_literal: true

module Standards
  class PrintJobsController < ApplicationController
    include PrintJobs

    def printable_record
      Standard.with_barcode(params[:standard_barcode]).first!
    end
  end
end
