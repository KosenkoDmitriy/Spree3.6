#insert_after :admin_tabs, 'admin/testimonials/tab'
Deface::Override.new(:virtual_path  => "spree/layouts/admin",
						:name => "admin_testimonials_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<ul class='nav nav-sidebar'><%= tab :testimonials, url: testimonials_engine.admin_testimonials_url, icon: 'file' %></ul>"
                     )
