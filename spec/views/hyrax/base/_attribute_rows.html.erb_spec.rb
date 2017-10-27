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

  let(:attributes) do
    { creator:     ['Tove Jansson', 'Lars Jansson'],
      keyword:     ['moominland', 'moomintroll'],
      source:      ['Too-Ticky'],
      rights_note: ['For the exclusive viewing of Little My.',
                    'Moomin: do not read this.'],
      subject:     ['Moomins', 'Snorks'] }
  end

  it { is_expected.to have_show_field(:creator).with_values(*attributes[:creator]).and_label('Creator') }
  it { is_expected.to have_show_field(:keyword).with_values(*attributes[:keyword]).and_label('Keyword') }
  it { is_expected.to have_show_field(:source).with_values(*attributes[:source]).and_label('Source') }
  it { is_expected.not_to have_show_field(:rights_note) }
  it { is_expected.to have_show_field(:subject).with_values(*attributes[:subject]).and_label('Subject') }
end
