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

{% set show_secondary_image = settings.product_hover %}

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
                </a>

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
                        {# Preço original rasurado cinzento apenas se o produto tiver preço promocional cadastrado na loja #}
                        {% set has_promotional_price = product.compare_at_price and product.compare_at_price > product.price %}

                        {# Preço em destaque em vermelho mostrando em 6 parcelas #}
                        {% set installment_6_cents = (product.price / 6) | round %}

                        {# Estrela amarela com nota aleatória de 4.7 a 5 #}
                        {% set random_ratings = ['4.8', '4.9', '4.7', '5.0', '4.9', '4.8', '5.0', '4.9', '4.7', '5.0'] %}
                        {% set rating_idx = product.id ? (product.id % 10) : 0 %}
                        {% set product_rating = random_ratings[rating_idx] %}

                        <div class="item-details-container" data-store="product-item-price-{{ product.id }}">
                            <div class="item-details-row">
                                {# Canto Esquerdo: Preço original rasurado cinzento (caso tenha promoção) + Preço em destaque em vermelho mostrando em 6 parcelas #}
                                <div class="item-details-left">
                                    <a href="{{ product_url_with_selected_variant }}" class="item-link">
                                        {% if not reduced_item and has_promotional_price %}
                                            <div class="item-price-compare">
                                                <span class="js-compare-price-display price-compare font-smallest">
                                                    {{ product.compare_at_price | money }}
                                                </span>
                                            </div>
                                        {% elseif not reduced_item %}
                                            <div class="item-price-compare d-none" style="display: none;">
                                                <span class="js-compare-price-display price-compare font-smallest" style="display: none;"></span>
                                            </div>
                                        {% endif %}

                                        <div class="item-price-promo">
                                            <span class="item-price-installment font-weight-bold">
                                                6x de {{ installment_6_cents | money }}
                                            </span>
                                            {# Hidden standard price span for JS variant updates #}
                                            <span class="js-price-display item-price d-none" data-product-price="{{ product.price }}">
                                                {{ product.price | money }}
                                            </span>
                                        </div>

                                        {% if not reduced_item %}
                                            <div class="item-price-cash font-smallest mt-1">
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
                                                {% else %}
                                                    <span>ou {{ product.price | money }} à vista</span>
                                                {% endif %}
                                            </div>
                                        {% endif %}
                                    </a>
                                </div>

                                {# Canto Direito: Estrela amarela com a nota ao lado (4.7 a 5) #}
                                <div class="item-details-right">
                                    <div class="item-rating" title="Avaliação {{ product_rating }}">
                                        <svg class="item-star-icon" viewBox="0 0 20 20" fill="#f59e0b">
                                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                                        </svg>
                                        <span class="item-rating-score">{{ product_rating }}</span>
                                    </div>
                                </div>
                            </div>

                            {# Botão vermelho com fonte branca abaixo com o nome Comprar #}
                            {% if product.available and not reduced_item %}
                                <div class="item-actions">
                                    {% set quickshop_button_classes = 'btn btn-primary btn-add-to-cart' %}
                                    {% set state = store.is_catalog ? 'catalog' : (product.available ? 'cart' : 'nostock') %}

                                    {% if product.isSubscribable() %}
                                        <a href="{{ product_url_with_selected_variant }}" class="{{ quickshop_button_classes }}" title="Comprar {{ product.name }}" aria-label="Comprar {{ product.name }}">
                                            Comprar
                                        </a>
                                    {% else %}
                                        {% if product.variations %}
                                            {# Open quickshop popup if has variants #}
                                            <span data-toggle="#quickshop-modal" class="js-quickshop-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open {{ quickshop_button_classes }}" title="Comprar {{ product.name }}" aria-label="Comprar {{ product.name }}" data-component="product-list-item.add-to-cart" data-component-value="{{product.id}}">
                                                <span class="js-open-quickshop-wording">Comprar</span>
                                            </span>
                                        {% else %}
                                            {# If not variants add directly to cart #}
                                            <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                                                <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                                                
                                                <div class="js-item-submit-container item-submit-container position-relative w-100">
                                                    <input type="submit" class="js-addtocart js-prod-submit-form js-quickshop-icon-add {{ quickshop_button_classes }} {{ state }}" value="Comprar" alt="Comprar" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}"/>
                                                </div>

                                                {# Fake add to cart CTA visible during add to cart event #}
                                                {% include 'snipplets/placeholders/button-placeholder.tpl' with {direct_add: true} %}
                                            </form>
                                        {% endif %}
                                    {% endif %}
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
            </div>
            {% if (settings.quick_shop or settings.product_color_variants) and not reduced_item %}
                </div>{# This closes the quickshop tag #}
            {% endif %}

            {# Structured data to provide information for Google about the product content #}
            {{ component('structured-data', {'item': true}) }}
        </div>
    </div>
