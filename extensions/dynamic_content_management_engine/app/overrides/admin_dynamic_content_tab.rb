#insert_after :admin_tabs, 'admin/testimonials/tab'
Deface::Override.new(:virtual_path  => "spree/layouts/admin",
	:name => "admin_dynamic_content_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab :content, :url => dynamic_content_management_engine.admin_dynamic_data_url, :icon => 'icon-file'  %>")
