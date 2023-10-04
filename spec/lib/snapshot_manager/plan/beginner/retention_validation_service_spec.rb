# frozen_string_literal: true

require 'date'
require_relative '../../../../../lib/snapshot_manager/plan/beginner/retention_validation_service'

describe SnapshotManager::Plan::Beginner::RetentionValidationService do
  describe '#call' do
    subject { described_class.new(date).call }

    let(:date) { Date.today.prev_day(days_ago).to_s }

    context 'when daily retain date is expired' do
      let(:days_ago) { daily_retain_value + 1 }

      it { is_expected.to be_falsey }
    end

    context 'when daily retain date is today' do
      let(:days_ago) { daily_retain_value }

      it { is_expected.to be_truthy }
    end

    context 'when daily retain date is not expired' do
      let(:days_ago) { daily_retain_value - 1 }

      it { is_expected.to be_truthy }
    end
  end
end
