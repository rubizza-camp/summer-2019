require_relative '../spec_helper'

RSpec.describe Router do
  context '#resolve' do
    let(:user) { double() }

    context '/start' do
      let(:message) { double('message', text: '/start') }

      it { expect(described_class.resolve(message, user)).to be_a(Start) }
    end

    context '/check_in' do
      let(:message) { double('message', text: '/check_in') }

      it { expect(described_class.resolve(message, user)).to be_a(CheckIn) }
    end

    context '/check_out' do
      let(:message) { double('message', text: '/check_out') }

      it { expect(described_class.resolve(message, user)).to be_a(CheckOut) }
    end

    context '/help' do
      let(:message) { double('message', text: '/help') }
      it { expect(described_class.resolve(message, user)).to be_a(Help) }
    end

    context 'geo' do
      let(:user) { double('user', status: :waiting_geo) }
      let(:message) { double('message', text: nil, user: user) }

      it { expect(described_class.resolve(message, user)).to be_a(Geo) }
    end

    context 'selfie' do
      let(:user) { double('user', status: :waiting_selfie) }
      let(:message) { double('message', text: nil, user: user) }

      it { expect(described_class.resolve(message, user)).to be_a(Selfie) }
    end

    context 'camp number' do
      let(:user) { double('user', status: :waiting_number) }
      let(:message) { double('message', text: nil, user: user) }

      it { expect(described_class.resolve(message, user)).to be_a(Register) }
    end
  end
end
