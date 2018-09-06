Deface::Override.new(:virtual_path  => "spree/layouts/admin",
	:name => "admin_galleries_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab :galleries, :url => galleries_engine.admin_galleries_url, :icon => 'icon-file'  %>")