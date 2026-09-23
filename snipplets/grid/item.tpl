{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set slide_item = slide_item | default(false) %}

{% if template == 'home'%}
    {% set columns_desktop = section_columns_desktop %}
    {% set columns_mobile = section_columns_mobile %}
    {% set section_slider = section_slider %}
{% else %}
    {% set columns_desktop = settings.grid_columns_desktop %}
    {% set columns_mobile = settings.grid_columns_mobile %}
    {% if template == 'product'%}
        {% set section_slider = true %}
    {% endif %}
{% endif %}

{% set mobile_column_class = columns_mobile == 1 ? '12' : '6' %}
{% set desktop_column_class = 
    columns_desktop == 2 ? '6' :
    columns_desktop == 3 ? '4' :
    columns_desktop == 4 ? '3' :
    columns_desktop == 5 ? '2-4' : '2'
 %}

{# Item image slider #}

{% set show_image_slider = 
    (template == 'category' or template == 'search')
    and settings.product_item_slider 
    and not slide_item
    and not reduced_item 
    and not has_filters
    and product.other_images
%}

{% if show_image_slider %}
    {% set slider_controls_container_class = 'item-slider-controls-container svg-icon-text d-none d-md-block' %}
    {% set control_next_svg_id = 'chevron' %}
    {% set control_prev_svg_id = 'chevron' %}
{% endif %}

{# Secondary images #}

{% if loop.first or loop.index is not defined %}
<style>
/* Action Max - Estilo dos Cards de Produto */
.item-product .item {
    border: 1px solid #e5e7eb !important;
    border-top: 4px solid #c0392b !important;
    border-radius: 14px !important;
    background-color: #ffffff !important;
    overflow: hidden !important;
    box-shadow: 0 4px 14px rgba(0, 0, 0, 0.04) !important;
    transition: transform 0.2s ease, box-shadow 0.2s ease !important;
    text-align: center !important;
    padding: 10px 8px 14px !important;
    display: flex !important;
    flex-direction: column !important;
    justify-content: space-between !important;
    height: calc(100% - 15px) !important;
}
.item-product .item:hover {
    transform: translateY(-2px) !important;
    box-shadow: 0 8px 22px rgba(0, 0, 0, 0.08) !important;
}
.item-product .item-image {
    border-radius: 10px !important;
    overflow: hidden !important;
    background: #ffffff !important;
}
.item-product .item-description {
    background: transparent !important;
    padding: 8px 4px 0 !important;
    text-align: center !important;
    flex-grow: 1 !important;
    display: flex !important;
    flex-direction: column !important;
    justify-content: space-between !important;
}
.item-product .item-name {
    font-size: 13.5px !important;
    font-weight: 700 !important;
    color: #111827 !important;
    opacity: 1 !important;
    text-align: center !important;
    margin-bottom: 6px !important;
    line-height: 1.35 !important;
    display: -webkit-box !important;
    -webkit-line-clamp: 2 !important;
    -webkit-box-orient: vertical !important;
    overflow: hidden !important;
}
.item-product .item-price-container {
    text-align: center !important;
    margin-top: 4px !important;
    margin-bottom: 4px !important;
}
.item-product .item-price-installment,
.item-product .item-price-main-highlight .item-price {
    color: #c0392b !important;
    font-size: 15.5px !important;
    font-weight: 700 !important;
    display: block !important;
    text-align: center !important;
    line-height: 1.25 !important;
}
.item-product .item-price-cash {
    font-size: 11.5px !important;
    color: #64748b !important;
    font-weight: 500 !important;
    text-align: center !important;
    margin-top: 3px !important;
    line-height: 1.3 !important;
}
.item-product .item-price-cash .js-payment-discount-price-container {
    font-size: 11.5px !important;
    color: #64748b !important;
    font-weight: 500 !important;
    display: inline-block !important;
    margin: 0 !important;
}
.item-product .item-price-cash .js-payment-discount-price-container::before {
    content: "ou ";
}
.item-product .item-price-cash .js-payment-discount-price-container ~ .item-cash-fallback {
    display: none !important;
}
.item-product .item-actions {
    text-align: center !important;
    margin-top: 8px !important;
    width: 100% !important;
}
.item-product .item-actions .btn {
    border-radius: 8px !important;
    font-size: 12px !important;
    font-weight: 600 !important;
    padding: 6px 14px !important;
    background-color: #c0392b !important;
    border-color: #c0392b !important;
    color: #ffffff !important;
    transition: background-color 0.2s ease !important;
}
.item-product .item-actions .btn:hover {
    background-color: #a93226 !important;
    border-color: #a93226 !important;
}
</style>
{% endif %}

    <div class="js-item-product{% if slide_item %} js-item-slide swiper-slide{% endif %} col-{{ mobile_column_class }} col-md-{{ desktop_column_class }} item-product col-grid {% if reduced_item %}item-product-reduced{% endif %}" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}">
        <div class="item {% if reduced_item %}mb-0{% endif %}">
            {% if (settings.quick_shop or settings.product_color_variants) and not reduced_item %}
                <div class="js-product-container js-quickshop-container{% if product.variations %} js-quickshop-has-variants{% endif %} position-relative" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}">
            {% endif %}
            {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}

            {# Set how much viewport space the images will take to load correct image #}

            {% if params.preview %}
                {% set mobile_image_viewport_space = '100' %}
                {% set desktop_image_viewport_space = '50' %}
            {% else %}
                {% if columns_mobile == 2 %}
                    {% set mobile_image_viewport_space = '50' %}
                {% else %}
                    {% set mobile_image_viewport_space = '100' %}
                {% endif %}

                {% if columns_desktop == 4 %}
                    {% set desktop_image_viewport_space = '25' %}
                {% elseif columns_desktop == 3 %}
                    {% set desktop_image_viewport_space = '33' %}
                {% else %}
                    {% set desktop_image_viewport_space = '50' %}
                {% endif %}
            {% endif %}

            {% set image_classes = 'js-item-image lazyautosizes ' ~ (not image_priority_high ? 'lazyload') ~ ' fade-in img-absolute img-absolute-centered' %}
            {% set data_expand = show_image_slider ? '50' : '-10' %}

            {% set floating_elements %}
                {% if not reduced_item %}
                    {% include 'snipplets/labels.tpl' with {labels_floating: true} %}
                {% endif %}
            {% endset %}
            
            {{ component(
                'product-item-image', {
                    image_lazy: true,
                    image_lazy_js: true,
                    image_data_expand: data_expand,
                    image_secondary_data_sizes: 'auto',
                    image_sizes: '(max-width: 768px)' ~ mobile_image_viewport_space ~ 'vw, (min-width: 769px)' ~ desktop_image_viewport_space ~ 'vw',
                    secondary_image: show_secondary_image,
                    slider: show_image_slider,
                    placeholder: true,
                    image_priority_high: image_priority_high,
                    custom_content: floating_elements,
                    slider_pagination_container: true,
                    product_item_image_classes: {
                        image_container: 'item-image' ~ (columns == 1 ? ' item-image-big') ~ (show_image_slider ? ' item-image-slider'),
                        image_padding_container: 'js-item-image-padding position-relative d-block',
                        image: image_classes,
                        image_featured: 'item-image-featured',
                        image_secondary: 'item-image-secondary',
                        slider_container: 'swiper-container position-absolute h-100 w-100',
                        slider_wrapper: 'swiper-wrapper',
                        slider_slide: 'swiper-slide item-image-slide',
                        slider_control_pagination_container: 'item-slider-pagination-container d-md-none ' ~ (product.images_count == 2 ? 'two-bullets'),
                        slider_control_pagination: 'swiper-pagination item-slider-pagination',
                        slider_control: 'icon-inline icon-lg',
                        slider_control_prev_container: 'swiper-button-prev ' ~ slider_controls_container_class,
                        slider_control_prev: 'icon-flip-horizontal',
                        slider_control_next_container: 'swiper-button-next ' ~ slider_controls_container_class,
                        more_images_message: 'item-more-images-message',
                        placeholder: 'placeholder-fade',
                    },
                    control_next_svg_id: control_next_svg_id,
                    control_prev_svg_id: control_prev_svg_id,
                })
            }}

            {% if 
                ((settings.quick_shop and not product.isSubscribable()) or settings.product_color_variants)
                and product.available 
                and product.display_price 
                and product.variations 
                and not reduced_item 
            %}

                {# Hidden product form to update item image and variants: Also this is used for quickshop popup #}

                <div class="js-item-variants hidden">
                    <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                        {% if product.variations %}
                            {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                        {% endif %}
                        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                        {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                        {# Add to cart CTA #}

                        {% set show_product_quantity = product.available and product.display_price %}

                        <div class="row no-gutters mt-3">

                            {% if show_product_quantity %}
                                {% include "snipplets/product/product-quantity.tpl" with {quickshop: true} %}
                            {% endif %}

                            <div class="{% if show_product_quantity %}col-8 col-md-9{% else %}col-12{% endif %}">

                                <input type="submit" class="js-addtocart js-prod-submit-form btn-add-to-cart btn btn-primary btn-big w-100 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

                                {# Fake add to cart CTA visible during add to cart event #}

                                {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-big"} %}
                            </div>
                        </div>
                    </form>
                </div>

            {% endif %}

            {# Subscription data - calculate only is_subscription_only for the CTA button #}
            {% set is_subscription_only = product.isSubscriptionOnly() %}

            {% set show_labels = not product.has_stock or product.compare_at_price or product.hasVisiblePromotionLabel %}
            <div class="item-description pt-3" data-store="product-item-info-{{ product.id }}">
                <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" class="item-link">
                    {% if settings.product_color_variants and not reduced_item %}
                        {% include 'snipplets/grid/item-colors.tpl' %}
                    {% endif %}

                    {{ component('nubesdk-slot', { type: "before_product_grid_item_name" }) }}

                    <div class="js-item-name item-name mb-2 font-small opacity-80" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>

                    {{ component('nubesdk-slot', { type: "after_product_grid_item_name" }) }}

                    {{ component('nubesdk-slot', { type: "before_product_grid_item_price" }) }}

                    {% if product.display_price %}
                        {% if is_subscription_only %}
                            {# Subscription only products: use subscription-price component with product_list location #}
                            {{ component('subscriptions/subscription-price', {
                                location: 'product_list',
                                subscription_classes: {
                                    container: 'item-price-container {% if settings.quick_shop and not reduced_item %}mb-3{% endif %}',
                                    price_compare: 'price-compare',
                                    price_with_subscription: 'item-price font-weight-bold {% if settings.payment_discount_price %}font-body{% endif %}',
                                },
                            }) }}
                        {% else %}
                            {# Normal products: price display with red installments & reduced cash condition #}
                            {% set max_installments_without_interests = product.get_max_installments(false) %}
                            {% set max_installments_with_interests = product.get_max_installments(true) %}
                            {% set max_installments = max_installments_without_interests ? max_installments_without_interests : (product.get_max_installments ? product.get_max_installments : max_installments_with_interests) %}
                            {% set has_installments = product.show_installments and max_installments and max_installments.installment > 1 and not reduced_item %}

                            <div class="item-price-container {% if settings.quick_shop and not reduced_item %}mb-2{% endif %}" data-store="product-item-price-{{ product.id }}">
                                
                                {# Original strikethrough price if compare_at_price exists #}
                                {% if not reduced_item and product.compare_at_price and product.compare_at_price > product.price %}
                                    <div class="item-price-compare mb-1 text-center">
                                        <span class="js-compare-price-display price-compare font-smallest">
                                            {{ product.compare_at_price | money }}
                                        </span>
                                    </div>
                                {% elseif not reduced_item %}
                                    <span class="js-compare-price-display price-compare" style="display:none;"></span>
                                {% endif %}

                                {# Main highlighted price in red #}
                                <div class="item-price-main-highlight text-center">
                                    {% if has_installments %}
                                        {# Parcelado as prominent red text #}
                                        <span class="item-price-installment font-weight-bold" style="color: #c0392b; font-size: 15px;">
                                            {{ max_installments.installment }}x de {{ max_installments.installment_data.installment_value | money }}
                                        </span>
                                        {# Hidden standard price span for JS variant updates #}
                                        <span class="js-price-display item-price d-none" data-product-price="{{ product.price }}">
                                            {{ product.price | money }}
                                        </span>
                                    {% else %}
                                        {# Standard price in red #}
                                        <span class="js-price-display item-price font-weight-bold" style="color: #c0392b; font-size: 15px;" data-product-price="{{ product.price }}">
                                            {{ product.price | money }}
                                        </span>
                                    {% endif %}

                                    {% if not reduced_item %}
                                        {% include 'snipplets/labels.tpl' %}
                                    {% endif %}
                                </div>

                                {# Cash / à vista condition in reduced size #}
                                {% if not reduced_item %}
                                    <div class="item-price-cash font-smallest text-center mt-1">
                                        {% if settings.payment_discount_price %}
                                            {{ component('payment-discount-price', {
                                                    visibility_condition: true,
                                                    location: 'product',
                                                    container_classes: "d-inline-block",
                                                    text_classes: {
                                                        price: 'font-weight-semibold',
                                                    },
                                                }) 
                                            }}
                                        {% endif %}
                                        <span class="item-cash-fallback">ou {{ product.price | money }} à vista</span>
                                    </div>
                                {% endif %}
                            </div>
                        {% endif %}
                    {% endif %}

                    {{ component('nubesdk-slot', { type: "after_product_grid_item_price" }) }}

                    {% if not reduced_item %}
                        {{ component('subscriptions/subscription-message', {
                            subscription_classes: {
                                container: 'font-smallest text-accent mt-2 mb-2',
                            },
                        }) }}
                    {% endif %}
                    {% if product.available and product.display_price and settings.quick_shop %}
                        {% if settings.quick_shop and not reduced_item %}
                            <div class="item-actions d-inline-block">

                                {% set quickshop_button_classes = 'btn btn-primary btn-small btn-smallest-md px-4' %}

                                {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                                {% set texts = {'cart': "Comprar", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                                {% if product.isSubscribable() %}

                                    {# Product with subscription will link to the product page #}

                                    {% set button_text = is_subscription_only ? ('our_components.subscriptions.subscribe' | tt) : texts[state] %}
                                    {% set button_title = is_subscription_only ? ('our_components.subscriptions.subscribe' | tt) ~ ' ' ~ product.name : ('Compra rápida de' | translate) ~ ' ' ~ product.name %}
                                    <a href="{{ product_url_with_selected_variant }}" class="{{ quickshop_button_classes }}" title="{{ button_title }}" aria-label="{{ button_title }}">
                                        {{ button_text | translate }}
                                    </a>

                                {% else %}

                                    {% if product.variations %}

                                        {# Open quickshop popup if has variants #}

                                        <span data-toggle="#quickshop-modal" class="js-quickshop-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open {{ quickshop_button_classes }}" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}" data-component="product-list-item.add-to-cart" data-component-value="{{product.id}}">
                                            <span class="js-open-quickshop-wording">{{ 'Comprar' | translate }}</span>
                                        </span>
                                    {% else %}
                                        {# If not variants add directly to cart #}
                                        <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                                            <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                                            
                                            <div class="js-item-submit-container item-submit-container position-relative float-left d-inline-block w-100">
                                                <input type="submit" class="js-addtocart js-prod-submit-form js-quickshop-icon-add {{ quickshop_button_classes }} {{ state }}" value="{{ texts[state] | translate }}" alt="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}"/>
                                            </div>

                                            {# Fake add to cart CTA visible during add to cart event #}

                                            {% include 'snipplets/placeholders/button-placeholder.tpl' with {direct_add: true} %}
                                        </form>
                                    {% endif %}
                                {% endif %}
                            </div>
                        {% endif %}
                    {% endif %}
                </a>
            </div>
            {% if (settings.quick_shop or settings.product_color_variants) and not reduced_item %}
                </div>{# This closes the quickshop tag #}
            {% endif %}

            {# Structured data to provide information for Google about the product content #}
            {{ component('structured-data', {'item': true}) }}
        </div>
    </div>
