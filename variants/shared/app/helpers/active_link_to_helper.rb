module ActiveLinkToHelper
  # Creates a link with 'active' class when current page matches the target
  # Simplified version of active_link_to gem with only essential functionality
  #
  # Examples:
  #   active_link_to "Home", root_path
  #   active_link_to "Users", users_path, match: :exact
  #   active_link_to "Dashboard", dashboard_path, active_class: "current"
  #
  # @param name [String] Link text
  # @param target [String, Hash] Path or URL for the link
  # @param options [Hash] Additional options
  # @option options [Symbol] :match (:inclusive) Match type - :exact, :inclusive
  # @option options [String] :active_class ("active") CSS class for active state
  # @option options [Hash] :html_options ({}) Standard link_to HTML options
  def active_link_to(name, target = nil, options = {}, &block)
    # Handle block syntax like standard link_to
    if block_given?
      options = target || {}
      target = name
      name = capture(&block)
    end

    # Set default options
    match_type = options.delete(:match) || :inclusive
    active_class = options.delete(:active_class) || "active"

    # Support legacy html_options parameter
    if options[:html_options]
      html_options = options.delete(:html_options)
      options = options.merge(html_options)
    end

    # Determine if link should be active
    is_active = link_active?(target, match_type)

    # Add active class if needed
    if is_active
      current_classes = options[:class].to_s
      css_classes = [current_classes, active_class].compact.reject(&:empty?).join(" ")
      options[:class] = css_classes unless css_classes.empty?
    end

    # Generate the link
    link_to(name, target, options)
  end

  private

  # Check if the link should be considered active
  # @param target [String, Hash] The link target
  # @param match_type [Symbol] How to match - :exact or :inclusive
  # @return [Boolean] Whether the link is active
  def link_active?(target, match_type)
    target_path = normalize_path(target)
    current_path = request.path

    case match_type
    when :exact
      current_path == target_path
    when :inclusive
      return true if current_path == target_path
      return false if target_path == "/"
      current_path.start_with?(target_path + "/") || current_path.start_with?(target_path + "?") || current_path.start_with?(target_path + "#")
    else
      false
    end
  rescue
    # Return false if path generation fails
    false
  end

  # Convert target to normalized path string
  # @param target [String, Hash] Link target
  # @return [String] Normalized path
  def normalize_path(target)
    case target
    when String
      target
    when Hash
      url_for(target)
    else
      polymorphic_path(target)
    end
  rescue
    # Return empty string if path generation fails
    ""
  end
end
