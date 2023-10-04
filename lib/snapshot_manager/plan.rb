# frozen_string_literal: true

module SnapshotManager
  module Plan
    DAILY_RETAIN_VALUE = 42
    MONTHLY_RETAIN_VALUE = 12
    YEARLY_RETAIN_VALUE = 7

    LAST_DAY_OF_THE_MONTH = -1

    def self.validate_retention(plan, date)
      Plan.const_get(plan)::RetentionValidationService.new(date).call
    rescue NameError
      "The plan #{plan} is not valid. Valid plans are: #{Plan.constants}"
    end
  end
end
