# frozen_string_literal: true

require_relative 'sequencescape_search/search_uuid_request'
require_relative 'sequencescape_search/search_result_request'

class SequencescapeSearch
  SearchNotFound = Class.new(StandardError)
  SequencescapeError = Class.new(StandardError)
  SequencescapeBusy = Class.new(SequencescapeError)

  # Passed into SequencescapeSearch and describes a particular search
  # name: The name of a search
  # parameter: The search parameter name passed in the post
  # return_map: A hash of keys that will be returned, and their 'address' in the json response
  SearchEndpoint = Struct.new(:name, :parameter, :return_map)

  def self.swipecard_search
    SequencescapeSearch::SearchEndpoint.new(
      'Find user by swipecard code',
      'swipecard_code',
      uuid: %w[user uuid], login: %w[user login]
    )
  end

  def self.plate_barcode_search
    SequencescapeSearch::SearchEndpoint.new(
      'Find assets by barcode',
      'barcode',
      uuid: %w[plate uuid], name: %w[plate name], external_type: %w[plate plate_purpose name]
    )
  end

  attr_reader :api_root, :search, :search_endpoint

  # api_root: A Faraday client pointed at the api root
  # search: A SearchEndpoint
  # search_endpoint: [optional] the name of the searches resource itself
  def initialize(api_root, search, search_endpoint = 'searches')
    @api_root = api_root
    @search = search
    @search_endpoint = search_endpoint
  end

  def find(query)
    SearchResultRequest.new(api_root, query, search, search_uuid, singlular_endpoint).result
  end

  private

  delegate :name, to: :search

  def singlular_endpoint
    search_endpoint.singularize
  end

  def search_uuid
    @search_uuid ||= SearchUuidRequest.new(api_root, name, search_endpoint).uuid
  end
end
