# Copyright 2018 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

# Add our google/ lib
$LOAD_PATH.unshift ::File.expand_path('../libraries', ::File.dirname(__FILE__))

require 'chef/resource'
require 'google/container/network/delete'
require 'google/container/network/get'
require 'google/container/network/post'
require 'google/container/network/put'
require 'google/container/property/boolean'
require 'google/container/property/cluster_name'
require 'google/container/property/integer'
require 'google/container/property/keyvaluepairs'
require 'google/container/property/nodepool_autoscaling'
require 'google/container/property/nodepool_config'
require 'google/container/property/nodepool_management'
require 'google/container/property/nodepool_upgrade_options'
require 'google/container/property/string'
require 'google/container/property/string_array'
require 'google/container/property/time'
require 'google/hash_utils'

module Google
  module GCONTAINER
    # A provider to manage Google Container Engine resources.
    # rubocop:disable Metrics/ClassLength
    class NodePool < Chef::Resource
      resource_name :gcontainer_node_pool

      property :np_label,
               String,
               coerce: ::Google::Container::Property::String.coerce,
               name_property: true, desired_state: true
      property :config,
               [Hash, ::Google::Container::Data::NodePoolConfig],
               coerce: ::Google::Container::Property::NodePoolConfig.coerce, desired_state: true
      property :initial_node_count,
               Integer, coerce: ::Google::Container::Property::Integer.coerce, desired_state: true
      property :version,
               String, coerce: ::Google::Container::Property::String.coerce, desired_state: true
      property :autoscaling,
               [Hash, ::Google::Container::Data::NodePoolAutoscaling],
               coerce: ::Google::Container::Property::NodePoolAutoscaling.coerce,
               desired_state: true
      property :management,
               [Hash, ::Google::Container::Data::NodePoolManagement],
               coerce: ::Google::Container::Property::NodePoolManagement.coerce, desired_state: true
      property :cluster,
               [String, ::Google::Container::Data::ClusterNameRef],
               coerce: ::Google::Container::Property::ClusterNameRef.coerce, desired_state: true
      property :zone,
               String, coerce: ::Google::Container::Property::String.coerce, desired_state: true

      property :credential, String, desired_state: false, required: true
      property :project, String, desired_state: false, required: true

      action :create do
        fetch = fetch_resource(@new_resource, self_link(@new_resource))
        if fetch.nil?
          converge_by "Creating gcontainer_node_pool[#{new_resource.name}]" do
            # TODO(nelsonjr): Show a list of variables to create
            # TODO(nelsonjr): Determine how to print green like update converge
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            create_req = ::Google::Container::Network::Post.new(
              collection(@new_resource), fetch_auth(@new_resource),
              'application/json', resource_to_request
            )
            wait_for_operation create_req.send, @new_resource
          end
        else
          @current_resource = @new_resource.clone
          @current_resource.np_label =
            ::Google::Container::Property::String.api_parse(fetch['name'])
          @current_resource.config =
            ::Google::Container::Property::NodePoolConfig.api_parse(fetch['config'])
          @current_resource.version =
            ::Google::Container::Property::String.api_parse(fetch['version'])
          @current_resource.autoscaling =
            ::Google::Container::Property::NodePoolAutoscaling.api_parse(fetch['autoscaling'])
          @current_resource.management =
            ::Google::Container::Property::NodePoolManagement.api_parse(fetch['management'])

          update
        end
      end

      action :delete do
        fetch = fetch_resource(@new_resource, self_link(@new_resource))
        unless fetch.nil?
          converge_by "Deleting gcontainer_node_pool[#{new_resource.name}]" do
            delete_req = ::Google::Container::Network::Delete.new(
              self_link(@new_resource), fetch_auth(@new_resource)
            )
            wait_for_operation delete_req.send, @new_resource
          end
        end
      end

      # TODO(nelsonjr): Add actions :manage and :modify

      private

      action_class do
        def resource_to_request
          request = {
            name: new_resource.np_label,
            config: new_resource.config,
            initialNodeCount: new_resource.initial_node_count,
            autoscaling: new_resource.autoscaling,
            management: new_resource.management
          }.reject { |_, v| v.nil? }
          # Format request to conform with API endpoint
          request = encode_request(request)
          request.to_json
        end

        def update
          converge_if_changed do |_vars|
            # TODO(nelsonjr): Determine how to print indented like upd converge
            # TODO(nelsonjr): Check w/ Chef... can we print this in red?
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            update_req =
              ::Google::Container::Network::Put.new(self_link(@new_resource),
                                                    fetch_auth(@new_resource),
                                                    'application/json',
                                                    resource_to_request)
            wait_for_operation update_req.send, @new_resource
          end
        end

        def self.fetch_export(resource, type, id, property)
          return if id.nil?
          resource.resources("#{type}[#{id}]").exports[property]
        end

        def self.resource_to_hash(resource)
          {
            project: resource.project,
            name: resource.np_label,
            config: resource.config,
            initial_node_count: resource.initial_node_count,
            version: resource.version,
            autoscaling: resource.autoscaling,
            management: resource.management,
            cluster: resource.cluster,
            zone: resource.zone
          }.reject { |_, v| v.nil? }
        end

        # Copied from Chef > Provider > #converge_if_changed
        def compute_changes
          properties = @new_resource.class.state_properties.map(&:name)
          properties = properties.map(&:to_sym)
          if current_resource
            compute_changes_for_existing_resource properties
          else
            compute_changes_for_new_resource properties
          end
        end

        # Collect the list of modified properties
        def compute_changes_for_existing_resource(properties)
          specified_properties = properties.select do |property|
            @new_resource.property_is_set?(property)
          end
          modified = specified_properties.reject do |p|
            @new_resource.send(p) == current_resource.send(p)
          end

          generate_pretty_green_text(modified)
        end

        def generate_pretty_green_text(modified)
          property_size = modified.map(&:size).max
          modified.map! do |p|
            properties_str = if @new_resource.sensitive
                               '(suppressed sensitive property)'
                             else
                               [
                                 @new_resource.send(p).inspect,
                                 "(was #{current_resource.send(p).inspect})"
                               ].join(' ')
                             end
            "  set #{p.to_s.ljust(property_size)} to #{properties_str}"
          end
        end

        # Write down any properties we are setting.
        def compute_changes_for_new_resource(properties)
          property_size = properties.map(&:size).max
          properties.map do |property|
            default = ' (default value)' \
              unless @new_resource.property_is_set?(property)
            next if @new_resource.send(property).nil?
            properties_str = if @new_resource.sensitive
                               '(suppressed sensitive property)'
                             else
                               @new_resource.send(property).inspect
                             end
            ["  set #{property.to_s.ljust(property_size)}",
             "to #{properties_str}#{default}"].join(' ')
          end.compact
        end

        def fetch_auth(resource)
          self.class.fetch_auth(resource)
        end

        def self.fetch_auth(resource)
          resource.resources("gauth_credential[#{resource.credential}]")
                  .authorization
        end

        def fetch_resource(resource, self_link)
          self.class.fetch_resource(resource, self_link)
        end

        def debug(message)
          Chef::Log.debug(message)
        end

        def self.collection(data)
          URI.join(
            'https://container.googleapis.com/v1/',
            expand_variables(
              'projects/{{project}}/zones/{{zone}}/clusters/{{cluster}}/nodePools',
              data
            )
          )
        end

        def collection(data)
          self.class.collection(data)
        end

        def self.self_link(data)
          URI.join(
            'https://container.googleapis.com/v1/',
            expand_variables(
              'projects/{{project}}/zones/{{zone}}/clusters/{{cluster}}/nodePools/{{name}}',
              data
            )
          )
        end

        def self_link(data)
          self.class.self_link(data)
        end

        def self.return_if_object(response, allow_not_found = false)
          raise "Bad response: #{response.body}" \
            if response.is_a?(Net::HTTPBadRequest)
          raise "Bad response: #{response}" \
            unless response.is_a?(Net::HTTPResponse)
          return if response.is_a?(Net::HTTPNotFound) && allow_not_found 
          return if response.is_a?(Net::HTTPNoContent)
          result = JSON.parse(response.body)
          raise_if_errors result, %w[error errors], 'message'
          raise "Bad response: #{response}" unless response.is_a?(Net::HTTPOK)
          result
        end

        def return_if_object(response, allow_not_found = false)
          self.class.return_if_object(response, allow_not_found)
        end

        def self.extract_variables(template)
          template.scan(/{{[^}]*}}/).map { |v| v.gsub(/{{([^}]*)}}/, '\1') }
                  .map(&:to_sym)
        end

        def self.expand_variables(template, var_data, extra_data = {})
          data = if var_data.class <= Hash
                   var_data.merge(extra_data)
                 else
                   resource_to_hash(var_data).merge(extra_data)
                 end
          extract_variables(template).each do |v|
            unless data.key?(v)
              raise "Missing variable :#{v} in #{data} on #{caller.join("\n")}}"
            end
            template.gsub!(/{{#{v}}}/, CGI.escape(data[v].to_s))
          end
          template
        end

        def expand_variables(template, var_data, extra_data = {})
          self.class.expand_variables(template, var_data, extra_data)
        end

        def fetch_resource(resource, self_link)
          self.class.fetch_resource(resource, self_link)
        end

        def async_op_url(data, extra_data = {})
          URI.join(
            'https://container.googleapis.com/v1/',
            expand_variables(
              'projects/{{project}}/zones/{{zone}}/operations/{{op_id}}',
              data, extra_data
            )
          )
        end

        def wait_for_operation(response, resource)
          op_result = return_if_object(response)
          return if op_result.nil?
          status = ::Google::HashUtils.navigate(op_result, %w[status])
          fetch_resource(
            resource,
            URI.parse(::Google::HashUtils.navigate(wait_for_completion(status,
                                                                       op_result,
                                                                       resource),
                                                   %w[targetLink]))
          )
        end

        def wait_for_completion(status, op_result, resource)
          op_id = ::Google::HashUtils.navigate(op_result, %w[name])
          op_uri = async_op_url(resource, op_id: op_id)
          while status != 'DONE'
            debug("Waiting for completion of operation #{op_id}")
            raise_if_errors op_result, %w[error errors], 'message'
            sleep 1.0
            raise "Invalid result '#{status}' on gcontainer_node_pool." \
              unless %w[PENDING RUNNING DONE ABORTING].include?(status)
            op_result = fetch_resource(resource, op_uri)
            status = ::Google::HashUtils.navigate(op_result, %w[status])
          end
          op_result
        end

        def raise_if_errors(response, err_path, msg_field)
          self.class.raise_if_errors(response, err_path, msg_field)
        end

        # Google Container Engine API has its own layout for the create method,
        # defined like this:
        #
        # {
        #   'nodePool': {
        #     ... node pool data
        #   }
        # }
        #
        # Format the request to match the expected input by the API
        def self.encode_request(resource_request)
          {
            'nodePool' => resource_request
          }
        end

        def encode_request(resource_request)
          self.class.encode_request(resource_request)
        end

        def self.fetch_resource(resource, self_link)
          get_request = ::Google::Container::Network::Get.new(
            self_link, fetch_auth(resource)
          )
          return_if_object get_request.send, true
        end

        def self.raise_if_errors(response, err_path, msg_field)
          errors = ::Google::HashUtils.navigate(response, err_path)
          raise_error(errors, msg_field) unless errors.nil?
        end

        def self.raise_error(errors, msg_field)
          raise IOError, ['Operation failed:',
                          errors.map { |e| e[msg_field] }.join(', ')].join(' ')
        end
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
