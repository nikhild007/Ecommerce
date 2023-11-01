class ProductDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      name: { source: "Product.name", cond: :like, searchable: true },
      description: { source: "Product.description" },
      price: { source: "Product.price" }
    }
  end

  def data
    records.map do |product|
      {
        name: product.name,
        description: product.description,
        price: product.price
      }
    end
  end

  def get_raw_records
    # insert query here
    Product.all
  end

end
