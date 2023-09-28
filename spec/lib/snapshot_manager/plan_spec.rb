# frozen_string_literal: true

require 'date'
require_relative '../../../lib/snapshot_manager/plan'

describe SnapshotManager::Plan do
  describe '#should_retain' do
    subject { described_class.should_retain(plan, date) }

    let(:date) { Date.today.to_s }

    context 'when plan is Beginner' do
      let(:plan) { 'Beginner' }

      it { is_expected.to be_truthy }
    end
  end
end
