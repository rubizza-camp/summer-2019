require './sorted_pages'

RSpec.describe SortedPages do
  subject { SortedPages.new }
  let(:list) { ['https://github.com/lostisland/faraday', 'https://github.com/rails/rails'] }
  let(:expected_list) { [['rails', 'issues 365'], ['faraday', 'issues 22']] }

  describe '#call' do
    it 'add htmls content in rows in the right order(start with)' do
      subject.call(list)
      expect(subject.rows.first.first).to start_with expected_list.first.first
    end
    it 'add htmls content in rows in the right order(end with)' do
      subject.call(list)
      expect(subject.rows.last.first).to start_with expected_list.last.first
    end
  end
end
