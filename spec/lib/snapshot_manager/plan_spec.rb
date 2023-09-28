# frozen_string_literal: true

require 'date'
require_relative '../../../lib/snapshot_manager/plan'

describe SnapshotManager::Plan do
  describe '#validate_retention' do
    subject { described_class.validate_retention(plan, date) }

    let(:date) { Date.today.to_s }

    context 'when plan is Beginner' do
      let(:plan) { 'Beginner' }

      it { is_expected.to be_truthy }
    end

    context 'when plan is Pro' do
      let(:plan) { 'Pro' }

      it { is_expected.to be_truthy }
    end

    context 'when plan is Ultra' do
      let(:plan) { 'Ultra' }

      it { is_expected.to be_truthy }
    end

    context 'when plan is not valid' do
      let(:plan) { 'InvalidPlan' }

      it 'returns an error message' do
        is_expected.to eq(
          "The plan #{plan} is not valid. Valid plans are: #{described_class.constants}"
        )
      end
    end

    context 'when given date is invalid' do
      let(:plan) { 'Beginner' }
      let(:date) { 'invalid date' }

      it { expect { subject }.to raise_error(Date::Error) }
    end
  end
end
