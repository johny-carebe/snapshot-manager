# frozen_string_literal: true

require 'date'
require_relative '../../../../../lib/snapshot_manager/plan/pro/retention_validation_service'

describe SnapshotManager::Plan::Pro::RetentionValidationService do
  describe '#call' do
    subject { described_class.new(date).call }

    let(:months_ago) { Date.today.prev_month(monthly_retain_value) }

    context 'when retain date is expired' do
      let(:date) { months_ago.prev_day(daily_retain_value + 1).to_s }

      it { is_expected.to be_falsey }
    end

    context 'when retain date is today' do
      let(:date) { months_ago.prev_day(daily_retain_value).to_s }

      it { is_expected.to be_truthy }
    end

    context 'when retain date is not expired' do
      let(:date) { months_ago.prev_day(daily_retain_value - 1).to_s }

      it { is_expected.to be_truthy }
    end
  end
end
