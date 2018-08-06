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

module Google
  module Container
    module Data
      # A class to manage data for AddonsConfig for cluster.
      class ClusterAddonsConfig
        include Comparable

        attr_reader :http_load_balancing
        attr_reader :horizontal_pod_autoscaling

        def to_json(_arg = nil)
          {
            'httpLoadBalancing' => http_load_balancing,
            'horizontalPodAutoscaling' => horizontal_pod_autoscaling
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            http_load_balancing: http_load_balancing.to_s,
            horizontal_pod_autoscaling: horizontal_pod_autoscaling.to_s
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? ClusterAddonsConfig
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? ClusterAddonsConfig
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
            { self: http_load_balancing, other: other.http_load_balancing },
            { self: horizontal_pod_autoscaling, other: other.horizontal_pod_autoscaling }
          ]
        end
      end

      # Manages a ClusterAddonsConfig nested object
      # Data is coming from the GCP API
      class ClusterAddonsConfigApi < ClusterAddonsConfig
        def initialize(args)
          @http_load_balancing = Google::Container::Property::ClusterHttpLoadBalancing.api_parse(
            args['httpLoadBalancing']
          )
          @horizontal_pod_autoscaling =
            Google::Container::Property::ClusterHorizontalPodAutoscaling.api_parse(
              args['horizontalPodAutoscaling']
            )
        end
      end

      # Manages a ClusterAddonsConfig nested object
      # Data is coming from the Chef catalog
      class ClusterAddonsConfigCatalog < ClusterAddonsConfig
        def initialize(args)
          @http_load_balancing =
            Google::Container::Property::ClusterHttpLoadBalancing.catalog_parse(
              args[:http_load_balancing]
            )
          @horizontal_pod_autoscaling =
            Google::Container::Property::ClusterHorizontalPodAutoscaling.catalog_parse(
              args[:horizontal_pod_autoscaling]
            )
        end
      end
    end

    module Property
      # A class to manage input to AddonsConfig for cluster.
      class ClusterAddonsConfig
        def self.coerce
          ->(x) { ::Google::Container::Property::ClusterAddonsConfig.catalog_parse(x) }
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::ClusterAddonsConfig
          Data::ClusterAddonsConfigCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::ClusterAddonsConfig
          Data::ClusterAddonsConfigApi.new(value)
        end
      end
    end
  end
end
