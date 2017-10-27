RSpec.shared_examples 'a model with ohsu core metadata' do
  subject(:model) { described_class.new }

  it { is_expected.to have_editable_property(:rights_note, RDF::Vocab::DC11.rights) }
end
