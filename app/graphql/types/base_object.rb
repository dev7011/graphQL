# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField

    private

    def dataload_association(record, association)
      dataloader
        .with(
          GraphQL::Dataloader::ActiveRecordAssociationSource,
          association
        )
        .load(record)
    end
  end
end
