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
end
