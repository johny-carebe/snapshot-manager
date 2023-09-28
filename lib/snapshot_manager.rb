# frozen_string_literal: true

module SnapshotManager
  def self.should_retain(plan, date)
    Plan.validate_retention(plan, date)
  end
end
