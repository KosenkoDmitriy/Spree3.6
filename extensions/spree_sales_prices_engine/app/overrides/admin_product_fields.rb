Deface::Override.new(virtual_path: "spree/admin/products/_form",
name: "sales_price",
# insert_after: "erb[loud]:contains('f.field_container :price')",
insert_before: 'div[data-hook=admin_product_form_price]',
# replace: "[data-hook='admin_product_form_price']",
text: "
<div class='alpha two columns'>
	<div class='form-group'>
		<%= f.label :main_price, Spree.t('main_price')%> <span class='required'>*</span><br />
		<%= f.text_field :main_price, value: number_with_precision(@product.main_price, unit: '', precision: 2), class: 'form-control' %>
		<%= f.error_message_on :main_price %>
	</div>
</div>

<div class='alpha two columns'>
	<div class='form-group'>
		<%= f.label :sale_price, 'Sale Price' %><br />
		<%= f.text_field :sale_price, value: number_with_precision(@product.sale_price, unit: '', precision: 2), class: 'form-control'  %>
		<%= f.error_message_on :sale_price %>
	</div>
</div>
"
)
