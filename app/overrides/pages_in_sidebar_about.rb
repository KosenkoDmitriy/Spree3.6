Deface::Override.new(
  virtual_path: 'base/_page_menu',
  name: 'pages_in_sidebar_about',
  insert_bottom: '#page_nav > ul:first-child',
  partial: 'spree/static_content/static_content_sidebar'
)
