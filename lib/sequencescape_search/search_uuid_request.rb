# frozen_string_literal: true

class SequencescapeSearch
  #
  # Class SearchUuidRequest provides a means of querying the sequencescape
  # api for the list of searches, and retrieving a particular uuid for later searching
  #
  class SearchUuidRequest
    attr_reader :api_root, :name, :search_endpoint

    delegate :body, :status, to: :response

    #
    # Create a new request to the Sequencescape API to retrieve a search UUID
    #
    # @param [Faraday] api_root A Faraday client pointed at the api root
    # @param [String] name The name of the search to retrieve
    # @param [String] search_endpoint the api endpoint of the searches index Defaults to 'searches'
    #
    def initialize(api_root, name, search_endpoint = 'searches')
      @api_root = api_root
      @name = name
      @search_endpoint = search_endpoint
    end

    def uuid
      case status
      when 200
        @uuid ||= extract_search_uuid
      when 503
        raise SequencescapeBusy, 'Sequencescape is currently unavailable.'
      else
        raise SequencescapeError, "Unexpected response status: #{response.status}"
      end
    end

    private

    def extract_search_uuid
      found_search = response_hash.fetch(search_endpoint).detect { |search| search['name'] == name }
      raise SearchNotFound, "Could not find search #{name}" if found_search.nil?
      found_search.fetch('uuid')
    end

    def response_hash
      @response_hash ||= JSON.parse(body)
    rescue JSON::ParserError
      raise SequencescapeError, 'Sequencescape returned non-json content'
    end

    def response
      @response ||= api_root.get(search_endpoint)
    end
  end
end
