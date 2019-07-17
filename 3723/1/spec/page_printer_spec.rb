require './page_printer'
require './sorted_pages'

RSpec.describe PagePrinter do
  subject { PagePrinter.new(row) }
  let(:row) { [['rails', 'forks 111'], %w[faraday 13], %w[rspec 1]] }

  describe '#call' do
    it 'can sort by number from top' do
      expect { subject.call(2) }.to change { subject.rows.count }.by(-1)
    end
    it 'can filter by part of name' do
      subject.call('far')
      expect(subject.rows.first.first).to eq('faraday')
    end
  end
end
