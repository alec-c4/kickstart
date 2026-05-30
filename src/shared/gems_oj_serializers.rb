# frozen_string_literal: true

create_file "app/serializers/.keep"

create_file "app/serializers/application_serializer.rb", <<~RUBY
  # frozen_string_literal: true

  class ApplicationSerializer < OjSerializers::Serializer
  end
RUBY

say "✓ oj_serializers configured", :green
