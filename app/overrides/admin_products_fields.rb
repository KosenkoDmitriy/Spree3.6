Deface::Override.new(:virtual_path  => "spree/admin/products/_form",
:name => "product_description_fields",
           :replace => "erb[loud]:contains('f.field_container :description do')",
:closing_selector => "erb[silent]:contains('end')") do
<<TXT
<%= f.field_container :description do %>
  <%= f.label :description, Spree.t(:description) %>
  <%= f.text_area :description, {:cols => 60, :rows => "10", :class => 'fullwidth tinymce'} %>
  <%= f.error_message_on :description %>
<% end %>
TXT
end

Deface::Override.new(:virtual_path  => "spree/admin/products/_form",
	:name => "extra_fields",
    :insert_bottom => "div[data-hook=admin_product_form_left]") do
<<TXT
<%= f.field_container :description_details do %>
	<%= f.label :description_details, t("details_description")%><br />
	<%= f.text_area :description_details, {:cols => 60, :rows => 4, :class => 'fullwidth tinymce'} %>
	<%= f.error_message_on :description_details %>
<% end %>

<%= f.field_container :description_technique do %>
	<%= f.label :description_technique, t("technique_description") %><br />
	<%= f.text_area :description_technique, {:cols => 60, :rows => 4, :class => 'fullwidth tinymce'} %>
	<%= f.error_message_on :description_technique %>
<% end %>
<%= tinymce %>
TXT
end
