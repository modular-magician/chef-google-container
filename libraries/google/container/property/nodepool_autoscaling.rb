# Copyright 2017 Google Inc.
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

module Google
  module Container
    module Data
      # A class to manage data for autoscaling for node_pool.
      class NodePoolAutosca
        include Comparable

        attr_reader :enabled
        attr_reader :min_node_count
        attr_reader :max_node_count

        def to_json(_arg = nil)
          {
            'enabled' => enabled,
            'minNodeCount' => min_node_count,
            'maxNodeCount' => max_node_count
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            enabled: enabled.to_s,
            min_node_count: min_node_count.to_s,
            max_node_count: max_node_count.to_s
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? NodePoolAutosca
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? NodePoolAutosca
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            result = compare[:self] <=> compare[:other]
            return result unless result.zero?
          end
          0
        end

        def inspect
          to_json
        end

        private

        def compare_fields(other)
          [
            { self: enabled, other: other.enabled },
            { self: min_node_count, other: other.min_node_count },
            { self: max_node_count, other: other.max_node_count }
          ]
        end
      end

      # Manages a NodePoolAutosca nested object
      # Data is coming from the GCP API
      class NodePoolAutoscaApi < NodePoolAutosca
        def initialize(args)
          @enabled =
            Google::Container::Property::Boolean.api_parse(args['enabled'])
          @min_node_count =
            Google::Container::Property::Integer.api_parse(args['minNodeCount'])
          @max_node_count =
            Google::Container::Property::Integer.api_parse(args['maxNodeCount'])
        end
      end

      # Manages a NodePoolAutosca nested object
      # Data is coming from the Chef catalog
      class NodePoolAutoscaCatalog < NodePoolAutosca
        def initialize(args)
          @enabled =
            Google::Container::Property::Boolean.catalog_parse(args[:enabled])
          @min_node_count = Google::Container::Property::Integer.catalog_parse(
            args[:min_node_count]
          )
          @max_node_count = Google::Container::Property::Integer.catalog_parse(
            args[:max_node_count]
          )
        end
      end
    end

    module Property
      # A class to manage input to autoscaling for node_pool.
      class NodePoolAutosca
        def self.coerce
          lambda do |x|
            ::Google::Container::Property::NodePoolAutosca.catalog_parse(x)
          end
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::NodePoolAutosca
          Data::NodePoolAutoscaCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::NodePoolAutosca
          Data::NodePoolAutoscaApi.new(value)
        end
      end
    end
  end
end
