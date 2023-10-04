# frozen_string_literal: true

require 'date'
require 'snapshot_manager/plan'

module SnapshotManager::Plan::Beginner
  class RetentionValidationService
    def initialize(date)
      @date = Date.parse(date)
    end

    def call
      validate_retention
    end

    private def validate_retention
      validate_beginner_plan
    end

    private def validate_beginner_plan
      @date >= daily_retain_date
    end

    private def daily_retain_date
      Date.today.prev_day(SnapshotManager::Plan::DAILY_RETAIN_VALUE)
    end
  end
end
