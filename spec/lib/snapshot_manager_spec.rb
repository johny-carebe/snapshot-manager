# frozen_string_literal: true

require_relative '../../lib/snapshot_manager'

describe SnapshotManager do
  describe '#should_retain' do
    subject { described_class.should_retain(plan, date) }

    let(:date) { Date.today.to_s }
    let(:plan) { 'Beginner' }

    it 'calls Plan#validate_retention' do
      expect(SnapshotManager::Plan).to receive(:validate_retention)

      subject
    end
  end
end
