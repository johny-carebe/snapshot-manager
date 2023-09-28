# frozen_string_literal: true

require 'date'
require 'snapshot_manager/plan'

module SnapshotManager::Plan::Beginner
  class RetentionValidationService
    def initialize(date)
      @date = date
    end

    def call
      Date.parse(@date) >= (Date.today - 42)
    end
  end
end
