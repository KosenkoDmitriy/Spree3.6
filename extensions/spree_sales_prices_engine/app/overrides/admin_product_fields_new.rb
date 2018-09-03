Deface::Override.new(virtual_path: "spree/admin/products/new",
name: "sales_price_new_product",
#insert_after: "erb[loud]:contains('text_field :price')",
insert_before: 'div[data-hook=new_product_price]',
# replace: "[data-hook='new_product_price']",
text: "
<%= f.field_container :main_price do %>
	<%= f.label :main_price, Spree.t('main_price')%> <span class='required'>*</span><br />
	<%= f.text_field :main_price, value: number_with_precision(@product.main_price, unit: '', precision: 2), class: 'form-control' %>
	<%= f.error_message_on :main_price %>
<% end %>

<%= f.field_container :sale_price do %>
	<%= f.label :sale_price, 'Sale Price' %><br />
	<%= f.text_field :sale_price, value: number_with_precision(@product.sale_price, unit: '', precision: 2), class: 'form-control' %>
	<%= f.error_message_on :sale_price %>
<% end %>
"
)
