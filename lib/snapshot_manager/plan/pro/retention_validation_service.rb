# frozen_string_literal: true

require 'date'
require 'snapshot_manager/plan/beginner/retention_validation_service'
require_relative '../../plan'

module SnapshotManager::Plan::Pro
  class RetentionValidationService
    include SnapshotManager::Plan

    def initialize(date)
      @date = Date.parse(date)
      @raw_date = date
    end

    def call
      validate_retention
    end

    private def validate_retention
      validate_beginner_plan || validate_pro_plan
    end

    private def validate_beginner_plan
      Beginner::RetentionValidationService.new(@raw_date).call
    end

    private def validate_pro_plan
      monthly_retain_dates.include?(@date)
    end

    private def monthly_retain_dates
      MONTHLY_RETAIN_VALUE.times.map do |previous_month_ago|
        previous_month_ago += 1

        last_day_of_previous_month_ago(previous_month_ago)
      end
    end

    private def last_day_of_previous_month_ago(previous_month_ago)
      previous_month = Date.today.prev_month(previous_month_ago)

      Date.new(previous_month.year, previous_month.month, LAST_DAY_OF_THE_MONTH)
    end
  end
end
