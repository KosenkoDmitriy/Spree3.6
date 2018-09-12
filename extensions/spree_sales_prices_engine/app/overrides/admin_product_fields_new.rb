Deface::Override.new(virtual_path: "spree/admin/products/new",
name: "sales_price_new_product",
#insert_after: "erb[loud]:contains('text_field :price')",
insert_before: 'div[data-hook=new_product_price]',
# replace: "[data-hook='new_product_price']",
text: "
<div class='col-xs-12 col-md-4'>
	<div class='form-group'>
		<%= f.label :main_price, Spree.t('main_price')%> <span class='required'>*</span><br />
		<%= f.text_field :main_price, value: number_with_precision(@product.main_price, unit: '', precision: 2), class: 'form-control' %>
		<%= f.error_message_on :main_price %>
	</div>
</div>
<div class='col-xs-12 col-md-4'>
	<div class='form-group'%>
		<%= f.label :sale_price, 'Sale Price' %><br />
		<%= f.text_field :sale_price, value: number_with_precision(@product.sale_price, unit: '', precision: 2), class: 'form-control' %>
		<%= f.error_message_on :sale_price %>
	</div>
</div>
"
)
