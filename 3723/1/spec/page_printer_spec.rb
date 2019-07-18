require './page_printer'
require './sorted_pages'

RSpec.describe PagePrinter do
  subject { PagePrinter.new(row) }
  let(:expected) { PagePrinter.new(expected_rows) }
  let(:row) { [%w[faraday 1], %w[rspec 1], %w[faraday 3], %w[rails 5], %w[faraday 7]] }
  let(:expected_rows) { [%w[faraday 1], %w[rspec 1]] }

  describe '#call' do
    it 'can sort by number from top' do
      expect(subject.call(2)).to eq(expected.call)
    end
    it 'can filter by part of name' do
      expect { subject.call('far') }.to change { subject.named_rows.count }.by(3)
    end
  end
end
