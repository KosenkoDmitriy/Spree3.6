Deface::Override.new(
  virtual_path: 'base/page_menu',
  name: 'pages_in_sidebar',
  insert_bottom: '#page_nav',
  partial: 'spree/static_content/static_content_sidebar'
)
