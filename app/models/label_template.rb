# frozen_string_literal: true

#
# Class LabelTemplate provides a means of naming print my barcode templates
# and caching their external ids locally.
# LabelTemplate are associated with a Printer and ensure that it isn't sent
# invalid labels
#
class LabelTemplate < ActiveRecord::Base
  validates_presence_of :name, :external_id
  validates_uniqueness_of :name, :external_id
end
