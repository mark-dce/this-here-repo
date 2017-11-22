module Mahonia
  ##
  #
  class CitationFormatter
    ##
    # @!attribute [rw] object
    #   @return [Object]
    attr_accessor :object

    ##
    # @param object [Object] the object to bulid citations for.
    def initialize(object:)
      @object = object
    end

    class << self
      ##
      # @param opts [Hash]
      # @option opts [Object] :object the object to bulid citations for.
      #
      # @return [String] a citation for the object
      def citation_for(**opts)
        new(**opts).citation
      end
    end

    ##
    # @return [String] a citation for the object
    def citation
      CiteProc::Processor
        .new(style: 'ohsu-apa', format: 'html')
        .import(item)
        .render(:bibliography, id: :item)
        .first
    rescue CiteProc::Error, TypeError, ArgumentError
      "#{object.creator.join(', ')}. #{object.title.first} " \
      "(#{(object.date || []).first}). <i>Scholar Archive</i>. " \
      "#{object.id}.#{' ' + doi if doi}\n#{url}"
    end

    def item
      CiteProc::Item.new(id:               :item,
                         type:             'thesis',
                         title:             object.title.first,
                         identifier:        object.id,
                         author:            object.creator,
                         issued:            object.date,
                         'container-title': 'Scholar Archive',
                         DOI:               doi,
                         internal_url:      url)
    end

    def doi
      object.identifier.first
    end

    def url
      return unless object.id
      Rails.application.routes.url_helpers.hyrax_etd_url(object.id)
    end
  end
end