# frozen_string_literal: true

module StandardSets
  class PrintJobsController < ApplicationController
    include PrintJobs

    def printable_record
      StandardSet.find_by!(uuid: uuid_from(params[:standard_set_uuid]))
    end
  end
end
