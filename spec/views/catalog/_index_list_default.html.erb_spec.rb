require 'rails_helper'

RSpec.describe 'catalog/_index_list_default', type: :view do
  subject(:page) { Capybara::Node::Simple.new(rendered) }

  let(:attributes) do
    { creator:       ['Tove Jansson'],
      keyword:       ['moomin', 'snorkmaiden'],
      resource_type: ['Moomin'],
      source:        ['Too-Ticky'] }
  end

  let!(:document)  { SolrDocument.new(etd.to_solr) }
  let!(:etd)       { FactoryGirl.build(:etd, **attributes) }
  let!(:presenter) { instance_double('Blacklight::IndexPresenter') }

  before do
    # @todo Set index_presenter on the view in a more realistic way.
    #   does this belong in the controller view helpers?
    allow(view).to receive(:index_presenter).and_return(presenter)
    # @todo Build a more comprehensive IndexPresenter fake
    allow(presenter).to receive(:field_value) { |field| "A value for #{field}" }

    render 'catalog/index_list_default', document: document
  end

  # title appears in a different partial, not in the metadata listing
  it 'does not display undesired fields' do
    is_expected.not_to list_index_fields('Title', 'Source')
  end

  it 'displays desired fields' do
    is_expected.to list_index_fields('Creator', 'Keyword', 'Resource Type')
  end
end
