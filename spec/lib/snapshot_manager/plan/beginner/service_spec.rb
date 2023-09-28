# frozen_string_literal: true

require 'date'
require_relative '../../../../../lib/snapshot_manager/plan/beginner/retention_validation_service'

describe SnapshotManager::Plan::Beginner::RetentionValidationService do
  describe '#call' do
    subject { described_class.new(date).call }

    context 'and daily retain date is expired' do
      let(:daily_retain_date) { 42 }
      let(:date) { (Date.today - daily_retain_date - 1).to_s }

      it { is_expected.to be_falsey }
    end
  end
end
