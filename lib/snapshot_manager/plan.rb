# frozen_string_literal: true

module SnapshotManager
  module Plan
    def self.validate_retention(plan, date)
      Plan.const_get(plan)::RetentionValidationService.new(date).call
    rescue NameError
      "The plan #{plan} is not valid. Valid plans are: #{Plan.constants}"
    end
  end
end
