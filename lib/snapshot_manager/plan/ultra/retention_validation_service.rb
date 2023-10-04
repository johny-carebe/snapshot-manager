# frozen_string_literal: true

require 'date'
require 'snapshot_manager/plan/pro/retention_validation_service'
require_relative '../../plan'

module SnapshotManager::Plan::Ultra
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
      validate_pro_plan || validate_ultra_plan
    end

    private def validate_pro_plan
      Pro::RetentionValidationService.new(@raw_date).call
    end

    private def validate_ultra_plan
      yearly_retain_dates.include?(@date)
    end

    private def yearly_retain_dates
      YEARLY_RETAIN_VALUE.times.map do |previous_year_ago|
        previous_year_ago += 1

        last_day_of_previous_year_ago(previous_year_ago)
      end
    end

    private def last_day_of_previous_year_ago(previous_year_ago)
      previous_year = Date.today.prev_year(previous_year_ago)

      Date.new(previous_year.year, 12, 31)
    end
  end
end
