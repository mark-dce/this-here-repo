# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CatalogController, type: :controller do
  describe 'facets' do
    let(:facets) do
      controller
        .blacklight_config
        .facet_fields.keys
        .map { |field| field.gsub(/\_s+im$/, '') }
    end

    let(:expected_facets) do
      ['human_readable_type',
       'resource_type',
       'creator',
       'contributor',
       'degree',
       'institution',
       'school',
       'department',
       'keyword',
       'subject',
       'language',
       'license',
       'based_near_label',
       'file_format',
       'member_of_collections',
       'generic_type',
       'rights_statement']
    end

    it 'has exactly expected facets' do
      expect(facets).to contain_exactly(*expected_facets)
    end
  end

  describe 'search fields' do
    let(:search_fields) { controller.blacklight_config.search_fields.keys }

    let(:expected_search_fields) do
      ['all_fields',
       'contributor',
       'creator',
       'title',
       'description',
       'date_created',
       'subject',
       'resource_type',
       'format',
       'identifier',
       'based_near',
       'keyword',
       'depositor']
    end

    it { expect(search_fields).to contain_exactly(*expected_search_fields) }
  end
end
