Deface::Override.new(virtual_path: "spree/layouts/admin",
						name: "admin_features_tab",
                     insert_bottom: "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
										 partial: 'features_engine/admin/tab'
                     )
