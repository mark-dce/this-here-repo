require 'rails_helper'

RSpec.describe 'hyrax/base/_attribute_rows.html.erb', type: :view do
  subject(:page) do
    render 'hyrax/base/attribute_rows', presenter: presenter
    Capybara::Node::Simple.new(rendered)
  end

  let(:ability)       { double }
  let(:presenter)     { Hyrax::WorkShowPresenter.new(solr_document, ability) }
  let(:solr_document) { SolrDocument.new(work.to_solr) }
  let(:work)          { FactoryGirl.build(:etd, **attributes) }

  let(:attributes) { { keyword: ['moominland', 'moomintroll'] } }

  it { is_expected.to have_show_field(:keyword).with_values(*attributes[:keyword]).and_label('Keyword') }
end
