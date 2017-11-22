# frozen_string_literal: true

module AssaySets
  class PrintJobsController < ApplicationController
    include PrintJobs

    def printable_record
      AssaySet.find_by!(uuid: uuid_from(params[:assay_set_uuid]))
    end
  end
end
