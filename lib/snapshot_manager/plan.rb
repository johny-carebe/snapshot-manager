# frozen_string_literal: true

module SnapshotManager
  module Plan
    def self.should_retain(plan, date)
      Plan.const_get(plan)::RetentionValidationService.new(date).call
    end
  end
end
