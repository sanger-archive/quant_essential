# frozen_string_literal: true

module Assays
  class PrintJobsController < ApplicationController
    include PrintJobs

    def printable_record
      Assay.with_barcode(params[:assay_barcode]).first!
    end
  end
end
