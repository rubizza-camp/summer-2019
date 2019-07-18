require './repo_info_loader'

RSpec.describe RepoInfoLoader do
  subject { RepoInfoLoader.new }
  let(:doc) { { 'gems' => %w[rails faraday] } }
  let(:one_wrong) { { 'gems' => %w[rails topkek] } }

  describe '#call' do
    it 'write only gems links in list' do
      expect { subject.call(doc) }.to change { subject.list.count }.by(2)
    end
    it 'write links only with correct name in list' do
      expect { subject.call(one_wrong) }.to change { subject.list.count }.by(1)
    end
  end
end
