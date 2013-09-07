module ApplicationHelper
    # This is to provide base title in case a page is missing provide
    # Returns the full title on a per-page basis
    def full_title(page_title)
        base_title = "BrightHearts"
        if page_title.empty?
            base_title
        else
            "#{base_title} | #{page_title}"
        end
    end
end
