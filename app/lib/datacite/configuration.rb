module Datacite
  class Configuration
    include Singleton

    ##
    # @!attribute [rw] domains
    #   @return [String]
    # @!attribute [rw] login
    #   @return [String]
    # @!attribute [rw] password
    #   @return [String]
    # @!attribute [rw] prefix
    #   @return [String]
    # @!attribute [rw] test_prefix
    #   @return [String]
    attr_accessor :domains, :login, :password, :prefix

    def initialize
      load_from_hash(Rails.application.config_for(:datacite)) if defined? Rails
    end

    ##
    # @param hash [Hash]
    # @return [Datacite::Configuration] self
    def load_from_hash(hash)
      self.domains  = hash.fetch('domains')
      self.login    = hash.fetch('login')
      self.password = hash.fetch('password')
      self.prefix   = hash.fetch('prefix')
    end
  end
end