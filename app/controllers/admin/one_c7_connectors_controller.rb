class Admin::OneC7ConnectorsController < Admin::BaseController
  def create
    # If file present
    if params[:one_c7][:xml_file]
      file = params[:one_c7][:xml_file]
      path = "#{Rails.root}/tmp/#{file.original_filename}"
      File.open(path, "wb") { |f| f.write file.read }
      
      # Parsing
      xml = REXML::Document.new(File.read(path))
      taxonomy = Taxonomy.find(params[:one_c7][:taxonomy])
      xml.elements.first.elements.each do |el|
        if el.attribute('ЭтоГруппа') && el.attribute('ЭтоГруппа').value == "1"
          # Always taxon, find or create it; rename if names different
          if el.attribute('Группа')
            # Children group
            parent_taxon = Taxon.find_by_code_1c(el.attribute('Группа').value)
            new_taxon = taxonomy.taxons.find_or_create_by_code_1c(el.attribute('Код').value)
            new_taxon.update_attributes(:name => el.attribute('Наименование').value, :parent_id => parent_taxon.id)
          else
            # Root group
            taxon = taxonomy.taxons.find_or_create_by_code_1c(el.attribute('Код').value)
            taxon.update_attributes(:name => el.attribute('Наименование').value, :parent_id => taxonomy.taxons.first.id)
          end
        else
          # Always Product, find or create it; rename if names different
          taxon = el.attribute('Группа') ? Taxon.find_by_code_1c(el.attribute('Группа').value) : Taxon.where(:taxonomy_id => params[:one_c7][:taxonomy], :parent_id => nil).first
          parse_product(taxon, el) if taxon && el.attribute('Наименование').value.present?
        end
      end
      
      # delete xml file after parsing
      File.delete(path)
      redirect_to new_admin_one_c7_connector_path, :notice => t(:successful_1c_import)
    else
      flash[:error] = t(:no_selected_file)
      redirect_to new_admin_one_c7_connector_path
    end
  end
  
  private
  
  def parse_product(taxon, el)
    product = Product.find_or_initialize_by_code_1c(el.attribute('Код').value)
    
    if product.new_record?
      product.name = el.attribute('Наименование').value
      product.price = el.attribute('Цена').value.present? ? el.attribute('Цена').value : 0
      product.available_on = Time.now
      product.taxons << taxon
      product.save!
    else
      product.update_attributes(:name => el.attribute('Наименование').value, :price => el.attribute('Цена').value)
      # Update taxon only have non-empty code_1c attribute
      unless product.taxons.include?(taxon)
        old_taxon = product.taxons.select { |t| t.code_1c != nil }
        product.taxons.delete(old_taxon)
        product.taxons << taxon
      end
    end
  end
end