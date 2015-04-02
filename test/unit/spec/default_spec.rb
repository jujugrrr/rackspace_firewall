# Encoding: utf-8

require_relative 'spec_helper'

# the runlist came from test-kitchen's default suite
describe 'rackspace_firewall::default' do
  before { stub_resources }
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: platform, version: version, log_level: :info) do |node, server|
            node_resources(node) # stub this node
            stub_nodes(platform, version, server) # stub other nodes for chef-zero
          end.converge(described_recipe)
        end

        it 'installs firewall' do
          expect(chef_run).to enable_firewall('default')
        end
        it 'adds Loopback rule' do
          expect(chef_run).to allow_firewall_rule('Loopback')
        end
        it 'adds default Reject rule' do
          expect(chef_run).to reject_firewall_rule('Drop not allowed')
        end
      end
    end
  end
end
