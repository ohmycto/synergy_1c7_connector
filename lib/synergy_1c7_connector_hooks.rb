class Synergy1c7ConnectorHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_product_form_right, "admin/shared/code_1c_fields"
  
  insert_after :admin_inside_taxon_form, "admin/shared/code_1c_fields"
  
  insert_after :admin_configurations_menu do
    "<%= configurations_menu_item(I18n.t('one_c7_connector'), new_admin_one_c7_connector_path, I18n.t('one_c7_connector_desc')) %>"
  end
  
  insert_after :admin_configurations_sidebar_menu do
    %(<li<%== ' class="active"' if controller.controller_name == 'one_c7_connectors' %>><%= link_to t("one_c7_connector"), new_admin_one_c7_connector_path %></li>)
  end
end