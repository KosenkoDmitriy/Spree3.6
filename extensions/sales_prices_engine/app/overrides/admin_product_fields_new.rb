Deface::Override.new(:virtual_path  => "spree/admin/products/new",
                     :replace => "erb[loud]:contains('f.field_container :price do')",
					:closing_selector => "erb[silent]:contains('end')",
                     :name => "sales_price_new_product") do 
<<TXT
<%= f.field_container :main_price do %>
	<%= f.label :main_price, Spree.t("master_price")%> <span class="required">*</span><br />
	<%= f.text_field :main_price, :value => number_with_precision(@product.main_price, :unit => '', precision: 6), :class => "fullwidth" %>
	<%= f.error_message_on :main_price %>
<% end %>

<%= f.field_container :sale_price do %>
	<%= f.label :sale_price, "Sale Price" %><br />
	<%= f.text_field :sale_price, :value => number_with_precision(@product.sale_price, :unit => '', precision: 6), :class => "fullwidth" %>
	<%= f.error_message_on :sale_price %>
<% end %>
TXT
end