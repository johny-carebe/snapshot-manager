# frozen_string_literal: true

require 'date'
require_relative '../../../../../lib/snapshot_manager/plan/ultra/retention_validation_service'

describe SnapshotManager::Plan::Ultra::RetentionValidationService do
  describe '#call' do
    subject { described_class.new(date).call }

    let(:years_and_months_ago) do
      Date.today.prev_year(yearly_retain_value).prev_month(monthly_retain_value)
    end

    context 'when retain date is expired' do
      let(:date) { years_and_months_ago.prev_day(daily_retain_value + 1).to_s }

      it { is_expected.to be_falsey }
    end

    context 'when retain date is today' do
      let(:date) { years_and_months_ago.prev_day(daily_retain_value).to_s }

      it { is_expected.to be_truthy }
    end

    context 'when retain date is not expired' do
      let(:date) { years_and_months_ago.prev_day(daily_retain_value - 1).to_s }

      it { is_expected.to be_truthy }
    end
  end
end
