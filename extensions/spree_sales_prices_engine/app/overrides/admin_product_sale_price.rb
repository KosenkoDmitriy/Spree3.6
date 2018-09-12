# insert_before :admin_product_form_right, "admin/products/price_additions"
Deface::Override.new(virtual_path: "spree/admin/shared/tabs",
                     insert_after: "div#registration",
                     render: "admin/posts/tab",
                     name: "admin_posts_tab")
