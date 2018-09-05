Deface::Override.new(
  virtual_path: 'shared/categories',
  name: 'pages_in_sidebar2',
  insert_bottom: '#product_nav',
  partial: 'shared/categories'# 'spree/static_content/static_content_sidebar'
)

# Deface::Override.new(
#   virtual_path: 'spree/shared/_sidebar',
#   name: 'pages_in_sidebar',
#   insert_bottom: '#sidebar',
#   partial: 'spree/static_content/static_content_sidebar'
# )
