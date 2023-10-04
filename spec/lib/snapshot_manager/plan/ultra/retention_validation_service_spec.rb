# frozen_string_literal: true

require 'date'
require 'timecop'

require_relative '../../../../../lib/snapshot_manager/plan/ultra/retention_validation_service'

describe SnapshotManager::Plan::Ultra::RetentionValidationService do
  describe '#call' do
    subject { described_class.new(date).call }

    let(:date_today_months_ago) { Date.today.prev_month(monthly_retain_value) }
    let(:years_ago) { date_today_months_ago.year }
    let(:months_ago) { date_today_months_ago.month }
    let(:days_ago) { last_day_of_the_month }
    let(:date) { Date.new(years_ago, months_ago, days_ago).to_s }

    context 'when daily retain date is expired' do
      context 'it returns false for retention validation' do
        let(:date) { Date.today.prev_day(daily_retain_value + 1).to_s }

        it { is_expected.to be_falsey }
      end

      context 'and monthly retain date is not expired and maximum retain limit' do
        it { is_expected.to be_truthy }
      end

      context 'and monthly retain date is not expired' do
        let(:months_ago) { date_today_months_ago.month + 1 }

        it { is_expected.to be_truthy }
      end

      context 'and february retain date is not expired' do
        let(:date) { '2022/02/28' }

        before { Timecop.freeze(Date.new(2023, 2, 4)) }
        after { Timecop.return }

        it { is_expected.to be_truthy }
      end

      context 'and monthly retain date is expired' do
        let(:months_ago) { date_today_months_ago.month - 1 }

        it { is_expected.to be_falsey }

        context 'by not being the last day of the month' do
          let(:months_ago) { date_today_months_ago.month }
          let(:days_ago) { last_day_of_the_month - 1 }

          it { is_expected.to be_falsey }
        end

        context 'and yearly retain date is not expired and maximum retain limit' do
          let(:date_today_years_ago) { Date.today.prev_year(yearly_retain_value) }
          let(:years_ago) { date_today_years_ago.year }
          let(:date) { Date.new(years_ago, 12, last_day_of_the_month).to_s }

          it { is_expected.to be_truthy }
        end

        context 'and yearly retain date is not expired' do
          let(:date_today_years_ago) { Date.today.prev_year(yearly_retain_value) }
          let(:years_ago) { date_today_years_ago.year + 1 }
          let(:date) { Date.new(years_ago, 12, last_day_of_the_month).to_s }

          it { is_expected.to be_truthy }
        end

        context 'and yearly retain date is expired' do
          let(:date_today_years_ago) { Date.today.prev_year(yearly_retain_value) }
          let(:years_ago) { date_today_years_ago.year - 1 }
          let(:days_ago) { last_day_of_the_month }
          let(:date) { Date.new(years_ago, 12, days_ago).to_s }

          it { is_expected.to be_falsey }

          context 'by not being the last day of the year' do
            let(:years_ago) { date_today_years_ago.year }
            let(:days_ago) { last_day_of_the_month - 1 }

            it { is_expected.to be_falsey }
          end

          context 'by not being the last month of the year' do
            let(:date) { Date.new(years_ago, 11, days_ago).to_s }

            it { is_expected.to be_falsey }
          end
        end
      end
    end

    context 'when daily retain date is today' do
      let(:date) { Date.today.prev_day(daily_retain_value).to_s }

      it { is_expected.to be_truthy }
    end

    context 'when daily retain date is not expired' do
      let(:date) { Date.today.prev_day(daily_retain_value - 1).to_s }

      it { is_expected.to be_truthy }
    end
  end
end
