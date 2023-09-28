# frozen_string_literal: true

require 'date'
require_relative '../../../../../lib/snapshot_manager/plan/ultra/retention_validation_service'

describe SnapshotManager::Plan::Ultra::RetentionValidationService do
  describe '#call' do
    subject { described_class.new(date).call }

    let(:daily_retain_date) { 42 }

    context 'when retain date is expired' do
      let(:date) do
        Date
          .today
          .prev_year(12)
          .prev_month(12)
          .prev_day(daily_retain_date + 1)
          .to_s
      end

      it { is_expected.to be_falsey }
    end

    context 'when retain date is today' do
      let(:date) do
        Date
          .today
          .prev_year(12)
          .prev_month(12)
          .prev_day(daily_retain_date)
          .to_s
      end

      it { is_expected.to be_truthy }
    end

    context 'when retain date is not expired' do
      let(:date) do
        Date
          .today
          .prev_year(12)
          .prev_month(12)
          .prev_day(daily_retain_date - 1)
          .to_s
      end

      it { is_expected.to be_truthy }
    end
  end
end
