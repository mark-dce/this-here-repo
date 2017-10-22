require 'rails_helper'

RSpec.describe 'hyrax/base/_form_metadata.html.erb', type: :view do
  let(:ability) { double }
  let(:work) { FactoryGirl.build(:etd) }
  let(:form) { Hyrax::EtdForm.new(work, ability, controller) }

  let(:form_template) do
    %(
      <%= simple_form_for [main_app, @form] do |f| %>
        <%= render "hyrax/base/form_metadata", f: f %>
      <% end %>
     )
  end

  let(:page) do
    assign(:form, form)
    render inline: form_template
    Capybara::Node::Simple.new(rendered)
  end

  it "renders the additional fields button" do
    expect(page).to have_content('Additional fields')
  end

  describe 'form fields' do
    it 'has a title' do
      expect(page).to have_content('Title')
    end
  end
end
