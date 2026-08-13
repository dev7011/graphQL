# frozen_string_literal: true

module Types
  class BaseConnection < Types::BaseObject
    # add `nodes` and `pageInfo` fields, as well as `edge_type(...)` and `node_nullable(...)` overrides
    include GraphQL::Types::Relay::ConnectionBehaviors

    field :total_count, Integer, null: false
    field :current_page, Integer, null: false
    field :total_pages, Integer, null: false

    def total_count
      object.items.count
    end

    def current_page
      first = object.first || 10
      offset = object.after ? Base64.decode64(object.after).to_i : 0

      (offset / first) + 1
    end

    def total_pages
      first = object.first || 10
      (total_count.to_f / first).ceil
    end
  end
end
