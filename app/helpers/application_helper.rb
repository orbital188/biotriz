module ApplicationHelper
  def hierarchical_select(object, method, model, options={}, html_options={})
    choices = [].tap do |ch|
      def rec(lst, records, indent_level=0)
        records.each do |record|
          indentation = '----' * indent_level
          indentation << ' ' unless indent_level == 0
          lst << [indentation + record.title, record.id]
          rec lst, record.children, indent_level + 1
        end
      end
      rec ch, model.roots
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
end
