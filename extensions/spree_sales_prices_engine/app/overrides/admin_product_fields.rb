Deface::Override.new(virtual_path: "spree/admin/products/_form",
name: "sales_price",
# insert_after: "erb[loud]:contains('f.field_container :price')",
insert_before: 'div[data-hook=admin_product_form_price]',
# replace: "[data-hook='admin_product_form_price']",
text: "
<%= f.field_container :main_price do %>
	<%= f.label :main_price, Spree.t('main_price')%> <span class='required'>*</span><br />
	<%= f.text_field :main_price, value: number_with_precision(@product.main_price, unit: '', precision: 2), class: 'form-control' %>
	<%= f.error_message_on :main_price %>
<% end %>

<%= f.field_container :sale_price do %>
	<%= f.label :sale_price, 'Sale Price' %><br />
	<%= f.text_field :sale_price, value: number_with_precision(@product.sale_price, unit: '', precision: 2), class: 'form-control'  %>
	<%= f.error_message_on :sale_price %>
<% end %>
"
)
