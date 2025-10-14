module ViewComponentHelper
  # Helper for view_component gem
  # can be used with
  # <%= component "example", title: "Hello World!" %>
  # or for namespaced components
  # <%= component "way_down/we_go/example", title: "Hello World!" %>
  # taken with small improvements from
  # https://evilmartians.com/chronicles/viewcomponent-in-the-wild-supercharging-your-components
  def component(name, *, **, &)
    component = "#{name.to_s.camelize}Component".constantize
    render(component.new(*, **), &)
  end
end
