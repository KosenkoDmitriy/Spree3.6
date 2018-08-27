Deface::Override.new(:virtual_path  => "spree/layouts/admin",
					:name => "admin_posts_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<ul class='nav nav-sidebar'><%= tab :news, :url => news_engine.admin_posts_url, icon: 'tasks' %></ul>"
                     )
