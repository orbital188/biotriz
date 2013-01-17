module ApplicationHelper
  def hierarchical_select(object, method, model, options={}, html_options={})
    choices = [].tap do |ch|
      rec = lambda do |records, indent_level=0|
        records.each do |record|
          indentation = '----' * indent_level
          indentation << ' ' unless indent_level == 0
          ch << [indentation + record.title, record.id]
          rec.call record.children, indent_level + 1
        end
      end
      rec.call model.roots
    end
    select object, method, choices, options, html_options
  end

  def display_error_messages_for(form)
    render "shared/error_messages", object: form.object
  end

  def pagination_for(collection)
    will_paginate collection, class: 'pagination pagination-small pagination-centered',
    previous_label: '<<', next_label: '>>'
  end

  def admin_links(entity)
    """
       <td>#{link_to 'View', polymorphic_path(entity)}</td>
       <td>#{link_to 'Edit', edit_polymorphic_path(entity)}</td>
       <td>#{link_to 'Delete', polymorphic_path(entity), confirm: 'Are you sure?', method: :delete}</td>
    """.html_safe
  end

  def list_with_links(collection, options = {})
    attr = options[:attr] || :title
    sep = options[:sep] || ", "

    collection.collect { |item| link_to item[attr], item }.join(sep).html_safe
  end
end
