# frozen_string_literal: true

class SequencescapeSearch
  #
  # Class SearchResultRequest provides a means of making a sequencescape
  # search and parsing the result
  #
  class SearchResultRequest
    attr_reader :api_root, :query, :search_uuid, :search, :model_name

    delegate :body, :status, to: :response
    delegate :name, :parameter, :return_map, to: :search

    #
    # Create a new request to the Sequencescape API to retrieve a search UUID
    #
    # @param [Faraday] api_root A Faraday client pointed at the api root
    # @param [String] query The main content of the query (eg. the barcode/swipecard)
    # @param [SequencescapeSearch::SearchEndpoint] search An item describing the search
    # @param [String] search_uuid URI of the search to use in the request
    #
    def initialize(api_root, query, search, search_uuid, model_name = 'search')
      @api_root = api_root
      @search = search
      @model_name = model_name
      @query = query
      @search_uuid = search_uuid
    end

    def result
      case status
      when 404
        nil
      when 301
        @result ||= result_hash
      when 503
        raise SequencescapeBusy, 'Sequencescape is currently unavailable.'
      else
        raise SequencescapeError, "Unexpected response status: #{searches.status}"
      end
    end

    private

    def search_uri
      "#{search_uuid}/first"
    end

    def payload
      { model_name => { parameter => query } }.to_json
    end

    def result_hash
      Hash[return_map.map { |k, v| [k, response_hash.dig(*v)] }]
    end

    def response_hash
      @response_hash ||= JSON.parse(body)
    rescue JSON::ParserError
      raise SequencescapeError, 'Sequencescape returned non-json content'
    end

    def response
      @response ||= api_root.post(search_uri, payload)
    end
  end
end
