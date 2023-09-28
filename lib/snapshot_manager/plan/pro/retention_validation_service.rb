# frozen_string_literal: true

require 'date'
require 'snapshot_manager/plan'

module SnapshotManager::Plan::Pro
  class RetentionValidationService
    def initialize(date)
      @date = Date.parse(date)
    end

    def call
      validate_retention
    end

    private def validate_retention
      @date >= retain_date
    end

    private def retain_date
      Date
        .today
        .prev_month(SnapshotManager::Plan::MONTHLY_RETAIN_VALUE)
        .prev_day(SnapshotManager::Plan::DAILY_RETAIN_VALUE)
    end
  end
end
