{% set search_page_filters = template == 'search' and search_filter %}
{% set category_page = template == 'category' %}
{% set show_filters = products or has_filters_available %}
{% if has_applied_filters and (category_page or search_page_filters) %}
    <div class="col-12 mb-3 mb-md-4 visible-when-content-ready {% if products %}d-none{% endif %} {% if not settings.filters_desktop_modal %}d-md-block{% endif %}">
        {{ component(
            'filters/remove-filters',{
                filter_classes: {
                    applied_filters_label: "font-body font-weight-bold mb-2",
                    remove: "chip",
                    remove_icon: "chip-remove-icon",
                    remove_all: "btn-link d-inline-block mt-1 mt-md-0 font-small",
                },
                remove_filter_svg_id: 'times',
            })
        }}
    </div>
{% endif %}
{% if not settings.filters_desktop_modal and (category_page or search_page_filters) and show_filters %}
<div class="col-md-auto filters-sidebar d-none d-md-block visible-when-content-ready">
        {% if products %}
            {{ component(
                'sort-by',{
                label: true,
                sort_by_classes: {
                    container: "mb-4 pb-2",
                    select_group: "form-group d-inline-block w-auto mb-0",
                    select_label: "h6 font-big mb-3 d-block",
                    select: "form-select-small",
                    select_svg: "icon-inline icon-w-14",
                },
                select_svg_id: 'chevron-down'
                })
            }}
            {{ component(
                'filters/filters',{
                    container_classes: {
                        filters_container: "visible-when-content-ready",
                    },
                    filter_classes: {
                        parent_category_link: "d-block",
                        parent_category_link_icon: "icon-inline icon-flip-horizontal mr-2 svg-icon-text",
                        list: "mb-4 pb-2 list-unstyled",
                        list_item: "mb-2",
                        list_link: "font-small",
                        list_title: "h6 font-big mb-4",
                        show_more_link: "d-inline-block btn-link font-small mt-1",
                        checkbox_last: "m-0",
                        price_group: 'price-filter-container filter-accordion mb-4 pb-2',
                        price_title: 'font-weight-bold mb-4 font-body',
                        price_submit: 'btn btn-default d-inline-block',
                        price_group: 'price-filter-container mb-4 pb-2',
                        price_title: 'h6 font-weight-bold mb-4 font-big',
                        price_submit: 'btn btn-default btn-small'
                    },
                })
            }}
        {% endif %}
    </div>
{% endif %}