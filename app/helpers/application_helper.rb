module ApplicationHelper
  def compare_changes(book, column)
    modifier = if book[column].to_f > book["previous_#{column}"].to_f
      :negative
    elsif book[column].to_f < book["previous_#{column}"].to_f
      :positive
    else
      :neutral
    end

    "<span class=\"book_price-change book_price-change--#{modifier}\">
      #{book[column]}\n
      #{if modifier == :negative then "<i>&uarr; #{(book[column] - book["previous_#{column}"]).round(3)}</i>" end}
      #{if modifier == :positive then "<i>&darr; #{(book["previous_#{column}"] - book[column]).round(3)}</i>" end}
    </span>".html_safe
  end
end
