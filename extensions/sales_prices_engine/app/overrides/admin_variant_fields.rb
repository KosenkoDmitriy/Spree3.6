Deface::Override.new(:virtual_path  => "spree/admin/variants/_form",
                     :replace => "div[data-hook=price]",
                     :name => "sales_price") do 
<<TXT
<div class="field" data-hook="main_price">
	<%= f.label :main_price, Spree.t(:price) %>
	<%= f.text_field :main_price, :value => number_with_precision(@variant.main_price, :unit => '', precision: 6), :class => 'fullwidth' %>
</div>
<div class="field" data-hook="sale_price">
	<%= f.label :sale_price, "Sale price" %>
	<%= f.text_field :sale_price, :value => number_with_precision(@variant.sale_price, :unit => '', precision: 6), :class => 'fullwidth' %>
</div>
TXT
end