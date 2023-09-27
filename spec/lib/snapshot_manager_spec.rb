# frozen_string_literal: true

require_relative '../../lib/snapshot_manager'

describe SnapshotManager do
  describe 'ping' do
    it { expect(described_class.ping).to eq(:pong) }
  end
end
