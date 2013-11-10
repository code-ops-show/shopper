class DropPgSearchDocuments < ActiveRecord::Migration
  def change
    drop_table :pg_search_documents
  end
end
