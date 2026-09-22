{# Set related products classes #}

{% set container_class = 'position-relative' %}
{% set title_class = 'h6 font-body mb-3 pb-1 text-md-center' %}
{% set slider_container_class = 'swiper-container' %}
{% set swiper_wrapper_class = 'swiper-wrapper swiper-products-slider flex-nowrap' %}
{% set slider_control_class = 'icon-inline icon-lg' %}
{% set slider_controls_container_class = 'swiper-button-outside d-none d-md-block svg-icon-text' %}
{% set slider_control_prev_class = 'swiper-button-prev ' ~ slider_controls_container_class %}
{% set slider_control_next_class = 'swiper-button-next ' ~ slider_controls_container_class %}
{% set control_next_svg_id = 'chevron' %}
{% set control_prev_svg_id = 'chevron' %}

{# Related cart products #}

{% set related_section_id = 'related-products-notification' %}

{% set related_products = related_products_list | length > 0 %}

{% if related_products %}
    {{ component(
        'products-section',{
        title: 'Sumá a tu compra' | translate,
        id: related_section_id,
        data_component: related_section_id,
        products_amount: related_products_list | length,
        products_array: related_products_list,
        product_template_path: 'snipplets/grid/item.tpl',
        product_template_params: {'slide_item': true, 'reduced_item': true},
        slider_controls_position: 'bottom',
        section_classes: {
            section: 'js-related-products-notification mx-md-3',
            container: container_class,
            title: title_class,
            products_container: 'related-products-notification-container mx-md-3',
            slider_container: 'js-swiper-related-products-notification ' ~ slider_container_class,
            slider_wrapper: swiper_wrapper_class,
            slider_control: slider_control_class,
            slider_control_prev_container: 'js-swiper-related-products-notification-prev ' ~ slider_control_prev_class,
            slider_control_prev: 'icon-flip-horizontal',
            slider_control_next_container: 'js-swiper-related-products-notification-next ' ~ slider_control_next_class,
        },
        control_next_svg_id: control_next_svg_id,
        control_prev_svg_id: control_prev_svg_id,
        })
    }}
{% endif %}
