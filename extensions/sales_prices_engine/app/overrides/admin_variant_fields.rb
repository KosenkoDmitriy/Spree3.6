Deface::Override.new(virtual_path: 'spree/admin/variants/_form',
name: 'sales_price',
insert_before: 'div[data-hook=price]',
# replace: 'div[data-hook=price]',
text: "
<div class='form-group' data-hook='main_price'>
	<%= f.label :main_price, Spree.t(:main_price) %> <span class='required'>*</span>
	<%= f.text_field :main_price, value: number_with_precision(@variant.main_price, unit: '', precision: 2), class: 'form-control' %>
</div>
<div class='form-group' data-hook='sale_price'>
	<%= f.label :sale_price, 'Sale price' %>
	<%= f.text_field :sale_price, value: number_with_precision(@variant.sale_price, unit: '', precision: 2), class: 'form-control' %>
</div>
"
)
