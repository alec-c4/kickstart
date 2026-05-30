# frozen_string_literal: true

create_file "app/serializers/application_serializer.rb", <<~RUBY
  # frozen_string_literal: true

  class ApplicationSerializer < OjSerializers::Serializer
  end
RUBY

copy_file "config/initializers/types_from_serializers.rb"

say "✓ oj_serializers + types_from_serializers configured", :green
