#insert_after :admin_tabs, 'admin/offers/tab'
Deface::Override.new(:virtual_path  => "spree/layouts/admin",
						:name => "admin_offers_tab",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab :offers, :url => affiliate_engine.admin_offers_url %>"
                     )
